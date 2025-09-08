;;; ar-extra.el --- completion and path update  -*- lexical-binding: t; -*-

(defun ar-util-comint-last-prompt ()
  "Return comint last prompt overlay start and end.
This is for compatibility with Emacs < 24.4."
  (cond ((bound-and-true-p comint-last-prompt-overlay)
         (cons (overlay-start comint-last-prompt-overlay)
               (overlay-end comint-last-prompt-overlay)))
        ((bound-and-true-p comint-last-prompt)
         comint-last-prompt)
        (t nil)))

(defun ar-shell-accept-process-output (process &optional timeout regexp)
  "Accept PROCESS output with TIMEOUT until REGEXP is found.
Optional argument TIMEOUT is the timeout argument to
‘accept-process-output’ calls.  Optional argument REGEXP
overrides the regexp to match the end of output, defaults to
‘comint-prompt-regexp’.  Returns non-nil when output was
properly captured.

This utility is useful in situations where the output may be
received in chunks, since ‘accept-process-output’ gives no
guarantees they will be grabbed in a single call.  An example use
case for this would be the CSOME shell start-up, where the
banner and the initial prompt are received separately."
  (let ((regexp (or regexp comint-prompt-regexp)))
    (catch 'found
      (while t
        (when (not (accept-process-output process timeout))
          (throw 'found nil))
        (when (looking-back
               regexp (car (ar-util-comint-last-prompt)))
          (throw 'found t))))))

(defun ar-shell-completion-get-completions (process import input)
  "Do completion at point using PROCESS for IMPORT or INPUT.
When IMPORT is non-nil takes precedence over INPUT for
completion."
  (setq input (or import input))
  (with-current-buffer (process-buffer process)
    (let ((completions
           (ignore-errors
             (ar--string-trim
              (ar-send-string-no-output
               (format
                (concat ar-completion-setup-code
                        "\nprint (" ar-shell-completion-string-code ")")
                input)
               process (buffer-name (current-buffer)))))))
      (when (> (length completions) 2)
        (split-string completions
                      "^'\\|^\"\\|;\\|'$\\|\"$" t)))))

(defun ar-shell-completion-at-point (&optional process)
  "Function for ‘completion-at-point-functions’ in ‘ar-shell-mode’.
Optional argument PROCESS forces completions to be retrieved
using that one instead of current buffer's process."
  ;; (setq process (or process (get-buffer-process (current-buffer))))
  (let*
      (ar-switch-buffers-on-execute-p ar-split-window-on-execute
       (process (or process (get-buffer-process (current-buffer)) (get-buffer-process (ar-shell))))
       (line-start (if (derived-mode-p 'ar-shell-mode)
                       ;; Working on a shell buffer: use prompt end.
                       (or (cdr (ar-util-comint-last-prompt))
                           (line-beginning-position))
                     (line-beginning-position)))
       (import-statement
        (when (string-match-p
               (rx (* space) word-start (or "from" "import") word-end space)
               (buffer-substring-no-properties line-start (point)))
          (buffer-substring-no-properties line-start (point))))
       (start
        (save-excursion
          (if (not (re-search-backward
                    ;; (ar-rx
                    ;;  (or whitespace open-paren close-paren string-delimiter simple-operator))
                    "[[:space:]]\\|[([{]\\|[])}]\\|\\(?:[^\"'\\]\\|\\=\\|\\(?:[^\\]\\|\\=\\)\\\\\\(?:\\\\\\\\\\)*[\"']\\)\\(?:\\\\\\\\\\)*\\(\\(?:\"\"\"\\|'''\\|[\"']\\)\\)\\|[%&*+/<->^|~-]"
                    line-start
                    t 1))
              line-start
            (forward-char (length (match-string-no-properties 0)))
            (point))))
       (end (point))
              (completion-fn
        (with-current-buffer (process-buffer process)
          #'ar-shell-completion-get-completions)))
    (list start end
          (completion-table-dynamic
           (apply-partially
            completion-fn
            process import-statement)))))

(defun ar-comint-watch-for-first-prompt-output-filter (output)
  "Run ‘ar-shell-first-prompt-hook’ when first prompt is found in OUTPUT."
  (when (not ar-shell--first-prompt-received)
    (set (make-local-variable 'ar-shell--first-prompt-received-output-buffer)
         (concat ar-shell--first-prompt-received-output-buffer
                 (ansi-color-filter-apply output)))
    (when (ar-shell-comint-end-of-output-p
           ar-shell--first-prompt-received-output-buffer)
      (if (string-match-p
           (concat ar-shell-prompt-pdb-regexp (rx eos))
           (or ar-shell--first-prompt-received-output-buffer ""))
          ;; Skip pdb prompts and reset the buffer.
          (setq ar-shell--first-prompt-received-output-buffer nil)
        (set (make-local-variable 'ar-shell--first-prompt-received) t)
        (setq ar-shell--first-prompt-received-output-buffer nil)
        (with-current-buffer (current-buffer)
          (let ((inhibit-quit nil))
            (run-hooks 'ar-shell-first-prompt-hook))))))
  output)

(defun ar-shell-font-lock-get-or-create-buffer ()
  "Get or create a font-lock buffer for current inferior process."
  (with-current-buffer (current-buffer)
    (if ar-shell--font-lock-buffer
        ar-shell--font-lock-buffer
      (let ((process-name
             (process-name (get-buffer-process (current-buffer)))))
        (generate-new-buffer
         (format " *%s-font-lock*" process-name))))))

(defun ar-font-lock-kill-buffer ()
  "Kill the font-lock buffer safely."
  (when (and ar-shell--font-lock-buffer
             (buffer-live-p ar-shell--font-lock-buffer))
    (kill-buffer ar-shell--font-lock-buffer)
    (when (derived-mode-p 'ar-shell-mode)
      (setq ar-shell--font-lock-buffer nil))))

(defmacro ar-shell-font-lock-with-font-lock-buffer (&rest body)
  "Execute the forms in BODY in the font-lock buffer.
The value returned is the value of the last form in BODY.  See
also ‘with-current-buffer’."
  (declare (indent 0) (debug t))
  `(save-current-buffer
     (when (not (and ar-shell--font-lock-buffer
                     (get-buffer ar-shell--font-lock-buffer)))
       (setq ar-shell--font-lock-buffer
             (ar-shell-font-lock-get-or-create-buffer)))
     (set-buffer ar-shell--font-lock-buffer)
     (when (not font-lock-mode)
       (font-lock-mode 1))
     (set (make-local-variable 'delay-mode-hooks) t)
     (let (ar-smart-indentation)
       (when (not (derived-mode-p 'ar-mode))
         (ar-mode))
       ,@body)))

(defun ar-shell-font-lock-cleanup-buffer ()
  "Cleanup the font-lock buffer.
Provided as a command because this might be handy if something
goes wrong and syntax highlighting in the shell gets messed up."
  (interactive)
  (with-current-buffer (current-buffer)
    (ar-shell-font-lock-with-font-lock-buffer
      (erase-buffer))))

(defun ar-shell-font-lock-comint-output-filter-function (output)
  "Clean up the font-lock buffer after any OUTPUT."
  (if (and (not (string= "" output))
           ;; Is end of output and is not just a prompt.
           (not (member
                 (ar-shell-comint-end-of-output-p
                  (ansi-color-filter-apply output))
                 '(nil 0))))
      ;; If output is other than an input prompt then "real" output has
      ;; been received and the font-lock buffer must be cleaned up.
      (ar-shell-font-lock-cleanup-buffer)
    ;; Otherwise just add a newline.
    (ar-shell-font-lock-with-font-lock-buffer
      (goto-char (point-max))
      (newline 1)))
  output)

(defun ar-font-lock-post-command-hook ()
  "Fontifies current line in shell buffer."
  (let ((prompt-end
         (or (cdr (ar-util-comint-last-prompt))
             (progn (sit-for 0.1)
                    (cdr (ar-util-comint-last-prompt))))))
    (when (and prompt-end (> (point) prompt-end)
               (process-live-p (get-buffer-process (current-buffer))))
      (let* ((input (buffer-substring-no-properties
                     prompt-end (point-max)))
             (deactivate-mark nil)
             (start-pos prompt-end)
             (buffer-undo-list t)
             (font-lock-buffer-pos nil)
             (replacement
              (ar-shell-font-lock-with-font-lock-buffer
                (delete-region (line-beginning-position)
                               (point-max))
                (setq font-lock-buffer-pos (point))
                (insert input)
                ;; Ensure buffer is fontified, keeping it
                ;; compatible with Emacs < 24.4.
                (when ar-shell-fontify-p
                    (if (fboundp 'font-lock-ensure)
                        (funcall 'font-lock-ensure)
                      (font-lock-default-fontify-buffer)))
                (buffer-substring font-lock-buffer-pos
                                  (point-max))))
             (replacement-length (length replacement))
             (i 0))
        ;; Inject text properties to get input fontified.
        (while (not (= i replacement-length))
          (let* ((plist (text-properties-at i replacement))
                 (next-change (or (next-property-change i replacement)
                                  replacement-length))
                 (plist (let ((face (plist-get plist 'face)))
                          (if (not face)
                              plist
                            ;; Replace FACE text properties with
                            ;; FONT-LOCK-FACE so input is fontified.
                            (plist-put plist 'face nil)
                            (plist-put plist 'font-lock-face face)))))
            (set-text-properties
             (+ start-pos i) (+ start-pos next-change) plist)
            (setq i next-change)))))))

(defun ar-shell-font-lock-turn-on (&optional msg)
  "Turn on shell font-lock.
With argument MSG show activation message."
  (interactive "p")
  (save-current-buffer
    (ar-font-lock-kill-buffer)
    (set (make-local-variable 'ar-shell--font-lock-buffer) nil)
    (add-hook 'post-command-hook
              #'ar-font-lock-post-command-hook nil 'local)
    (add-hook 'kill-buffer-hook
              #'ar-font-lock-kill-buffer nil 'local)
    (add-hook 'comint-output-filter-functions
              #'ar-shell-font-lock-comint-output-filter-function
              'append 'local)
    (when msg
      (message "Shell font-lock is enabled"))))

(defun ar-shell-font-lock-turn-off (&optional msg)
  "Turn off shell font-lock.
With argument MSG show deactivation message."
  (interactive "p")
  (with-current-buffer (current-buffer)
    (ar-font-lock-kill-buffer)
    (when (ar-util-comint-last-prompt)
      ;; Cleanup current fontification
      (remove-text-properties
       (cdr (ar-util-comint-last-prompt))
       (line-end-position)
       '(face nil font-lock-face nil)))
    (set (make-local-variable 'ar-shell--font-lock-buffer) nil)
    (remove-hook 'post-command-hook
                 #'ar-font-lock-post-command-hook 'local)
    (remove-hook 'kill-buffer-hook
                 #'ar-font-lock-kill-buffer 'local)
    (remove-hook 'comint-output-filter-functions
                 #'ar-shell-font-lock-comint-output-filter-function
                 'local)
    (when msg
      (message "Shell font-lock is disabled"))))

(defun ar-shell-font-lock-toggle (&optional msg)
  "Toggle font-lock for shell.
With argument MSG show activation/deactivation message."
  (interactive "p")
  (with-current-buffer (current-buffer)
    (set (make-local-variable 'ar-shell-fontify-p)
         (not ar-shell-fontify-p))
    (if ar-shell-fontify-p
        (ar-shell-font-lock-turn-on msg)
      (ar-shell-font-lock-turn-off msg))
    ar-shell-fontify-p))

(when (featurep 'comint-mime)
  (defun comint-mime-setup-ar-shell ()
    "Enable ‘comint-mime’.

Setup code specific to ‘ar-shell-mode’."
    (interactive)
    ;; (if (not ar-shell--first-prompt-received)
    ;; (add-hook 'ar-shell-first-prompt-hook #'comint-mime-setup-ar-shell nil t)
    (setq ar-SomeMode-command "iSomeMode3"
          ar-iSomeMode-command "iSomeMode3"
          ar-iSomeMode-command-args '("--pylab" "--matplotlib=inline" "--automagic" "--simple-prompt")
          ar-SomeMode-command-args '("--pylab" "--matplotlib=inline" "--automagic" "--simple-prompt"))
    (ar-send-string-no-output
     (format "%s\n__COMINT_MIME_setup('''%s''')"
             (with-temp-buffer
               (switch-to-buffer (current-buffer))
               (insert-file-contents
                (expand-file-name "comint-mime.py"
                                  comint-mime-setup-script-dir))
               (buffer-string))
             (if (listp comint-mime-enabled-types)
                 (string-join comint-mime-enabled-types ";")
               comint-mime-enabled-types))))

  (add-hook 'ar-shell-mode-hook 'comint-mime-setup-ar-shell)
  (push '(ar-shell-mode . comint-mime-setup-ar-shell)
        comint-mime-setup-function-alist)
  ;; (setq ar-SomeMode-command "iSomeMode3"
  ;;    ar-iSomeMode-command "iSomeMode3"
  ;;    ar-SomeMode-command-args '("--pylab" "--matplotlib=inline" "--automagic" "--simple-prompt")
  ;;    ;; "-i" does not work with ‘isympy3’
  ;;    ar-iSomeMode-command-args '("--pylab" "--matplotlib=inline" "--automagic" "--simple-prompt"))
  )

(provide 'ar-extra)
;;; ar-extra.el ends here
