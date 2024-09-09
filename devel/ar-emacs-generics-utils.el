;;; ar-emacs-generics-utils.el - generate utils -*- lexical-binding: t; -*-

;; URL: https://github.com/andreas-roehler/emacs-generics

;; Keywords: languages, processes, oop

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(defconst ar-emacs-generics-directory
  (expand-file-name "~/werkstatt/emacs-generics"))

(defconst ar-shells
  (list
   'ipython
   'ipython3
   'jython
   'python
   'python2
   'python3
   'pypy
   ""
   ))

(defvar ar-prefix "ar-")

(defconst ar-position-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "comment"
   "def"
   "def-or-class"
   "expression"
   "except-block"
   "if-block"
   "indent"
   "line"
   "minor-block"
   "partial-expression"
   "paragraph"
   "section"
   "statement"
   "top-level"
   "try-block"
   ))

;; like positions, but without comment, statement, expression, section,
;; toplevel, : avoid ar--end-base
(defconst ar-beg-end-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def-or-class"
   "def"
   "if-block"
   "elif-block"
   "else-block"
   "for-block"
   "except-block"
   "try-block"
   "minor-block"
   ))

(defconst ar-block-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "minor-block"
   "try-block"
   ))

(defconst ar-def-or-class-forms
  (list
   "class"
   "def-or-class"
   "def"
   ))

;; like positions, but without statement and expression, avoid ar--end-base
(defconst ar-end-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "comment"
   "def"
   "def-or-class"
   "line"
   "minor-block"
   "paragraph"
   "section"
   "statement"
   "top-level"
   ))

;; section has a different end as others
(defconst ar-execute-forms
  (list
   "block"
   "block-or-clause"
   "buffer"
   "class"
   "clause"
   "def"
   "def-or-class"
   "expression"
   "indent"
   "line"
   "minor-block"
   "paragraph"
   "partial-expression"
   "region"
   "statement"
   "top-level"
   )
  "Internally used")

(defconst ar-bol-forms
  (list
   "assignment"
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "indent"
   "minor-block"
   "statement"
   "try-block"
   ))

(defconst ar-non-bol-forms
  (list
   "comment"
   "expression"
   "line"
   "paragraph"
   "partial-expression"
   "section"
   "top-level"
   ))

(defconst ar-extra-execute-forms
  (list
   "try-block"
   "if-block"
   "for-block"
   ;; "with-block"
   ))

;; execute + comment
(defconst ar-hide-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "comment"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "expression"
   "for-block"
   "if-block"
   "indent"
   "line"
   "minor-block"
   "paragraph"
   "partial-expression"
   "section"
   "statement"
   "top-level"
   ))

;; comment can't use re-forms
(defconst ar-navigate-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "expression"
   "for-block"
   "if-block"
   "indent"
   "minor-block"
   "partial-expression"
   "section"
   "statement"
   "top-level"
   "try-block"
   ))

;; like navigate, but not top-level
(defconst ar-beginning-of-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "expression"
   "for-block"
   "if-block"
   "indent"
   "minor-block"
   "partial-expression"
   "section"
   "statement"
   "try-block"
   ))

(defconst ar-backward-def-or-class-forms
  (list
   "block"
   "class"
   "def"
   "def-or-class"
   ))

(defconst ar-backward-minor-block-forms
  (list
   "assignment"
   "block-or-clause"
   "clause"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "minor-block"
   "try-block"
   ))

;; comment, section not suitable here
(defconst ar-navigate-test-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "expression"
   "for-block"
   "if-block"
   "minor-block"
   "partial-expression"
   "statement"
   "top-level"
   "try-block"
   ))

(defconst ar-comment-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "indent"
   "minor-block"
   "section"
   "statement"
   "top-level"
   ))

;; top-level is special
(defconst ar-down-forms
  (list
   "block"
   "class"
   "clause"
   "block-or-clause"
   "def"
   "def-or-class"
   "minor-block"
   "statement"
   ))

(defconst ar-shift-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "comment"
   "def"
   "def-or-class"
   "indent"
   "minor-block"
   "paragraph"
   "region"
   "statement"
   "top-level"))

;; top-level, paragraph not part of `ar-shift-bol-forms'
(defconst ar-shift-bol-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "indent"
   "minor-block"
   "statement"
   "try-block"
   ))

(defconst ar-toggle-form-vars
  (list
   "ar-nil-docstring-style"
   "ar-onetwo-docstring-style"
   "ar-pep-257-docstring-style"
   "ar-pep-257-nn-docstring-style"
   "ar-symmetric-docstring-style"
   "ar-django-docstring-style" ))

(defconst ar-options
  (list ""
        "switch"
        "no-switch"
        "dedicated"
        ;; "dedicated-switch"
        ))

(defconst ar-full-options
  (list ""
        ;; "switch"
        ;; "no-switch"
        "dedicated"
        ;; "dedicated-switch"
        ))

(defvar ar-commands
  (list
   "ar-python-command"
   "ar-ipython-command"
   "ar-python3-command"
   "ar-python2-command"
   "ar-jython-command")
  "Python-mode will generate commands opening shells mentioned
  here. Edit this list \w resp. to your machine.")

(defconst ar-core-command-name
  '("statement"
    "block"
    "def"
    "class"
    "region"
    "file"))

(defconst ar-bounds-command-names
  (list
   "block"
   "block-or-clause"
   "buffer"
   "class"
   "clause"
   "def"
   "def-or-class"
   "else-block"
   "except-block"
   "expression"
   "if-block"
   "minor-block"
   "partial-expression"
   "section"
   "statement"
   "top-level"
   "try-block"
   ))

;; statement needed by ar-beginning-bol-command-names
(defconst ar-beginning-bol-command-names
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "indent"
   "minor-block"
   "statement"
   "try-block"
   ))

;; backward class/def treated with shorter forms internally
(defconst ar-backward-bol-command-names
  (list
   "block"
   "block-or-clause"
   "clause"
   "elif-block"
   "else-block"
   "except-block"
   "for-block"
   "if-block"
   "minor-block"
   "try-block"
   ))

(defconst ar-checker-command-names
  '("clear-flymake-allowed-file-name-masks"
    "pylint-flymake-mode"
    "pyflakes-flymake-mode"
    "pychecker-flymake-mode"
    "pep8-flymake-mode"
    "pyflakespep8-flymake-mode"
    "ar-pylint-doku"
    "ar-pyflakes-run"
    "ar-pyflakespep8-run"
    "ar-pyflakespep8-help"))

(defconst ar-fast-execute-forms-names
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "expression"
   "partial-expression"
   "section"
   "statement"
   "top-level"))

(defconst ar-navigation-forms
  (list
   "block"
   "block-or-clause"
   "class"
   "clause"
   "def"
   "def-or-class"
   "elif"
   "else"
   "expression"
   "partial-expression"
   "section"
   "try"
   "except"
   ))

;; "top-level" doesn't make sence WRT bol
(defconst docstring-styles
  (list
   "django"
   "onetwo"
   "pep-257"
   "pep-257-nn"
   "symmetric")
  "Customizable variable `ar-fill-docstring-style' provides default value
  used by `ar-fill-string', `ar-fill-paragraph'

  DJANGO:

      \"\"\"
      Process foo, return bar.
      \"\"\"

      \"\"\"
      Process foo, return bar.

      If processing fails throw ProcessingError.
      \"\"\"

  ONETWO:

      \"\"\"Process foo, return bar.\"\"\"

      \"\"\"
      Process foo, return bar.

      If processing fails throw ProcessingError.

      \"\"\"

  PEP-257:

      \"\"\"Process foo, return bar.\"\"\"

      \"\"\"Process foo, return bar.

      If processing fails throw ProcessingError.

      \"\"\"

  PEP-257-NN:

      \"\"\"Process foo, return bar.\"\"\"

      \"\"\"Process foo, return bar.

      If processing fails throw ProcessingError.
      \"\"\"

  SYMMETRIC:

      \"\"\"Process foo, return bar.\"\"\"

      \"\"\"
      Process foo, return bar.

      If processing fails throw ProcessingError.
      \"\"\"

  Built upon code seen at python.el, thanks Fabian")

