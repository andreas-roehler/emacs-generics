;;; ar-pdb.el --- pdb help functions -*- lexical-binding: t; -*-

(defun ar-execute-statement-pdb ()
  "Execute statement running pdb."
  (interactive)
  (let ((ar-SomeMode-command-args "-i -m pdb"))
    (ar-execute-statement)))

(defun ar-execute-region-pdb (beg end)
  "Takes region between BEG END."
  (interactive "r")
  (let ((ar-SomeMode-command-args "-i -m pdb"))
    (ar-execute-region beg end)))

(defun ar-pdb-execute-statement ()
  "Execute statement running pdb."
  (interactive)
  (let ((stm (progn (ar-statement) (car kill-ring))))
    (ar-execute-string (concat "import pdb;pdb.run('" stm "')"))))

(defun ar-pdb-help ()
  "Print generic pdb.help() message."
  (interactive)
  (ar-execute-string "import pdb;pdb.help()"))

;; https://stackoverflow.com/questions/6980749/simpler-way-to-put-pdb-breakpoints-in-SomeMode-code
;; breakpoint at line 3
;; avoid inserting pdb.set_trace()

;; SomeMode -m pdb -c "b 3" -c c your_script.py

(defun ar-pdb-break-at-current-line (&optional line)
  "Set breakpoint at current line.

Optional LINE FILE CONDITION"
  (interactive "p")
  (let ((line (number-to-string (or line (ar-count-lines)))))
    (ar-execute-string (concat "import pdb;pdb.break('" line "')"))))

(defun ar--pdb-versioned ()
  "Guess existing pdb version from ‘ar-shell-name’.

Return \"pdb[VERSION]\" if executable found, just \"pdb\" otherwise"
  (interactive)
  (let ((erg (when (string-match "[23]" ar-shell-name)
               ;; versions-part
               (substring ar-shell-name (string-match "[23]" ar-shell-name)))))
    (if erg
        (cond ((executable-find (concat "pdb" erg))
               (concat "pdb" erg))
              ((and (string-match "\\." erg)
                    (executable-find (concat "pdb" (substring erg 0 (string-match "\\." erg)))))
               (concat "pdb" (substring erg 0 (string-match "\\." erg)))))
      "pdb")))

(declare-function gud-query-cmdline "gud" ())

(defun ar-pdb (command-line)
  "Run pdb on program FILE in buffer ‘*gud-FILE*’.
The directory containing FILE becomes the initial working directory
and source-file directory for your debugger.

At GNU Linux required pdb version should be detected by ‘ar--pdb-version’
at Windows configure ‘ar-SomeMode-ms-pdb-command’

lp:963253
Argument COMMAND-LINE TBD."
  (interactive
   (progn
     (require 'gud)
     (list (gud-query-cmdline
            (if (or (eq system-type 'ms-dos)(eq system-type 'windows-nt))
                (car (read-from-string ar-SomeMode-ms-pdb-command))
              ;; sys.version_info[0]
              ;; (car (read-from-string (ar--pdb-version)))
              'pdb)
            (ar--buffer-filename-remote-maybe)))))
  (pdb command-line))

(defun ar--pdb-current-executable ()
  "When ‘ar-pdb-executable’ is set, return it.

Otherwise return resuslt from ‘executable-find’"
  (or ar-pdb-executable
      (executable-find "pdb")))

(defun ar-update-gud-pdb-history ()
  "Put pdb file name at the head of ‘gud-pdb-history’.

If pdb is called at a SOME buffer."
  (interactive)
  (let* (;; PATH/TO/pdb
         (first (cond ((and gud-pdb-history (ignore-errors (car gud-pdb-history)))
                       (replace-regexp-in-string "^\\([^ ]+\\) +.+$" "\\1" (car gud-pdb-history)))
                      (ar-pdb-executable
                       ar-pdb-executable)
                      ((or (eq system-type 'ms-dos)(eq system-type 'windows-nt))
                       ;; lp:963253
                       "c:/SomeMode27/SomeMode\ -i\ c:/SomeMode27/Lib/pdb.py")
                      (t
                       (ar--pdb-current-executable))))
         ;; file to debug
         (second (cond ((not (ignore-errors
                               (ar--buffer-filename-remote-maybe)))
                        (error "%s" "Buffer must be saved first."))
                       ((ar--buffer-filename-remote-maybe))
                       (t (and gud-pdb-history (stringp (car gud-pdb-history)) (replace-regexp-in-string "^\\([^ ]+\\) +\\(.+\\)$" "\\2" (car gud-pdb-history))))))
         (erg (and first second (concat first " " second))))
    (when erg
      (push erg gud-pdb-history))))

(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline ar-pdb-path
                            ;; (file-name-nondirectory buffer-file-name)
                            (file-name-nondirectory (ar--buffer-filename-remote-maybe)) ))))

