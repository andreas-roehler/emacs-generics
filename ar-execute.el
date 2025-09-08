;;; ar-execute.el --- Part of ar-mode -*- lexical-binding: t; -*-

(defun ar-switch-to-SomeMode (eob-p)
  "Switch to the SOME process buffer, maybe starting new process.

With EOB-P, go to end of buffer."
  (interactive "p")
  (pop-to-buffer (process-buffer (ar-proc)) t) ;Runs SomeMode if needed.
  (when eob-p
    (goto-char (point-max))))

;;  Split-Windows-On-Execute forms
(defun ar-toggle-split-windows-on-execute (&optional arg)
  "If ‘ar-split-window-on-execute’ should be on or off.

optional ARG
  Returns value of ‘ar-split-window-on-execute’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-split-window-on-execute -1 1))))
    (if (< 0 arg)
        (setq ar-split-window-on-execute t)
      (setq ar-split-window-on-execute nil))
    (when (called-interactively-p 'any) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
    ar-split-window-on-execute))

(defun ar-split-windows-on-execute-on (&optional arg)
  "Make sure, ‘ar-split-window-on-execute’ according to ARG.

Returns value of ‘ar-split-window-on-execute’."
  (interactive "p")
  (let ((arg (or arg 1)))
    (ar-toggle-split-windows-on-execute arg))
  (when (called-interactively-p 'any) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
  ar-split-window-on-execute)

(defun ar-split-windows-on-execute-off ()
  "Make sure, ‘ar-split-window-on-execute’ is off.

Returns value of ‘ar-split-window-on-execute’."
  (interactive)
  (ar-toggle-split-windows-on-execute -1)
  (when (called-interactively-p 'any) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
  ar-split-window-on-execute)

;;  Shell-Switch-Buffers-On-Execute forms
(defun ar-toggle-switch-buffers-on-execute (&optional arg)
  "If ‘ar-switch-buffers-on-execute-p’ according to ARG.

  Returns value of ‘ar-switch-buffers-on-execute-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-switch-buffers-on-execute-p -1 1))))
    (if (< 0 arg)
        (setq ar-switch-buffers-on-execute-p t)
      (setq ar-switch-buffers-on-execute-p nil))
    (when (called-interactively-p 'any) (message "ar-shell-switch-buffers-on-execute: %s" ar-switch-buffers-on-execute-p))
    ar-switch-buffers-on-execute-p))

(defun ar-switch-buffers-on-execute-on (&optional arg)
  "Make sure, ‘ar-switch-buffers-on-execute-p’ according to ARG.

Returns value of ‘ar-switch-buffers-on-execute-p’."
  (interactive "p")
  (let ((arg (or arg 1)))
    (ar-toggle-switch-buffers-on-execute arg))
  (when (called-interactively-p 'any) (message "ar-shell-switch-buffers-on-execute: %s" ar-switch-buffers-on-execute-p))
  ar-switch-buffers-on-execute-p)

(defun ar-switch-buffers-on-execute-off ()
  "Make sure, ‘ar-switch-buffers-on-execute-p’ is off.

Returns value of ‘ar-switch-buffers-on-execute-p’."
  (interactive)
  (ar-toggle-switch-buffers-on-execute -1)
  (when (called-interactively-p 'any) (message "ar-shell-switch-buffers-on-execute: %s" ar-switch-buffers-on-execute-p))
  ar-switch-buffers-on-execute-p)

(defun ar-guess-default-SomeMode ()
  "Defaults to \"SomeMode\", if guessing did not succeed."
  (interactive)
  (let* ((ptn (or ar-shell-name (ar-choose-shell) "SomeMode"))
         (erg (if ar-edit-only-p ptn (executable-find ptn))))
    (when (called-interactively-p 'any)
      (if erg
          (message "%s" ptn)
        (message "%s" "Could not detect SOME on your system")))))

;;  from iSomeMode.el
(defun ar-dirstack-hook ()
  "To synchronize dir-changes."
  (make-local-variable 'shell-dirstack)
  (setq shell-dirstack nil)
  (make-local-variable 'shell-last-dir)
  (setq shell-last-dir nil)
  (make-local-variable 'shell-dirtrackp)
  (setq shell-dirtrackp t)
  (add-hook 'comint-input-filter-functions 'shell-directory-tracker nil t))

(defalias (quote ar-dedicated-shell) (quote ar-shell-dedicated))
(defun ar-shell-dedicated (&optional argprompt)
  "Start an interpreter in another window according to ARGPROMPT.

With optional \\[universal-argument] user is prompted by
‘ar-choose-shell’ for command and options to pass to the SOME
interpreter."
  (interactive "P")
  (ar-shell argprompt nil t))

(defun ar-kill-shell-unconditional (&optional shell)
  "With optional argument SHELL.

Otherwise kill default (I)SOME shell.
Kill buffer and its process.
Receives a ‘buffer-name’ as argument"
  (interactive)
  (let ((shell (or shell (ar-shell))))
    (ignore-errors (ar-kill-buffer-unconditional shell))))

(defun ar-kill-default-shell-unconditional ()
  "Kill buffer \"\*SOME\*\" and its process."
  (interactive)
  (ignore-errors (ar-kill-buffer-unconditional "*SOME*")))

(defun ar--report-executable (buffer)
  (let ((erg (downcase (replace-regexp-in-string
                        "<\\([0-9]+\\)>" ""
                        (replace-regexp-in-string
                         "\*" ""
                         (if
                             (string-match " " buffer)
                             (substring buffer (1+ (string-match " " buffer)))
                           buffer))))))
    (when (string-match "-" erg)
      (setq erg (substring erg 0 (string-match "-" erg))))
    erg))

(defun ar--guess-buffer-name (argprompt dedicated)
  "Guess the ‘buffer-name’ core string according to ARGPROMPT DEDICATED."
  (when (and (not dedicated) argprompt
             (eq 4 (prefix-numeric-value argprompt)))
    (read-buffer "ar-Shell buffer: "
                 (generate-new-buffer-name (ar--choose-buffer-name)))))

(defun ar--configured-shell (name)
  "Return the configured PATH/TO/STRING if any according to NAME."
  (if (string-match "//\\|\\\\" name)
      name
    (cond ((string-match "^[Ii]" name)
           (or ar-iSomeMode-command name))
          ((string-match "[Pp]ython3" name)
           (or ar-SomeMode3-command name))
          ((string-match "[Pp]ython2" name)
           (or ar-SomeMode2-command name))
          ((string-match "[Jj]ython" name)
           (or ar-jython-command name))
          (t (or ar-SomeMode-command name)))))

(defun ar--determine-local-default ()
  (if (not (string= "" ar-shell-local-path))
      (expand-file-name ar-shell-local-path)
    (when ar-use-local-default
      (error "Abort: ‘ar-use-local-default’ is set to t but ‘ar-shell-local-path’ is empty. Maybe call ‘y-toggle-local-default-use’"))))

(defun ar-switch-to-shell ()
  "Switch to SOME process buffer."
  (interactive)
  (pop-to-buffer (ar-shell) t))

;;  Code execution commands

(defun ar--store-result (erg)
  "If no error occurred and ‘ar-store-result-p’ store ERG for yank."
  (and (not ar-error) erg (or ar-debug-p ar-store-result-p) (kill-new erg)))

(defun ar-current-working-directory ()
  "Return the directory of current SomeMode SHELL."
  (interactive)
  (let* ((proc (get-buffer-process (current-buffer)))
         erg)
    (if proc
        (setq erg (ar-execute-string (concat "import os\;os.getcwd()") proc nil t))
      (setq erg (replace-regexp-in-string "\n" "" (shell-command-to-string (concat ar-shell-name " -c \"import os; print(os.getcwd())\"")))))
    (when (called-interactively-p 'interactive)
      (message "CWD: %s" erg))
    erg))

(defun ar-set-working-directory (&optional directory)
  "Set working directory according to optional DIRECTORY.

When given, to value of ‘ar-default-working-directory’ otherwise"
  (interactive)
  (let* ((proc (get-buffer-process (current-buffer)))
        (dir (or directory ar-default-working-directory))
        erg)
    ;; (ar-execute-string (concat "import os\;os.chdir(\"" dir "\")") proc nil t)
    (ar-execute-string (concat "import os\;os.chdir(\"" dir "\")") proc nil t)
    (setq erg (ar-execute-string "os.getcwd()" proc nil t))
    (when (called-interactively-p 'interactive)
      (message "CWD changed to: %s" erg))
    erg))

(defun ar--update-execute-directory-intern (dir proc procbuf fast)
  (let ((strg (concat "import os\;os.chdir(\"" dir "\")")))
    (if fast
        (ar-fast-send-string strg proc procbuf t t)
      (ar-execute-string strg proc nil t))))
;; (comint-send-string proc (concat "import os;os.chdir(\"" dir "\")\n")))

(defun ar--update-execute-directory (proc procbuf execute-directory fast)
  (with-current-buffer procbuf
    (let ((cwd (ar-current-working-directory)))
      (unless (string= execute-directory (concat cwd "/"))
        (ar--update-execute-directory-intern (or ar-execute-directory execute-directory) proc procbuf fast)))))

(defun ar--close-execution (tempbuf tempfile)
  "Delete TEMPBUF and TEMPFILE."
  (unless ar-debug-p
    (when tempfile (ar-delete-temporary tempfile tempbuf))))

(defun ar--SomeMode-send-setup-code-intern (name buffer)
  "Send setup code to BUFFER according to NAME, a string."
  (save-excursion
    (let ((setup-file (concat (ar--normalize-directory ar-temp-directory) "ar-" name "-setup-code.py"))
          ar-return-result-p ar-store-result-p)
      (unless (file-readable-p setup-file)
        (with-temp-buffer
          (insert (eval (car (read-from-string (concat "ar-" name "-setup-code")))))
          (write-file setup-file)))
      (ar--execute-file-base setup-file (get-buffer-process buffer) nil buffer)
      )))

(defun ar--SomeMode-send-completion-setup-code (buffer)
  "For SOME see ar--SomeMode-send-setup-code.
Argument BUFFER the buffer completion code is sent to."
  (ar--SomeMode-send-setup-code-intern "shell-completion" buffer))

(defun ar--iSomeMode-import-module-completion ()
  "Setup ISOME v0.11 or greater.

Used by ‘ar-iSomeMode-module-completion-string’"
  (let ((setup-file (concat (ar--normalize-directory ar-temp-directory) "ar-iSomeMode-module-completion.py")))
    (unless (file-readable-p setup-file)
      (with-temp-buffer
        (insert ar-iSomeMode-module-completion-code)
        (write-file setup-file)))
    (ar--execute-file-base setup-file nil nil (current-buffer) nil t)))

(defun ar-delete-temporary (&optional file filebuf)
  (when (file-readable-p file)
    (delete-file file))
  (when (buffer-live-p filebuf)
    (set-buffer filebuf)
    (set-buffer-modified-p 'nil)
    (kill-buffer filebuf)))

(defun ar--insert-offset-lines (line)
  "Fix offline amount, make error point at the correct LINE."
  (insert (make-string (- line (ar-count-lines (point-min) (point))) 10)))

(defun ar-execute-string-dedicated (&optional strg shell switch fast)
  "Send the argument STRG to an unique SOME interpreter.

Optional SHELL SWITCH FAST
See also ‘ar-execute-region’."
  (interactive)
  (let ((strg (or strg (read-from-minibuffer "String: ")))
        (shell (or shell (default-value (quote ar-shell-name)))))
    (with-temp-buffer
      (insert strg)
      (ar-execute-region (point-min) (point-max) shell t switch fast))))

(defun ar--insert-execute-directory (directory &optional orig done)
  (let ((orig (or orig (point)))
        (done done))
    (if done (goto-char done) (goto-char (point-min)))
    (cond ((re-search-forward "^from __future__ import " nil t 1)
           (ar-forward-statement)
           (setq done (point))
           (ar--insert-execute-directory directory orig done))
          ((re-search-forward ar-encoding-string-re nil t 1)
           (setq done (point))
           (ar--insert-execute-directory directory orig done))
          ((re-search-forward ar-shebang-regexp nil t 1)
           (setq done (point))
           (ar--insert-execute-directory directory orig done))
          (t (forward-line 1)
             (unless (eq 9 (char-after)) (newline 1))
             (insert (concat "import os; os.chdir(\"" directory "\")\n"))))))

;; ‘ar-execute-line’ calls void function, lp:1492054,  lp:1519859
(or (functionp 'indent-rigidly-left)
    (defun indent-rigidly--pop-undo ()
      (and (memq last-command '(indent-rigidly-left indent-rigidly-right
                                                    indent-rigidly-left-to-tab-stop
                                                    indent-rigidly-right-to-tab-stop))
           (consp buffer-undo-list)
           (eq (car buffer-undo-list) nil)
           (pop buffer-undo-list)))

    (defun indent-rigidly-left (beg end)
      "Indent all lines between BEG and END leftward by one space."
      (interactive "r")
      (indent-rigidly--pop-undo)
      (indent-rigidly
       beg end
       (if (eq (current-bidi-paragraph-direction) 'right-to-left) 1 -1))))

(defun ar--qualified-module-name (file)
  "Return the fully qualified SOME module name for FILE.

FILE is a string.  It may be an absolute or a relative path to
any file stored inside a SOME package directory, although
typically it would be a (absolute or relative) path to a SOME
source code file stored inside a SOME package directory.

This collects all directories names that have a __init__.py
file in them, starting with the directory of FILE and moving up."
  (let ((module-name (file-name-sans-extension (file-name-nondirectory file)))
        (dirname     (file-name-directory (expand-file-name file))))
    (while (file-exists-p (expand-file-name "__init__.py" dirname))
      (setq module-name
            (concat
             (file-name-nondirectory (directory-file-name dirname))
             "."
             module-name))
      (setq dirname (file-name-directory (directory-file-name dirname))))
    module-name))

(defun ar-execute-import-or-reload (&optional shell)
  "Import the current buffer's file in a SOME interpreter.

Optional SHELL
If the file has already been imported, then do reload instead to get
the latest version.

If the file's name does not end in \".py\", then do execfile instead.

If the current buffer is not visiting a file, do ‘ar-execute-buffer’
instead.

If the file local variable ‘ar-master-file’ is non-nil, import or
reload the named file instead of the buffer's file.  The file may be
saved based on the value of ‘ar-execute-import-or-reload-save-p’.

See also ‘\\[py-execute-region]’.

This may be preferable to ‘\\[py-execute-buffer]’ because:

 - Definitions stay in their module rather than appearing at top
   level, where they would clutter the global namespace and not affect
   uses of qualified names (MODULE.NAME).

 - The SOME debugger gets line number information about the functions."
  (interactive)
  ;; Check file local variable ar-master-file
  (when ar-master-file
    (let* ((filename (expand-file-name ar-master-file))
           (buffer (or (get-file-buffer filename)
                       (find-file-noselect filename))))
      (set-buffer buffer)))
  (let ((ar-shell-name (or shell (ar-choose-shell)))
        (file (ar--buffer-filename-remote-maybe)))
    (if file
        (let ((proc (or
                     (ignore-errors (get-process (file-name-directory shell)))
                     (get-buffer-process
                      (ar-shell nil nil ar-dedicated-process-p shell
                                ;; (or shell (default-value (quote ar-shell-name)))
                                (or shell ar-shell-name)
                     )))))
          ;; Maybe save some buffers
          (save-some-buffers (not ar-ask-about-save) nil)
          (ar--execute-file-base file proc
                                (if (string-match "\\.py$" file)
                                    (let ((m (ar--qualified-module-name (expand-file-name file))))
                                      (if (string-match "SomeMode2" ar-shell-name)
                                          (format "import sys\nif sys.modules.has_key('%s'):\n reload(%s)\nelse:\n import %s\n" m m m)
                                        (format "import sys,imp\nif'%s' in sys.modules:\n imp.reload(%s)\nelse:\n import %s\n" m m m)))
                                  ;; (format "execfile(r'%s')\n" file)
                                  (ar-execute-file-command file))))
      (ar-execute-buffer))))

(provide 'ar-execute)
;;; ar-execute.el ends here