(defconst ar-fast-core
  (list
   'block
   'block-or-clause
   'class
   'clause
   'def
   'def-or-class
   'expression
   'partial-expression
   'region
   'statement
   'strg
   'top-level))

(defconst ar-virtualenv-symbols
  (list
   'activate
   'deactivate
   'p
   'workon))

(defconst ar-fast-forms
  (list
   'ar--fast-send-string
   'ar-process-region-fast
   'ar-execute-statement-fast
   'ar-execute-block-fast
   'ar-execute-block-or-clause-fast
   'ar-execute-def-fast
   'ar-execute-class-fast
   'ar-execute-def-or-class-fast
   'ar-execute-expression-fast
   'ar-execute-partial-expression-fast
   'ar-execute-top-level-fast
   'ar-execute-clause-fast))

(defconst ar-bol-menu-forms
  (list
   'ar-backward-block-bol
   'ar-backward-clause-bol
   'ar-backward-block-or-clause-bol
   'ar-backward-def-bol
   'ar-backward-class-bol
   'ar-backward-def-or-class-bol
   'ar-backward-if-block-bol
   'ar-backward-try-block-bol
   'ar-backward-minor-block-bol
   'ar-backward-statement-bol))

(defconst ar-bol-end-forms
  (list
   'ar-forward-block-bol
   'ar-forward-clause-bol
   'ar-forward-block-or-clause-bol
   'ar-forward-def-bol
   'ar-forward-class-bol
   'ar-forward-def-or-class-bol
   'ar-forward-if-block-bol
   'ar-forward-try-block-bol
   'ar-forward-minor-block-bol
   'ar-forward-statement-bol))

(defconst ar-bol-coar-forms
  (list
   'ar-coar-block-bol
   'ar-coar-clause-bol
   'ar-coar-block-or-clause-bol
   'ar-coar-def-bol
   'ar-coar-class-bol
   'ar-coar-def-or-class-bol
   'ar-coar-statement-bol))

(defconst ar-other-symbols
  (list
   'boolswitch
   'empty-out-list-backward
   'kill-buffer-unconditional
   'remove-overlays-at-point))

(defconst ar-pyflakes-pep8-symbols
  (list
   'ar-pyflakes-pep8-run
   'ar-pyflakes-pep8-help
   'pyflakes-pep8-flymake-mode))

(defconst ar-flake8-symbols
  (list
   'ar-flake8-run
   'ar-flake8-help))

(defconst ar-pyflakes-symbols
  (list
   'ar-pyflakes-run
   'ar-pyflakes-help
   'pyflakes-flymake-mode))

(defconst ar-pep8-symbols
  (list
   'ar-pep8-run
   'ar-pep8-help
   'pep8-flymake-mode))

(defconst ar-pylint-symbols
  (list
   'ar-pylint-run
   'ar-pylint-help
   'pylint-flymake-mode))

(defconst ar-checks-symbols
  (list
   'ar-flycheck-mode
   'ar-pychecker-run))

(defconst ar-debugger-symbols
  (list
   'ar-execute-statement-pdb
   'pdb))

(defconst ar-help-symbols
  (list
   'ar-find-definition
   'ar-help-at-point
   'ar-info-lookup-symbol
   'ar-symbol-at-point))

(defconst ar-completion-symbols
  (list
   'ar-complete
   'ar-indent-or-complete
   'ar-shell-complete
   ))

(defconst ar-skeletons
  (list
   'else-statement
   'for-statement
   'if-statement
   'ar-try/except-statement
   'ar-try/finally-statement
   'while-statement
   ))

(defconst ar-filling-symbols
  (list
   'ar-docstring-style
   'ar-fill-comment
   'ar-fill-paragraph
   'ar-fill-string
   'ar-fill-string-django
   'ar-fill-string-onetwo
   'ar-fill-string-pep-257
   'ar-fill-string-pep-257-nn
   'ar-fill-string-symmetric
   ))

(defconst ar-electric-symbols
  (list
   'complete-electric-comma
   'complete-electric-lparen
   'electric-backspace
   'electric-colon
   'electric-comment
   'electric-delete
   'electric-yank
   'hungry-delete-backwards
   'hungry-delete-forward
   ))

(defconst ar-completion-symbols
  (list
   'ar-indent-or-complete
   'ar-shell-complete
   'ar-complete
   ))

(defconst ar-skeletons
  (list
   'else-statement
   'for-statement
   'if-statement
   'ar-try/except-statement
   'ar-try/finally-statement
   'while-statement
   ))

(defconst ar-filling-symbols
  (list
   'ar-docstring-style
   'ar-fill-comment
   'ar-fill-paragraph
   'ar-fill-string
   'ar-fill-string-django
   'ar-fill-string-onetwo
   'ar-fill-string-pep-257
   'ar-fill-string-pep-257-nn
   'ar-fill-string-symmetric
   ))

(defconst ar-electric-symbols
  (list
   'complete-electric-comma
   'complete-electric-lparen
   'electric-backspace
   'electric-colon
   'electric-comment
   'electric-delete
   'electric-yank
   'hungry-delete-backwards
   'hungry-delete-forward
   ))

(defconst ar-other-symbols
  (list
   'boolswitch
   'empty-out-list-backward
   'kill-buffer-unconditional
   'remove-overlays-at-point
   ))

(defconst ar-pyflakes-pep8-symbols
  (list
   'ar-pyflakes-pep8-run
   'ar-pyflakes-pep8-help
   'pyflakes-pep8-flymake-mode
   ))

(defconst ar-flake8-symbols
  (list
   'ar-flake8-run
   'ar-flake8-help
   ))

(defconst ar-pyflakes-symbols
  (list
   'ar-pyflakes-run
   'ar-pyflakes-help
   'pyflakes-flymake-mode
   ))

(defconst ar-pep8-symbols
  (list
   'ar-pep8-run
   'ar-pep8-help
   'pep8-flymake-mode
   ))

(defconst ar-pylint-symbols
  (list
   'ar-pylint-run
   'ar-pylint-help
   'pylint-flymake-mode
   ))

(defconst ar-checks-symbols
  (list
   'ar-flycheck-mode
   'ar-pychecker-run
   ))

(defconst ar-debugger-symbols
  (list
   'ar-execute-statement-pdb
   'pdb
   ))

(defconst ar-help-symbols
  (list
   'ar-find-definition
   'ar-help-at-point
   'ar-info-lookup-symbol
   'ar-symbol-at-point
   ))

(defconst arkopf
      "\n
;; URL: https://github.com/andreas-roehler/emacs-generics
;; Keywords: languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary: 

;; 

;;; Code:

")

(defun ar-write-file-forms ()
  "Write `ar-execute-file-python...' etc."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-execute-file.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-execute-file --- Runs files -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (insert ";; Execute file given\n\n")
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer)))
  (goto-char (point-max))
  (dolist (elt ar-shells)
    (setq ele (format "%s" elt))
    (insert (concat "(defun ar-execute-file-" ele " (filename)"))
    (insert
     (concat "
  \"Send file to " (ar--prepare-shell-name ele) " interpreter\"
  (interactive \"fFile: \")
  (let ((interactivep (called-interactively-p 'interactive))
        (buffer (ar-shell nil nil nil \"" ele "\" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t interactivep)))\n\n")
     ))
  (dolist (elt ar-shells)
    (setq ele (format "%s" elt))
    (insert (concat "(defun ar-execute-file-" ele "-dedicated (filename)"))
    (insert (concat "
  \"Send file to a dedicated" (ar--prepare-shell-name ele) " interpreter\"
  (interactive \"fFile: \")
  (let ((interactivep (called-interactively-p 'interactive))
        (buffer (ar-shell nil nil t \"" ele "\" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t interactivep)))\n\n")))
  ;; (ar--execute-base nil nil \"" ele "\" filename nil t t t))\n\n")))
  (insert "(provide 'ar-emacs-generics-execute-file)
;;; ar-emacs-generics-execute-file.el ends here\n")
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer))
    (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-execute-file.el")))

(defun ar--exexutable-name (ele)
  "Return \"IPython\" for \"ipython\" etc."
  (let (erg)
    (if (string-match "ipython" ele)
        (concat "IP" (substring ele 2))
      (capitalize ele))))

;; forms not to be declined with all variants
(defun ar-write-execute-forms (&optional command)
  "Write `ar-execute-block...' etc."
  (interactive)
    (set-buffer (get-buffer-create "ar-emacs-generics-exec-forms.el"))
    (erase-buffer)
    (insert ";;; ar-emacs-generics-exec-forms.el --- Forms with a reduced range of derived commands -*- lexical-binding: t; -*-\n")
    (insert arkopf)
    (insert ";; Execute forms at point\n\n")
    (dolist (ele ar-extra-execute-forms)
      (insert (concat "(defun ar-execute-" ele " ()"))
      (insert (concat "
  \"Send " ele " at point to Python default interpreter.\"\n"))
      (insert (concat "  (interactive)
  (let ((beg (prog1
                 (or (ar--beginning-of-" ele "-p)
                     (save-excursion
                       (ar-backward-" ele ")))))
        (end (save-excursion
               (ar-forward-" ele"))))
    (ar-execute-region beg end)))\n\n")))
  (insert "(provide 'ar-emacs-generics-exec-forms)
;;; ar-emacs-generics-exec-forms.el ends here\n ")
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer))
    (emacs-lisp-mode))
    (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-exec-forms.el")))

(defun write-options-dokumentation-subform (pyo)
  (cond ((string-match "dedicated" pyo)
         (insert "\n\nUses a dedicated shell.")))
  (cond ((string-match "no-switch" pyo)
         (insert "\nIgnores default of `ar-switch-buffers-on-execute-p', uses it with value \\\"nil\\\""))
        ((string-match "switch" pyo)
         (insert "\nIgnores default of `ar-switch-buffers-on-execute-p', uses it with value \\\"non-nil\\\""))))

(defun write-execute-ert-tests (&optional command path-to-shell option)
  "Write `ar-execute-block...' etc."
  (interactive)
  ;; (load-shells)
  (let ((ar-bounds-command-names (if command (list command) ar-bounds-command-names))
        (ar-test-shells (if path-to-shell (list path-to-shell) ar-shells))
        (ar-options (if option (list option) ar-options)))
    (if path-to-shell
        (set-buffer (get-buffer-create (concat path-to-shell ".el")))
      (set-buffer (get-buffer-create "python-executes-test.el")))
    (erase-buffer)
    (switch-to-buffer (current-buffer))
    (insert ";; ")
    (if path-to-shell
        (insert (concat path-to-shell ".el"))
      (insert "python-executes-ert-tests.el"))
    (insert " --- executes ert tests")
    (insert arkopf)
    (dolist (ele ar-bounds-command-names)
      (insert (concat "(defun ar-execute-" ele "-test ()
  (ar-tests-with-temp-buffer \n    "))
      (cond ((or (string-match "block" ele)(string-match "clause" ele))
             (insert (concat "if True: print(\\\"I'm the ar-execute-" ele)))
            ((string-match "def" ele)
             (insert (concat "def foo (): print(\\\"I'm the ar-execute-" ele)))
            ((string= "class" ele)
             (insert (concat "class foo (): print(\\\"I'm the ar-execute-" ele)))
            (t (insert (concat "\"print(\\\"I'm the ar-execute-" ele))))
      (insert "-test\\\")\"))")
      (insert (concat "
    (ar-execute-" ele ")"))
      (insert (concat "    (set-buffer (ar--fetch-first-python-buffer))
    (goto-char (point-max))
    (and (should (search-backward \"ar-execute-" ele " -test" nil t 1))
         (ar-kill-buffer-unconditional (current-buffer))))

  (insert "\n\n(provide 'python-executes-ert-tests)
;;; python-executes-ert-tests.el ends here\n ")
  (emacs-lisp-mode)
  (switch-to-buffer (current-buffer)))

(defun write-shell-arg-ert-tests (&optional command path-to-shell option)
  "Write `ar-shell...' etc."
  (interactive)
  (set-buffer (get-buffer-create "ar-shell-arg-ert-tests.el"))
  (erase-buffer)
  (switch-to-buffer (current-buffer))
  (insert ";;; ar-shell-arg-ert-tests.el --- ar-shell ert tests -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (dolist (ele ar-shells)
    (setq ele (format "%s" ele))
    (let ((buffer (prin1-to-string (ar--choose-buffer-name ele)))
          ;; (concat "*" ele "*")
          (arg (concat "ar-" ele "-command-args")))
      (insert (concat "(ert-deftest ar-ert-" ele "-shell-test ()\n"))
      (insert (make-string 2 ?\ ))
      (insert "(let (("arg"  (list \"-i -c\\\"abc=4\\\"\")))\n")
      (insert (make-string 4 ?\ ))
      (insert (concat "(ar-kill-buffer-unconditional " buffer")\n"))
      (insert (make-string 4 ?\ ))
      (insert (concat "(" ele ")\n"))
      (insert (make-string 4 ?\ ))
      (insert (concat "(should (buffer-live-p (get-buffer " buffer ")))\n"))
      (insert (make-string 4 ?\ ))
      ;; comint-last-input-end
      (insert (concat "(set-buffer (get-buffer " buffer "))\n"))
      (insert (make-string 4 ?\ ))
      (insert "(should (string= \"4\" ar-result))\n")
      (insert (make-string 4 ?\ ))
      (insert "(should (< 1 comint-last-input-end))))\n\n")))
  (insert "(provide 'ar-shell-arg-ert-tests)
;;; ar-shell-arg-ert-tests.el ends here\n ")
  (emacs-lisp-mode)
  (write-file (concat ar-emacs-generics-directory "/test/ar-shell-arg-ert-tests.el"))
  (switch-to-buffer (current-buffer)))

(defun write--extended-execute-switches (ele pyo)
  "Internally used by write-extended-execute-forms"

  (if (string-match "dedicated" pyo)
      (insert " t")
    (insert " dedicated"))
  (cond ((or (string= "switch" pyo)
             (string= "dedicated-switch" pyo))
         (insert " 'switch"))
        ((string= "no-switch" pyo)
         (insert " 'no-switch"))
        (t (insert " switch")))
  (cond ((string= "region" ele)
         (insert " (or beg (region-beginning)) (or end (region-end))")
         (insert " nil fast proc wholebuf split)))\n"))
        ((string= "buffer" ele)
         (insert " (point-min) (point-max)")
         (insert " nil fast proc wholebuf split)))\n"))
        (t  (insert " nil nil nil fast proc wholebuf split)))\n"))))

(defun write--unified-extended-execute-forms-docu (ele elt pyo)
  (insert (concat "
  \"Send " ele " at point to"))
  (cond
   ((string-match "" elt)
    (insert (concat " a " ar-python-command)))
   ((string-match "ipython" elt)
    (insert " IPython"))
   ((string= "python" elt)
    (insert " default"))
   (t (insert (concat " " (capitalize elt)))))
  (cond ((string= pyo "dedicated")
         (insert " unique interpreter."))
        ((string= pyo "dedicated-switch")
         (insert " unique interpreter and switch to result."))
        (t (insert " interpreter.")))
  (cond ((string= pyo "switch")
         (insert "\n\nSwitch to output buffer. Ignores `ar-switch-buffers-on-execute-p'."))
        ((string= pyo "no-switch")
         (insert "\n\nKeep current buffer. Ignores `ar-switch-buffers-on-execute-p' ")))
  (when (string= "python" elt)
    (insert "\n\nFor `default' see value of `ar-shell-name'"))
  (insert "\"\n"))

(defun write--unified-extended-execute-forms-arglist-intern (ele pyo elt arglist)
  (let ((args (cond ((string= "" pyo)
                     arglist)
                    ((string-match (concat pyo " *") arglist)
                     (replace-regexp-in-string (concat pyo " *") "" arglist))
                    ((string= "dedicated-switch" pyo)
                     (replace-regexp-in-string "dedicated\\|switch" "" arglist))
                    ((string= "no-switch" pyo)
                     (replace-regexp-in-string "switch" "" arglist))

                    (t arglist))))
    ;; (message "%s" args)
    (if (string= "region" ele)
        (if (string= "" elt)
            (insert (concat " (beg end &optional shell " args ")"))
          (insert (concat " (beg end &optional " args ")")))
      (if (string= "" elt)
          (insert (concat " (&optional shell " args ")"))
        (insert (concat " (&optional " args ")"))))))

(defun write--unified-extended-execute-forms-arglist (ele pyo elt)
  (let ((erst (if (string= "" elt)
                  "&optional shell"
                "&optional"))
        (arglist "dedicated fast split switch proc"))
    (write--unified-extended-execute-forms-arglist-intern ele pyo elt arglist)))

(defun write--unified-extended-execute-forms-interactive-spec (ele)
  (cond
   ((string= "region" ele)
    (insert "  (interactive \"r\")\n"))
   (t (insert "  (interactive)\n"))))

(defun write--unified-extended-execute-buffer-form ()
  (insert "  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))\n"))

(defun write--unified-extended-execute-basic-form ()
  (insert "  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))\n"))

(defun write--unified-extended-execute-let-form ()
  (insert "  (let ((wholebuf nil))\n"))

(defun write--unified-extended-execute-shells (elt)
  (if (string= "" elt)
      (insert " shell")
    (insert (concat " '" elt))))

;; not ready, don't use
;; (defun install--unified-extended-execute-forms ()
;;   ;; (switch-to-buffer (current-buffer))
;;   ;; (goto-char (point-max))
;;   (interactive)
;;   (dolist (ele ar-execute-forms)
;;     (dolist (elt ar-shells)
;;       ;; (setq elt (format "%s" elt))
;;       (fset  (quote elt
;;       (dolist (pyo ar-full-options)
;;      (concat "ar-execute-" ele)
;;      (unless (string= "" elt)
;;        (concat "-" elt))
;;      (unless (string= pyo "")(concat "-" pyo))
;;      ))))))

;; (defvar ar--basic-execute-forms
;;   (defun ar-execute-statement (&optional shell dedicated fast split switch proc)
;;   "Send statement at point to interpreter."
;;   (interactive)
;;   (let ((wholebuf nil))
;;     (ar--execute-prepare 'statement shell dedicated switch nil nil nil fast proc wholebuf split)))
;; "Internally used by ar-emacs-generics-utils.el"

;; (defun ar-execute-block-switch (\&optional shell dedicated fast split proc)
;;   \"Send block at point to  interpreter\.

;; Switch to output buffer\. Ignores \`ar-switch-buffers-on-execute-p'\.\"
;;   (interactive)
;;   (let ((wholebuf nil))
;;     (ar--execute-prepare 'block shell dedicated 'switch nil nil nil fast proc wholebuf split)))

;; (defun ar-execute-block-no-switch (\&optional shell dedicated fast split  proc)
;;   \"Send block at point to  interpreter\.

;; Keep current buffer\. Ignores \`ar-switch-buffers-on-execute-p' \"
;;   (interactive)
;;   (let ((wholebuf nil))
;;     (ar--execute-prepare 'block shell dedicated 'no-switch nil nil nil fast proc wholebuf split)))

;; (defun ar-execute-block-dedicated-switch (\&optional shell  fast split  proc)
;;   \"Send block at point to  unique interpreter\.
;; Switch to result\.\"
;;   (interactive)
;;   (let ((wholebuf nil))
;;     (ar--execute-prepare 'block shell t 'switch nil nil nil fast proc wholebuf split)))



(setq ar--basic-execute-forms "(defun ar--execute-prepare (form shell \&optional dedicated switch beg end filename fast proc wholebuf split)
  \"Update some vars\.\"
  (save-excursion
    (let* ((form (prin1-to-string form))
           (origline (ar-count-lines))
           (fast
            (or fast ar-fast-process-p))
           (ar-exception-buffer (current-buffer))
           (beg (unless filename
                  (prog1
                      (or beg (funcall (intern-soft (concat \"ar--beginning-of-\" form \"-p\")))
                          (funcall (intern-soft (concat \"ar-backward-\" form)))
                          (push-mark)))))
           (end (unless filename
                  (or end (save-excursion (funcall (intern-soft (concat \"ar-forward-\" form))))))))
      \;\; (setq ar-buffer-name nil)
      (if filename
            (if (file-readable-p filename)
                (ar--execute-file-base (expand-file-name filename) nil nil nil origline)
              (message \"%s not readable\. %s\" filename \"Do you have write permissions?\"))
        (ar--execute-base beg end shell filename proc wholebuf fast dedicated split switch)))))
")

(defun write--unified-extended-execute-forms-intern ()
  (switch-to-buffer (current-buffer))
  (goto-char (point-max))
  (insert ar--basic-execute-forms)
  (dolist (ele ar-execute-forms)
    ;; (unless (or
    ;; (string= "region" ele)
    ;; (if (string= "" ele))
    (dolist (elt ar-shells)
      (setq elt (format "%s" elt))
      (dolist (pyo ar-full-options)
        (insert (concat "\n(defun ar-execute-" ele))
        (unless (string= "" elt)
          (insert (concat "-" elt)))
        (unless (string= pyo "") (insert (concat "-" pyo)))
        (write--unified-extended-execute-forms-arglist ele pyo elt)
        (write--unified-extended-execute-forms-docu ele elt pyo)
        (write--unified-extended-execute-forms-interactive-spec ele)
        (cond ((string= "buffer" ele)
               (write--unified-extended-execute-buffer-form))
              ;; ((string= "buffer" ele)
              ;; (write--unified-extended-execute-basic-form))
              (t (write--unified-extended-execute-let-form)))
        (insert (concat "    (ar--execute-prepare '"ele))
        (write--unified-extended-execute-shells elt)
        (write--extended-execute-switches ele pyo)))))

(defun write-unified-extended-execute-forms ()
  "Write `ar-execute-statement, ...' etc.

Include default forms "
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-extended-executes.el"))
  (erase-buffer)
  (insert ";; Extended executes --- more execute forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write--unified-extended-execute-forms-intern)
  (insert "\n(provide 'ar-emacs-generics-extended-executes)
;;; ar-emacs-generics-extended-executes.el ends here")
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-extended-executes.el"))
  )

(defun pmu-fix-ipython (ele)
  (when (string-match "^ipython.*" ele)
        (skip-chars-backward "[a-z][0-9]\\.")
        (delete-char 1)
        (insert "P")
        (end-of-line)))

(defun ar-provide-installed-shells-commands ()
  "Reads ar-shells, provides commands opening these shell."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-named-shells.el"))
  (erase-buffer)
  (insert ";;; Python named shells -*- lexical-binding: t; -*- \n
;; This file is generated. Edits here might not be persistent.")
  (goto-char (point-max))
  (insert arkopf)
  (goto-char (point-max))
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer)))
  (goto-char (point-max))
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (dolist (ele ar-shells)
    (unless (string= ele "")
      (setq ele (replace-regexp-in-string "\\\\" "" (prin1-to-string ele)))
      (insert (concat "(defun " ele " (&optional argprompt args buffer fast exception-buffer split)
  \"Start an "))
      (insert (capitalize ele))
      (pmu-fix-ipython ele)
      (insert (concat " interpreter.

With optional \\\\[universal-argument] get a new dedicated "))
      (insert (concat "shell.\"
  (interactive \"p\")
  (let ((buffer (ar-shell argprompt args nil \"" ele "\" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max))
    buffer))\n\n"))))
  (insert "(provide 'ar-emacs-generics-named-shells)
;;; ar-emacs-generics-named-shells.el ends here
")

  (emacs-lisp-mode)
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-named-shells.el")))

(defun ar-write-installed-shells-menu ()
  (interactive)
  (with-current-buffer
      (get-buffer-create "ar-emacs-generics-installed-shells-menu.el")
    (erase-buffer)
    (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
          (emacs-lisp-mode))
    (insert "             (\"Other\"
                   :help \"Alternative Python Shells\"")
    (newline)
    (dolist (ele ar-shells)
      (setq ele (replace-regexp-in-string "\\\\" "" (prin1-to-string ele)))
      (unless (string= "python" ele)
        (emen ele)
        (skip-chars-forward "^]")
        (forward-char 1)
        (newline)))
    ;; dedicated
    (insert "\n(\"Dedicated\"
                   :help \"Dedicated Shells\"")
    (dolist (ele ar-shells)
      (emen (replace-regexp-in-string "\\\\" "" (concat (prin1-to-string ele) "-dedicated")))
      (skip-chars-forward "^]")
      (forward-char 1)
      (newline))
    (insert ")")
    (newline)
    ;; switch
    (insert "\n(\"Switch\"
                   :help \"Switch to shell\"")
    (dolist (ele ar-shells)
      (emen (replace-regexp-in-string "\\\\" "" (concat (prin1-to-string ele) "-switch")))
      (skip-chars-forward "^]")
      (forward-char 1)
      (newline))
    (insert ")")
    (insert ")")
    (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
          (emacs-lisp-mode))
    (write-file (concat ar-emacs-generics-directory "/devel/ar-emacs-generics-installed-shells-menu.el"))))

(defun ar-write-installed-shells-test-intern ()
  (dolist (ele ar-shells)
      (setq ele (replace-regexp-in-string "\\\\" "" (prin1-to-string ele)))
      (insert (concat "\n(ert-deftest " ele))
      ;; (pmu-fix-ipython ele)
      ;; (when arg (insert (concat "-" arg)))
      (insert (concat "-shell-test ()
  (ar-kill-buffer-unconditional \"*" (capitalize ele)))
      (pmu-fix-ipython ele)
      ;; (when arg (insert (concat "-" arg)))
      (insert (concat "*\")
  (" ele ")
  (should (buffer-live-p (get-buffer \"*" (capitalize ele)))
      (pmu-fix-ipython ele)
      ;; (when arg (insert (concat "-" arg)))
      (insert "*\"))))\n")))

(defun ar-write-installed-shells-test ()
  (interactive)
  (with-current-buffer
      (get-buffer-create "ar-emacs-generics-installed-shells-test.el")
    (erase-buffer)
    (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
          (emacs-lisp-mode))
    (ar-write-installed-shells-test-intern)
    (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
          (emacs-lisp-mode))
    (write-file (concat ar-emacs-generics-directory "/test/ar-emacs-generics-installed-shells-test.el"))))

(defun ar-write-shift-forms ()
  " "
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-shift-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-shift-forms.el --- Move forms left or right -*- lexical-binding: t; -*- \n")
  (insert arkopf)

  (insert "
\(defun ar-shift-left (&optional count start end)
  \"Dedent region according to `ar-indent-offset' by COUNT times.

If no region is active, current line is dedented.
Return indentation reached
Optional COUNT: COUNT times `ar-indent-offset'
Optional START: region beginning
Optional END: region end\"
  (interactive \"p\")
  (ar--shift-intern (- count) start end))

\(defun ar-shift-right (&optional count beg end)
  \"Indent region according to `ar-indent-offset' by COUNT times.

If no region is active, current line is indented.
Return indentation reached
Optional COUNT: COUNT times `ar-indent-offset'
Optional BEG: region beginning
Optional END: region end\"
  (interactive \"p\")
  (ar--shift-intern count beg end))

\(defun ar--shift-intern (count &optional start end)
  (save-excursion
    (let\* ((inhibit-point-motion-hooks t)
           deactivate-mark
           (beg (cond (start)
                      ((use-region-p)
                       (save-excursion
                         (goto-char
                          (region-beginning))))
                      (t (line-beginning-position))))
           (end (cond (end)
                      ((use-region-p)
                       (save-excursion
                         (goto-char
                          (region-end))))
                      (t (line-end-position)))))
      (setq beg (coar-marker beg))
      (setq end (coar-marker end))
      (if (< 0 count)
          (indent-rigidly beg end ar-indent-offset)
        (indent-rigidly beg end (- ar-indent-offset)))
      (push-mark beg t)
      (goto-char end)
      (skip-chars-backward \" \\t\\r\\n\\f\"))
    (ar-indentation-of-statement)))

\(defun ar--shift-forms-base (form arg &optional beg end)
  (let\* ((begform (intern-soft (concat \"ar-backward-\" form)))
         (endform (intern-soft (concat \"ar-forward-\" form)))
         (orig (coar-marker (point)))
         (beg (cond (beg)
                    ((use-region-p)
                     (save-excursion
                       (goto-char (region-beginning))
                       (line-beginning-position)))
                    (t (save-excursion
                         (funcall begform)
                         (line-beginning-position)))))
         (end (cond (end)
                    ((use-region-p)
                     (region-end))
                    (t (funcall endform))))
         (erg (ar--shift-intern arg beg end)))
    (goto-char orig)
    erg))
")
  (dolist (ele ar-shift-forms)
    (insert (concat "
\(defun ar-shift-" ele "-right (&optional arg)
  \"Indent " ele " by COUNT spaces.

COUNT defaults to `ar-indent-offset',
use \\\\[universal-argument] to specify a different value.

Return outmost indentation reached.\"
  (interactive \"\*P\")
  (ar--shift-forms-base \"" ele "\" (or arg ar-indent-offset)))

\(defun ar-shift-" ele "-left (&optional arg)
  \"Dedent " ele " by COUNT spaces.

COUNT defaults to `ar-indent-offset',
use \\\\[universal-argument] to specify a different value.

Return outmost indentation reached.\"
  (interactive \"\*P\")
  (ar--shift-forms-base \"" ele "\" (- (or arg ar-indent-offset))))
")))
      (insert "\n(provide 'ar-emacs-generics-shift-forms)
;;; ar-emacs-generics-shift-forms.el ends here\n ")

    (emacs-lisp-mode)
    (switch-to-buffer (current-buffer))
    (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-shift-forms.el"))
    )

;; (defun ar-write-down-forms-bol ()
;;   " "
;;   (interactive)
;;   (set-buffer (get-buffer-create "ar-end-of-form-bol-commands.txt"))
;;   (erase-buffer)
;;   (dolist (ele ar-down-forms)
;;     (insert (concat "ar-end-of-" ele "-bol\n")))
;;   (set-buffer (get-buffer-create "ar-end-of-form-bol.el"))
;;   (erase-buffer)
;;   (insert ";; Complementary left corner end of form commands")
;;   (dolist (ele ar-down-forms)
;;     (insert (concat "
;; \(defalias 'ar-down-" ele "-bol 'ar-end-of-" ele "-bol)
;; \(defun ar-forward-" ele "-bol ()
;;   \"Goto beginning of line following end of " ele ".
;; Return position reached, if successful, nil otherwise.

;; A complementary command travelling at beginning of line, whilst `ar-forward-" ele "' stops at right corner.
;; See also `ar-down-" ele "': down from current definition to next beginning of " ele " below.\"
;;   (interactive)
;;   (let ((erg (ar-forward-" ele ")))
;;     (when erg
;;       (unless (eobp)
;;         (forward-line 1)
;;         (beginning-of-line)
;;         (setq erg (point))))
;;   (when (called-interactively-p 'interactive) (message \"%s\" erg))
;;   erg))
;; "))
;;     (emacs-lisp-mode)
;;     (switch-to-buffer (current-buffer))))

(defun ar-write-specifying-shell-forms ()
  " "
  (interactive)
  (set-buffer (get-buffer-create "specifying-shell-forms"))
  (erase-buffer)
  (dolist (ele ar-shells)
    (insert (concat "
\(defun ar-execute-region-" ele " (start end)
  \"Send the region to a common shell calling the " ele " interpreter.\"
  (interactive \"r\\nP\")
  (ar--execute-base start end \"" ele "\"))

\(defun ar-execute-region-" ele "-switch (start end)
  \"Send the region to a common shell calling the " ele " interpreter.
  Ignores setting of `ar-switch-buffers-on-execute-p', output-buffer will being switched to.\"
  (interactive \"r\\nP\")
  (let ((ar-switch-buffers-on-execute-p t))
    (ar--execute-base start end async \"" ele "\")))

\(defun ar-execute-region-" ele "-no-switch (start end)
  \"Send the region to a common shell calling the " ele " interpreter.
  Ignores setting of `ar-switch-buffers-on-execute-p', output-buffer will not being switched to.\"
  (interactive \"r\\nP\")
  (let ((ar-switch-buffers-on-execute-p))
    (ar--execute-base start end async \"" ele "\")))"))))

(defun xemacs-remove-help-strings ()
  "menu :help not supported presently at XEmacs."
  (interactive "*")
  (let (erg)
    (goto-char (point-min))
    (while
        (and (search-forward ":help" nil t 1)(not (ar-in-string-or-comment-p)))
      (save-match-data
        (skip-chars-forward "[[:blank:]\"]+")
        (ar-kill-string-atpt)
        (setq erg (point))
        (push-mark))
      (goto-char (match-beginning 0))
      (delete-region (point) erg)
      (if (ar-empty-line-p)
          (delete-region (line-beginning-position) (1+ (line-end-position)))
        (push-mark)
        (setq erg (point))
        (skip-chars-backward " \t\r\n\f")
        (delete-region (point) erg))))
  (message "%s" "fertig"))

(defconst ar-noregexp-forms
  (list
   "paragraph"
   "line"
   "statement"
   "expression"
   "partial-expression"))

(defconst ar-regexp-forms
  (list
   "block"
   "clause"
   "block-or-clause"
   "def"
   "class"
   "def-or-class"))

(defun write-toggle-forms (&optional arg)
  "Write toggle-forms according to (car kill-ring) "
  (interactive "P")
  (let ((liste (if (eq 4 (prefix-numeric-value arg))
                   (car kill-ring)
                 ar-toggle-form-vars))
        done buffer-out first menu-buffer)
    (if (listp liste)
        (dolist (ele liste)
          (write-toggle-forms-intern ele))
      (write-toggle-forms-intern liste))))

(defun write-toggle-forms-intern (ele)
      (if done
          (set-buffer buffer-out)
        (setq buffer-out (capitalize ele))
        (set-buffer (get-buffer-create buffer-out))
        (erase-buffer)
        (insert (concat ";; " ele " forms\n\n"))
        (setq done t))
      (message "Writing for; %s" ele)
      (insert (concat "
\(defun toggle-" ele " (&optional arg)
  \"If `" ele "' should be on or off.

Return value of `" ele "' switched to.\"
  (interactive)
  (let ((arg (or arg (if " ele " -1 1))))
    (if (< 0 arg)
        (setq " ele " t)
      (setq " ele " nil))
    (when (or ar-verbose-p (called-interactively-p 'interactive)) (message \"" ele ": %s\" " ele "))
    " ele "))

\(defun " ele "-on (&optional arg)
  \"Make sure, " ele "' is on.

Return value of `" ele "'.\"
  (interactive)
  (let ((arg (or arg 1)))
    (toggle-" ele " arg))
  (when (or ar-verbose-p (called-interactively-p 'interactive)) (message \"" ele ": %s\" " ele "))
  " ele ")

\(defun " ele "-off ()
  \"Make sure, `" ele "' is off.

Return value of `" ele "'.\"
  (interactive)
  (toggle-" ele " -1)
  (when (or ar-verbose-p (called-interactively-p 'interactive)) (message \"" ele ": %s\" " ele "))
  " ele ")"))
      (newline)
      (emacs-lisp-mode)
      (eval-buffer)
      (if first
          (set-buffer menu-buffer)
        (setq menu-buffer (concat "Menu " ele))
        (set-buffer (get-buffer-create menu-buffer))
        (erase-buffer)
        (insert (concat ";; " ele " forms\n\n"))
        (setq first t))
      (switch-emen ele)
      ;; (set-buffer buffer-out)
      ;; (switch-to-buffer (current-buffer))
      )

(defun write-commandp-forms ()
  "Write forms according to `ar-bounds-command-names' "
  (interactive)
  (let ((erg ar-bounds-command-names))

    (set-buffer (get-buffer-create "Commandp tests"))
    (erase-buffer)
    (dolist (ele erg)
      (insert (concat "--funcall " ele "-commandp-test \\\n")))
    (insert ";; Commandp tests")
    ;; (dolist (ele ar-bounds-command-names)
    (dolist (ele erg)
      (insert (concat "
\(defun " ele "-commandp-test (&optional arg load-branch-function)
  (interactive \"p\")
  (let ((teststring \"\"))
  (ar-bug-tests-intern '" ele "-commandp-base arg teststring)))

\(defun " ele "-commandp-base (arg)
    (assert (commandp '" ele ") nil \"" ele "-commandp-test failed\"))"))
      (newline)))
  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode))

(defun write-invoke-ar-shell-forms ()
  "Write forms according to `ar-shells' "
  (interactive)
  (set-buffer (get-buffer-create "Py-shell interactive calls"))
  (erase-buffer)
  (dolist (ele ar-shells)
    (insert (concat "'ar-shell-invoking-" ele "-lp:835151-test\n")))

  (set-buffer (get-buffer-create "Py-shell batch-commands"))
  (erase-buffer)
  (dolist (ele ar-shells)
    (insert (concat "--funcall ar-shell-invoking-" ele "-lp:835151-test \\\n")))

  (set-buffer (get-buffer-create "Py-shell tests"))
  (erase-buffer)
  (insert ";; Py-shell tests")
  ;; (dolist (ele ar-bounds-command-names)
  (dolist (ele ar-shells)
    (insert (concat "
\(defun ar-shell-invoking-" ele "-lp:835151-test (&optional arg load-branch-function)
  (interactive \"p\")
  (let ((teststring \"print(\\\"ar-shell-name: " ele "\\\")\"))
    (when load-branch-function (funcall load-branch-function))
    (ar-bug-tests-intern 'ar-shell-invoking-" ele "-lp:835151-base arg teststring)))

\(defun ar-shell-invoking-" ele "-lp:835151-base (arg)
  (setq ar-shell-name \"" ele "\")
  (assert (markerp (ar-execute-buffer)) nil \"ar-shell-invoking-" ele "-lp:835151-test failed\"))\n")))
  (newline)
  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode))

(defalias 'fehler-python-tests 'lookup-failing-command)
(defun lookup-failing-command ()
  "From ./python-mode-tests.sh buffer, jump to definition of command.

Needs `elisp-find-definition' from
http://repo.or.cz/w/elbb.git/blob/HEAD:/code/Go-to-Emacs-Lisp-Definition.el
"
  (interactive)
  (let (erg)
    (search-backward " pass")
    (forward-char -1)
    (setq erg (prin1-to-string (symbol-at-point)))
    (find-file "~/arbeit/emacs/python-modes/components-python-mode/test/python-mode-tests.sh")
    (goto-char (point-min))
    (when (search-forward erg)
      (search-forward "--funcall ")
      (setq erg (prin1-to-string (symbol-at-point)))
      (elisp-find-definition erg))
    (when (called-interactively-p 'interactive) (message "%s" erg))
    erg))

(defun ar-write-up-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-up.el"))
  (erase-buffer)
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer)))
  (insert ";;; ar-emacs-generics-up.el -- Searching upwards in buffer -*- lexical-binding: t; -*- \n")
  (insert arkopf)
  (dolist (ele ar-down-forms)
    (unless (string= ele "statement")
      (insert (concat "
\(defun ar-up-" ele " ()
  \"Go to the beginning of next " ele " upwards.

Return position if " ele " found, nil otherwise.\"
  (interactive)
  (ar-up-base 'ar-"))
      (cond ((string-match "def\\|class\\|section" ele)
             (insert (concat ele "-re))\n")))
            ;; (t (insert "extended-block-or-clause-re))\n"))
            (t (insert (concat ele "-re))\n")))
            ;; (t (insert "extended-block-or-clause-re))\n"))
            )))
  ;; up bol
  (dolist (ele ar-down-forms)
    (if (string= "statement" ele)
        nil
      (insert (concat "
\(defun ar-up-" ele "-bol ()
  \"Go to the beginning of next " ele " upwards.

Go to beginning of line.
Return position if " ele " found, nil otherwise.\"
  (interactive)
  (and (ar-up-base 'ar-" ele "-re)
    (progn (beginning-of-line)(point))))\n"))))
  ;; down bol

  (insert "\n;; ar-emacs-generics-up.el ends here
\(provide 'ar-emacs-generics-up)")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-up.el")))

(defun ar-write-down-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-down.el"))
  (erase-buffer)
  (when (called-interactively-p 'interactive)
    (switch-to-buffer (current-buffer)))
  (insert ";;; ar-emacs-generics-down.el -- Searching downwards in buffer -*- lexical-binding: t; -*- \n")
  (insert arkopf)
  ;; down
  (dolist (ele ar-down-forms)
    (if (string= "statement" ele)
        nil
      (insert (concat "
\(defun ar-down-" ele " (&optional indent)
  \"Go to the beginning of next " ele " downwards according to INDENT.

Return position if " ele " found, nil otherwise.\"
  (interactive)
  (ar-down-base 'ar-" ele "-re indent))\n"))))
  ;; down bol
  (dolist (ele ar-down-forms)
    (if (string= "statement" ele)
        nil
      (insert (concat "
\(defun ar-down-" ele "-bol (&optional indent)
  \"Go to the beginning of next " ele " below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if " ele " found, nil otherwise \"
  (interactive)
  (ar-down-base 'ar-" ele "-re indent t)
  (progn (beginning-of-line)(point)))\n"))))
  (insert "\n;; ar-emacs-generics-down.el ends here
\(provide 'ar-emacs-generics-down)")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-down.el")))

(defun temen (&optional symbol)
  "Provide menu for toggle-commands using checkbox."
  (interactive "*")
  (let* ((erg (or symbol (car kill-ring)))
         (name (intern-soft erg))
         (doku (if (functionp name)
                   (documentation name)
                 (documentation-property name 'variable-documentation)))
         (banner1 (replace-regexp-in-string "-" " " (replace-regexp-in-string "ar-" "" erg)))
         (banner2 (replace-regexp-in-string " p$" " " (replace-regexp-in-string "ar-" "" banner1))))
    ;; (goto-char (point-max))
    (switch-to-buffer (current-buffer))
    (save-excursion
      (insert (concat "\n\[\"" banner2 "\"
  (setq " erg "
     (not " erg "))
 :help \""))
      (when doku (insert (regexp-quote doku)))
      (insert (concat "Use `M-x customize-variable' to set it permanently\"
 :style toggle :selected " erg "]\n")))
    (skip-chars-forward "[[:punct:]]")
    (capitalize-word 1)))

(defun switch-emen (&optional symbol)
  "Provide menu draft for switches."
  (interactive "*")
  (let* ((erg (or symbol (car kill-ring)))
         (name (intern-soft erg))
         (doku (if (functionp name)
                   (documentation name)
                 (documentation-property name 'variable-documentation))))
    (switch-to-buffer (current-buffer))
    (save-excursion
      ;; ("ar-switch-buffers-on-execute-p"
      ;; :help "Toggle `ar-switch-buffers-on-execute-p'"
      (insert (concat "(\"" (replace-regexp-in-string "-" " " (replace-regexp-in-string "ar-" "" erg)) "\"
 :help \"Toggle `" erg "'\"
")))
    (capitalize-word 1)
    (goto-char (point-max))
    (emen (concat "toggle-" symbol))
    (goto-char (point-max))
    (emen (concat symbol "-on"))
    (goto-char (point-max))
    (emen (concat symbol "-off"))
    (goto-char (point-max))
    (insert "\n)\n"))
  (emacs-lisp-mode))

(defun write-ar-comment-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-comment.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-comment.el -- Comment/uncomment python constructs at point -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (insert "
\(defun ar-comment-region (beg end &optional arg)
  \"Like `comment-region' but uses double hash (`#') comment starter.\"
  (interactive \"r\\nP\")
  (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start)))
    (comment-region beg end arg)))\n
")
  (dolist (ele ar-comment-forms)
    (insert (concat "(defun ar-comment-" ele " (&optional beg end arg)
  \"Comments " ele " at point.

Uses double hash (`#') comment starter when `ar-block-comment-prefix-p' is  t,
the default\"
  (interactive \"\*\")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-" ele "-position)))
          (end (or end (ar-end-of-" ele "-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))\n\n")))
  (insert "\n;; ar-emacs-generics-comment ends here
\(provide 'ar-emacs-generics-comment)")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-comment.el")))

  ;; (set-buffer (get-buffer-create "Menu-Python-Components-Comments"))
  ;; (erase-buffer)
  ;; (insert "(\"Comment ...\"
  ;;           :help \"Comment forms\"\n\n")

  ;; (switch-to-buffer (current-buffer))
  ;; (dolist (ele ar-comment-forms)
  ;;   (setq name (concat "ar-comment-" ele))
  ;;   (write-menu-entry name))
  ;; (insert "      ))")
  ;; (emacs-lisp-mode)
  ;; (switch-to-buffer (current-buffer)))

(defun ar-write-mark-bol ()
  (interactive)
    (set-buffer (get-buffer-create "mark-bol.el"))
    (erase-buffer)
    (dolist (ele ar-navigate-forms)
      (insert (concat "
\(defun ar-mark-" ele "-bol ()
  \"Mark " ele ", take beginning of line positions.

Return beginning and end positions of region, a cons.\"
  (interactive)
  (let (erg)
    (setq erg (ar--mark-base-bol \"" ele "\"))
    (exchange-point-and-mark)
    (when (and ar-verbose-p (called-interactively-p 'interactive)) (message \"%s\" erg))
    erg))
")))
    (switch-to-buffer (current-buffer))
    (emacs-lisp-mode))

(defun ar--insert-backward-def-or-class-forms ()
  (dolist (ele ar-backward-def-or-class-forms)
    (insert (concat "
\(defun ar-backward-" ele " ()"))
    (insert (concat "\n  \"Go to beginning of `" ele "'.

If already at beginning, go one `" ele "' backward."))
    (insert (concat "
Return position if successful, nil otherwise\"\n"))
    (insert "  (interactive)
  (let (erg)")
    (insert (concat "
    (setq erg (ar--go-to-keyword 'ar-" (ar-block-regexp-name-richten ele) "-re '<))"))
    ;; (setq erg (ar--backward-regexp 'ar-" (ar-block-regexp-name-richten ele) "-re (current-indentation)))"))
    (when (string-match  "def\\|class$\\|block$" ele)
    (insert "\n    (when ar-mark-decorators
      (and (ar-backward-decorator) (setq erg (point))))"))
    (insert "\n    erg))\n")))

(defun ar--insert-backward-def-or-class-bol-forms ()
  ;; bol forms
  (dolist (ele ar-backward-def-or-class-forms)
    (insert (concat "
\(defun ar-backward-" ele "-bol ()"))
    (insert (concat "
  \"Go to beginning of `" ele "', go to BOL."))
    ;; (when (string-match "def\\|class" ele)
    ;;   (insert  "\nOptional DECORATOR\n"))

(insert (concat "
If already at beginning, go one `" ele "' backward.
Return beginning of `" ele "' if successful, nil otherwise"))
    (insert "\"\n")
    (insert "  (interactive)")
           (insert (concat "
  (and (ar-backward-" ele ")
       (progn (beginning-of-line)(point))))\n"))))

(defun ar--insert-backward-minor-block-forms ()
  (dolist (ele ar-backward-minor-block-forms)
    (insert (concat "
\(defun ar-backward-" ele " ()"))
    ;; (if (string-match "def\\|class" ele)
    ;;  (insert "&optional decorator)")
    ;; (insert ")"))
    (insert (concat "\n  \"Go to beginning of `" ele "'.

If already at beginning, go one `" ele "' backward."))
    ;; (when (string-match "def\\|class" ele)
    ;;   (insert "\nOptional DECORATOR\n"))
    (insert (concat "
Return position if successful, nil otherwise\"\n"))
    (insert "  (interactive)")
    (insert (concat "
  (ar--go-to-keyword 'ar-" (ar-block-regexp-name-richten ele) "-re '<))\n"))
        ))

(defun ar--insert-backward-minor-block-bol-forms ()
  ;; bol forms
  (dolist (ele ar-backward-minor-block-forms)
    (insert (concat "
\(defun ar-backward-" ele "-bol ()"))
    (insert (concat "
  \"Go to beginning of `" ele "', go to BOL."))
(insert (concat "
If already at beginning, go one `" ele "' backward.
Return beginning of `" ele "' if successful, nil otherwise"))
    (insert "\"\n")
    (insert "  (interactive)")
           (insert (concat "
  (and (ar-backward-" ele ")
       (progn (beginning-of-line)(point))))\n"))))

(defun ar-write-backward-forms ()
  "Uses ar-backward-forms, not `ar-navigate-forms'.

Use backward-statement for `top-level', also bol-forms don't make sense here"
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-backward-forms.el"))
  (erase-buffer)
  (switch-to-buffer (current-buffer))
  (insert ";;; ar-emacs-generics-backward-forms.el --- Go to beginning of form or further backward -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (insert "(defun ar-backward-region ()
  \"Go to the beginning of current region.\"
  (interactive)
  (let ((beg (region-beginning)))
    (when beg (goto-char beg))))
")

  ;; don't handle (partial)-expression forms here
  (ar--insert-backward-def-or-class-forms)
  (ar--insert-backward-def-or-class-bol-forms)
  (ar--insert-backward-minor-block-forms)
  (ar--insert-backward-minor-block-bol-forms)
  (insert "\n(provide 'ar-emacs-generics-backward-forms)
;;; ar-emacs-generics-backward-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-backward-forms.el")))

(defun ar-write-forms-code ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-forms-code.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-forms-code.el --- Return Python forms' code -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (dolist (ele ar-execute-forms)
    (insert (concat "
\(defun ar-" ele))
    (if (member ele (list "block" "block-or-clause" "def" "def-or-class" "class" "top-level"))
        (insert " (&optional decorators)")
      (insert " ()"))
    (insert (concat "
  \"When called interactively, mark " (capitalize ele) " at point.

From a programm, return source of " (capitalize ele) " at point, a string."))
        (if (member ele (list "block" "block-or-clause" "def" "def-or-class" "class" "top-level"))
            (insert "\n\nOptional arg DECORATORS: include decorators when called at def or class.
Also honors setting of `ar-mark-decorators'\"")
          (insert "\""))
        (insert (concat "
  (interactive)
  (if (called-interactively-p 'interactive)
      (ar--mark-base \"" ele "\""))
        (when (member ele (list "block" "block-or-clause" "def" "def-or-class" "class" "top-level"))
          (insert " (or decorators ar-mark-decorators)"))
        (insert (concat  ")
    (ar--thing-at-point \""ele"\""))
        (when (member ele (list "block" "block-or-clause" "def" "def-or-class" "class" "top-level"))
          (insert " (or decorators ar-mark-decorators)"))
     (insert ")))\n"))
  (insert "\n;; ar-emacs-generics-forms-code.el ends here
\(provide 'ar-emacs-generics-forms-code)")

  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode)
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-forms-code.el")))

(defun ar-write-hide-forms ()
  (interactive "*")
  (set-buffer (get-buffer-create "ar-emacs-generics-hide-show.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-hide-show.el --- Provide hs-minor-mode forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (insert"
\;; (setq hs-block-start-regexp 'ar-extended-block-or-clause-re)
\;; (setq hs-forward-sexp-func 'ar-forward-block)

\(defun ar-hide-base (form &optional beg end)
  \"Hide visibility of existing form at point.\"
  (hs-minor-mode 1)
  (save-excursion
    (let\* ((form (prin1-to-string form))
           (beg (or beg (or (funcall (intern-soft (concat \"ar--beginning-of-\" form \"-p\")))
                            (funcall (intern-soft (concat \"ar-backward-\" form))))))
           (end (or end (funcall (intern-soft (concat \"ar-forward-\" form)))))
           (modified (buffer-modified-p))
           (inhibit-read-only t))
      (if (and beg end)
          (progn
            (hs-make-overlay beg end 'code)
            (set-buffer-modified-p modified))
        (error (concat \"No \" (format \"%s\" form) \" at point\"))))))

\(defun ar-hide-show (&optional form beg end)
  \"Toggle visibility of existing forms at point.\"
  (interactive)
  (save-excursion
    (let\* ((form (prin1-to-string form))
           (beg (or beg (or (funcall (intern-soft (concat \"ar--beginning-of-\" form \"-p\")))
                            (funcall (intern-soft (concat \"ar-backward-\" form))))))
           (end (or end (funcall (intern-soft (concat \"ar-forward-\" form)))))
           (modified (buffer-modified-p))
           (inhibit-read-only t))
      (if (and beg end)
          (if (overlays-in beg end)
              (hs-discard-overlays beg end)
            (hs-make-overlay beg end 'code))
        (error (concat \"No \" (format \"%s\" form) \" at point\")))
      (set-buffer-modified-p modified))))

\(defun ar-show ()
  \"Remove invisibility of existing form at point\.\"
  (interactive)
  (with-silent-modifications
    (save-excursion
      (back-to-indentation)
      (let ((end (next-overlay-change (point))))
        (hs-discard-overlays (point) end)))))

\(defun ar-show-all ()
  \"Remove invisibility of hidden forms in buffer\.\"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let (end)
      (while (and (not (eobp))  (setq end (next-overlay-change (point))))
        (hs-discard-overlays (point) end)
        (goto-char end)))))

\(defun ar-hide-region (beg end)
  \"Hide active region.\"
  (interactive
   (list
    (and (use-region-p) (region-beginning))(and (use-region-p) (region-end))))
  (ar-hide-base 'region beg end))

\(defun ar-show-region (beg end)
  \"Un-hide active region.\"
  (interactive
   (list
    (and (use-region-p) (region-beginning))(and (use-region-p) (region-end))))
  (ar-show-base 'region beg end))
")
  (dolist (ele ar-hide-forms)
    (insert (concat "
\(defun ar-hide-" ele " ()
  \"Hide " ele " at point.\"
  (interactive)
  (ar-hide-base '" ele "))
")))

;; \(defun ar-show-" ele " ()
;;   \"Show " ele " at point.\"
;;   (interactive)
;;   (ar-show-base '" ele "))

  (insert "\n;; ar-emacs-generics-hide-show.el ends here
\(provide 'ar-emacs-generics-hide-show)")
  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode)
    (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-hide-show.el")))

(defun write-ar-ert-always-split-lp-1361531-tests (&optional pyshellname-list)
  (interactive)
  (let* ((liste ar-shells))
    (set-buffer (get-buffer-create "ar-ert-always-split-lp-1361531-tests.el"))
    (erase-buffer)
    (insert ";;; ar-ert-always-split-lp-1361531-tests.el --- Test splitting -*- lexical-binding: t; -*-\n")
    (insert arkopf)
    (when ar--debug-p (switch-to-buffer (current-buffer)))
    (dolist (ele liste)
      (setq elt (prin1-to-string ele))
    (insert (concat "
\(ert-deftest ar-ert-always-split-dedicated-lp-1361531-" elt "-test ()
  (ar-test-with-temp-buffer
      \"#! /usr/bin/env " elt "
# -*- coding: utf-8 -*-
print(\\\"I'm the ar-always-split-dedicated-lp-1361531-" elt "-test\\\")\""))
    (when ar--debug-p (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
    (insert (concat "
    (delete-other-windows)
    (let* ((ar-split-window-on-execute 'always)
           (erg1 (progn (ar-execute-statement-" elt "-dedicated) ar-buffer-name))
           (erg2 (progn (ar-execute-statement-" elt "-dedicated) ar-buffer-name)))
      (sit-for 1 t)
      (when ar--debug-p (message \"(count-windows) %s\" (count-windows)))
      (should (< 2 (count-windows)))
      (ar-kill-buffer-unconditional erg1)
      (ar-kill-buffer-unconditional erg2)
      (ar-restore-window-configuration))))
"))))
    (insert "\n;; ar-ert-always-split-lp-1361531-tests.el ends here
\(provide 'ar-ert-always-split-lp-1361531-tests)")
  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode))

(defun write-ar-ert-just-two-split-lp-1361531-tests (&optional pyshellname-list)
  (interactive)
  (let* ((liste ar-shells))
    (set-buffer (get-buffer-create "ar-ert-just-two-split-lp-1361531-tests.el"))
    (erase-buffer)
    (insert ";;; ar-ert-just-two-split-lp-1361531-tests.el --- Test splitting -*- lexical-binding: t; -*-\n")
    (insert arkopf)
    (when ar--debug-p (switch-to-buffer (current-buffer)))
    (dolist (ele liste)
      (setq elt (prin1-to-string ele))
    (insert (concat "
\(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-" elt "-test ()
  (ar-test-with-temp-buffer
      \"#! /usr/bin/env " elt "
# -*- coding: utf-8 -*-
print(\\\"I'm the ar-just-two-split-dedicated-lp-1361531-" elt "-test\\\")\""))
    (when ar--debug-p (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
    (insert (concat "
    (delete-other-windows)
    (let* ((ar-split-window-on-execute 'just-two)
           (erg1 (progn (ar-execute-statement-" elt "-dedicated) ar-buffer-name))
           (erg2 (progn (ar-execute-statement-" elt "-dedicated) ar-buffer-name)))
      (sit-for 1 t)
      (when ar--debug-p (message \"(count-windows) %s\" (count-windows)))
      (should (eq 2 (count-windows)))
      (ar-kill-buffer-unconditional erg1)
      (ar-kill-buffer-unconditional erg2)
      (ar-restore-window-configuration))))
"))))
    (insert "\n;; ar-ert-just-two-split-lp-1361531-tests.el ends here
\(provide 'ar-ert-just-two-split-lp-1361531-tests)")
  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode))

(defun ar-write-ert-beginning-tests ()
  (interactive)
  (set-buffer (get-buffer-create "ar-ert-beginning-tests.el"))
  (erase-buffer)
  (switch-to-buffer (current-buffer))
  (insert ";;; ar-ert-beginning-tests.el --- Just some more tests \n -*- lexical-binding: t; -*-")
  (insert arkopf)
  (dolist (ele ar-navigate-forms)
    (insert (concat "
\(ert-deftest ar-ert-beginning-of-" ele "-test ()
  (ar-test-with-temp-buffer
      \"
# -*- coding: utf-8 -*-
class bar:
    def foo ():
        try:
            if True:
                for a in range(anzahl):
                    pass
        except:
            block2
\"
    (forward-line -3)
    (when ar--debug-p (switch-to-buffer (current-buffer))
          (font-lock-fontify-buffer))
    (ar-beginning-of-" ele ")
    (should (eq (char-after) "))
    (cond ((string= "block" ele)
           (insert "?f"))
          ((string= "clause" ele)
           (insert "?f"))
          ((string= "for-block" ele)
           (insert "?f"))
          ((string= "block-or-clause" ele)
           (insert "?f"))
          ((string= "def" ele)
           (insert "?d"))
          ((string= "class" ele)
           (insert "?c"))
          ((string= "def-or-class" ele)
           (insert "?d"))
          ((string= "if-block" ele)
           (insert "?i"))
          ((string= "try-block" ele)
           (insert "?t"))
          ((string= "minor-block" ele)
           (insert "?f"))
          ((string= "top-level" ele)
           (insert "?c"))
          ((string= "statement" ele)
           (insert "?f"))
          ((string= "expression" ele)
           (insert "?r"))
          ((string= "partial-expression" ele)
           (insert "?r")))
    (insert "))))\n"))

  (dolist (ele ar-bol-forms)
    (insert (concat "
\(ert-deftest ar-ert-beginning-of-" ele "-bol-test ()
  (ar-test-with-temp-buffer
      \"
\# -*- coding: utf-8 -*-
class bar:
    def foo ():
        try:
            if True:
                for a in range(anzahl):
                    pass
        except:
            block2
\"
    (when ar--debug-p (switch-to-buffer (current-buffer))
          (font-lock-fontify-buffer))
    (forward-line -3)
    (ar-beginning-of-" ele "-bol)
    (should (eq (char-after) "))

    (cond ((string-match "block" ele)
           (insert "?\\ "))
          ((string-match "clause" ele)
           (insert "?\\ "))
          ((string-match "for-block" ele)
           (insert "?\\ "))
          ((string-match "block-or-clause" ele)
           (insert "?\\ "))
          ((string-match "def" ele)
           (insert "?\\ "))
          ((string-match "class" ele)
           (insert "?c"))
          ((string-match "def-or-class" ele)
           (insert "?\\ "))
          ((string-match "if-block" ele)
           (insert "?\\ "))
          ((string-match "try-block" ele)
           (insert "?\\ "))
          ((string-match "minor-block" ele)
           (insert "?\\ "))
          ((string= "statement" ele)
           (insert "?\\ ")))

    (insert "))))\n\n"))

  (insert "(provide 'ar-ert-beginning-tests)
;;; ar-ert-beginning-tests.el ends here")

  (switch-to-buffer (current-buffer))
  (emacs-lisp-mode)
  (write-file (concat ar-emacs-generics-directory "/test/ar-ert-beginning-tests.el")))

(defun ar-write-beginning-position-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-beginning-position-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-beginning-position-forms.el --- -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (dolist (ele ar-position-forms)
    (insert (concat "
\(defun ar--beginning-of-" ele "-position ()
  \"Return beginning of " ele " position.\"
  (save-excursion
    (or (ar--beginning-of-" ele "-p)
        (ar-backward-" ele "))))\n")))

  (dolist (ele ar-beginning-bol-command-names)
    (insert (concat "
\(defun ar--beginning-of-" ele "-position-bol ()
  \"Return beginning of " ele " position at `beginning-of-line'.\"
  (save-excursion
    (or (ar--beginning-of-" ele "-bol-p)
        (ar-backward-" ele "-bol))))
")))
  (insert "\n(provide 'ar-emacs-generics-beginning-position-forms)
;;; ar-emacs-generics-beginning-position-forms.el ends here")

  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-beginning-position-forms.el")))

(defun ar-write-end-position-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-end-position-forms.el"))
  (erase-buffer)
  (switch-to-buffer (current-buffer))
  (insert ";;; ar-emacs-generics-end-position-forms.el --- -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (dolist (ele ar-position-forms)
    (insert (concat "
\(defun ar--end-of-" ele "-position ()
  \"Return end of " ele " position.\"
  (save-excursion (ar-forward-" ele ")))\n")))

  (dolist (ele ar-shift-bol-forms)
    (insert (concat "
\(defun ar--end-of-" ele "-position-bol ()
  \"Return end of " ele " position at `beginning-of-line'.\"
  (save-excursion (ar-forward-" ele "-bol)))\n")))

 (insert "\n(provide 'ar-emacs-generics-end-position-forms)
;;; ar-emacs-generics-end-position-forms.el ends here")

  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer)))
  (emacs-lisp-mode)
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-end-position-forms.el")))

(defun ar-write-forward-forms ()
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-forward-forms.el"))
  (erase-buffer)
  (switch-to-buffer (current-buffer))

  (insert ";;; ar-emacs-generics-forward-forms.el -- Go to the end of forms -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (goto-char (point-max))
  (insert "\n(defun ar-forward-assignment (&optional orig bol)
  \"Go to end of assignment.

Return end of `assignment' if successful, nil otherwise
Optional ORIG: start position
Optional BOL: go to beginning of line following end-position\"
  (interactive)
  (ar--end-base 'ar-assignment-re orig bol))

\(defun ar-forward-assignment-bol ()
  \"Goto beginning of line following end of `assignment'.

Return position reached, if successful, nil otherwise.
See also `ar-down-assignment'.\"
  (interactive)
  (ar-forward-assignment nil t))\n\n")

  (insert "(defun ar-forward-region ()
  \"Go to the end of current region.\"
  (interactive)
  (let ((end (region-end)))
    (when end (goto-char end))))
")
  (dolist (ele ar-block-forms)
    ;; (when (or (string-match "def" ele) (string-match "class" ele))
    ;;   (insert "\n;;;###autoload"))
    ;; beg-end check forms
    (insert (concat "
\(defun ar-forward-" ele " (&optional orig bol)
  \"Go to end of " ele ".

Return end of `" ele "' if successful, nil otherwise
Optional ORIG: start position
Optional BOL: go to beginning of line following end-position\"
  (interactive)
  (let (erg)
    (unless (setq erg (ar--end-base 'ar-" (ar-block-regexp-name-richten ele)
                               "-re orig bol))
      (skip-chars-forward \" \\t\\r\\n\\f\")
      (setq erg (ar--end-base 'ar-" (ar-block-regexp-name-richten ele)
                               "-re orig bol)))
    erg))

\(defun ar-forward-" ele "-bol ()
  \"Goto beginning of line following end of `" ele "'.

Return position reached, if successful, nil otherwise.
See also `ar-down-" ele "'.\"
  (interactive)
  (ar-forward-" ele " nil t))\n")))

  (insert "\n;; ar-emacs-generics-forward-forms.el ends here
\(provide 'ar-emacs-generics-forward-forms)")
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-forward-forms.el"))
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode)))

(defun ar-write-booleans-beginning-forms ()
  "Uses `ar-booleans-beginning-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-booleans-beginning-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-booleans-beginning-forms.el --- booleans-beginning forms -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (switch-to-buffer (current-buffer))
  (goto-char (point-max))
  (dolist (ele ar-non-bol-forms)
    (unless (string-equal ele "statement")
      ;; expression needs "\b"
      ;; (unless (equal ele "expression")
      (insert (concat "\(defun ar--beginning-of-" ele "-p (&optional pps)
  \"If cursor is at the beginning of a `" ele "'.
Return position, nil otherwise.\"\n"))
      (insert (concat "  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat \"\\\\b\" ar-"  (ar-block-regexp-name-richten ele) "-re))
         (point))))\n\n"))))
  (dolist (ele ar-bol-forms)
    (unless (string-equal ele "statement")
      (insert (concat "\(defun ar--beginning-of-" ele "-p (&optional pps)
  \"If cursor is at the beginning of a `" ele "'.
Return position, nil otherwise.\""))
      (insert (concat "
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-" (ar-block-regexp-name-richten ele) "-re)
         (looking-back \"[^ \\t]*\" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))\n\n"))))
  (dolist (ele ar-bol-forms)
    (unless (string-equal ele "statement")
      (insert (concat "\(defun ar--beginning-of-" ele "-bol-p (&optional pps)
  \"If cursor is at the beginning of a `" ele "'.
Return position, nil otherwise.\""))
      (insert (concat "
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-" (ar-block-regexp-name-richten ele) "-re)
         (looking-back \"[^ \\t]*\" (line-beginning-position))
         (point))))\n\n"))))
  (insert "(provide 'ar-emacs-generics-booleans-beginning-forms)
;; ar-emacs-generics-booleans-beginning-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-booleans-beginning-forms.el")))

(defun ar-write-booleans-end-forms (&optional filename dirname)
  "Write elisp code defining end-of-syntactic element predicate functions.

The source code is stored in a Emacs Lisp source file with the name
specified by FILENAME if specified. Otherwise it is stored inside
the default name: ar-emacs-generics-booleans-end-forms.el
The FILENAME must include the .el extension.

The file is stored inside the directory identified by DIRNAME if specified.
If nil, the default, specified by the global `ar-emacs-generics-directory' is used.

The generated source code defines functions that return the position
of point when it is located at the end of a specific Python syntactic element,
or return nil otherwise.

The generated functions with names that look like:
- ar--end-of-XX-p
- ar--end-of-XX-bol-p

where 'XX' is the Python syntactic element."
  (interactive)
  (let* ((filename (or filename "ar-emacs-generics-booleans-end-forms.el"))
         (dirname  (or dirname  ar-emacs-generics-directory))
         (file-path (expand-file-name filename dirname))
         (feature-name (file-name-sans-extension filename)))
    (set-buffer (get-buffer-create filename))
    (erase-buffer)
    (insert (format "\
;;; %s --- booleans-end forms -*- lexical-binding: t; -*-\n"
                    filename))
    (insert arkopf)
    ;;
    (dolist (ele ar-non-bol-forms)
      (insert (concat "
\(defun ar--end-of-" ele "-p ()
  \"If cursor is at the end of a " ele ".
Return position, nil otherwise.\"
  (let ((orig (point)))
    (save-excursion
      (ar-backward-" ele ")
      (ar-forward-" ele ")
      (when (eq orig (point))
        orig))))\n")))
    ;;
    (dolist (ele ar-bol-forms)
      (unless (string= "statement" ele)
        (insert (concat "
\(defun ar--end-of-" ele "-bol-p ()
  \"If at `beginning-of-line' at the end of a " ele ".
Return position, nil otherwise.\"
  (let ((orig (point)))
    (save-excursion
      (ar-backward-" ele "-bol)
      (ar-forward-" ele "-bol)
      (when (eq orig (point))
        orig))))\n"))))
    ;;
    (dolist (ele ar-bol-forms)
      (unless (string= "statement" ele)
        (insert (concat "
\(defun ar--end-of-" ele "-p ()
  \"If cursor is at the end of a " ele ".
Return position, nil otherwise.\"
  (let ((orig (point)))
    (save-excursion
      (ar-backward-" ele ")
      (ar-forward-" ele ")
      (when (eq orig (point))
        orig))))\n"))))
    ;;
    (insert (format "\n(provide '%s)
;; ar-emacs-generics-booleans-end-forms.el ends here\n"
                    feature-name))
    (when (called-interactively-p 'interactive)
      (switch-to-buffer (current-buffer))
      (emacs-lisp-mode))
    (write-file file-path)))

(defun ar-write-kill-forms (&optional forms)
  "Useseb `ar-kill-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-kill-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-kill-forms.el --- kill forms -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (let ((forms (or forms ar-non-bol-forms)))
    (dolist (ele forms)
      (insert (concat "
\(defun ar-kill-"ele" ()
  \"Delete " ele " at point.

Stores data in kill ring\"
  (interactive \"*\")
  (let ((erg (ar--mark-base \"" ele "\")))
    (kill-region (car erg) (cdr erg))))\n")))
    ;; expression-forms don't make sense WRT bol
    (dolist (ele ar-bol-forms)
      (insert (concat "
\(defun ar-kill-" ele " ()
  \"Delete " ele " at point.

Stores data in kill ring. Might be yanked back using `C-y'.\"
  (interactive \"\*\")
  (let ((erg (ar--mark-base-bol \"" ele "\")))
    (kill-region (car erg) (cdr erg))))
"))))
  (insert "\n(provide 'ar-emacs-generics-kill-forms)
;;; ar-emacs-generics-kill-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-kill-forms.el")))

(defun ar-write-close-forms (&optional forms)
  "Useseb `ar-close-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-close-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-close-forms.el --- close forms -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated. Edits here might not be persistent.\n")
  (insert arkopf)
  (let ((forms (or forms ar-down-forms)))
    (dolist (ele forms)
      (insert (concat "
\(defun ar-close-"ele" ()
  \"Close " ele " at point.

Set indent level to that of beginning of function definition.

If final line isn't empty
and `ar-close-block-provides-newline' non-nil,
insert a newline.\"
  (interactive \"*\")
  (ar--close-intern 'ar-" ele "-re))
"))))
  (insert "\n(provide 'ar-emacs-generics-close-forms)
;;; ar-emacs-generics-close-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-close-forms.el")))

(defun ar-write-mark-forms ()
  "Uses `ar-mark-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-mark-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-mark-forms.el --- mark forms -*- lexical-binding: t; -*-\n")
  (insert "\n;; This file is generated.\n")
  (insert arkopf)
  (dolist (ele ar-non-bol-forms)
    (if (string-match "def\\|class" ele)
        (insert (concat "
\(defun ar-mark-" ele " (&optional arg)"))
      (insert (concat "
\(defun ar-mark-" ele " ()")))
    (insert (concat "
  \"Mark " ele " at point.\n\n"))
    (when (string-match "def\\|class" ele)
      (insert "With ARG \\\\[universal-argument] or `ar-mark-decorators' set to t, decorators are marked too.
"))

    (insert (concat "Return beginning and end positions of marked area, a cons.\""))
    (if (string-match "def\\|class" ele)
        (insert "\n  (interactive \"P\")")
      (insert "\n  (interactive)"))
    (if (string-match "def\\|class" ele)
        (insert (concat "\n  (let ((ar-mark-decorators (or arg ar-mark-decorators)))
    (ar--mark-base \"" ele "\" ar-mark-decorators)"))
      (insert "\n  (ar--mark-base \"" ele "\")"))
    (insert "\n  (exchange-point-and-mark)\n  (cons (region-beginning) (region-end)))")
    (newline))
  (dolist (ele ar-bol-forms)
    (unless (string= ele "section")
      ;; Mark bol-forms
      (if (string-match "def\\|class" ele)
          (insert (concat "
\(defun ar-mark-" ele " (&optional arg)"))
        (insert (concat "
\(defun ar-mark-" ele " ()")))
      (insert (concat "
  \"Mark " ele ", take beginning of line positions. \n\n"))
      (when (string-match "def\\|class" ele)
        (insert "With ARG \\\\[universal-argument] or `ar-mark-decorators' set to t, decorators are marked too.
"))

      (insert (concat "Return beginning and end positions of region, a cons.\""))
      (if (string-match "def\\|class" ele)
          (insert "\n  (interactive \"P\")")
        (insert "\n  (interactive)"))
      (if (string-match "def\\|class" ele)
          (insert (concat "\n  (let ((ar-mark-decorators (or arg ar-mark-decorators)))
    (ar--mark-base-bol \"" ele "\" ar-mark-decorators))"))
        (insert "\n  (ar--mark-base-bol \"" ele "\")"))
      (insert "\n  (exchange-point-and-mark)\n  (cons (region-beginning) (region-end)))")
      ))

  (insert "\n(provide 'ar-emacs-generics-mark-forms)
;;; ar-emacs-generics-mark-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-mark-forms.el")))

(defun ar-write-coar-forms (&optional forms)
  "Uses `ar-execute-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-coar-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-coar-forms.el --- copy forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (let ((forms (or forms ar-execute-forms)))
    (dolist (ele forms)
      (insert (concat "
\(defun ar-coar-" ele " ()
  \"Copy " ele " at point.

Store data in kill ring, so it might yanked back.\"
  (interactive \"\*\")
  (save-excursion
    (let ((erg (ar--mark-base-bol \"" ele "\")))
      (coar-region-as-kill (car erg) (cdr erg)))))\n")))

    (dolist (ele forms)
      (unless (string= "section" ele)
        (insert (concat "
\(defun ar-coar-" ele "-bol ()
  \"Delete " ele " bol at point.

Stores data in kill ring. Might be yanked back using `C-y'.\"
  (interactive \"\*\")
  (save-excursion
    (let ((erg (ar--mark-base-bol \"" ele "\")))
      (coar-region-as-kill (car erg) (cdr erg)))))
")))))
  (insert "\n(provide 'ar-emacs-generics-coar-forms)
;; ar-emacs-generics-coar-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-coar-forms.el")))

(defun ar--write-delete-forms (forms)
  (dolist (ele forms)
    (insert (concat "
\(defun ar-delete-" ele " ()"))
    (insert (concat "
  \"Delete " (upcase ele) " at point.

\Don't store data in kill ring."))
    (insert "\"")

    (if (string-match "def\\|class" ele)
        (insert "\n  (interactive \"P\")")
      (insert "\n  (interactive)"))
    (if (string-match "def\\|class" ele)
        (insert (concat "\n (let* ((ar-mark-decorators (or arg ar-mark-decorators))
        (erg (ar--mark-base \"" ele "\" ar-mark-decorators)))"))
      (insert (concat
               "\n  (let ((erg (ar--mark-base \"" ele "\")))")))
    (insert "
    (delete-region (car erg) (cdr erg))))\n")))

(defun ar--write-delete-forms-bol (forms)
  (dolist (ele forms)
    (if (string-match "def\\|class" ele)
        (insert (concat "
\(defun ar-delete-" ele " (&optional arg)"))
      (insert (concat "
\(defun ar-delete-" ele " ()")))
    (insert (concat "
  \"Delete " (upcase ele) " at point until `beginning-of-line'.

\Don't store data in kill ring."))
    (if (string-match "def\\|class" ele)
        (insert "\nWith ARG \\\\[universal-argument] or `ar-mark-decorators' set to t, `decorators' are included.\"")
      (insert "\""))
    (if (string-match "def\\|class" ele)
        (insert "\n  (interactive \"P\")")
      (insert "\n  (interactive)"))
    (if (string-match "def\\|class" ele)
        (insert (concat "\n (let* ((ar-mark-decorators (or arg ar-mark-decorators))
        (erg (ar--mark-base \"" ele "\" ar-mark-decorators)))"))
      (insert (concat
               "\n  (let ((erg (ar--mark-base-bol \"" ele "\")))")))
    (insert "
    (delete-region (car erg) (cdr erg))))\n")))

(defun ar-write-delete-forms ()
  "Uses `ar-execute-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-delete-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-delete-forms.el --- delete forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (ar--write-delete-forms-bol ar-bol-forms)
  (ar--write-delete-forms ar-non-bol-forms)
  (insert "\n(provide 'ar-emacs-generics-delete-forms)
;; ar-emacs-generics-delete-forms.el ends here\n")
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-delete-forms.el")))

(defun write--section-forms ()
  (dolist (ele ar-shells)
    (setq ele (format "%s" ele))
    (insert "(defun ar-execute-section")
    (unless (string= "" ele) (insert (concat "-" ele)))
    (insert " ()
  \"Execute section at point")
    (unless (string= "" ele) (insert (concat " using " ele " interpreter")))
    (insert ".\"
  (interactive)
  (ar-execute-section-prepare")
    (unless (string= "" ele) (insert (concat " \"" ele "\"")))
    (insert "))\n\n")))

(defun ar-write-section-forms ()
  "Uses `ar-section-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-section-forms.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-section-forms.el --- section forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write--section-forms)
  (insert "\n(provide 'ar-emacs-generics-section-forms)
;;; ar-emacs-generics-section-forms.el ends here\n")
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-section-forms.el")))

;; ar-comment-forms
(defun write--narrow-forms ()
  (dolist (ele ar-comment-forms)
    ;; (setq ele (format "%s" ele))
    (insert "(defun ar-narrow-to")
    (unless (string= "" ele) (insert (concat "-" ele)))
    (insert (concat " ()
  \"Narrow to " ele " at point"))
            ;; (unless (string= "" ele) (insert (concat " using " ele " interpreter")))
    (insert ".\"
  (interactive)
  (ar--narrow-prepare")
    (unless (string= "" ele) (insert (concat " \"" ele "\"")))
    (insert "))\n\n")))

(defun ar-write-narrow-forms ()
  "Uses `ar-narrow-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-narrow.el"))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-narrow.el --- narrow forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write--narrow-forms)
  (insert "(provide 'ar-emacs-generics-narrow)
;;; ar-emacs-generics-narrow.el ends here\n")
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-narrow.el")))

;;  ar-emacs-generics-execute-region
(defun write--execute-region ()
  (dolist (ele ar-shells)
    (setq ele (format "%s" ele))
    (dolist (pyo ar-full-options)
      (insert "(defun ar-execute-region")
      (unless (string= "" ele) (insert (concat "-" ele)))
      (unless (string= "" pyo) (insert (concat "-" pyo)))
      (insert (concat " (beg end &optional shell filename proc)
  \"Execute region " ele))
      (insert ".\"
  (interactive \"r\")\n")
      (unless (string= "" pyo)
        (insert "  (let (")
        (ar--insert-split-switch-forms pyo)
        (insert ")\n  "))
      (insert "  (ar--execute-base beg end ")
      (if (string= "" ele)
          (insert "shell")
        (insert (concat "'" ele)))
      (insert " filename proc))")
      (unless (string= "" pyo)(insert ")"))
      (insert "\n\n")
      )))

(defun ar-write-execute-region ()
  "Uses `ar-execute-region-forms'."
  (interactive)
  (set-buffer (get-buffer-create "ar-emacs-generics-execute-region.el"))
  (switch-to-buffer (current-buffer))
  (erase-buffer)
  (insert ";;; ar-emacs-generics-execute-region.el --- execute-region forms -*- lexical-binding: t; -*-\n")
  (insert arkopf)
  (when (called-interactively-p 'interactive) (switch-to-buffer (current-buffer))
        (emacs-lisp-mode))
  (write--execute-region)
  (insert "(provide 'ar-emacs-generics-execute-region)
;;; ar-emacs-generics-execute-region.el ends here\n")
  (write-file (concat ar-emacs-generics-directory "/ar-emacs-generics-execute-region.el")))

(defun ar--insert-split-switch-doku (pyo)
    (cond ((string= pyo "switch")
                 (insert "Switch to output buffer. Ignores `ar-switch-buffers-on-execute-p'."))
                ((string= pyo "no-switch")
                 (insert "\n\nKeep current buffer. Ignores `ar-switch-buffers-on-execute-p' "))))

(defun ar--insert-split-switch-forms (pyo)
  (cond ((string= pyo "switch")
         ;; (insert (make-string 2 ?\ ))
         (insert "(ar-switch-buffers-on-execute-p t)"))
        ((string= pyo "dedicated-switch")
         ;; (insert (make-string 2 ?\ ))
         (insert "(ar-switch-buffers-on-execute-p t)\n")
         (insert (make-string 8 ?\ ))
         (insert "(ar-split-window-on-execute t)"))
        ((string= pyo "no-switch")
         ;; (insert (make-string 2 ?\ ))
         (insert "(ar-switch-buffers-on-execute-p nil)"))
        ((string= pyo "dedicated")
         ;; (insert (make-string 2 ?\ ))
         (insert "(ar-dedicated-process-p t)"))))

(defun ar-block-regexp-name-richten (ele)
  (cond ((string-match "^if-" ele)
         "if")
        ((string-match "for-" ele)
         "for")
        ((string-match "clause-" ele)
         "clause")
        ((string-match "elif-" ele)
         "elif")
        ((string-match "try-" ele)
         "try")
        ((string-match "else-" ele)
         "else")
        ((string-match "except-" ele)
         "except")
        (t ele)))

(defun write-most-of-forms ()
  "Let's see if we can write/update forms at once."
  (interactive)
  (ar-provide-installed-shells-commands)
  (ar-write-backward-forms)
  (ar-write-beginning-position-forms)
  (ar-write-end-position-forms)
  (ar-write-booleans-beginning-forms)
  (ar-write-booleans-end-forms)
  (ar-write-coar-forms)
  (ar-write-delete-forms)
  (ar-write-forms-code)
  (ar-write-forward-forms)
  (ar-write-kill-forms)
  (ar-write-close-forms)
  (ar-write-mark-forms)
  (write-ar-comment-forms)
  (ar-write-up-forms)
  (ar-write-down-forms)
  (ar-write-execute-forms)
  (write-unified-extended-execute-forms)
  (ar-write-hide-forms)
  ;; (ar-write-execute-region)
  ;; (ar-write-edit-forms)
  ;; (write-execute-region-forms)
  )

(provide 'ar-emacs-generics-utils)