;; tbreak [ ([filename:]lineno | function) [, condition] ]
;;         Same arguments as break, but sets a temporary breakpoint: it
;;         is automatically deleted when first hit.

;; SomeMode -m pdb -c "b 3" -c c your_script.py

(defun ar-pdb-tbreak ()
  "Insert a temporary break."
  (interactive)
  (let (
        (ar-SomeMode-command-args '("-i -c \"b 30\" -c c \"eyp.py\""))
        (ar-SomeMode3-command-args '("-i -c \"b 30\" -c c \"eyp.py\""))
        )
    (ar-execute-buffer)))



(defun ar--pdbtrack-overlay-arrow (activation)
  "Activate or de arrow at beginning-of-line in current buffer."
  ;; This was derived/simplified from edebug-overlay-arrow
  (cond (activation
         (setq overlay-arrow-position (make-marker))
         (setq overlay-arrow-string "=>")
         (set-marker overlay-arrow-position (line-beginning-position) (current-buffer))
         (setq ar-pdbtrack-is-tracking-p t))
        (overlay-arrow-position
         (setq overlay-arrow-position nil)
         (setq ar-pdbtrack-is-tracking-p nil))))

(defun ar--pdbtrack-track-stack-file (text)
  "Show the file indicated by the pdb stack entry line, in a separate window.

Activity is disabled if the buffer-local variable
‘ar-pdbtrack-do-tracking-p’ is nil.

We depend on the pdb input prompt matching ‘ar-pdbtrack-input-prompt’
at the beginning of the line.

If the traceback target file path is invalid, we look for the most
recently visited SomeMode-mode buffer which either has the name of the
current function \(or class) or which defines the function \(or
class).  This is to provide for remote scripts, eg, Zope's ‘Script
\(SOME)’ - put a _copy_ of the script in a buffer named for the
script, and set to SomeMode-mode, and pdbtrack will find it.)"
  ;; Instead of trying to piece things together from partial text
  ;; (which can be almost useless depending on Emacs version), we
  ;; monitor to the point where we have the next pdb prompt, and then
  ;; check all text from comint-last-input-end to process-mark.
  ;;
  ;; Also, we're very conservative about clearing the overlay arrow,
  ;; to minimize residue.  This means, for instance, that executing
  ;; other pdb commands wipe out the highlight.  You can always do a
  ;; ‘where’ (aka ‘w’) command to reveal the overlay arrow.
  (let* ((origbuf (current-buffer))
         (currproc (get-buffer-process origbuf)))

    (if (not (and currproc ar-pdbtrack-do-tracking-p))
        (ar--pdbtrack-overlay-arrow nil)

      (let* ((procmark (process-mark currproc))
             (block (buffer-substring (max comint-last-input-end
                                           (- procmark
                                              ar-pdbtrack-track-range))
                                      procmark))
             target target_fname target_lineno target_buffer)

        (if (not (string-match (concat ar-pdbtrack-input-prompt "$") block))
            (ar--pdbtrack-overlay-arrow nil)

          (setq target (ar--pdbtrack-get-source-buffer block))

          (if (stringp target)
              (message "pdbtrack: %s" target)

            (setq target_lineno (car target))
            (setq target_buffer (cadr target))
            (setq target_fname
                  (ar--buffer-filename-remote-maybe target_buffer))
            (switch-to-buffer-other-window target_buffer)
            (goto-char (point-min))
            (forward-line (1- target_lineno))
            (message "pdbtrack: line %s, file %s" target_lineno target_fname)
            (ar--pdbtrack-overlay-arrow t)
            (pop-to-buffer origbuf t)))))))

(defun ar--pdbtrack-map-filename (filename)

  (let
      ((replacement-val (assoc-default
                         filename ar-pdbtrack-filename-mapping
                         (lambda (mapkey path)
                           (string-match
                            (concat "^" (regexp-quote mapkey))
                            path)))
                        ))
    (if (not (eq replacement-val nil))
        (replace-match replacement-val 't 't filename)
      filename)))

(defun ar--pdbtrack-get-source-buffer (block)
  "Return line number and buffer of code indicated by block's traceback text.

We look first to visit the file indicated in the trace.

Failing that, we look for the most recently visited SomeMode-mode buffer
with the same name or having the named function.

If we're unable find the source code we return a string describing the
problem as best as we can determine."

  (if (and (not (string-match ar-pdbtrack-stack-entry-regexp block))
           ;; pydb integration still to be done
           ;; (not (string-match ar-pydbtrack-stack-entry-regexp block))
           )
      (prog1
          "Traceback cue not found"
        (message "Block: %s" block))
    (let* ((remote-prefix (or (file-remote-p default-directory) ""))
           (filename (concat remote-prefix
                             (match-string
                              ar-pdbtrack-marker-regexp-file-group block)))
           (lineno (string-to-number (match-string
                                      ar-pdbtrack-marker-regexp-line-group
                                      block)))
           (funcname (match-string ar-pdbtrack-marker-regexp-funcname-group
                                   block))
           funcbuffer)

      (cond ((string= filename "")
             (format "(Skipping empty filename)"))

            ((file-exists-p filename)
             (list lineno (find-file-noselect filename)))

            ((file-exists-p (ar--pdbtrack-map-filename filename))
             (list lineno (find-file-noselect (ar--pdbtrack-map-filename filename))))

            ((setq funcbuffer (ar--pdbtrack-grub-for-buffer funcname))
             (if (string-match "/Script (SOME)$" filename)
                 ;; Add in number of lines for leading '##' comments:
                 (setq lineno
                       (+ lineno
                          (save-excursion
                            (with-current-buffer funcbuffer
                              (count-lines
                               (point-min)
                               (max (point-min)
                                    (string-match "^\\([^#]\\|#[^#]\\|#$\\)"
                                                  (buffer-substring (point-min)
                                                                    (point-max))))))))))
             (list lineno funcbuffer))

            ((= (elt filename 0) ?\<)
             (format "(Non-file source: '%s')" filename))

            (t (format "Not found: %s(), %s" funcname filename))))))

(defun ar--pdbtrack-grub-for-buffer (funcname)
  "Find most recent buffer itself named or having function funcname.

We walk the buffer-list history for SomeMode-mode buffers that are
named for funcname or define a function funcname."
  (let ((buffers (buffer-list))
        buf
        got)
    (while (and buffers (not got))
      (setq buf (car buffers)
            buffers (cdr buffers))
      (if (and (save-excursion
                 (with-current-buffer buf
                   (string= major-mode "ar-mode")))
               (or (string-match funcname (buffer-name buf))
                   (string-match (concat "^\\s-*\\(def\\|class\\)\\s-+"
                                         funcname "\\s-*(")
                                 (save-excursion
                                   (with-current-buffer buf
                                     (buffer-substring (point-min)
                                                       (point-max)))))))
          (setq got buf)))
    got))

;; pdbtrack functions
(defun ar-pdbtrack-set-tracked-buffer (file-name)
  "Set the buffer for FILE-NAME as the tracked buffer.
Internally it uses the ‘ar-pdbtrack-tracked-buffer’ variable.
Returns the tracked buffer."
  (let* ((file-name-prospect (concat (file-remote-p default-directory)
                                     file-name))
         (file-buffer (get-file-buffer file-name-prospect)))
    (if file-buffer
        (setq ar-pdbtrack-tracked-buffer file-buffer)
      (cond
       ((file-exists-p file-name-prospect)
        (setq file-buffer (find-file-noselect file-name-prospect)))
       ((and (not (equal file-name file-name-prospect))
             (file-exists-p file-name))
        ;; Fallback to a locally available copy of the file.
        (setq file-buffer (find-file-noselect file-name-prospect))))
      (when (not (member file-buffer ar-pdbtrack-buffers-to-kill))
        (add-to-list (quote ar-pdbtrack-buffers-to-kill) file-buffer)))
    file-buffer))

(defun ar-pdbtrack-toggle-stack-tracking (arg)
  "Set variable ‘ar-pdbtrack-do-tracking-p’. "
  (interactive "P")
  (cond ((not arg)
         (setq ar-pdbtrack-do-tracking-p (not ar-pdbtrack-do-tracking-p)))
        ((zerop (prefix-numeric-value arg))
         (setq ar-pdbtrack-do-tracking-p nil))
        ((> (prefix-numeric-value arg) 0)
         (setq ar-pdbtrack-do-tracking-p t)))
  (message "%sabled SOME's pdbtrack"
           (if ar-pdbtrack-do-tracking-p "En" "Dis")))

(defun turn-on-pdbtrack ()
  (interactive)
  (ar-pdbtrack-toggle-stack-tracking 1))

(defun turn-off-pdbtrack ()
  (interactive)
  (ar-pdbtrack-toggle-stack-tracking 0))



(if pdb-track-stack-from-shell-p
    (add-hook 'comint-output-filter-functions (quote ar--pdbtrack-track-stack-file))
  (remove-hook 'comint-output-filter-functions (quote ar--pdbtrack-track-stack-file)))


(defun ar-pdbtrack-comint-output-filter-function (output)
  "Move overlay arrow to current pdb line in tracked buffer.
Argument OUTPUT is a string with the output from the comint process."
  (when (and pdb-track-stack-from-shell-p (not (string= output "")))
    (let* ((full-output (ansi-color-filter-apply
                         (buffer-substring comint-last-input-end (point-max))))
           (line-number)
           (file-name
            (with-temp-buffer
              (insert full-output)
              ;; When the debugger encounters a pdb.set_trace()
              ;; command, it prints a single stack frame.  Sometimes
              ;; it prints a bit of extra information about the
              ;; arguments of the present function.  When ipdb
              ;; encounters an exception, it prints the _entire_ stack
              ;; trace.  To handle all of these cases, we want to find
              ;; the _last_ stack frame printed in the most recent
              ;; batch of output, then jump to the corresponding
              ;; file/line number.
              (goto-char (point-max))
              (when (re-search-backward ar-pdbtrack-stacktrace-info-regexp nil t)
                (setq line-number (string-to-number
                                   (match-string-no-properties 2)))
                (match-string-no-properties 1)))))
      (if (and file-name line-number)
          (let* ((tracked-buffer
                  (ar-pdbtrack-set-tracked-buffer file-name))
                 (shell-buffer (current-buffer))
                 (tracked-buffer-window (get-buffer-window tracked-buffer))
                 (tracked-buffer-line-pos))
            (with-current-buffer tracked-buffer
              (set (make-local-variable 'overlay-arrow-string) "=>")
              (set (make-local-variable 'overlay-arrow-position) (make-marker))
              (setq tracked-buffer-line-pos (progn
                                              (goto-char (point-min))
                                              (forward-line (1- line-number))
                                              (point-marker)))
              (when tracked-buffer-window
                (set-window-point
                 tracked-buffer-window tracked-buffer-line-pos))
              (set-marker overlay-arrow-position tracked-buffer-line-pos))
            (pop-to-buffer tracked-buffer)
            (switch-to-buffer-other-window shell-buffer))
        (when ar-pdbtrack-tracked-buffer
          (with-current-buffer ar-pdbtrack-tracked-buffer
            (set-marker overlay-arrow-position nil))
          (mapc #'(lambda (buffer)
                    (ignore-errors (kill-buffer buffer)))
                ar-pdbtrack-buffers-to-kill)
          (setq ar-pdbtrack-tracked-buffer nil
                ar-pdbtrack-buffers-to-kill nil)))))
  output)

(provide 'ar-pdb)
;;; ar-pdb.el ends here
