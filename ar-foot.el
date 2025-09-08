;;; ar-foot.el --- foot -*- lexical-binding: t; -*-

(defun ar-shell-fontify ()
  "Fontifies input in shell buffer. "
  ;; causes delay in fontification until next trigger
  ;; (unless (or (member (char-before) (list 32 ?: ?\)))
  ;; (unless (and (eq last-command 'self-insert-command) (eq (char-before) 32))
  ;; (< (abs (save-excursion (skip-chars-backward "^ \t\r\n\f"))) 2))
  (let* ((pps (parse-partial-sexp (line-beginning-position) (point)))
         (start (if (and (nth 8 pps) (nth 1 pps))
                    (max (nth 1 pps) (nth 8 pps))
                  (or (nth 1 pps) (nth 8 pps)))))
    (when (or start
              (setq start (ignore-errors (cdr comint-last-prompt))))
      (let* ((input (buffer-substring-no-properties
                     start (point-max)))
             (buffer-undo-list t)
             (replacement
              (save-current-buffer
                (set-buffer ar-shell--font-lock-buffer)
                (erase-buffer)
                (insert input)
                ;; Ensure buffer is fontified, keeping it
                ;; compatible with Emacs < 24.4.
                (if (fboundp 'font-lock-ensure)
                    (funcall 'font-lock-ensure)
                  (font-lock-default-fontify-buffer))
                (buffer-substring (point-min) (point-max))))
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
             (+ start i) (+ start next-change) plist)
            (setq i next-change)))))))

(defun ar-message-which-ar-mode ()
  (if (buffer-file-name)
      (if (string= "SomeMode-mode-el" (buffer-file-name))
          (message "%s" "SomeMode-mode loaded from SomeMode-mode-el")
        (message "%s" "SomeMode-mode loaded from ar-mode"))
    (message "SomeMode-mode loaded from: %s" ar-mode-message-string)))

(defalias 'ar-next-statement 'ar-forward-statement)
;; #134, cython-mode compatibility
(defalias 'ar-end-of-statement 'ar-forward-statement)
(defalias 'ar-beginning-of-statement 'ar-backward-statement)
(defalias 'ar-beginning-of-block 'ar-backward-block)
(defalias 'ar-end-of-block 'ar-forward-block)
(defalias 'ar-previous-statement 'ar-backward-statement)
(defalias 'ar-markup-region-as-section 'ar-sectionize-region)

(define-derived-mode ar-auto-completion-mode SomeMode-mode "Pac"
  "Run auto-completion"
  ;; disable company
  ;; (when company-mode (company-mode))
  (if ar-auto-completion-mode-p
      (progn
        (setq ar-auto-completion-mode-p nil
              ar-auto-completion-buffer nil)
        (when (timerp ar--auto-complete-timer)(cancel-timer ar--auto-complete-timer)))
    (setq ar-auto-completion-mode-p t
          ar-auto-completion-buffer (current-buffer))
    (setq ar--auto-complete-timer
          (run-with-idle-timer
           ar--auto-complete-timer-delay
           ;; 1
           t
           #'ar-complete-auto)))
  (force-mode-line-update))

(autoload 'SomeMode-mode "ar-mode" "SOME Mode." t)

(defun all-mode-setting ()
  (set (make-local-variable 'indent-tabs-mode) ar-indent-tabs-mode)
  (set (make-local-variable 'electric-indent-inhibit) nil)
  (set (make-local-variable 'outline-regexp)
       (concat (mapconcat 'identity
                          (mapcar #'(lambda (x) (concat "^\\s-*" x "\\_>"))
                                  ar-outline-mode-keywords)
                          "\\|")))
  (when ar-font-lock-defaults-p
    (if ar-use-font-lock-doc-face-p
        (set (make-local-variable 'font-lock-defaults)
             '(ar-font-lock-keywords nil nil nil nil
                                         (font-lock-syntactic-keywords
                                          . ar-font-lock-syntactic-keywords)
                                         (font-lock-syntactic-face-function
                                          . ar--font-lock-syntactic-face-function)))
      (set (make-local-variable 'font-lock-defaults)
           '(ar-font-lock-keywords nil nil nil nil
                                       (font-lock-syntactic-keywords
                                        . ar-font-lock-syntactic-keywords)))))
  (ar--update-version-dependent-keywords)
  ;; (cond ((string-match "ython3" ar-SomeMode-edit-version)
  ;;        (font-lock-add-keywords 'SomeMode-mode
  ;;                             '(("\\<print\\>" . 'ar-builtins-face)
  ;;                               ("\\<file\\>" . nil))))
  ;;       (t (font-lock-add-keywords 'SomeMode-mode
  ;;                               '(("\\<print\\>" . 'font-lock-keyword-face)
  ;;                                 ("\\<file\\>" . 'ar-builtins-face)))))
  (set (make-local-variable 'which-func-functions) 'ar-which-def-or-class)
  (set (make-local-variable 'parse-sexp-lookup-properties) t)
  (set (make-local-variable 'comment-use-syntax) t)
  (set (make-local-variable 'comment-start) "#")
  (set (make-local-variable 'comment-start-skip) "#+\\s-*")
  (if ar-empty-comment-line-separates-paragraph-p
      (progn
        (set (make-local-variable 'paragraph-separate) (concat "\f\\|^[\t]*$\\|^[ \t]*" comment-start "[ \t]*$\\|^[\t\f]*:[[:alpha:]]+ [[:alpha:]]+:.+$"))
        (set (make-local-variable 'paragraph-start)
             (concat "\f\\|^[ \t]*$\\|^[ \t]*" comment-start "[ \t]*$\\|^[ \t\f]*:[[:alpha:]]+ [[:alpha:]]+:.+$"))
        (set (make-local-variable 'paragraph-separate)
             (concat "\f\\|^[ \t]*$\\|^[ \t]*" comment-start "[ \t]*$\\|^[ \t\f]*:[[:alpha:]]+ [[:alpha:]]+:.+$")))
    (set (make-local-variable 'paragraph-separate) "\f\\|^[ \t]*$\\|^[\t]*#[ \t]*$\\|^[ \t\f]*:[[:alpha:]]+ [[:alpha:]]+:.+$")
    (set (make-local-variable 'paragraph-start) "\f\\|^[ \t]*$\\|^[\t]*#[ \t]*$\\|^[ \t\f]*:[[:alpha:]]+ [[:alpha:]]+:.+$"))
  (set (make-local-variable 'comment-column) 40)
  ;; (set (make-local-variable 'comment-indent-function) #'ar--comment-indent-function)
  (set (make-local-variable 'indent-region-function) 'ar-indent-region)
  (set (make-local-variable 'indent-line-function) 'ar-indent-line)
  ;; introduced to silence compiler warning, no real setting
  ;; (set (make-local-variable 'hs-hide-comments-when-hiding-all) 'ar-hide-comments-when-hiding-all)
  (set (make-local-variable 'outline-heading-end-regexp) ":[^\n]*\n")
  (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil)
  (set (make-local-variable 'add-log-current-defun-function) 'ar-current-defun)
  (set (make-local-variable 'fill-paragraph-function) 'ar-fill-paragraph)
  (set (make-local-variable 'normal-auto-fill-function) 'ar-fill-string-or-comment)
  (set (make-local-variable 'require-final-newline) mode-require-final-newline)
  (set (make-local-variable 'tab-width) ar-indent-offset)
  (set (make-local-variable 'electric-indent-mode) nil)
  (and ar-load-skeletons-p (ar-load-skeletons))
  (and ar-guess-ar-install-directory-p (ar-set-load-path))
  ;; (and ar-autopair-mode
  ;;      (declare-function autopair-SomeMode-triple-quote-action "autopair" ())
  ;;      (declare-function autopair-default-handle-action "autopair" ())
  ;;      (load-library "autopair")
  ;;      (add-hook 'ar-mode-hook
  ;;                #'(lambda ()
  ;;                    (setq autopair-handle-action-fns
  ;;                          (list #'autopair-default-handle-action
  ;;                                #'autopair-SomeMode-triple-quote-action))))
  ;;      (ar-autopair-mode-on))
  (when (and ar--imenu-create-index-p
             (fboundp 'imenu-add-to-menubar)
             (ignore-errors (require 'imenu)))
    (setq imenu-create-index-function 'ar--imenu-create-index-function)
    (setq imenu--index-alist (funcall ar--imenu-create-index-function))
    ;; fallback
    (unless imenu--index-alist
      (setq imenu--index-alist (ar--imenu-create-index-new)))
    ;; (message "imenu--index-alist: %s" imenu--index-alist)
    (imenu-add-to-menubar "PyIndex"))
  (when ar-trailing-whitespace-smart-delete-p
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil 'local))
  (ar-shell-prompt-set-calculated-regexps)
  (setq comint-prompt-regexp ar-shell--prompt-calculated-input-regexp)
  (cond
   (ar-complete-function
    (add-hook 'completion-at-point-functions
              ar-complete-function nil 'local))
   (ar-load-pymacs-p
    (add-hook 'completion-at-point-functions
              'ar-complete-completion-at-point nil 'local))
   (ar-do-completion-p
    (add-hook 'completion-at-point-functions
              'ar-shell-complete nil 'local)))
  (add-hook 'ar-mode-hook
            (lambda ()
              (if ar-electric-backspace-p (ar-electric-backspace-mode 1)
                (ar-electric-backspace-mode -1))))
  (if ar-auto-fill-mode
      (add-hook 'ar-mode-hook 'ar--run-auto-fill-timer)
    (remove-hook 'ar-mode-hook 'ar--run-auto-fill-timer))
  (add-hook 'ar-mode-hook
            (lambda ()
              (setq imenu-create-index-function ar--imenu-create-index-function)))
  (add-hook 'completion-at-point-functions
            #'ar-fast-complete)
  ;; caused insert-file-contents error lp:1293172
  ;;  (add-hook 'after-change-functions 'ar--after-change-function nil t)
  (if ar-defun-use-top-level-p
      (progn
        (set (make-local-variable 'beginning-of-defun-function) 'ar-backward-top-level)
        (set (make-local-variable 'end-of-defun-function) 'ar-forward-top-level)
        (define-key ar-mode-map [(control meta a)] 'ar-backward-top-level)
        (define-key ar-mode-map [(control meta e)] 'ar-forward-top-level))
    (set (make-local-variable 'beginning-of-defun-function) 'ar-backward-def-or-class)
    (set (make-local-variable 'end-of-defun-function) 'ar-forward-def-or-class)
    (define-key ar-mode-map [(control meta a)] 'ar-backward-def-or-class)
    (define-key ar-mode-map [(control meta e)] 'ar-forward-def-or-class))
  (when ar-sexp-use-expression-p
    (define-key ar-mode-map [(control meta f)] 'ar-forward-expression)
    (define-key ar-mode-map [(control meta b)] 'ar-backward-expression))

  (when ar-hide-show-minor-mode-p (hs-minor-mode 1))
  (when ar-outline-minor-mode-p (outline-minor-mode 1))
  (when (and ar-debug-p (called-interactively-p 'any))
    (ar-message-which-ar-mode))
  (when ar-use-menu-p
    (ar-define-menu ar-mode-map))
  (force-mode-line-update))

(defun ar--update-version-dependent-keywords ()
  (let ((kw-py2 '(("\\<print\\>" . 'font-lock-keyword-face)
                  ("\\<file\\>" . 'ar-builtins-face)))
        (kw-py3 '(("\\<print\\>" . 'ar-builtins-face))))
    (font-lock-remove-keywords 'SomeMode-mode kw-py3)
    (font-lock-remove-keywords 'SomeMode-mode kw-py2)
    ;; avoid to run ar-choose-shell again from ‘ar--fix-start’
    (cond ((string-match "ython3" ar-SomeMode-edit-version)
           (font-lock-add-keywords 'SomeMode-mode kw-py3 t))
          (t (font-lock-add-keywords 'SomeMode-mode kw-py2 t)))))

(define-derived-mode ar-mode prog-mode SomeMode-mode-modeline-display
  "Major mode for editing SOME files.

To submit a report, enter ‘\\[py-submit-bug-report]’
from a‘ar-mode’ buffer.
Do ‘\\[py-describe-mode]’ for detailed documentation.
To see what version of ‘ar-mode’ you are running,
enter ‘\\[py-version]’.

This mode knows about SOME indentation,
tokens, comments (and continuation lines.
Paragraphs are separated by blank lines only.

COMMANDS

‘ar-shell’\tStart an interactive SOME interpreter in another window
‘ar-execute-statement’\tSend statement at point to SOME default interpreter
‘ar-backward-statement’\tGo to the initial line of a simple statement

etc.

See available commands listed in files commands-SomeMode-mode at directory doc

VARIABLES

‘ar-indent-offset’ indentation increment
‘ar-shell-name’ shell command to invoke SOME interpreter
‘ar-split-window-on-execute’ When non-nil split windowas
‘ar-switch-buffers-on-execute-p’ When non-nil switch to the SOME output buffer

\\{ar-mode-map}"
  :group 'ar-mode
  ;; load known shell listed in
  ;; Local vars
  (all-mode-setting))

(define-derived-mode ar-shell-mode comint-mode ar-modeline-display
  "Major mode for SOME shell process.

Variables
‘ar-shell-prompt-regexp’,
‘ar-shell-prompt-output-regexp’,
‘ar-shell-input-prompt-2-regexp’,
‘ar-shell-fontify-p’,
‘ar-completion-setup-code’,
‘ar-shell-completion-string-code’,
can customize this mode for different SOME interpreters.

This mode resets ‘comint-output-filter-functions’ locally, so you
may want to re-add custom functions to it using the
‘ar-shell-mode-hook’.

\(Type \\[describe-mode] in the process buffer for a list of commands.)"
  (setq mode-line-process '(":%s"))
  (all-mode-setting)
  ;; (set (make-local-variable 'indent-tabs-mode) nil)
  (set (make-local-variable 'ar-shell--prompt-calculated-input-regexp) nil)
  (set (make-local-variable 'ar-shell--block-prompt) nil)
  (set (make-local-variable 'ar-shell--prompt-calculated-output-regexp) nil)
  (ar-shell-prompt-set-calculated-regexps)
  (set (make-local-variable 'comint-prompt-read-only) t)
  (set (make-local-variable 'comint-output-filter-functions)
       '(ansi-color-process-output
         ar-comint-watch-for-first-prompt-output-filter
         ar-pdbtrack-comint-output-filter-function
         ar-comint-postoutput-scroll-to-bottom
         comint-watch-for-password-prompt))
  (set (make-local-variable 'compilation-error-regexp-alist)
       ar-shell-compilation-regexp-alist)
  (compilation-shell-minor-mode 1)
  (add-hook 'completion-at-point-functions
            #'ar-shell-completion-at-point nil 'local)
  (define-key ar-shell-mode-map [(control c) (control r)] 'ar-nav-last-prompt)
  (make-local-variable 'ar-pdbtrack-buffers-to-kill)
  ;; (make-local-variable 'ar-shell-fast-last-output)
  (set (make-local-variable 'ar-shell--block-prompt) nil)
  (set (make-local-variable 'ar-shell--prompt-calculated-output-regexp) nil)
  (ar-shell-prompt-set-calculated-regexps)
  (if ar-shell-fontify-p
      (progn
        (ar-shell-font-lock-turn-on))
    (ar-shell-font-lock-turn-off)))

(make-obsolete 'jSomeMode-mode 'jython-mode nil)

;; (push "*SOME*"  same-window-buffer-names)
;; (push "*ISOME*"  same-window-buffer-names)

;; SOME Macro File
(unless (member '("\\.py\\'" . SomeMode-mode) auto-mode-alist)
  (push (cons "\\.py\\'"  'ar-mode)  auto-mode-alist))

(unless (member '("\\.pym\\'" . SomeMode-mode) auto-mode-alist)
  (push (cons "\\.pym\\'"  'ar-mode)  auto-mode-alist))

(unless (member '("\\.pyc\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pyc\\'"  'ar-mode)  auto-mode-alist))

;; Pyrex Source
(unless (member '("\\.pyx\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pyx\\'"  'ar-mode) auto-mode-alist))

;; SOME Optimized Code
(unless (member '("\\.pyo\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pyo\\'"  'ar-mode) auto-mode-alist))

;; Pyrex Definition File
(unless (member '("\\.pxd\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pxd\\'"  'ar-mode) auto-mode-alist))

;; SOME Repository
(unless (member '("\\.pyr\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pyr\\'"  'ar-mode)  auto-mode-alist))

;; SOME Stub file
;; https://www.SomeMode.org/dev/peps/pep-0484/#stub-files
(unless (member '("\\.pyi\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pyi\\'"  'ar-mode)  auto-mode-alist))

;; SOME Path Configuration
(unless (member '("\\.pth\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.pth\\'"  'ar-mode)  auto-mode-alist))

;; SOME Wheels
(unless (member '("\\.whl\\'" . SomeMode-mode)  auto-mode-alist)
  (push (cons "\\.whl\\'"  'ar-mode)  auto-mode-alist))

(unless (member '("!#[          ]*/.*[jp]ython[0-9.]*" . SomeMode-mode) magic-mode-alist)
  (push '("!#[ \\t]*/.*[jp]ython[0-9.]*" . SomeMode-mode) magic-mode-alist))

;;  lp:1355458, what about using ‘magic-mode-alist’?

(defalias 'ar-hungry-delete-forward 'c-hungry-delete-forward)
(defalias 'ar-hungry-delete-backwards 'c-hungry-delete-backwards)

(defalias 'ar-end-of-block 'ar-backward-block)
(defalias 'ar-end-of-block-or-clause 'ar-backward-block-or-clause)
(defalias 'ar-end-of-class 'ar-backward-class)
(defalias 'ar-end-of-clause 'ar-backward-clause)
(defalias 'ar-end-of-def 'ar-backward-def)
(defalias 'ar-end-of-def-or-class 'ar-forward-def-or-class)
(defalias 'ar-end-of-top-level 'ar-backward-top-level)

(defalias 'ar-beginning-of-block 'ar-backward-block)
(defalias 'ar-beginning-of-block-or-clause 'ar-backward-block-or-clause)
(defalias 'ar-beginning-of-class 'ar-backward-class)
(defalias 'ar-beginning-of-clause 'ar-backward-clause)
(defalias 'ar-beginning-of-def 'ar-backward-def)
(defalias 'ar-beginning-of-def-or-class 'ar-backward-def-or-class)
(defalias 'ar-beginning-of-top-level 'ar-backward-top-level)

(defalias 'ar-end-of-block-bol 'ar-backward-block-bol)
(defalias 'ar-end-of-block-or-clause-bol 'ar-backward-block-or-clause-bol)
(defalias 'ar-end-of-class-bol 'ar-backward-class-bol)
(defalias 'ar-end-of-clause-bol 'ar-backward-clause-bol)
(defalias 'ar-end-of-def-bol 'ar-backward-def-bol)
(defalias 'ar-end-of-def-or-class-bol 'ar-forward-def-or-class-bol)

(defalias 'ar-beginning-of-block-bol 'ar-backward-block-bol)
(defalias 'ar-beginning-of-block-or-clause-bol 'ar-backward-block-or-clause-bol)
(defalias 'ar-beginning-of-class-bol 'ar-backward-class-bol)
(defalias 'ar-beginning-of-clause-bol 'ar-backward-clause-bol)
(defalias 'ar-beginning-of-def-bol 'ar-backward-def-bol)
(defalias 'ar-beginning-of-def-or-class-bol 'ar-backward-def-or-class-bol)

;; https://github.com/andreas-roehler/emacs-generics/SomeMode-mode/-/issues/105#note_1095808557
(puthash "SomeMode-"
         (append (gethash "SomeMode" definition-prefixes) '("ar-mode"))
         definition-prefixes)

(provide 'ar-foot)

;;; ar-foot.el ends here
