;;; ar-start1.el --- Edit, debug, develop and run programs. -*- lexical-binding: t; -*-

(require 'ansi-color)
(ignore-errors (require 'subr-x))
(require 'cc-cmds)
(require 'comint)
(require 'compile)
(require 'custom)
(require 'ert)
(require 'flymake)
(require 'hippie-exp)
(require 'hideshow)
(require 'json)
(require 'shell)
(require 'thingatpt)
(require 'which-func)
(require 'tramp)
(require 'tramp-sh)
(require 'org-loaddefs)
(unless (functionp 'mapcan)
  (require 'cl-extra)
  ;; mapcan does not exist in Emacs 25
  (defalias 'mapcan 'cl-mapcan)
  )

;; (require 'org)

(or
 ar-install-directory
 (and (buffer-live-p (ignore-errors (set-buffer (get-buffer "SomeMode-mode.el")))) ;; mark for a generic mode
      (setq ar-install-directory (ignore-errors (file-name-directory (buffer-file-name (get-buffer "SomeMode-mode.el"))))))
 (and (buffer-live-p (ignore-errors (set-buffer (get-buffer "ar-mode.el"))))
      (setq ar-install-directory (ignore-errors (file-name-directory (buffer-file-name (get-buffer "ar-mode.el")))))))

;; credits to SomeMode.el

(unless (functionp 'file-local-name)
  (defun file-local-name (file)
    "Return the local name component of FILE.
This function removes from FILE the specification of the remote host
and the method of accessing the host, leaving only the part that
identifies FILE locally on the remote system.
The returned file name can be used directly as argument of
‘process-file’, ‘start-file-process’, or ‘shell-command’."
    (or (file-remote-p file 'localname) file)))

(defun ar---emacs-version-greater-23 ()
  "Return ‘t’ if emacs major version is above 23"
  (< 23 (string-to-number (car (split-string emacs-version "\\.")))))

;; (format "execfile(r'%s')\n" file)
(defun ar-execute-file-command (filename)
  "Return the command using FILENAME."
  (format "exec(compile(open(r'%s').read(), r'%s', 'exec')) # PYTHON-MODE\n" filename filename)
  )

(defun ar--beginning-of-buffer-p ()
  "Returns position, if cursor is at the beginning of buffer.
Return nil otherwise. "
  (when (bobp)(point)))

;;  (setq strip-chars-before  "[ \t\r\n]*")
(defun ar--string-strip (str &optional chars-before chars-after)
  "Return a copy of STR, CHARS removed.

Removed chars default to values of ‘ar-chars-before’ and ‘ar-chars-after’
i.e. spaces, tabs, carriage returns, newlines and newpages

Optional arguments ‘CHARS-BEFORE’ and ‘CHARS-AFTER’ override default"
  (let ((s-c-b (or chars-before
                   ar-chars-before))
        (s-c-a (or chars-after
                   ar-chars-after))
        (erg str))
    (setq erg (replace-regexp-in-string  s-c-b "" erg))
    (setq erg (replace-regexp-in-string  s-c-a "" erg))
    erg))

(defun ar-toggle-session-p (&optional arg)
  "Switch boolean variable ‘ar-session-p’.

With optional ARG message state switched to"
  (interactive "p")
  (setq ar-session-p (not ar-session-p))
  (when arg (message "ar-session-p: %s" ar-session-p)))

(defun ar-toggle-ar-return-result-p ()
  "Toggle value of ‘ar-return-result-p’."
  (interactive)
  (setq ar-return-result-p (not ar-return-result-p))
  (when (called-interactively-p 'interactive) (message "ar-return-result-p: %s" ar-return-result-p)))

;; (defcustom ar-autopair-mode nil
;;   "If ‘ar-mode’ calls (autopair-mode-on)

;; Default is nil
;; Load ‘autopair-mode’ written by Joao Tavora <joaotavora [at] gmail.com>
;; URL: http://autopair.googlecode.com"
;;   :type 'boolean
;;   :tag "ar-autopair-mode"
;;   :group 'ar-mode)

(make-variable-buffer-local 'ar-indent-list-style)

(make-variable-buffer-local 'ar-indent-offset)

(and
 ;; used as a string finally
 ;; kept a character not to break existing customizations
 (characterp ar-separator-char)(setq ar-separator-char (char-to-string ar-separator-char)))

;; (setq ar-shells
;; (list
;; ""
;; 'iSomeMode
;; 'iSomeMode2.7
;; 'iSomeMode3
;; 'jython
;; 'SomeMode
;; 'SomeMode2
;; 'SomeMode3
;; 'pypy
;; ))

(defun ar-install-named-shells-fix-doc (ele)
  "Internally used by ‘ar-load-named-shells’.

Argument ELE: a shell name, a string."
  (cond ((string-match "^i" ele)
         (concat "I" (capitalize (substring ele 1))))
        ((string-match "^pypy" ele)
         "PyPy")
        (t (capitalize ele))))

(make-variable-buffer-local 'ar-master-file)

(setq ar-pdbtrack-input-prompt "^[(<]*[Ii]?[Pp]y?db[>)]+ *")

;; (setq ar-pdbtrack-input-prompt "^[(< \t]*[Ii]?[Pp]y?db[>)]*.*")

(setq ar-fast-filter-re
  (concat "\\("
          (mapconcat 'identity
                     (delq nil
                           (list
                            ar-shell-input-prompt-1-regexp
                            ar-shell-input-prompt-2-regexp
                            ar-iSomeMode-input-prompt-re
                            ar-iSomeMode-output-prompt-re
                            ar-pdbtrack-input-prompt
                            ar-pydbtrack-input-prompt
                            "[.]\\{3,\\}:? *"
                            ))
                     "\\|")
          "\\)"))

;; made buffer-local as pdb might need t in all circumstances
(make-variable-buffer-local 'ar-switch-buffers-on-execute-p)

;; (defcustom ar-shell-name
;;   (if (eq system-type 'windows-nt)
;;       "C:/SOME27/SomeMode"
;;     "SomeMode")

;;   "A PATH/TO/EXECUTABLE or default value ‘ar-shell’ may look for.

;; If no shell is specified by command.

;; On Windows default is C:/SOME27/SomeMode
;; --there is no garantee it exists, please check your system--

;; Else SomeMode"
;;   :type 'string
;;   :tag "ar-shell-name
;; "
;;   :group 'ar-mode)

;; "/usr/bin/SomeMode3"

(setq ar-mode-syntax-table
      (let ((table (make-syntax-table)))
        ;; Give punctuation syntax to ASCII that normally has symbol
        ;; syntax or has word syntax and is not a letter.
        (let ((symbol (string-to-syntax "_"))
              (sst (standard-syntax-table)))
          (dotimes (i 128)
            (unless (= i ?_)
              (if (equal symbol (aref sst i))
                  (modify-syntax-entry i "." table)))))
        (modify-syntax-entry ?$ "." table)
        (modify-syntax-entry ?% "." table)
        ;; exceptions
        (modify-syntax-entry ?# "<" table)
        (modify-syntax-entry ?\n ">" table)
        (modify-syntax-entry ?' "\"" table)
        (modify-syntax-entry ?` "$" table)
        (if ar-underscore-word-syntax-p
            (modify-syntax-entry ?\_ "w" table)
          (modify-syntax-entry ?\_ "_" table))
        table))

(defun ar-toggle-ar-debug-p ()
  "Toggle value of ‘ar-debug-p’."
  (interactive)
  (setq ar-debug-p (not ar-debug-p))
  (when (called-interactively-p 'interactive) (message "ar-debug-p: %s" ar-debug-p)))

(make-variable-buffer-local 'ar-shell-complete-p)

;; (setq ar-colon-labelled-re "[ \\t]*[[:graph:]]* *: *[[:graph:]]+\\|[ \\t]*[\\*-] +[[:graph:]]")

;; "[ \t]+\\c.+"

(setq ar-symbol-re "[ \t]*\\c.+[ \t]*")

(setq ar-expression-skip-chars "^ [{(=#\t\r\n\f")

(setq ar-partial-expression-re (concat "[" ar-partial-expression-stop-backward-chars "]+"))

(setq ar-indent-re ".+")

;; (setq ar-operator-re "[ \t]*\\(\\.\\|+\\|-\\|*\\|//\\|//\\|&\\|%\\||\\|\\^\\|>>\\|<<\\|<\\|<=\\|>\\|>=\\|==\\|!=\\|=\\)[ \t]*")

(setq ar-variable-name-face 'ar-variable-name-face)

;; (defvar ar-font-lock-keywords nil)

;; Constants

(setq ar-block-closing-keywords-re
  "[ \t]*\\_<\\(return\\|raise\\|break\\|continue\\|pass\\)\\_>[ \n\t]*")

;; (defconst ar-except-re
;;   "[ \t]*\\_<except\\_>[:( \n\t]*"
;;   "Regular expression matching keyword which composes a try-block.")

;; 'name':

(setq ar-else-re "else")

;; (defconst ar-elif-block-re "[ \t]*\\_<elif\\_> +[[:alpha:]_][[:alnum:]_]* *[: \n\t]"
;;   "Matches the beginning of an ‘elif’ block.")

;; (setq ar-def-or-class-re "[ \t]*\\_<\\(async def\\|class\\|def\\)\\_>[ \n\t]")

;; (defconst ar-def-re "[ \t]*\\_<\\(async def\\|def\\)\\_>[ \n\t]"

(defun ar--arglist-indent (nesting &optional indent-offset)
  "Internally used by ‘ar-compute-indentation’"
  (if
      (and (eq 1 nesting)
           (save-excursion
             (back-to-indentation)
             (looking-at ar-extended-block-or-clause-re)))
      (progn
        (back-to-indentation)
        (1+ (+ (current-column) (* 2 (or indent-offset ar-indent-offset)))))
    (+ (current-indentation) (or indent-offset ar-indent-offset))))

(defun ar--quote-syntax (n)
  "Put ‘syntax-table’ property correctly on triple quote.
Used for syntactic keywords.  N is the match number (1, 2 or 3)."
  ;; Given a triple quote, we have to check the context to know
  ;; whether this is an opening or closing triple or whether it is
  ;; quoted anyhow, and should be ignored.  (For that we need to do
  ;; the same job as ‘syntax-ppss’ to be correct and it seems to be OK
  ;; to use it here despite initial worries.) We also have to sort
  ;; out a possible prefix -- well, we do not _have_ to, but I think it
  ;; should be treated as part of the string.

  ;; Test cases:
  ;;  ur"""ar""" x='"' # """
  ;; x = ''' """ ' a
  ;; '''
  ;; x '"""' x """ \"""" x
  (save-excursion
    (goto-char (match-beginning 0))
    (cond
     ;; Consider property for the last char if in a fenced string.
     ((= n 3)
      (let* ((syntax (parse-partial-sexp (point-min) (point))))
        (when (eq t (nth 3 syntax))     ; after unclosed fence
          (goto-char (nth 8 syntax))    ; fence position
          ;; (skip-chars-forward "uUrR")        ; skip any prefix
          ;; Is it a matching sequence?
          (if (eq (char-after) (char-after (match-beginning 2)))
              (eval-when-compile (string-to-syntax "|"))))))
     ;; Consider property for initial char, accounting for prefixes.
     ((or (and (= n 2) ; leading quote (not prefix)
               (not (match-end 1)))     ; prefix is null
          (and (= n 1) ; prefix
               (match-end 1)))          ; non-empty
      (unless (eq 'string (syntax-ppss-context (parse-partial-sexp (point-min) (point))))
        (eval-when-compile (string-to-syntax "|"))))
     ;; Otherwise (we're in a non-matching string) the property is
     ;; nil, which is OK.
     )))

;; testing

;; Pdb
;; #62, pdb-track in a shell buffer

(make-variable-buffer-local 'ar-pdbtrack-do-tracking-p)

;; subr-x.el might not exist yet

(defun ar-toggle-imenu-create-index ()
  "Toggle value of ‘ar--imenu-create-index-p’."
  (interactive)
  (setq ar--imenu-create-index-p (not ar--imenu-create-index-p))
  (when (called-interactively-p 'interactive)
    (message "ar--imenu-create-index-p: %s" ar--imenu-create-index-p)))

(defun ar-toggle-shell-completion ()
  "Switch value of buffer-local var ‘ar-shell-complete-p’."
  (interactive)
    (setq ar-shell-complete-p (not ar-shell-complete-p))
    (when (called-interactively-p 'interactive)
      (message "ar-shell-complete-p: %s" ar-shell-complete-p)))

(defun ar--at-raw-string ()
  "If at beginning of a raw-string."
  (and (looking-at "\"\"\"\\|'''") (member (char-before) (list ?u ?U ?r ?R))))

(defmacro ar-preceding-line-backslashed-p ()
  "Return t if preceding line is a backslashed continuation line."
  `(save-excursion
     (beginning-of-line)
     (skip-chars-backward " \t\r\n\f")
     (and (eq (char-before (point)) ?\\ )
          (ar-escaped-p))))

(defun ar--docstring-p (pos)
  "Check to see if there is a docstring at POS.

If succesful, returns beginning of docstring position in buffer"
  (save-excursion
    (let ((erg
           (progn
             (goto-char pos)
             (and (looking-at "\"\"\"\\|'''")
                  ;; https://github.com/swig/swig/issues/889
                  ;; def foo(rho, x):
                  ;;     r"""Calculate :math:`D^\nu \rho(x)`."""
                  ;;     return True
                  (if (ar--at-raw-string)
                      (progn
                        (forward-char -1)
                        (point))
                    (point))))))
      (when (and erg (or (bobp) (ar-backward-statement)))
        (when (or (bobp) (looking-at ar-def-or-class-re)(looking-at "\\_<__[[:alnum:]_]+__\\_>"))
          (list erg (progn (goto-char erg) (forward-sexp) (point))))))))

(defun ar--font-lock-syntactic-face-function (state)
  "STATE expected as result von (parse-partial-sexp (point-min) (point)."
  (if (nth 3 state)
      (if (ar--docstring-p (nth 8 state))
          'font-lock-doc-face
        'font-lock-string-face)
    'font-lock-comment-face))

(and (fboundp 'make-obsolete-variable)
     (make-obsolete-variable 'ar-mode-hook 'ar-mode-hook nil))

(defun ar-choose-shell-by-shebang (&optional shebang)
  "Choose shell by looking at #! on the first line.

If SHEBANG is non-nil, returns the shebang as string,
otherwise the SOME resp. Jython shell command name."
  (interactive)
  ;; look for an interpreter specified in the first line
  (let* (erg res)
    (save-excursion
      (goto-char (point-min))
      (when (looking-at ar-shebang-regexp)
        (if shebang
            (setq erg (match-string-no-properties 0))
          (setq erg (split-string (match-string-no-properties 0) "[#! \t]"))
          (dolist (ele erg)
            (when (string-match "[bijp]+ython" ele)
              (setq res ele))))))
    (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" res))
    res))

(defun ar--choose-shell-by-import ()
  "Choose CSOME or Jython mode based imports.

If a file imports any packages in ‘ar-jython-packages’, within
‘ar-import-check-point-max’ characters from the start of the file,
return ‘jython’, otherwise return nil."
  (let (mode)
    (save-excursion
      (goto-char (point-min))
      (while (and (not mode)
                  (search-forward-regexp
                   "^\\(\\(from\\)\\|\\(import\\)\\) \\([^ \t\n.]+\\)"
                   ar-import-check-point-max t))
        (setq mode (and (member (match-string 4) ar-jython-packages)
                        'jython))))
    mode))

(defun ar-choose-shell-by-path (&optional separator-char)
  "SEPARATOR-CHAR according to system variable ‘path-separator’.

Select SOME executable according to version desplayed in path.
Returns versioned string, nil if nothing appropriate found"
  (interactive)
  (let ((path (ar--buffer-filename-remote-maybe))
        (separator-char (or separator-char ar-separator-char))
                erg)
    (when (and path separator-char
               (string-match (concat separator-char "[iI]?[pP]ython[0-9.]+" separator-char) path))
      (setq erg (substring path
                           (1+ (string-match (concat separator-char "[iI]?[pP]ython[0-9.]+" separator-char) path)) (1- (match-end 0)))))
    (when (called-interactively-p 'any) (message "%s" erg))
    erg))

(defun ar-which-SomeMode (&optional shell)
  "Return version of SOME of current environment, a number.
Optional argument SHELL selected shell."
  (interactive)
  (let* ((cmd (or shell (ar-choose-shell)))
         (treffer (string-match "\\([23]*\\.?[0-9\\.]*\\)$" cmd))
         version erg)
    (if treffer
        ;; if a number if part of SomeMode name, assume its the version
        (setq version (substring-no-properties cmd treffer))
      (setq erg (shell-command-to-string (concat cmd " --version")))
      (setq version (cond ((string-match (concat "\\(on top of SOME \\)" "\\([0-9]\\.[0-9]+\\)") erg)
                           (match-string-no-properties 2 erg))
                          ((string-match "\\([0-9]\\.[0-9]+\\)" erg)
                           (substring erg 7 (1- (length erg)))))))
    (when (called-interactively-p 'any)
      (if version
          (when ar-verbose-p (message "%s" version))
        (message "%s" "Could not detect SOME on your system")))
    (string-to-number version)))

(defun ar-SomeMode-current-environment ()
  "Return path of current SOME installation."
  (interactive)
  (let* ((cmd (ar-choose-shell))
         (denv (shell-command-to-string (concat "type " cmd)))
         (erg (substring denv (string-match "/" denv))))
    (when (called-interactively-p 'any)
      (if erg
          (message "%s" erg)
        (message "%s" "Could not detect SOME on your system")))
    erg))

 ;; requested by org-mode still
(defalias 'ar-toggle-shells 'ar-choose-shell)

(defun ar--cleanup-process-name (res)
  "Make res ready for use by ‘executable-find’.

Returns RES or substring of RES"
  (if (string-match "<" res)
      (substring res 0 (match-beginning 0))
    res))

(defalias 'ar-which-shell 'ar-choose-shell)
(defun ar-choose-shell (&optional shell)
  "Return an appropriate executable as a string.

Does the following:
 - look for an interpreter with ‘ar-choose-shell-by-shebang’
 - examine imports using ‘ar--choose-shell-by-import’
 - look if Path/To/File indicates a SOME version
 - if not successful, return default value of ‘ar-shell-name’

When interactivly called, messages the SHELL name
Return nil, if no executable found."
  (interactive)
  ;; org-babel uses ‘ar-toggle-shells’ with arg, just return it
  (or shell
      (let* (done
             (erg
              (cond ((and ar-shell-name (executable-find ar-shell-name))
                     ar-shell-name)
                    (ar-force-ar-shell-name-p
                     (default-value 'ar-shell-name))
                    (ar-use-local-default
                     (if (not (string= "" ar-shell-local-path))
                         (expand-file-name ar-shell-local-path)
                       (message "Abort: ‘ar-use-local-default’ is set to ‘t’ but ‘ar-shell-local-path’ is empty. Maybe call ‘ar-toggle-local-default-use’")))
                    ((and (not ar-fast-process-p)
                          (comint-check-proc (current-buffer))
                          (setq done t)
                          (string-match "ython" (process-name (get-buffer-process (current-buffer)))))
                     (ar--cleanup-process-name (process-name (get-buffer-process (current-buffer)))))
                    ((ar-choose-shell-by-shebang))
                    ((ar--choose-shell-by-import))
                    ((ar-choose-shell-by-path))
                    (t (or
                        (and ar-SomeMode-command (executable-find ar-SomeMode-command) ar-SomeMode-command)
                        "SomeMode3"))))
             (cmd (if (or
                       ;; comint-check-proc was succesful
                       done
                       ar-edit-only-p)
                      erg
                    (executable-find erg))))
        (if cmd
            (when (called-interactively-p 'any)
              (message "%s" cmd))
          (when (called-interactively-p 'any) (message "%s" "Could not detect SOME on your system. Maybe set ‘ar-edit-only-p’?")))
        erg)))

(defun ar--normalize-directory (directory)
  "Make sure DIRECTORY ends with a file-path separator char.

Returns DIRECTORY"
  (cond ((string-match (concat ar-separator-char "$") directory)
         directory)
        ((not (string= "" directory))
         (concat directory ar-separator-char))))

(defun ar--normalize-SomeModepath (SomeModepath)
  "Make sure PYTHONPATH ends with a colon.

Returns PYTHONPATH"
  (let ((erg (cond ((string-match (concat path-separator "$") SomeModepath)
                    SomeModepath)
                   ((not (string= "" SomeModepath))
                    (concat SomeModepath path-separator))
                   (t SomeModepath))))
    erg))

(defun ar-install-directory-check ()
  "Do some sanity check for ‘ar-install-directory’.

Returns t if successful."
  (interactive)
  (let ((erg (and (boundp 'ar-install-directory) (stringp ar-install-directory) (< 1 (length ar-install-directory)))))
    (when (called-interactively-p 'any) (message "ar-install-directory-check: %s" erg))
    erg))

(defun ar--buffer-filename-remote-maybe (&optional file-name)
  "Argument FILE-NAME: the value of variable ‘buffer-file-name’."
  (let ((file-name (or file-name
                       (and
                        (ignore-errors (file-readable-p (buffer-file-name)))
                        (buffer-file-name)))))
    (if (and (featurep 'tramp) (tramp-tramp-file-p file-name))
        (tramp-file-name-localname
         (tramp-dissect-file-name file-name))
      file-name)))

(defun ar-guess-ar-install-directory ()
  "If `(locate-library \"SomeMode-mode\")' is not succesful.

Used only, if ‘ar-install-directory’ is empty."
  (interactive)
  (cond (;; do not reset if it already exists
         ar-install-directory)
        ;; ((locate-library "ar-mode")
        ;;  (file-name-directory (locate-library "ar-mode")))
        ((ignore-errors (string-match "ar-mode" (ar--buffer-filename-remote-maybe)))
         (file-name-directory (ar--buffer-filename-remote-maybe)))
        (t (if
               (and (get-buffer "SomeMode-mode.el")
                    (set-buffer (get-buffer "SomeMode-mode.el"))
                    ;; (setq ar-install-directory (ignore-errors (file-name-directory (buffer-file-name (get-buffer  "SomeMode-mode.el")))))
                    (buffer-file-name (get-buffer  "SomeMode-mode.el")))
               (setq ar-install-directory (file-name-directory (buffer-file-name (get-buffer  "SomeMode-mode.el"))))
             (if
                 (and
                  (get-buffer "ar-mode.el") ;; generic mark
                  (set-buffer (get-buffer "ar-mode.el")) ;; generic mark
                  (buffer-file-name (get-buffer "ar-mode.el"))) ;; generic mark
                 (setq ar-install-directory (file-name-directory (buffer-file-name (get-buffer "ar-mode.el")))))))))

(defun ar--fetch-SomeModepath ()
  "Consider settings of ‘ar-SomeModepath’."
  (if (string= "" ar-SomeModepath)
      (getenv "PYTHONPATH")
    (concat (ar--normalize-SomeModepath (getenv "PYTHONPATH")) ar-SomeModepath)))

(defun ar-load-pymacs ()
  "Load Pymacs as delivered.

Pymacs has been written by François Pinard and many others.
See original source: http://pymacs.progiciels-bpi.ca"
  (interactive)
  (let ((pyshell (ar-choose-shell))
        (path (ar--fetch-SomeModepath))
        (ar-install-directory (cond ((string= "" ar-install-directory)
                                     (ar-guess-ar-install-directory))
                                    (t (ar--normalize-directory ar-install-directory)))))
    (if (ar-install-directory-check)
        (progn
          ;; If Pymacs has not been loaded before, prepend ar-install-directory to
          ;; PYTHONPATH, so that the Pymacs delivered with SomeMode-mode is used.
          (unless (featurep 'pymacs)
            (setenv "PYTHONPATH" (concat
                                  (expand-file-name ar-install-directory)
                                  (if path (concat path-separator path)))))
          (setenv "PYMACS_PYTHON" (if (string-match "IP" pyshell)
                                      "SomeMode"
                                    pyshell))
          (require 'pymacs))
      (error "‘ar-install-directory’ not set, see INSTALL"))))

(when ar-load-pymacs-p (ar-load-pymacs))

(when (and ar-load-pymacs-p (featurep 'pymacs))
  (defun ar-load-pycomplete ()
    "Load Pymacs based pycomplete."
    (interactive)
    (let* ((path (ar--fetch-SomeModepath))
           (ar-install-directory (cond ((string= "" ar-install-directory)
                                        (ar-guess-ar-install-directory))
                                       (t (ar--normalize-directory ar-install-directory))))
           (pycomplete-directory (concat (expand-file-name ar-install-directory) "completion")))
      (if (ar-install-directory-check)
          (progn
            ;; If the Pymacs process is already running, augment its path.
            (when (and (get-process "pymacs") (fboundp 'pymacs-exec))
              (pymacs-exec (concat "sys.path.insert(0, '" pycomplete-directory "')")))
            (require 'pymacs)
            (setenv "PYTHONPATH" (concat
                                  pycomplete-directory
                                  (if path (concat path-separator path))))
            (push pycomplete-directory load-path)
            (require 'pycomplete)
            (add-hook 'ar-mode-hook 'ar-complete-initialize))
        (error "‘ar-install-directory’ not set, see INSTALL")))))

(when (functionp 'ar-load-pycomplete)
  (ar-load-pycomplete))

(defun ar-set-load-path ()
  "Include needed subdirs of ‘ar-mode’ directory."
  (interactive)
  (let ((install-directory (ar--normalize-directory ar-install-directory)))
    (if ar-install-directory
        (cond ((and (not (string= "" install-directory))(stringp install-directory))
               (push (expand-file-name install-directory) load-path)
               (push (concat (expand-file-name install-directory) "completion")  load-path)
               (push (concat (expand-file-name install-directory) "extensions")  load-path)
               (push (concat (expand-file-name install-directory) "test") load-path)
               )
              (t (error "Please set ‘ar-install-directory’, see INSTALL")))
      (error "Please set ‘ar-install-directory’, see INSTALL")))
  (when (called-interactively-p 'interactive) (message "%s" load-path)))

(defun ar-count-lines (&optional beg end)
  "Count lines in accessible part until current line.

See http://debbugs.gnu.org/cgi/bugreport.cgi?bug=7115
Optional argument BEG specify beginning.
Optional argument END specify end."
  (interactive)
  (save-excursion
    (let ((count 0)
          (beg (or beg (point-min)))
          (end (or end (point))))
      (save-match-data
        (if (or (eq major-mode 'comint-mode)
                (eq major-mode 'ar-shell-mode))
            (if
                (re-search-backward ar-shell-prompt-regexp nil t 1)
                (goto-char (match-end 0))
              ;; (when ar-debug-p (message "%s"  "ar-count-lines: Do not see a prompt here"))
              (goto-char beg))
          (goto-char beg)))
      (while (and (< (point) end)(not (eobp)) (skip-chars-forward "^\n" end))
        (setq count (1+ count))
        (unless (or (not (< (point) end)) (eobp)) (forward-char 1)
                (setq count (+ count (abs (skip-chars-forward "\n" end))))))
      (when (bolp) (setq count (1+ count)))
      (when (and ar-debug-p (called-interactively-p 'any)) (message "%s" count))
      count)))

(defun ar--escape-doublequotes (start end)
  "Escape doublequotes in region by START END."
  (let ((end (copy-marker end)))
    (save-excursion
      (goto-char start)
      (while (and (not (eobp)) (< 0 (abs (skip-chars-forward "^\"" end))))
        (when (eq (char-after) ?\")
          (unless (ar-escaped-p)
            (insert "\\")
            (forward-char 1)))))))

(defun ar--escape-open-paren-col1 (start end)
  "Start from position START until position END."
  (goto-char start)
  (while (re-search-forward "^(" end t 1)
    (insert "\\")
    (end-of-line)))

(and ar-company-pycomplete-p (require 'company-pycomplete))

(defun ar-empty-line-p ()
  "Return t if cursor is at an empty line, nil otherwise."
  (save-excursion
    (beginning-of-line)
    (looking-at ar-empty-line-p-chars)))

(defun ar-toggle-closing-list-dedents-bos (&optional arg)
  "Switch boolean variable ‘ar-closing-list-dedents-bos’.

With optional ARG message state switched to"
  (interactive "p")
  (setq ar-closing-list-dedents-bos (not ar-closing-list-dedents-bos))
  (when arg (message "ar-closing-list-dedents-bos: %s" ar-closing-list-dedents-bos)))

(defun ar-comint-delete-output ()
  "Delete all output from interpreter since last input.
Does not delete the prompt."
  (interactive)
  (let ((proc (get-buffer-process (current-buffer)))
        (replacement nil)
        (inhibit-read-only t))
    (save-excursion
      (let ((pmark (progn (goto-char (process-mark proc))
                          (forward-line 0)
                          (point-marker))))
        (delete-region comint-last-input-end pmark)
        (goto-char (process-mark proc))
        (setq replacement (concat "*** output flushed ***\n"
                                  (buffer-substring pmark (point))))
        (delete-region pmark (point))))
    ;; Output message and put back prompt
    (comint-output-filter proc replacement)))

(defun ar-in-comment-p ()
  "Return the beginning of current line's comment, if inside. "
  (interactive)
  (let ((pps (parse-partial-sexp (point-min) (point))))
    (and (nth 4 pps) (nth 8 pps))))

;;
(defun ar-in-string-or-comment-p ()
  "Returns beginning position if inside a string or comment, nil otherwise. "
  (or (nth 8 (parse-partial-sexp (point-min) (point)))
      (when (or (looking-at "\"") (looking-at "[ \t]*#[ \t]*"))
        (point))))

(when ar-org-cycle-p
  (define-key ar-mode-map (kbd "<backtab>") 'org-cycle))

(defun ar-forward-buffer ()
  "A complementary form used by auto-generated commands.

Returns position reached if successful"
  (interactive)
  (unless (eobp)
    (goto-char (point-max))))

(defun ar-backward-buffer ()
  "A complementary form used by auto-generated commands.

Returns position reached if successful"
  (interactive)
  (unless (bobp)
    (goto-char (point-min))))

(defun ar--beginning-of-line-form ()
  "Internal use: Go to beginning of line following end of form.

Return position."
  (if (eobp)
      (point)
    (forward-line 1)
    (beginning-of-line)
    (point)))

(defun ar--skip-to-semicolon-backward (&optional limit)
  "Fetch the beginning of statement after a semicolon.

Returns ‘t’ if point was moved"
  (prog1
      (< 0 (abs (skip-chars-backward "^;" (or limit (line-beginning-position)))))
    (skip-chars-forward " \t" (line-end-position))))

;; (defun ar-forward-comment ()
;;   "Go to the end of comment at point."
;;   (let ((orig (point))
;;         last)
;;     (while (and (not (eobp)) (nth 4 (parse-partial-sexp (line-beginning-position) (point))) (setq last (line-end-position)))
;;       (forward-line 1)
;;       (end-of-line))
;;     (when
;;         (< orig last)
;;       (goto-char last)(point))))

(defun ar-forward-comment ()
  "Go to the end of commented section at point."
  (interactive)
  (let (last)
    (while
        (and (not (eobp))
             (or
              (and comment-start (looking-at comment-start))
              (and comment-start-skip (looking-at comment-start-skip))
              (nth 4 (parse-partial-sexp (point-min) (point)))))
      (setq last (line-end-position))
      (forward-line 1)
      (skip-chars-forward " \t\r\n\f")
      (unless (or (eobp) (eq (point) last))
        (back-to-indentation)))
    (when last (goto-char last))))

(defun ar--forward-string-maybe (&optional start)
  "Go to the end of string.

Expects START position of string
Return position of moved, nil otherwise."
  (let ((orig (point)))
    (when start (goto-char start)
          (when (looking-at "\"\"\"\\|'''")
            (goto-char (1- (match-end 0)))
            (forward-sexp))
          ;; maybe at the inner fence
          (when (looking-at "\"\"\\|''")
            (goto-char (match-end 0)))
          (and (< orig (point)) (point)))))

(defun ar-load-skeletons ()
  "Load skeletons from extensions. "
  (interactive)
  (load (concat ar-install-directory "/extensions/ar-skeletons.el")))

(defun ar--kill-emacs-hook ()
  "Delete files in ‘ar-file-queue’.
These are SOME temporary files awaiting execution."
  (when (and ar-file-queue (listp ar-file-queue))
    (dolist (ele ar-file-queue)
      (ignore-errors (delete-file ele)))))

;; (defun ar--kill-emacs-hook ()
;;   "Delete files in ‘ar-file-queue’.
;; These are SOME temporary files awaiting execution."
;;   (when ar-file-queue
;;     (mapc #'(lambda (filename)
;;               (ignore-errors (delete-file filename)))
;;           ar-file-queue)))

(add-hook 'kill-emacs-hook 'ar--kill-emacs-hook)

;;  Add a designator to the minor mode strings
(or (assq 'ar-pdbtrack-is-tracking-p minor-mode-alist)
    (push '(ar-pdbtrack-is-tracking-p ar-pdbtrack-minor-mode-string)
          minor-mode-alist))

(defun ar--update-lighter (shell)
  "Select lighter for mode-line display"
  (setq ar-modeline-display
        (cond
         ;; ((eq 2 (prefix-numeric-value argprompt))
         ;; ar-SomeMode2-command-args)
         ((string-match "^[^-]+3" shell)
          ar-SomeMode3-modeline-display)
         ((string-match "^[^-]+2" shell)
          ar-SomeMode2-modeline-display)
         ((string-match "^.[Ii]" shell)
          ar-iSomeMode-modeline-display)
         ((string-match "^.[Jj]" shell)
          ar-jython-modeline-display)
         (t
          SomeMode-mode-modeline-display))))

;;  bottle.py
;;  py   = sys.version_info
;;  py3k = py >= (3,0,0)
;;  py25 = py <  (2,6,0)
;;  py31 = (3,1,0) <= py < (3,2,0)

;;  sys.version_info[0]
(defun ar-SomeMode-version (&optional executable verbose)
  "Returns versions number of a SOME EXECUTABLE, string.

If no EXECUTABLE given, ‘ar-shell-name’ is used.
Interactively output of ‘--version’ is displayed. "
  (interactive)
  (let* ((executable (or executable ar-shell-name))
         (erg (ar--string-strip (shell-command-to-string (concat executable " --version")))))
    (when (called-interactively-p 'any) (message "%s" erg))
    (unless verbose (setq erg (cadr (split-string erg))))
    erg))

(defun ar-version ()
  "Echo the current version of ‘ar-mode’ in the minibuffer."
  (interactive)
  (message "Using ‘ar-mode’ version %s" ar-version))

(declare-function compilation-shell-minor-mode "compile" (&optional arg))

(defun ar--warn-tmp-files-left ()
  "Detect and warn about file of form \"py11046IoE\" in ar-temp-directory."
  (let ((erg1 (file-readable-p (concat ar-temp-directory ar-separator-char (car (directory-files  ar-temp-directory nil "py[[:alnum:]]+$"))))))
    (when erg1
      (message "ar--warn-tmp-files-left: %s ?" (concat ar-temp-directory ar-separator-char (car (directory-files  ar-temp-directory nil "py[[:alnum:]]*$")))))))

(defun ar--fetch-indent-line-above (&optional orig)
  "Report the preceding indent. "
  (save-excursion
    (when orig (goto-char orig))
    (forward-line -1)
    (current-indentation)))

(defun ar-continuation-offset (&optional arg)
  "Set if numeric ARG differs from 1. "
  (interactive "p")
  (and (numberp arg) (not (eq 1 arg)) (setq ar-continuation-offset arg))
  (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" ar-continuation-offset))
  ar-continuation-offset)

(defun ar-list-beginning-position (&optional start)
  "Return lists beginning position, nil if not inside.

Optional ARG indicates a start-position for ‘parse-partial-sexp’."
  (nth 1 (parse-partial-sexp (or start (point-min)) (point))))

(defun ar-end-of-list-position (&optional arg)
  "Return end position, nil if not inside.

Optional ARG indicates a start-position for ‘parse-partial-sexp’."
  (interactive)
  (let* ((ppstart (or arg (point-min)))
         (erg (parse-partial-sexp ppstart (point)))
         (beg (nth 1 erg))
         end)
    (when beg
      (save-excursion
        (goto-char beg)
        (forward-list 1)
        (setq end (point))))
    (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" end))
    end))

(defun ar--in-comment-p ()
  "Return the beginning of current line's comment, if inside or at comment-start. "
  (save-restriction
    (widen)
    (let* ((pps (parse-partial-sexp (point-min) (point)))
           (erg (when (nth 4 pps) (nth 8 pps))))
      (unless erg
        (when (ignore-errors (looking-at (concat "[ \t]*" comment-start)))
          (setq erg (point))))
      erg)))

(defun ar-in-triplequoted-string-p ()
  "Returns character address of start tqs-string, nil if not inside. "
  (interactive)
  (let* ((pps (parse-partial-sexp (point-min) (point)))
         (erg (when (and (nth 3 pps) (nth 8 pps))(nth 2 pps))))
    (save-excursion
      (unless erg (setq erg
                        (progn
                          (when (looking-at "\"\"\"\\|''''")
                            (goto-char (match-end 0))
                            (setq pps (parse-partial-sexp (point-min) (point)))
                            (when (and (nth 3 pps) (nth 8 pps)) (nth 2 pps)))))))
    (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" erg))
    erg))

(defun ar-in-string-p-intern (pps)
  (goto-char (nth 8 pps))
  (list (point) (char-after)(skip-chars-forward (char-to-string (char-after)))))

(defun ar-in-string-p ()
  "if inside a double- triple- or singlequoted string,

If non-nil, return a list composed of
- beginning position
- the character used as string-delimiter (in decimal)
- and length of delimiter, commonly 1 or 3 "
  (interactive)
  (save-excursion
    (let* ((pps (parse-partial-sexp (point-min) (point)))
           (erg (when (nth 3 pps)
                  (ar-in-string-p-intern pps))))
      (unless erg
        (when (looking-at "\"\\|'")
          (forward-char 1)
          (setq pps (parse-partial-sexp (line-beginning-position) (point)))
          (when (nth 3 pps)
            (setq erg (ar-in-string-p-intern pps)))))
      erg)))

(defun ar-toggle-local-default-use ()
  "Toggle boolean value of ‘ar-use-local-default’.

Returns ‘ar-use-local-default’

See also ‘ar-install-local-shells’
Installing named virualenv shells is the preffered way,
as it leaves your system default unchanged."
  (interactive)
  (setq ar-use-local-default (not ar-use-local-default))
  (when (called-interactively-p 'any) (message "ar-use-local-default set to %s" ar-use-local-default))
  ar-use-local-default)

(defun ar--beginning-of-buffer-position ()
  "Provided for abstract reasons."
  (point-min))

(defun ar--end-of-buffer-position ()
  "Provided for abstract reasons."
  (point-max))

(defun ar-backward-comment ()
  "Got to beginning of a commented section.

Start from POS if specified"
  (interactive)
  (let ((last (point))
        (orig (point)))
    (while (and (not (bobp))
                (ignore-errors (< (ignore-errors (goto-char (ar-in-comment-p))) last)))
      (setq last (point))
      (skip-chars-backward " \t\r\n\f"))
    (and (< (point) orig) (< (point)  last) (goto-char last))))

(defun ar-go-to-beginning-of-comment ()
  "Go to the beginning of current line's comment, if any.

From a programm use macro ‘ar-backward-comment’ instead"
  (interactive)
  (let ((erg (ar-backward-comment)))
    (when (and ar-verbose-p (called-interactively-p 'any))
      (message "%s" erg))))

(defun ar--up-decorators-maybe (indent)
  (let ((last (point)))
    (while (and (not (bobp))
                (ar-backward-statement)
                (eq (current-indentation) indent)
                (if (looking-at ar-decorator-re)
                    (progn (setq last (point)) nil)
                  t)))
    (goto-char last)))

(defun ar-leave-comment-or-string-backward ()
  "If inside a comment or string, leave it backward."
  (interactive)
  (let ((pps
         (if (featurep 'xemacs)
             (parse-partial-sexp (point-min) (point))
           (parse-partial-sexp (point-min) (point)))))
    (when (nth 8 pps)
      (goto-char (1- (nth 8 pps))))))

;;  Decorator
(defun ar-backward-decorator ()
  "Go to the beginning of a decorator.

Returns position if succesful"
  (interactive)
  (let ((orig (point)))
    (unless (bobp) (forward-line -1)
            (back-to-indentation)
            (while (and (progn (looking-at "@\\w+")(not (looking-at "\\w+")))
                        (not
                         ;; (ar-empty-line-p)
                         (member (char-after) (list 9 10)))
                        (not (bobp))(forward-line -1))
              (back-to-indentation))
            (or (and (looking-at "@\\w+") (match-beginning 0))
                (goto-char orig)))))

(defun ar-forward-decorator ()
  "Go to the end of a decorator.

Returns position if succesful"
  (interactive)
  (let ((orig (point)) erg)
    (unless (looking-at "@\\w+")
      (setq erg (ar-backward-decorator)))
    (when erg
      (if
          (re-search-forward ar-def-or-class-re nil t)
          (progn
            (back-to-indentation)
            (skip-chars-backward " \t\r\n\f")
            (ar-leave-comment-or-string-backward)
            (skip-chars-backward " \t\r\n\f")
            (setq erg (point)))
        (goto-char orig)
        (end-of-line)
        (skip-chars-backward " \t\r\n\f")
        (when (ignore-errors (goto-char (ar-list-beginning-position)))
          (forward-list))
        (when (< orig (point))
          (setq erg (point))))
      erg)))

(defun ar-beginning-of-list-pps (&optional iact last ppstart orig done)
  "Go to the beginning of a list.

IACT - if called interactively
LAST - was last match.
Optional PPSTART indicates a start-position for ‘parse-partial-sexp’.
ORIG - consider original position or point.
DONE - transaktional argument
Return beginning position, nil if not inside."
  (interactive "p")
  (let* ((orig (or orig (point)))
         (ppstart (or ppstart (re-search-backward "^[a-zA-Z]" nil t 1) (point-min)))
         erg)
    (unless done (goto-char orig))
    (setq done t)
    (if
        (setq erg (nth 1 (if (featurep 'xemacs)
                             (parse-partial-sexp ppstart (point))
                           (parse-partial-sexp (point-min) (point)))))
        (progn
          (setq last erg)
          (goto-char erg)
          (ar-beginning-of-list-pps iact last ppstart orig done))
      last)))

(defun ar--record-list-error (pps)
  "When encountering a missing parenthesis, store its line, position.
‘ar-verbose-p’  must be t"
  (let ((this-err
         (save-excursion
           (list
            (nth 1 pps)
            (progn
              (goto-char (nth 1 pps))
              (ar-count-lines (point-min) (point)))))))
    this-err))

(defun ar--message-error (err)
  "Receives a list (position line) "
  (message "Closing paren missed: line %s pos %s" (cadr err) (car err)))

(defun ar--forward-regexp (regexp)
  "Search forward next regexp not in string or comment.

Return and move to match-beginning if successful"
  (save-match-data
    (let (erg)
      (while (and
              (setq erg (re-search-forward regexp nil 'move 1))
              (nth 8 (parse-partial-sexp (point-min) (point)))))
      (unless
          (nth 8 (parse-partial-sexp (point-min) (point)))
        erg))))

(defun ar--forward-regexp-keep-indent-endform (last orig)
  (unless
      (nth 8 (parse-partial-sexp (point-min) (point)))
    (if last (goto-char last)
      (back-to-indentation))
    (and (< orig (point)) (point))))

(defun ar--forward-regexp-keep-indent (regexp &optional indent)
  "Search forward next regexp not in string or comment.

Return and move to match-beginning if successful"
  (save-match-data
    (let ((indent (or indent (current-indentation)))
          (regexp (if (stringp regexp)
                      regexp
                    (symbol-value regexp)))
          (orig (point))
          last done)
      (forward-line 1)
      (beginning-of-line)
      (if (<= (current-indentation) indent)
          (ar--forward-regexp-keep-indent-endform last orig)
          (while (and
                  (not done)
                  (re-search-forward regexp nil 'move 1)
                  (or (nth 8 (parse-partial-sexp (point-min) (point)))
                      (or (< indent (current-indentation))(setq done t))
                      (setq last (line-end-position)))))
          (ar--forward-regexp-keep-indent-endform last orig)))))

(defun ar-down-base (regexp &optional indent bol)
  (let ((indent (or indent (current-indentation))))
    (and (ar--forward-regexp-keep-indent regexp indent)
         (progn
           (if bol
               (beginning-of-line)
             (back-to-indentation))
           (point)))))

(defun ar--beginning-of-statement-p (&optional pps bol)
  "Return ‘t’, if cursor is at the beginning of a ‘statement’, nil otherwise."
  (interactive)
  (save-excursion
    (when (or bol (bolp)) (back-to-indentation))
    (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
      (and (not (or (nth 8 pps) (nth 1 pps)))
           (looking-at ar-statement-re)
           (looking-back "[^ \t]*" (line-beginning-position))
           (eq (current-column) (current-indentation))
           (eq (point) (progn (ar-forward-statement) (ar-backward-statement)))))))

(defun ar--beginning-of-statement-bol-p (&optional pps)
  "Return position, if cursor is at the beginning of a ‘statement’, nil otherwise."
  (save-excursion
    (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
      (and (bolp)
           (not (or (nth 8 pps) (nth 1 pps)))
           (looking-at ar-statement-re)
           (looking-back "[^ \t]*" (line-beginning-position))
           (eq (point) (progn (ar-forward-statement-bol) (ar-backward-statement-bol)))
           (point)))))

(defun ar--refine-regexp-maybe (regexp)
  "Use a more specific regexp if possible. "
  (let ((regexpvalue (if (symbolp regexp)(symbol-value regexp) regexp)))
    (if (looking-at regexpvalue)
        (setq regexp
              (cond ((looking-at ar-if-re)
                     'ar-if-re)
                    ((looking-at ar-try-re)
                     'ar-try-re)
                    ((looking-at ar-def-re)
                     'ar-def-re)
                    ((looking-at ar-class-re)
                     'ar-class-re)
                    (t regexp)))
      regexp)))

(defun ar-forward-clause-intern (indent)
  (end-of-line)
  (let (last)
    (while
        (and
         (ar-forward-statement)
         (< indent (current-indentation))
         (setq last (point))))
    (when last (goto-char last))))

(defun ar--backward-empty-lines-or-comment ()
  "Travel backward"
  (while
      (or (< 0 (abs (skip-chars-backward " \t\r\n\f")))
          (ar-backward-comment))))

(defun ar--down-end-form ()
  "Return position."
  (progn (ar--backward-empty-lines-or-comment)
         (point)))

(defun ar--which-delay-process-dependent (buffer)
  "Call a ‘ar-iSomeMode-send-delay’ or ‘ar-SomeMode-send-delay’ according to process"
  (if (string-match "^.[IJ]" buffer)
      ar-iSomeMode-send-delay
    ar-SomeMode-send-delay))

(defun ar-temp-file-name (strg)
  (let* ((temporary-file-directory
          (if (file-remote-p default-directory)
              (concat (file-remote-p default-directory) "/tmp")
            temporary-file-directory))
         (temp-file-name (make-temp-file "py")))

    (with-temp-file temp-file-name
      (insert strg)
      (delete-trailing-whitespace))
    temp-file-name))

(defun ar--fetch-error (output-buffer &optional origline filename)
  "Highlight exceptions found in BUF.

If an exception occurred return error-string, otherwise return nil.
BUF must exist.

Indicate LINE if code was not run from a file,
thus remember ORIGLINE of source buffer"
  (with-current-buffer output-buffer
    (when ar-debug-p (switch-to-buffer (current-buffer)))
    ;; (setq ar-error (buffer-substring-no-properties (point) (point-max)))
    (goto-char (point-max))
    (when (re-search-backward "File \"\\(.+\\)\", line \\([0-9]+\\)\\(.*\\)$" nil t)
      (when (and filename (re-search-forward "File \"\\(.+\\)\", line \\([0-9]+\\)\\(.*\\)$" nil t)
                 (replace-match filename nil nil nil 1))
        (when (and origline (re-search-forward "line \\([0-9]+\\)\\(.*\\)$" (line-end-position) t 1))
          (replace-match origline nil nil nil 2)))
      (setq ar-error (buffer-substring-no-properties (point) (point-max))))
        ar-error))

(defun ar--fetch-result (buffer  &optional limit cmd)
  "CMD: some shells echo the command in output-buffer
Delete it here"
  (when ar-debug-p (message "(current-buffer): %s" (current-buffer)))
  (cond (ar-mode-v5-behavior-p
         (with-current-buffer buffer
           (ar--string-trim (buffer-substring-no-properties (point-min) (point-max)) nil "\n")))
        ((and cmd limit (< limit (point-max)))
         (replace-regexp-in-string cmd "" (ar--string-trim (replace-regexp-in-string ar-shell-prompt-regexp "" (buffer-substring-no-properties limit (point-max))))))
        (t (when (and limit (< limit (point-max)))
             (ar--string-trim (replace-regexp-in-string ar-shell-prompt-regexp "" (buffer-substring-no-properties limit (point-max))))))))

(defun ar--postprocess (output-buffer origline limit &optional cmd filename)
  "Provide return values, check result for error, manage windows.

According to OUTPUT-BUFFER ORIGLINE ORIG"
  ;; ar--fast-send-string does not set origline
  (when (or ar-return-result-p ar-store-result-p)
    (with-current-buffer output-buffer
      (when ar-debug-p (switch-to-buffer (current-buffer)))
      (sit-for (ar--which-delay-process-dependent (prin1-to-string output-buffer)))
      ;; (catch 'ar--postprocess
      (setq ar-result (ar--fetch-result output-buffer limit cmd))
      ;; (throw 'ar--postprocess (error "ar--postprocess failed"))
      ;;)
      (if (and ar-result (not (string= "" ar-result)))
          (if (string-match "^Traceback" ar-result)
              (if filename
                  (setq ar-error ar-result)
                (progn
                  (with-temp-buffer
                    (insert ar-result)
                    (sit-for 0.1 t)
                    (setq ar-error (ar--fetch-error origline filename)))))
            (when ar-store-result-p
              (kill-new ar-result))
            (when ar-verbose-p (message "ar-result: %s" ar-result))
            ar-result)
        (when ar-verbose-p (message "ar--postprocess: %s" "Do not see any result"))))))

(defun ar-fetch-ar-master-file ()
  "Lookup if a ‘ar-master-file’ is specified.

See also doku of variable ‘ar-master-file’"
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (when (re-search-forward "^ *# Local Variables:" nil (quote move) 1)
        (when
            (re-search-forward (concat "^\\( *# ar-master-file: *\\)\"\\([^ \t]+\\)\" *$") nil t 1)
          (setq ar-master-file (match-string-no-properties 2))))))
  ;; (when (called-interactively-p 'any) (message "%s" ar-master-file))
  )

(defun ar-iSomeMode--which-version (shell)
  "Returns ISOME version as string"
  (shell-command-to-string (concat (downcase (replace-regexp-in-string  "[[:punct:]+]" "" shell)) " -V")))

(defun ar--provide-command-args (shell fast-process)
  "Unbuffered WRT fast-process"
  (let ((erg
         (delq nil
               (cond
                ;; ((eq 2 (prefix-numeric-value argprompt))
                ;; ar-SomeMode2-command-args)
                ((string-match "^[Ii]" shell)
                 (if (string-match "^[0-4]" (ar-iSomeMode--which-version shell))
                     (remove "--simple-prompt"  ar-iSomeMode-command-args)
                   (if (member "--simple-prompt"  ar-iSomeMode-command-args)
                       ar-iSomeMode-command-args
                     (cons "--simple-prompt"  ar-iSomeMode-command-args))))
                ((string-match "^[^-]+3" shell)
                 ar-SomeMode3-command-args)
                ((string-match "^[jy]" shell)
                 ar-jython-command-args)
                (t
                 ar-SomeMode-command-args)))))
    (if (and fast-process (not (member "-u" erg)))
        ;;  unbuffered output
        (cons "-u" erg)
      erg)))

;; This and other stuff from SomeMode.el
(defun ar-info-encoding-from-cookie ()
  "Detect current buffer's encoding from its coding cookie.
Returns the encoding as a symbol."
  (let ((first-two-lines
         (save-excursion
           (save-restriction
             (widen)
             (goto-char (point-min))
             (forward-line 2)
             (buffer-substring-no-properties
              (point)
              (point-min))))))
    (when (string-match
           ;; (ar-rx coding-cookie)
           "^#[[:space:]]*\\(?:coding[:=][[:space:]]*\\(?1:\\(?:[[:word:]]\\|-\\)+\\)\\|-\\*-[[:space:]]*coding:[[:space:]]*\\(?1:\\(?:[[:word:]]\\|-\\)+\\)[[:space:]]*-\\*-\\|vim:[[:space:]]*set[[:space:]]+fileencoding[[:space:]]*=[[:space:]]*\\(?1:\\(?:[[:word:]]\\|-\\)+\\)[[:space:]]*:\\)"
           first-two-lines)
      (intern (match-string-no-properties 1 first-two-lines)))))

(defun ar-info-encoding ()
  "Return encoding for file.
Try ‘ar-info-encoding-from-cookie’, if none is found then
default to utf-8."
  (or (ar-info-encoding-from-cookie)
      'utf-8))

(defun ar-indentation-of-statement ()
  "Returns the indenation of the statement at point. "
  (interactive)
  (let ((erg (save-excursion
               (back-to-indentation)
               (or (ar--beginning-of-statement-p)
                   (ar-backward-statement))
               (current-indentation))))
    (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" erg))
    erg))

(defun ar--filter-result (strg)
  "Set ‘ar-result’ according to ‘ar-fast-filter-re’.

Remove trailing newline"
  (ar--string-trim
   (replace-regexp-in-string
    ar-fast-filter-re
    ""
    (ansi-color-filter-apply strg))))

(defun ar--cleanup-shell (orig buffer)
  (with-current-buffer buffer
    (with-silent-modifications
      (sit-for ar-SomeMode3-send-delay)
      (when ar-debug-p (switch-to-buffer (current-buffer)))
      (delete-region orig (point-max)))))

(defun ar-shell--save-temp-file (strg)
  (let* ((temporary-file-directory
          (if (file-remote-p default-directory)
              (concat (file-remote-p default-directory) "/tmp")
            temporary-file-directory))
         (temp-file-name (make-temp-file "py"))
         (coding-system-for-write (ar-info-encoding)))
    (with-temp-file temp-file-name
      (insert strg)
      (delete-trailing-whitespace))
    temp-file-name))

(defun ar--get-process (&optional argprompt args dedicated shell buffer)
  "Get appropriate SOME process for current buffer and return it.

Optional ARGPROMPT DEDICATED SHELL BUFFER"
  (interactive)
  (or (and buffer (get-buffer-process buffer))
      (get-buffer-process (current-buffer))
      (get-buffer-process (ar-shell argprompt args dedicated shell buffer))))

(defun ar-shell-send-file (file-name &optional process temp-file-name
                                     delete)
  "Send FILE-NAME to SOME PROCESS.

If TEMP-FILE-NAME is passed then that file is used for processing
instead, while internally the shell will continue to use
FILE-NAME.  If TEMP-FILE-NAME and DELETE are non-nil, then
TEMP-FILE-NAME is deleted after evaluation is performed.  When
optional argument."
  (interactive
   (list
    (read-file-name "File to send: ")))
  (let* ((proc (or process (ar--get-process)))
         (encoding (with-temp-buffer
                     (insert-file-contents
                      (or temp-file-name file-name))
                     (ar-info-encoding)))
         (file-name (expand-file-name (file-local-name file-name)))
         (temp-file-name (when temp-file-name
                           (expand-file-name
                            (file-local-name temp-file-name)))))
    (ar-shell-send-string
     (format
      (concat
       "import codecs, os;"
       "__pyfile = codecs.open('''%s''', encoding='''%s''');"
       "__code = __pyfile.read().encode('''%s''');"
       "__pyfile.close();"
       (when (and delete temp-file-name)
         (format "os.remove('''%s''');" temp-file-name))
       "exec(compile(__code, '''%s''', 'exec'));")
      (or temp-file-name file-name) encoding encoding file-name)
     proc)))

(defun ar-shell-send-string (strg &optional process)
  "Send STRING to SOME PROCESS.

Uses ‘comint-send-string’."
  (interactive
   (list (read-string "SOME command: ") nil t))
  (let ((process (or process (ar--get-process))))
    (if (string-match ".\n+." strg)   ;Multiline.
        (let* ((temp-file-name (ar-shell--save-temp-file strg))
               (file-name (or (buffer-file-name) temp-file-name)))
          (ar-shell-send-file file-name process temp-file-name t))
      (comint-send-string process strg)
      (when (or (not (string-match "\n\\'" strg))
                (string-match "\n[ \t].*\n?\\'" strg))
        (comint-send-string process "\n")))))

(defun ar-fast-process (&optional buffer)
  "Connect am (I)SOME process suitable for large output.

Output buffer displays \"Fast\"  by default
It is not in interactive, i.e. comint-mode,
as its bookkeepings seem linked to the freeze reported by lp:1253907"
  (interactive)
  (let ((this-buffer
         (set-buffer (or (and buffer (get-buffer-create buffer))
                         (get-buffer-create ar-shell-name)))))
    (let ((proc (start-process ar-shell-name this-buffer ar-shell-name)))
      (with-current-buffer this-buffer
        (erase-buffer))
      proc)))

(defun ar-proc (&optional argprompt)
  "Return the current SOME process.

Start a new process if necessary. "
  (interactive "P")
  (let ((erg
         (cond ((comint-check-proc (current-buffer))
                (get-buffer-process (buffer-name (current-buffer))))
               (t (ar-shell argprompt)))))
    erg))

(defun ar-process-file (filename &optional output-buffer error-buffer)
  "Process \"SomeMode FILENAME\".

Optional OUTPUT-BUFFER and ERROR-BUFFER might be given."
  (interactive "fDatei:")
  (let ((coding-system-for-read 'utf-8)
        (coding-system-for-write 'utf-8)
        (output-buffer (or output-buffer (make-temp-name "ar-process-file-output")))
        (pcmd (ar-choose-shell)))
    (unless (buffer-live-p output-buffer)
      (set-buffer (get-buffer-create output-buffer)))
    (shell-command (concat pcmd " " filename) output-buffer error-buffer)
    (when ar-switch-buffers-on-execute-p (switch-to-buffer output-buffer))))

(defun ar-remove-overlays-at-point ()
  "Remove overlays as set when ‘ar-highlight-error-source-p’ is non-nil."
  (interactive "*")
  (delete-overlay (car (overlays-at (point)))))

(defun ar--jump-to-exception-intern (act exception-buffer origline)
  (let (erg)
    (set-buffer exception-buffer)
    (goto-char (point-min))
    (forward-line (1- origline))
    (and (search-forward act (line-end-position) t)
         (and ar-verbose-p (message "exception-buffer: %s on line %d" ar-exception-buffer origline))
         (and ar-highlight-error-source-p
              (setq erg (make-overlay (match-beginning 0) (match-end 0)))
              (overlay-put erg
                           'face 'highlight)))))

(defun ar--jump-to-exception (perr origline &optional file)
  "Jump to the PERR SOME code at ORIGLINE in optional FILE."
  (with-silent-modifications
    (let (
          ;; (inhibit-point-motion-hooks t)
          (file (or file (car perr)))
          (act (nth 2 perr)))
      (cond ((and ar-exception-buffer
                  (buffer-live-p ar-exception-buffer))
             ;; (pop-to-buffer procbuf)
             (ar--jump-to-exception-intern act ar-exception-buffer origline))
            ((ignore-errors (file-readable-p file))
             (find-file file)
             (ar--jump-to-exception-intern act (get-buffer (file-name-nondirectory file)) origline))
            ((buffer-live-p (get-buffer file))
             (set-buffer file)
             (ar--jump-to-exception-intern act file origline))
            (t (setq file (find-file (read-file-name "Exception file: "
                                                     nil
                                                     file t)))
               (ar--jump-to-exception-intern act file origline))))))

(defun ar-goto-exception (&optional file line)
  "Go to FILE and LINE indicated by the traceback."
  (interactive)
  (let ((file file)
        (line line))
    (unless (and file line)
      (save-excursion
        (beginning-of-line)
        (if (looking-at ar-traceback-line-re)
            (setq file (substring-no-properties (match-string 1))
                  line (string-to-number (match-string 2))))))
    (if (not file)
        (error "Not on a traceback line"))
    (find-file file)
    (goto-char (point-min))
    (forward-line (1- line))))

(defun ar--find-next-exception (start buffer searchdir errwhere)
  "Find the next SOME exception and jump to the code that caused it.
START is the buffer position in BUFFER from which to begin searching
for an exception.  SEARCHDIR is a function, either
‘re-search-backward’ or ‘re-search-forward’ indicating the direction
to search.  ERRWHERE is used in an error message if the limit (top or
bottom) of the trackback stack is encountered."
  (let (file line)
    (save-excursion
      (with-current-buffer buffer
        (goto-char start)
        (if (funcall searchdir ar-traceback-line-re nil t)
            (setq file (match-string 1)
                  line (string-to-number (match-string 2))))))
    (if (and file line)
        (ar-goto-exception file line)
      (error "%s of traceback" errwhere))))

(defun ar-down-exception (&optional bottom)
  "Go to the next line down in the traceback.
With \\[univeral-argument] (programmatically, optional argument
BOTTOM), jump to the bottom (innermost) exception in the exception
stack."
  (interactive "P")
  (let* ((buffer ar-output-buffer))
    (if bottom
        (ar--find-next-exception 'eob buffer 're-search-backward "Bottom")
      (ar--find-next-exception 'eol buffer 're-search-forward "Bottom"))))

(defun ar-up-exception (&optional top)
  "Go to the previous line up in the traceback.
With \\[universal-argument] (programmatically, optional argument TOP)
jump to the top (outermost) exception in the exception stack."
  (interactive "P")
  (let* ((buffer ar-output-buffer))
    (if top
        (ar--find-next-exception 'bob buffer 're-search-forward "Top")
      (ar--find-next-exception 'bol buffer 're-search-backward "Top"))))

;; ;
;;  obsolete by ar--fetch-result
;;  followed by ar--fetch-error
;;  still used by ar--execute-ge24.3

(defun ar--find-next-exception-prepare (direction start)
  "According to DIRECTION and START setup exception regexps.

Depends from kind of SOME shell."
  (let* ((name (get-process (substring (buffer-name (current-buffer)) 1 -1)))
         (buffer (cond (name (buffer-name (current-buffer)))
                       ((buffer-live-p (get-buffer ar-output-buffer))
                        ar-output-buffer)
                       (ar-last-exeption-buffer (buffer-name ar-last-exeption-buffer))
                       (t (error "Do not see exeption buffer")))))
    (when buffer (set-buffer (get-buffer buffer)))
    (if (eq direction 'up)
        (if (string= start "TOP")
            (ar--find-next-exception 'bob buffer 're-search-forward "Top")
          (ar--find-next-exception 'bol buffer 're-search-backward "Top"))
      (if (string= start "BOTTOM")
          (ar--find-next-exception 'eob buffer 're-search-backward "Bottom")
        (ar--find-next-exception 'eol buffer 're-search-forward "Bottom")))))

(defun ar-shell-comint-end-of-output-p (output)
  "Return non-nil if OUTPUT ends with input prompt."
  (ignore-errors (string-match
                  ;; XXX: It seems on macOS an extra carriage return is attached
                  ;; at the end of output, this handles that too.
                  (concat
                   "\r?\n?"
                   ;; Remove initial caret from calculated regexp
                   (ignore-errors (replace-regexp-in-string
                                   (rx string-start ?^) ""
                                   ar-shell--prompt-calculated-input-regexp))
                   (rx eos))
                  output)))

(defun ar-comint-postoutput-scroll-to-bottom (output)
  "Faster version of ‘comint-postoutput-scroll-to-bottom’.
Avoids ‘recenter’ calls until OUTPUT is completely sent."
  (when (and (not (string= "" output))
             (ar-shell-comint-end-of-output-p
              (ansi-color-filter-apply output)))
    (comint-postoutput-scroll-to-bottom output))
  output)

(defmacro ar-shell--add-to-path-with-priority (pathvar paths)
  "Modify PATHVAR and ensure PATHS are added only once at beginning."
  `(dolist (path (reverse ,paths))
     (setq ,pathvar (cons path (cl-delete path ,pathvar :test #'string=)))))

(defun ar-shell-tramp-refresh-remote-path (vec paths)
  "Update VEC's remote-path giving PATHS priority."
  (cl-assert (featurep 'tramp))
  (declare-function tramp-set-remote-path "tramp-sh")
  (declare-function tramp-set-connection-property "tramp-cache")
  (declare-function tramp-get-connection-property "tramp-cache")
  (let ((remote-path (tramp-get-connection-property vec "remote-path" nil)))
    (when remote-path
      ;; FIXME: This part of the Tramp code still knows about SOME!
      (ar-shell--add-to-path-with-priority remote-path paths)
      (tramp-set-connection-property vec "remote-path" remote-path)
      (tramp-set-remote-path vec))))

(defun ar-shell-tramp-refresh-process-environment (vec env)
  "Update VEC's process environment with ENV."
  ;; Stolen from ‘tramp-open-connection-setup-interactive-shell’.
  (let ((env (append (when (fboundp 'tramp-get-remote-locale)
                       ;; Emacs<24.4 compat.
                       (list (tramp-get-remote-locale vec)))
                     (copy-sequence env)))
        (tramp-end-of-heredoc
         (if (boundp 'tramp-end-of-heredoc)
             tramp-end-of-heredoc
           (md5 tramp-end-of-output)))
        unset vars item)
    (while env
      (setq item (split-string (car env) "=" 'omit))
      (setcdr item (mapconcat 'identity (cdr item) "="))
      (if (and (stringp (cdr item)) (not (string-equal (cdr item) "")))
          (push (format "%s %s" (car item) (cdr item)) vars)
        (push (car item) unset))
      (setq env (cdr env)))
    (when vars
      (tramp-send-command
       vec
       (format "while read var val; do export $var=$val; done <<'%s'\n%s\n%s"
               tramp-end-of-heredoc
               (mapconcat 'identity vars "\n")
               tramp-end-of-heredoc)
       t))
    (when unset
      (tramp-send-command
       vec (format "unset %s" (mapconcat 'identity unset " ")) t))))

(defun ar-shell-calculate-SomeModepath ()
  "Calculate the PYTHONPATH using ‘SomeMode-shell-extra-SomeModepaths’."
  (let ((SomeModepath
         (split-string
          (or (getenv "PYTHONPATH") "") path-separator 'omit)))
    (ar-shell--add-to-path-with-priority
     SomeModepath ar-shell-extra-SomeModepaths)
    (mapconcat #'identity SomeModepath path-separator)))

(defun ar-shell-calculate-exec-path ()
  "Calculate ‘exec-path’.
Prepends ‘ar-shell-exec-path’ and adds the binary directory
for virtualenv if ‘ar-shell-virtualenv-root’ is set - this
will use the SomeMode interpreter from inside the virtualenv when
starting the shell.  If ‘default-directory’ points to a remote host,
the returned value appends ‘ar-shell-remote-exec-path’ instead
of ‘exec-path’."
  (let ((new-path (copy-sequence
                   (if (file-remote-p default-directory)
                       ar-shell-remote-exec-path
                     exec-path)))

        ;; Windows and POSIX systems use different venv directory structures
        (virtualenv-bin-dir (if (eq system-type 'windows-nt) "Scripts" "bin")))
    (ar-shell--add-to-path-with-priority
     new-path ar-shell-exec-path)
    (if (not ar-shell-virtualenv-root)
        new-path
      (ar-shell--add-to-path-with-priority
       new-path
       (list (expand-file-name virtualenv-bin-dir ar-shell-virtualenv-root)))
      new-path)))

(defun ar-shell-calculate-process-environment ()
  "Calculate ‘process-environment’ or ‘tramp-remote-process-environment’.
Prepends ‘ar-shell-process-environment’, sets extra
SomeModepaths from ‘ar-shell-extra-SomeModepaths’ and sets a few
virtualenv related vars.  If ‘default-directory’ points to a
remote host, the returned value is intended for
‘tramp-remote-process-environment’."
  (let* ((remote-p (file-remote-p default-directory))
         (process-environment (if remote-p
                                  tramp-remote-process-environment
                                process-environment))
         (virtualenv (when ar-shell-virtualenv-root
                       (directory-file-name ar-shell-virtualenv-root))))
    (dolist (env ar-shell-process-environment)
      (pcase-let ((`(,key ,value) (split-string env "=")))
        (setenv key value)))
    (when ar-shell-unbuffered
      (setenv "PYTHONUNBUFFERED" "1"))
    (when ar-shell-extra-SomeModepaths
      (setenv "PYTHONPATH" (ar-shell-calculate-SomeModepath)))
    (if (not virtualenv)
        process-environment
      (setenv "PYTHONHOME" nil)
      (setenv "VIRTUAL_ENV" virtualenv))
    process-environment))

(defun ar-shell-prompt-detect ()
  "Detect prompts for the current interpreter.
When prompts can be retrieved successfully from the
interpreter run with
‘ar-SomeMode-command-args’, returns a list of
three elements, where the first two are input prompts and the
last one is an output prompt.  When no prompts can be detected
shows a warning with instructions to avoid hangs and returns nil.
When ‘ar-shell-prompt-detect-p’ is nil avoids any
detection and just returns nil."
  (when ar-shell-prompt-detect-p
    (SomeMode-shell-with-environment
      (let* ((code (concat
                    "import sys\n"
                    "ps = [getattr(sys, 'ps%s' % i, '') for i in range(1,4)]\n"
                    ;; JSON is built manually for compatibility
                    "ps_json = '\\n[\"%s\", \"%s\", \"%s\"]\\n' % tuple(ps)\n"
                    "print (ps_json)\n"
                    "sys.exit(0)\n"))
             ;; (interpreter ar-shell-name)
             ;; (interpreter-arg ar-SomeMode-command-args)
             (output
              (with-temp-buffer
                ;; TODO: improve error handling by using
                ;; ‘condition-case’ and displaying the error message to
                ;; the user in the no-prompts warning.
                (ignore-errors
                  (let ((code-file
                         ;; SOME 2.x on Windows does not handle
                         ;; carriage returns in unbuffered mode.
                         (let ((inhibit-eol-conversion (getenv "PYTHONUNBUFFERED")))
                           (ar-shell--save-temp-file code))))
                    (unwind-protect
                        ;; Use ‘process-file’ as it is remote-host friendly.
                        (process-file
                         ar-shell-name
                         code-file
                         '(t nil)
                         nil
                         ar-SomeMode-command-args)
                      ;; Try to cleanup
                      (delete-file code-file))))
                (buffer-string)))
             (prompts
              (catch 'prompts
                (dolist (line (split-string output "\n" t))
                  (let ((res
                         ;; Check if current line is a valid JSON array
                         (and (string= (substring line 0 2) "[\"")
                              (ignore-errors
                                ;; Return prompts as a list, not vector
                                (append (json-read-from-string line) nil)))))
                    ;; The list must contain 3 strings, where the first
                    ;; is the input prompt, the second is the block
                    ;; prompt and the last one is the output prompt.  The
                    ;; input prompt is the only one that can not be empty.
                    (when (and (= (length res) 3)
                               (cl-every #'stringp res)
                               (not (string= (car res) "")))
                      (throw 'prompts res))))
                nil)))
        (if (not prompts)
            (lwarn
             '(SomeMode ar-shell-prompt-regexp)
             :warning
             (concat
              "SOME shell prompts cannot be detected.\n"
              "If your emacs session hangs when starting SomeMode shells\n"
              "recover with ‘keyboard-quit’ and then try fixing the\n"
              "interactive flag for your interpreter by adjusting the\n"
              "‘ar-SomeMode-command-args’ or add regexps\n"
              "matching shell prompts in the directory-local friendly vars:\n"
              "  + ‘ar-shell-prompt-regexp’\n"
              "  + ‘ar-shell-input-prompt-2-regexp’\n"
              "  + ‘ar-shell-prompt-output-regexp’\n"
              "Or alternatively in:\n"
              "  + ‘ar-shell-input-prompt-regexps’\n"
              "  + ‘ar-shell-prompt-output-regexps’"))
          prompts)))))

(defun ar-util-valid-regexp-p (regexp)
  "Return non-nil if REGEXP is valid."
  (ignore-errors (string-match regexp "") t))

(defun ar-shell-prompt-validate-regexps ()
  "Validate all user provided regexps for prompts.
Signals ‘user-error’ if any of these vars contain invalid
regexps: ‘ar-shell-prompt-regexp’,
‘ar-shell-input-prompt-2-regexp’,
‘ar-shell-prompt-pdb-regexp’,
‘ar-shell-prompt-output-regexp’,
‘ar-shell-input-prompt-regexps’,
‘ar-shell-prompt-output-regexps’."
  (dolist (symbol (list 'ar-shell-input-prompt-1-regexp
                        'ar-shell-prompt-output-regexps
                        'ar-shell-input-prompt-2-regexp
                        'ar-shell-prompt-pdb-regexp))
    (dolist (regexp (let ((regexps (symbol-value symbol)))
                      (if (listp regexps)
                          regexps
                        (list regexps))))
      (when (not (ar-util-valid-regexp-p regexp))
        (user-error "Invalid regexp %s in ‘%s’"
                    regexp symbol)))))

(defun ar-shell-prompt-set-calculated-regexps ()
  "Detect and set input and output prompt regexps.

Build and set the values for input- and output-prompt regexp
using the values from ‘ar-shell-prompt-regexp’,
‘ar-shell-input-prompt-2-regexp’, ‘ar-shell-prompt-pdb-regexp’,
‘ar-shell-prompt-output-regexp’, ‘ar-shell-input-prompt-regexps’,
 and detected prompts from ‘ar-shell-prompt-detect’."
  (when (not (and ar-shell--prompt-calculated-input-regexp
                  ar-shell--prompt-calculated-output-regexp))
    (let* ((detected-prompts (ar-shell-prompt-detect))
           (input-prompts nil)
           (output-prompts nil)
           (build-regexp
            (lambda (prompts)
              (concat "^\\("
                      (mapconcat #'identity
                                 (sort prompts
                                       (lambda (a b)
                                         (let ((length-a (length a))
                                               (length-b (length b)))
                                           (if (= length-a length-b)
                                               (string< a b)
                                             (> (length a) (length b))))))
                                 "\\|")
                      "\\)"))))
      ;; Validate ALL regexps
      (ar-shell-prompt-validate-regexps)
      ;; Collect all user defined input prompts
      (dolist (prompt (append ar-shell-input-prompt-regexps
                              (list ar-shell-input-prompt-2-regexp
                                    ar-shell-prompt-pdb-regexp)))
        (cl-pushnew prompt input-prompts :test #'string=))
      ;; Collect all user defined output prompts
      (dolist (prompt (cons ar-shell-prompt-output-regexp
                            ar-shell-prompt-output-regexps))
        (cl-pushnew prompt output-prompts :test #'string=))
      ;; Collect detected prompts if any
      (when detected-prompts
        (dolist (prompt (butlast detected-prompts))
          (setq prompt (regexp-quote prompt))
          (cl-pushnew prompt input-prompts :test #'string=))
        (setq ar-shell--block-prompt (nth 1 detected-prompts))
        (cl-pushnew (regexp-quote
                     (car (last detected-prompts)))
                    output-prompts :test #'string=))
      ;; Set input and output prompt regexps from collected prompts
      (setq ar-shell--prompt-calculated-input-regexp
            (funcall build-regexp input-prompts)
            ar-shell--prompt-calculated-output-regexp
            (funcall build-regexp output-prompts)))))

(defun ar-shell-output-filter (strg)
  "Filter used in ‘ar-shell-send-string-no-output’ to grab output.
STRING is the output received to this point from the process.
This filter saves received output from the process in
‘ar-shell-output-filter-buffer’ and stops receiving it after
detecting a prompt at the end of the buffer."
  (let ((ar-shell--prompt-calculated-output-regexp
         (or ar-shell--prompt-calculated-output-regexp (ar-shell-prompt-set-calculated-regexps))))
    (setq
     strg (ansi-color-filter-apply strg)
     ar-shell-output-filter-buffer
     (concat ar-shell-output-filter-buffer strg))
    (when (ar-shell-comint-end-of-output-p
           ar-shell-output-filter-buffer)
      ;; Output ends when ‘ar-shell-output-filter-buffer’ contains
      ;; the prompt attached at the end of it.
      (setq ar-shell-output-filter-in-progress nil
            ar-shell-output-filter-buffer
            (substring ar-shell-output-filter-buffer
                       0 (match-beginning 0)))
      (when (string-match
             ar-shell--prompt-calculated-output-regexp
             ar-shell-output-filter-buffer)
        ;; Some shells, like ISOME might append a prompt before the
        ;; output, clean that.
        (setq ar-shell-output-filter-buffer
              (substring ar-shell-output-filter-buffer (match-end 0)))))
    ""))

(defun ar--fast-send-string-no-output-intern (strg proc limit output-buffer no-output)
  (let (erg)
    (with-current-buffer output-buffer
      ;; (when ar-debug-p (switch-to-buffer (current-buffer)))
      ;; (erase-buffer)
      (process-send-string proc strg)
      (or (string-match "\n$" strg)
          (process-send-string proc "\n")
          (goto-char (point-max))
          )
      (cond (no-output
             (delete-region (field-beginning) (field-end))
             ;; (erase-buffer)
             ;; (delete-region (point-min) (line-beginning-position))
             )
            (t
             (if
                 (setq erg (ar--fetch-result output-buffer limit strg))
                 (setq ar-result (ar--filter-result erg))
               (dotimes (_ 3) (unless (setq erg (ar--fetch-result output-buffer limit))(sit-for 1 t)))
               (or (ar--fetch-result output-buffer limit))
               (error "ar--fast-send-string-no-output-intern: ar--fetch-result: no result")))))))

(defun ar-execute-string (strg &optional process result no-output orig output-buffer fast argprompt args dedicated shell exception-buffer split switch internal)
  "Evaluate STRG in SOME PROCESS.

With optional Arg PROCESS send to process.
With optional Arg RESULT store result in var ‘ar-result’, also return it.
With optional Arg NO-OUTPUT do not display any output
With optional Arg ORIG deliver original position.
With optional Arg OUTPUT-BUFFER specify output-buffer"
  (interactive "sSOME command: ")
  (save-excursion
    (let* ((buffer (or output-buffer
                       (and process (buffer-name (process-buffer process)))
                       (buffer-name
                        (ar-shell argprompt args dedicated shell output-buffer fast exception-buffer split switch internal))))
           (proc (or process (get-buffer-process buffer)))
           (orig (or orig (point)))
           (limit (ignore-errors (marker-position (process-mark proc)))))
      (unless (eq 1 (length (window-list))) (window-configuration-to-register ar--windows-config-register))
      (cond ((and no-output fast)
             (ar--fast-send-string-no-output-intern strg proc limit buffer no-output))
            (no-output
             (ar-send-string-no-output strg proc))
            ((and (string-match ".\n+." strg) (string-match "^[Ii]"
                                                            ;; (buffer-name buffer)
                                                            buffer
                                                            ))  ;; multiline
             (let* ((temp-file-name (ar-temp-file-name strg))
                    (file-name (or (buffer-file-name) temp-file-name)))
               (ar-execute-file file-name proc)))
            (t
             (comint-send-string proc strg)
             (when (or (not (string-match "\n\\'" strg))
                       (string-match "\n[ \t].*\n?\\'" strg))
               (comint-send-string proc "\n"))
             (cond (result
                    ;; (sit-for ar-SomeMode-send-delay)
                    (sit-for ar-SomeMode-send-delay)
                    (setq ar-result (ar--fetch-result buffer limit strg)))
                   (no-output
                    (and orig (ar--cleanup-shell orig buffer))))))
      ;; (message "ar-execute-string; current-buffer: %s" (current-buffer))
      (if (eq 1 (length (window-list)))
          (ar--shell-manage-windows buffer)
        (when (get-register ar--windows-config-register)
          (ignore-errors (jump-to-register (get-register ar--windows-config-register))))))))

(defun ar--shell-manage-windows (output-buffer &optional exception-buffer split switch)
  "Adapt or restore window configuration from OUTPUT-BUFFER.

Optional EXCEPTION-BUFFER SPLIT SWITCH
Return nil."
  (let* ((exception-buffer (or exception-buffer (other-buffer)))
         (old-window-list (window-list))
         (number-of-windows (length old-window-list))
         (split (or split ar-split-window-on-execute))
         (switch
          (or ar-switch-buffers-on-execute-p switch ar-pdbtrack-tracked-buffer)))
    ;; (output-buffer-displayed-p)
    (cond
     (ar-keep-windows-configuration
      (ar-restore-window-configuration)
      (set-buffer output-buffer)
      (goto-char (point-max)))
     ((and (eq split 'always)
           switch)
      (if (member (get-buffer-window output-buffer) (window-list))
          ;; (delete-window (get-buffer-window output-buffer))
          (select-window (get-buffer-window output-buffer))
        (ar--manage-windows-split exception-buffer)
        ;; otherwise new window appears above
        (save-excursion
          (other-window 1)
          (switch-to-buffer output-buffer))
        (display-buffer exception-buffer)))
     ((and
       (eq split 'always)
       (not switch))
      (if (member (get-buffer-window output-buffer) (window-list))
          (select-window (get-buffer-window output-buffer))
        (ar--manage-windows-split exception-buffer)
        (display-buffer output-buffer)
        (pop-to-buffer exception-buffer)))
     ((and
       (eq split 'just-two)
       switch)
      (switch-to-buffer (current-buffer))
      (delete-other-windows)
      (ar--manage-windows-split exception-buffer)
      ;; otherwise new window appears above
      (other-window 1)
      (set-buffer output-buffer)
      (switch-to-buffer (current-buffer)))
     ((and
       (eq split 'just-two)
       (not switch))
      (switch-to-buffer exception-buffer)
      (delete-other-windows)
      (unless
          (member (get-buffer-window output-buffer) (window-list))
        (ar--manage-windows-split exception-buffer))
      (save-excursion
        (other-window 1)
        (pop-to-buffer output-buffer)
        (goto-char (point-max))
        (other-window 1)))
     ((and
       split
       (not switch))
      ;; https://bugs.launchpad.net/SomeMode-mode/+bug/1478122
      ;; > If the shell is visible in any of the windows it should re-use that window
      ;; > I did double check and ar-keep-window-configuration is nil and split is t.
      (ar--split-t-not-switch-wm output-buffer number-of-windows exception-buffer))
     ((and split switch)
      (unless
          (member (get-buffer-window output-buffer) (window-list))
        (ar--manage-windows-split exception-buffer))
      (set-buffer output-buffer)
      (switch-to-buffer output-buffer)
      (goto-char (point-max)))
     ((not switch)
      (let (pop-up-windows)
        (ar-restore-window-configuration))))))

(defun ar--execute-file-base (filename &optional proc cmd procbuf origline fast)
  "Send to SOME interpreter process PROC.

In SOME version 2.. \"execfile('FILENAME')\".

Takes also CMD PROCBUF ORIGLINE NO-OUTPUT.

Make that process's buffer visible and force display.  Also make
comint believe the user typed this string so that
‘kill-output-from-shell’ does The Right Thing.
Returns position where output starts."
  (let* ((filename (expand-file-name filename))
         (buffer (or procbuf (and proc (process-buffer proc)) (ar-shell nil nil nil nil nil fast)))
         (proc (or proc (get-buffer-process buffer)))
         (limit (marker-position (process-mark proc)))
         (cmd (or cmd (ar-execute-file-command filename)))
         erg)
    (if fast
        (process-send-string proc cmd)
      (ar-execute-string cmd proc))
    (with-current-buffer buffer
      (when (or ar-return-result-p ar-store-result-p)
        (setq erg (ar--postprocess buffer origline limit cmd filename))
        (if ar-error
            (setq ar-error (prin1-to-string ar-error))
          erg)))))

(defun ar-restore-window-configuration (&optional register)
  "Restore ‘ar-restore-window-configuration’."
  (let ((val register))
    (if val
        (jump-to-register (get-register val))
      (and (setq val (get-register ar--windows-config-register))
           (consp val) (window-configuration-p (car val))
           (markerp (cadr val))(marker-buffer (cadr val))
           (jump-to-register ar--windows-config-register)))))

(defun ar-toggle-split-window-function ()
  "If window is splitted vertically or horizontally.

When code is executed and ‘ar-split-window-on-execute’ is t,
the result is displays in an output-buffer, \"\*SOME\*\" by default.

Customizable variable ‘ar-split-windows-on-execute-function’
tells how to split the screen."
  (interactive)
  (if (eq 'split-window-vertically ar-split-windows-on-execute-function)
      (setq ar-split-windows-on-execute-function'split-window-horizontally)
    (setq ar-split-windows-on-execute-function 'split-window-vertically))
  (when (and ar-verbose-p (called-interactively-p 'any))
    (message "ar-split-windows-on-execute-function set to: %s" ar-split-windows-on-execute-function)))

(defun ar--manage-windows-set-and-switch (buffer)
  "Switch to output BUFFER, go to ‘point-max’.

Internal use"
  (set-buffer buffer)
  (goto-char (process-mark (get-buffer-process (current-buffer)))))

(defun ar--alternative-split-windows-on-execute-function ()
  "Toggle split-window-horizontally resp. vertically."
  (if (eq ar-split-windows-on-execute-function 'split-window-vertically)
      'split-window-horizontally
    'split-window-vertically))

(defun ar--get-splittable-window ()
  "Search ‘window-list’ for a window suitable for splitting."
  (or (and (window-left-child)(split-window (window-left-child)))
      (and (window-top-child)(split-window (window-top-child)))
      (and (window-parent)(ignore-errors (split-window (window-parent))))
      (and (window-atom-root)(split-window (window-atom-root)))))

(defun ar--manage-windows-split (buffer)
  "If one window, split BUFFER.

according to ‘ar-split-windows-on-execute-function’."
  (interactive)
  (set-buffer buffer)
  (or
   ;; (split-window (selected-window) nil ’below)
   (ignore-errors (funcall ar-split-windows-on-execute-function))
   ;; If call did not succeed according to settings of
   ;; ‘split-height-threshold’, ‘split-width-threshold’
   ;; resp. ‘window-min-height’, ‘window-min-width’
   ;; try alternative split
   (unless (ignore-errors (funcall (ar--alternative-split-windows-on-execute-function)))
     ;; if alternative split fails, look for larger window
     (ar--get-splittable-window)
     (ignore-errors (funcall (ar--alternative-split-windows-on-execute-function))))))

;; (defun ar--display-windows (output-buffer)
;;     "Otherwise new window appears above"
;;       (display-buffer output-buffer)
;;       (select-window ar-exception-window))

(defun ar--split-t-not-switch-wm (output-buffer number-of-windows exception-buffer)
  (unless (window-live-p output-buffer)
    (with-current-buffer (get-buffer exception-buffer)

      (when (< number-of-windows ar-split-window-on-execute-threshold)
        (unless
            (member (get-buffer-window output-buffer) (window-list))
          (ar--manage-windows-split exception-buffer)))
      (display-buffer output-buffer t)
      (switch-to-buffer exception-buffer)
      )))

(defun ar-execute-file (filename &optional proc)
  "When called interactively, user is prompted for FILENAME."
  (interactive "fFilename: ")
  (let (;; postprocess-output-buffer might want origline
        (origline 1)
        (ar-exception-buffer filename)
        erg)
    (if (file-readable-p filename)
        (if ar-store-result-p
            (setq erg (ar--execute-file-base (expand-file-name filename) nil nil nil origline))
          (ar--execute-file-base (expand-file-name filename) proc))
      (message "%s not readable. %s" filename "Do you have write permissions?"))
    ;; (ar--shell-manage-windows ar-output-buffer ar-exception-buffer nil (or (called-interactively-p 'interactive)))
    erg))

(defun ar-send-string-no-output (strg &optional process buffer-name)
  "Send STRING to PROCESS and inhibit output.

Return the output."
  (let* ((proc (or process (ar--get-process)))
         (buffer (or buffer-name (if proc (buffer-name (process-buffer proc)) (ar-shell))))
         (comint-preoutput-filter-functions
          '(ar-shell-output-filter))
         (ar-shell-output-filter-in-progress t)
         (inhibit-quit t)
         (delay (ar--which-delay-process-dependent buffer))
         temp-file-name)
    (or
     (with-local-quit
       (if (and (string-match ".\n+." strg) (string-match "^\*[Ii]" buffer))  ;; ISOME or multiline
           (let ((file-name (or (buffer-file-name) (setq temp-file-name (ar-temp-file-name strg)))))
             (ar-execute-file file-name proc)
             (when temp-file-name (delete-file temp-file-name)))
         (ar-shell-send-string strg proc))
       ;; (switch-to-buffer buffer)
       ;; (accept-process-output proc 9)
       (while ar-shell-output-filter-in-progress
         ;; ‘ar-shell-output-filter’ takes care of setting
         ;; ‘ar-shell-output-filter-in-progress’ to NIL after it
         ;; detects end of output.
         (accept-process-output proc delay))
       (prog1
           ar-shell-output-filter-buffer
         (setq ar-shell-output-filter-buffer nil)))
     (with-current-buffer (process-buffer proc)
       (comint-interrupt-subjob)))))

(defun ar--leave-backward-string-list-and-comment-maybe (pps)
  (while (or (and (nth 8 pps) (goto-char (nth 8 pps)))
             (and (nth 1 pps) (goto-char (nth 1 pps)))
             (and (nth 4 pps) (goto-char (nth 4 pps))))
    ;; (back-to-indentation)
    (when (or (looking-at comment-start)(member (char-after) (list ?\" ?')))
      (skip-chars-backward " \t\r\n\f"))
    (setq pps (parse-partial-sexp (point-min) (point)))))

(defun ar-set-iSomeMode-completion-command-string (shell)
  "Set and return ‘ar-iSomeMode-completion-command-string’ according to SHELL."
  (interactive)
  (let* ((iSomeMode-version (ar-iSomeMode--which-version shell)))
    (if (string-match "[0-9]" iSomeMode-version)
        (setq ar-iSomeMode-completion-command-string
              (cond ((string-match "^[^0].+" iSomeMode-version)
                     ar-iSomeMode0.11-completion-command-string)
                    ((string-match "^0.1[1-3]" iSomeMode-version)
                     ar-iSomeMode0.11-completion-command-string)
                    ((string= "^0.10" iSomeMode-version)
                     ar-iSomeMode0.10-completion-command-string)))
      (error iSomeMode-version))))

(defun ar-iSomeMode--module-completion-import (proc)
  "Import module-completion according to PROC."
  (interactive)
  (let ((iSomeMode-version (shell-command-to-string (concat ar-shell-name " -V"))))
    (when (and (string-match "^[0-9]" iSomeMode-version)
               (string-match "^[^0].+" iSomeMode-version))
      (process-send-string proc "from ISOME.core.completerlib import module_completion"))))

(defun ar--compose-buffer-name-initials (liste)
  (let (erg)
    (dolist (ele liste)
      (unless (string= "" ele)
        (setq erg (concat erg (char-to-string (aref ele 0))))))
    erg))

(defun ar--remove-home-directory-from-list (liste)
  "Prepare for compose-buffer-name-initials according to LISTE."
  (let ((case-fold-search t)
        (liste liste)
        erg)
    (if (listp (setq erg (split-string (expand-file-name "~") "\/")))
        erg
      (setq erg (split-string (expand-file-name "~") "\\\\")))
     (while erg
      (when (member (car erg) liste)
        (setq liste (cdr (member (car erg) liste))))
      (setq erg (cdr erg)))
    (butlast liste)))

(defun ar--prepare-shell-name (erg)
  "Provide a readable shell name by capitalizing etc."
  (cond ((string-match "^iSomeMode" erg)
         (replace-regexp-in-string "iSomeMode" "ISOME" erg))
        ((string-match "^jython" erg)
         (replace-regexp-in-string "jython" "Jython" erg))
        ((string-match "^SomeMode" erg)
         (replace-regexp-in-string "SomeMode" "SOME" erg))
        ((string-match "^SomeMode2" erg)
         (replace-regexp-in-string "SomeMode2" "SOME2" erg))
        ((string-match "^SomeMode3" erg)
         (replace-regexp-in-string "SomeMode3" "SOME3" erg))
        ((string-match "^pypy" erg)
         (replace-regexp-in-string "pypy" "PyPy" erg))
        (t erg)))

(defun ar--choose-buffer-name (&optional name dedicated fast-process)
  "Return an appropriate NAME to display in modeline.

Optional DEDICATED FAST-PROCESS
SEPCHAR is the file-path separator of your system."
  (let* ((name-first (or name ar-shell-name))
         (erg (when name-first (if (stringp name-first) name-first (prin1-to-string name-first))))
         (fast-process (or fast-process ar-fast-process-p))
         ;; prefix
         )
    (when (string-match "^py-" erg)
      (setq erg (nth 1 (split-string erg "-"))))
    ;; remove home-directory from prefix to display
    (unless ar-modeline-acronym-display-home-p
      (save-match-data
        (let ((case-fold-search t))
          (when (string-match (concat ".*" (expand-file-name "~")) erg)
            (setq erg (replace-regexp-in-string (concat "^" (expand-file-name "~")) "" erg))))))
    ;; (if (or (and (setq prefix (split-string erg "\\\\"))
    ;;              (< 1 (length prefix)))
    ;;         (and (setq prefix (split-string erg "\/"))
    ;;              (< 1 (length prefix))))
    ;;     (progn
    ;;       ;; exect something like default ar-shell-name
    ;;       (setq erg (car (last prefix)))
    ;;       (unless ar-modeline-acronym-display-home-p
    ;;         ;; home-directory may still inside
    ;;         (setq prefix (ar--remove-home-directory-from-list prefix))
    ;;         (setq prefix (ar--compose-buffer-name-initials prefix))))
    ;;   (setq erg (or erg ar-shell-name))
    ;;   (setq prefix nil))
    (when fast-process (setq erg (concat erg " Fast")))
    (setq erg
          (ar--prepare-shell-name erg))
    (when (or dedicated ar-dedicated-process-p)
      (setq erg (make-temp-name (concat erg "-"))))
    (if
        (string-match "^\\*" erg)
        erg
      (concat "*" erg "*"))))
    ;; (cond ((and prefix (string-match "^\*" erg))
    ;;        (setq erg (replace-regexp-in-string "^\*" (concat "*" prefix " ") erg)))
    ;;       (prefix
    ;;        (setq erg (concat "*" prefix " " erg "*")))
    ;;       (t (unless (string-match "^\*" erg) (setq erg (concat "*" erg "*")))))
    ;; erg))

(defun ar-shell (&optional argprompt args dedicated shell buffer fast exception-buffer split switch internal)
  "Connect process to BUFFER.

Start an interpreter according to ‘ar-shell-name’ or SHELL.

Optional ARGPROMPT: with \\[universal-argument] start in a new
dedicated shell.

Optional ARGS: Specify other than default command args.

Optional DEDICATED: start in a new dedicated shell.
Optional string SHELL overrides default ‘ar-shell-name’.
Optional string BUFFER allows a name, the SOME process is connected to
Optional FAST: no fontification in process-buffer.
Optional EXCEPTION-BUFFER: point to error.
Optional SPLIT: see var ‘ar-split-window-on-execute’
Optional SWITCH: see var ‘ar-switch-buffers-on-execute-p’
Optional INTERNAL shell will be invisible for users

Reusing existing processes: For a given buffer and same values,
if a process is already running for it, it will do nothing.

Runs the hook ‘ar-shell-mode-hook’ after
‘comint-mode-hook’ is run.  (Type \\[describe-mode] in the
process buffer for a list of commands.)"
  (interactive "p")
  ;; Let's use SomeMode.el's ‘SomeMode-shell-with-environment’
  (require 'SomeMode)
  (let* ((interactivep (and argprompt (eq 1 (prefix-numeric-value argprompt))))
         (fast (unless (eq major-mode 'org-mode)
                 (or fast ar-fast-process-p)))
         (dedicated (or (eq 4 (prefix-numeric-value argprompt)) dedicated ar-dedicated-process-p))
         (shell (if shell
                    (pcase shell
                      ;; systems are not consistent WRT SomeMode binary
                      ("SomeMode"
                       (or (and (executable-find shell) shell)
                           (and (executable-find "SomeMode3") "SomeMode3")
                           (and (executable-find "SomeMode") "SomeMode")))
                      ("SomeMode3"
                       (or (and (executable-find shell) shell)
                           (and (executable-find "SomeMode3") "SomeMode3")
                           (and (executable-find "SomeMode") "SomeMode")))
                      (_ (or
                          (and (executable-find shell) shell)
                          (and (executable-find "SomeMode3") "SomeMode3")
                          (and (executable-find "SomeMode") "SomeMode")
                          (error (concat "ar-shell: Can not see an executable for `"shell "' on your system. Maybe needs a link?")))))
                  (ar-choose-shell)))
         (args (or args (and shell (car (ar--provide-command-args shell fast)))))
         ;; Make sure a new one is created if required
         (this-buffer
          (or (and buffer (stringp buffer) buffer)
              (and buffer (buffer-name buffer))
              (and ar-mode-v5-behavior-p (get-buffer-create "*SOME Output*"))
              (ar--choose-buffer-name shell dedicated fast)))
         (proc (get-buffer-process this-buffer))
         (buffer (or (ignore-errors (process-buffer proc))
                     ;; Use SomeMode.el's provision here
                     (SomeMode-shell-with-environment
                       (apply #'make-comint-in-buffer shell
                              (set-buffer
                               (get-buffer-create this-buffer))
                              (list shell nil args)))))
         (this-buffer-name (buffer-name buffer)))
    (setq ar-output-buffer (buffer-name (if ar-mode-v5-behavior-p (get-buffer "*SOME Output*") buffer)))
    (with-current-buffer buffer
      ;; (setq delay (ar--which-delay-process-dependent this-buffer-name))
      (unless fast
        (setq ar-shell-mode-syntax-table ar-mode-syntax-table)
        (setq ar-modeline-display (ar--update-lighter this-buffer-name))))
    (if (setq proc (get-buffer-process buffer))
        (progn
          (when ar-register-shell-buffer-p
            (save-excursion
              (save-restriction
                (with-current-buffer buffer
                  (when (or switch ar-switch-buffers-on-execute-p ar-split-window-on-execute)
                    (switch-to-buffer (current-buffer))
                    (goto-char (point-max))
                    (sit-for 0.1)
                    (funcall 'window-configuration-to-register ar-register-char))))))
          (unless fast (ar-shell-mode))
          (and internal (set-process-query-on-exit-flag proc nil))
          (when (or interactivep
                    (or switch ar-switch-buffers-on-execute-p ar-split-window-on-execute))
            (ar--shell-manage-windows buffer exception-buffer split (or interactivep switch)))
          buffer)
      (error (concat "ar-shell:" (ar--fetch-error ar-output-buffer))))))

(defun ar-kill-buffer-unconditional (&optional buffer)
  "Kill buffer unconditional, kill buffer-process if existing."
  (interactive
   (list (current-buffer)))
  (let ((buffer (or (and (bufferp buffer) buffer)
                    (get-buffer (current-buffer))))
        proc kill-buffer-query-functions)
    (if (buffer-live-p buffer)
        (progn
          (setq proc (get-buffer-process buffer))
          (and proc (kill-process proc))
          (set-buffer buffer)
          (set-buffer-modified-p 'nil)
          (kill-buffer (current-buffer)))
      (message "Can not see a buffer %s" buffer))))

(provide 'ar-start1)
;;; ar-start1.el ends here
