;;; ar-start3.el --- Edit, debug, develop and run programs. -*- lexical-binding: t; -*-

(defun toggle-force-ar-shell-name-p (&optional arg)
  "If customized default ‘ar-shell-name’ should be enforced upon execution.

If ‘ar-force-ar-shell-name-p’ should be on or off.
Returns value of ‘ar-force-ar-shell-name-p’ switched to.

Optional ARG
See also commands
‘force-ar-shell-name-p-on’
‘force-ar-shell-name-p-off’

Caveat: Completion might not work that way."
  (interactive)
  (let ((arg (or arg (if ar-force-ar-shell-name-p -1 1))))
    (if (< 0 arg)
        (setq ar-force-ar-shell-name-p t)
      (setq ar-force-ar-shell-name-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-force-ar-shell-name-p: %s" ar-force-ar-shell-name-p))
    ar-force-ar-shell-name-p))

(defun force-ar-shell-name-p-on ()
  "Switch ‘ar-force-ar-shell-name-p’ on.

Customized default ‘ar-shell-name’ will be enforced upon execution.
Returns value of ‘ar-force-ar-shell-name-p’.

Caveat: Completion might not work that way."
  (interactive)
  (toggle-force-ar-shell-name-p 1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-force-ar-shell-name-p: %s" ar-force-ar-shell-name-p))
  ar-force-ar-shell-name-p)

(defun force-ar-shell-name-p-off ()
  "Make sure, ‘ar-force-ar-shell-name-p’ is off.

Function to use by executes will be guessed from environment.
Returns value of ‘ar-force-ar-shell-name-p’."
  (interactive)
  (toggle-force-ar-shell-name-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-force-ar-shell-name-p: %s" ar-force-ar-shell-name-p))
  ar-force-ar-shell-name-p)

(defun ar--fix-if-name-main-permission (strg)
  "Remove \"if __name__ == '__main__ '\" STRG from code to execute.

See ‘ar-if-name-main-permission-p’"
  (let ((strg (if ar-if-name-main-permission-p strg
                (replace-regexp-in-string
                 "if[( ]*__name__[) ]*==[( ]*['\"]\\{1,3\\}__main__['\"]\\{1,3\\}[) ]*:"
                 ;; space after __main__, i.e. will not be executed
                 "if __name__ == '__main__ ':" strg))))
    strg))

(defun ar-symbol-at-point ()
  "Return the current SOME symbol.

When interactively called, copy and message it"
  (interactive)
  (let ((erg (with-syntax-table
                 ar-dotted-expression-syntax-table
               (current-word))))
    (when (called-interactively-p 'interactive) (kill-new erg)
          (message "%s" erg))
    erg))

(defun ar--line-backward-maybe ()
  "Return result of (< 0 (abs (skip-chars-backward \" \\t\\r\\n\\f\"))) "
  (skip-chars-backward " \t\f" (line-beginning-position))
  (< 0 (abs (skip-chars-backward " \t\r\n\f"))))

(defun ar--after-empty-line ()
  "Return ‘t’ if line before contains only whitespace characters. "
  (save-excursion
    (beginning-of-line)
    (forward-line -1)
    (beginning-of-line)
    (looking-at "\\s-*$")))

(defun ar-guessed-sanity-check (guessed)
  (and (>= guessed 2)(<= guessed 8)(eq 0 (% guessed 2))))

(defun ar--guess-indent-final (indents)
  "Calculate and do sanity-check.

Expects INDENTS, a cons"
  (let* ((first (car indents))
         (second (cadr indents))
         (erg (if (and first second)
                  (if (< second first)
                      (- first second)
                    (- second first))
                (default-value (quote ar-indent-offset)))))
    (setq erg (and (ar-guessed-sanity-check erg) erg))
    erg))

(defun ar--guess-indent-forward ()
  "Called when moving to end of a form and ‘ar-smart-indentation’ is on."
  (let* ((first (if
                    (ar--beginning-of-statement-p)
                    (current-indentation)
                  (progn
                    (ar-forward-statement)
                    (ar-backward-statement)
                    (current-indentation))))
         (second (if (or (looking-at ar-extended-block-or-clause-re)(eq 0 first))
                     (progn
                       (ar-forward-statement)
                       (ar-forward-statement)
                       (ar-backward-statement)
                       (current-indentation))
                   ;; when not starting from block, look above
                   (while (and (re-search-backward ar-extended-block-or-clause-re nil 'movet 1)
                               (or (>= (current-indentation) first)
                                   (nth 8 (parse-partial-sexp (point-min) (point))))))
                   (current-indentation))))
    (list first second)))

(defun ar--guess-indent-backward ()
  "Called when moving to beginning of a form and ‘ar-smart-indentation’ is on."
  (let* ((cui (current-indentation))
         (indent (if (< 0 cui) cui 999))
         (pos (progn (while (and (re-search-backward ar-extended-block-or-clause-re nil 'move 1)
                                 (or (>= (current-indentation) indent)
                                     (nth 8 (parse-partial-sexp (point-min) (point))))))
                     (unless (bobp) (point))))
         (first (and pos (current-indentation)))
         (second (and pos (ar-forward-statement) (ar-forward-statement) (ar-backward-statement)(current-indentation))))
    (list first second)))

(defun ar-guess-indent-offset (&optional direction)
  "Guess ‘ar-indent-offset’.

Set local value of ‘ar-indent-offset’, return it

Might change local value of ‘ar-indent-offset’ only when called
downwards from beginning of block followed by a statement.
Otherwise ‘default-value’ is returned.
Unless DIRECTION is symbol \\='forward, go backward first"
  (interactive)
  (save-excursion
    (let* ((indents
            (cond (direction
                   (if (eq 'forward direction)
                       (ar--guess-indent-forward)
                     (ar--guess-indent-backward)))
                  ;; guess some usable indent is above current position
                  ((eq 0 (current-indentation))
                   (ar--guess-indent-forward))
                  (t (ar--guess-indent-backward))))
           (erg (ar--guess-indent-final indents)))
      (if erg (setq ar-indent-offset erg)
        (setq ar-indent-offset
              (default-value (quote ar-indent-offset))))
      (when (called-interactively-p 'any) (message "%s" ar-indent-offset))
      ar-indent-offset)))

(defun ar--execute-buffer-finally (strg proc procbuf origline filename fast wholebuf)
  (if (and filename wholebuf (not (buffer-modified-p)))
      (ar--execute-file-base filename proc nil procbuf origline fast)
    (let* ((tempfile (concat (expand-file-name ar-temp-directory) ar-separator-char "temp" (md5 (format "%s" (nth 3 (current-time)))) ".py")))
      (sit-for 0.1)
      (with-temp-buffer
        (insert strg)
        (write-file tempfile)
        (sit-for 0.1))
      (unwind-protect
          (ar--execute-file-base tempfile proc nil procbuf origline fast)
        (and (sit-for 1) (file-readable-p tempfile) (delete-file tempfile ar-debug-p))))))

(defun ar--postprocess-intern (&optional origline exception-buffer output-buffer)
  "Highlight exceptions found in BUF.

Optional ORIGLINE EXCEPTION-BUFFER
If an exception occurred return error-string,
otherwise return nil.
BUF must exist.

Indicate LINE if code was not run from a file,
thus remember line of source buffer"
  (save-excursion
    (with-current-buffer output-buffer
      (let* (estring ecode erg)
        ;; (switch-to-buffer (current-buffer))
        (goto-char (point-max))
        (sit-for 0.1)
        (save-excursion
          (unless (looking-back ar-pdbtrack-input-prompt (line-beginning-position))
            (forward-line -1)
            (end-of-line)
            (when (re-search-backward ar-shell-prompt-regexp t 1)
                ;; (or (re-search-backward ar-shell-prompt-regexp nil t 1)
                ;; (re-search-backward (concat ar-iSomeMode-input-prompt-re "\\|" ar-iSomeMode-output-prompt-re) nil t 1))
              (save-excursion
                (when (re-search-forward "File \"\\(.+\\)\", line \\([0-9]+\\)\\(.*\\)$" nil t)
                  (setq erg (copy-marker (point)))
                  (delete-region (progn (beginning-of-line)
                                        (save-match-data
                                          (when (looking-at
                                                 ;; all prompt-regexp known
                                                 ar-shell-prompt-regexp)
                                            (goto-char (match-end 0)))))

                                        (progn (skip-chars-forward " \t\r\n\f"   (line-end-position))(point)))
                  (insert (concat "    File " (buffer-name exception-buffer) ", line "
                                  (prin1-to-string origline)))))
              ;; these are let-bound as ‘tempbuf’
              ;; (and (boundp 'tempbuf)
              ;;      (search-forward (buffer-name tempbuf) nil t)
              ;;      (delete-region (line-beginning-position) (1+ (line-end-position))))
              ;; if no buffer-file exists, signal "Buffer", not "File(when
              (when erg
                (goto-char erg)
                ;; (forward-char -1)
                ;; (skip-chars-backward "^\t\r\n\f")
                ;; (skip-chars-forward " \t")
                (save-match-data
                  (and (not (ar--buffer-filename-remote-maybe
                             (or
                              (get-buffer exception-buffer)
                              (get-buffer (file-name-nondirectory exception-buffer)))))
                       (string-match "^[ \t]*File" (buffer-substring-no-properties (point) (line-end-position)))
                       (looking-at "[ \t]*File")
                       (replace-match " Buffer")))
                (push origline ar-error)
                (push (buffer-name exception-buffer) ar-error)
                (forward-line 1)
                (when (looking-at "[ \t]*\\([^\t\n\r\f]+\\)[ \t]*$")
                  (setq estring (match-string-no-properties 1))
                  (setq ecode (replace-regexp-in-string "[ \n\t\f\r^]+" " " estring))
                  (push (quote ar-error) ecode))))))
        ar-error))))

(defun ar-execute-SomeMode-mode-v5 (start end &optional origline filename)
  "Take START END &optional EXCEPTION-BUFFER ORIGLINE."
  (interactive
   (list (region-beginning) (region-end) (ar-count-lines)(and (buffer-file-name) (buffer-file-name))))
  (let ((ar-mode-v5-behavior-p t)
        (output-buffer "*SOME Output*")
        (ar-split-window-on-execute 'just-two)
        (pcmd (concat ar-shell-name (if (string-equal ar-which-bufname
                                                      "Jython")
                                        " -"
                                      ;; " -c "
                                      "")))
        ;; (filename (and (buffer-file-name) (buffer-file-name)))
        )
    (save-excursion
      (shell-command-on-region start end
                               pcmd output-buffer))
    (if (not (get-buffer output-buffer))
        (message "ar-execute-SomeMode-mode-v5: No output.")
      (setq ar-result (ar--fetch-result (with-temp-buffer  (get-buffer output-buffer))))
      (if (string-match "Traceback" ar-result)
          (message "%s" (setq ar-error (ar--fetch-error output-buffer origline filename)))
        (when ar-verbose-p (message "%s" ar-result))
        ar-result))))

(defun ar--execute-ge24.3 (start end execute-directory which-shell &optional exception-buffer proc file origline)
  "An alternative way to do it.

According to START END EXECUTE-DIRECTORY WHICH-SHELL
Optional EXCEPTION-BUFFER PROC FILE ORIGLINE
May we get rid of the temporary file?"
  (and (ar--buffer-filename-remote-maybe) buffer-offer-save (buffer-modified-p (ar--buffer-filename-remote-maybe)) (y-or-n-p "Save buffer before executing? ")
       (write-file (ar--buffer-filename-remote-maybe)))
  (let* ((start (copy-marker start))
         (end (copy-marker end))
         (exception-buffer (or exception-buffer (current-buffer)))
         (line (ar-count-lines (point-min) (if (eq start (line-beginning-position)) (1+ start) start)))
         (strg (buffer-substring-no-properties start end))
         (tempfile (or (ar--buffer-filename-remote-maybe) (concat (expand-file-name ar-temp-directory) ar-separator-char (replace-regexp-in-string ar-separator-char "-" "temp") ".py")))

         (proc (or proc (if ar-dedicated-process-p
                            (get-buffer-process (ar-shell nil nil t which-shell))
                          (or (get-buffer-process ar-buffer-name)
                              (get-buffer-process (ar-shell nil nil ar-dedicated-process-p which-shell ar-buffer-name))))))
         (procbuf (process-buffer proc))
         (file (or file (with-current-buffer ar-buffer-name
                          (concat (file-remote-p default-directory) tempfile))))
         (filebuf (get-buffer-create file)))
    (set-buffer filebuf)
    (erase-buffer)
    (newline line)
    (save-excursion
      (insert strg))
    (ar--fix-start (buffer-substring-no-properties (point) (point-max)))
    (unless (string-match "[jJ]ython" which-shell)
      ;; (when (and execute-directory ar-use-current-dir-when-execute-p
      ;; (not (string= execute-directory default-directory)))
      ;; (message "Warning: options ‘execute-directory’ and ‘ar-use-current-dir-when-execute-p’ may conflict"))
      (and execute-directory
           (process-send-string proc (concat "import os; os.chdir(\"" execute-directory "\")\n"))))
    (set-buffer filebuf)
    (process-send-string proc
                         (buffer-substring-no-properties
                          (point-min) (point-max)))
    (sit-for 0.1 t)
    (if (and (setq ar-error (save-excursion (ar--postprocess-intern origline exception-buffer)))
             (car ar-error)
             (not (markerp ar-error)))
        (ar--jump-to-exception ar-error origline)
      (unless (string= (buffer-name (current-buffer)) (buffer-name procbuf))
        (when ar-verbose-p (message "Output buffer: %s" procbuf))))))

(defun ar--execute-base-intern (strg filename proc wholebuf buffer origline execute-directory start end &optional fast)
  "Select the handler according to:

STRG FILENAME PROC FILE WHOLEBUF
BUFFER ORIGLINE EXECUTE-DIRECTORY START END WHICH-SHELL
Optional FAST RETURN"
  (setq ar-error nil)
  (cond ;; (fast (ar-fast-send-string strg proc buffer result))
   ;; enforce proceeding as SomeMode-mode.el v5
   (ar-mode-v5-behavior-p
    (ar-execute-SomeMode-mode-v5 start end origline filename))
   (ar-execute-no-temp-p
    (ar--execute-ge24.3 start end execute-directory ar-shell-name ar-exception-buffer proc filename origline))
   ((and filename wholebuf)
    (ar--execute-file-base filename proc nil buffer origline fast))
   (t
    ;; (message "(current-buffer) %s" (current-buffer))
    (ar--execute-buffer-finally strg proc buffer origline filename fast wholebuf)
    ;; (ar--delete-temp-file tempfile)
    )))

(defun ar--execute-base (&optional start end shell filename proc wholebuf fast dedicated split switch)
  "Update optional variables.
START END SHELL FILENAME PROC FILE WHOLEBUF FAST DEDICATED SPLIT SWITCH."
  (setq ar-error nil)
  (when ar-debug-p (message "ar--execute-base: (current-buffer): %s" (current-buffer)))
  ;; (when (or fast ar-fast-process-p) (ignore-errors (ar-kill-buffer-unconditional ar-output-buffer)))
  (let* ((orig (point))
         (fast (or fast ar-fast-process-p))
         (exception-buffer (current-buffer))
         (start (or start (and (use-region-p) (region-beginning)) (point-min)))
         (end (or end (and (use-region-p) (region-end)) (point-max)))
         (strg-raw (if ar-if-name-main-permission-p
                       (buffer-substring-no-properties start end)
                     (ar--fix-if-name-main-permission (buffer-substring-no-properties start end))))
         (strg (ar--fix-start strg-raw))
         (wholebuf (unless filename (or wholebuf (and (eq (buffer-size) (- end start))))))
         ;; error messages may mention differently when running from a temp-file
         (origline
          (format "%s" (save-restriction
                         (widen)
                         (ar-count-lines (point-min) orig))))
         ;; argument SHELL might be a string like "SomeMode", "ISOME" "SomeMode3", a symbol holding PATH/TO/EXECUTABLE or just a symbol like 'SomeMode3
         (shell (or
                 (and shell
                      ;; shell might be specified in different ways
                      (or (and (stringp shell) shell)
                          (ignore-errors (eval shell))
                          (and (symbolp shell) (format "%s" shell))))
                 ;; (save-excursion
                 (ar-choose-shell)
                 ;;)
                 ))
         (shell (or shell (ar-choose-shell)))
         (buffer-name
          (ar--choose-buffer-name shell dedicated fast))
         (execute-directory
          (cond ((ignore-errors (file-name-directory (file-remote-p (buffer-file-name) 'localname))))
                ((and ar-use-current-dir-when-execute-p (buffer-file-name))
                 (file-name-directory (buffer-file-name)))
                ((and ar-use-current-dir-when-execute-p
                      ar-fileless-buffer-use-default-directory-p)
                 (expand-file-name default-directory))
                ((stringp ar-execute-directory)
                 ar-execute-directory)
                ((getenv "VIRTUAL_ENV"))
                (t (getenv "HOME"))))
         (filename (or (and filename (expand-file-name filename))
                       (ar--buffer-filename-remote-maybe)))
         (ar-orig-buffer-or-file (or filename (current-buffer)))
         (proc-raw (or proc (get-buffer-process buffer-name)))

         (proc (or proc-raw (get-buffer-process buffer-name)
                   (prog1
                       (get-buffer-process (ar-shell nil nil dedicated shell buffer-name fast exception-buffer split switch))
                     (sit-for 0.1))))

         ;; (split (if ar-mode-v5-behavior-p 'just-two split))
         )
    (setq ar-output-buffer (or (and ar-mode-v5-behavior-p "*SOME Output*")
                               (and proc (buffer-name (process-buffer proc)))
                               (ar--choose-buffer-name shell dedicated fast)))
    (ar--execute-base-intern strg filename proc wholebuf ar-output-buffer origline execute-directory start end fast)))

(provide 'ar-start3)
;;; ar-start3.el ends here
