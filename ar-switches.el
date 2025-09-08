;;; ar-switches.el --- Toggle minor modes -*- lexical-binding: t; -*-


(defun ar-toggle-ar-mode-v5-behavior ()
  "Switch the values of ‘ar-mode-v5-behavior-p’."
  (interactive)
  (setq ar-mode-v5-behavior-p (not ar-mode-v5-behavior-p))
  (when (called-interactively-p 'interactive)
    (message "ar-mode-v5-behavior-p: %s" ar-mode-v5-behavior-p)))

(defun ar-toggle-ar-verbose-p ()
  "Switch the values of ‘ar-verbose-p’.

Default is nil.
If on, messages value of ‘ar-result’ for instance."
  (interactive)
  (setq ar-verbose-p (not ar-verbose-p))
  (when (called-interactively-p 'interactive)
    (message "ar-verbose-p: %s" ar-verbose-p)))

(defun ar-verbose-on ()
  "Switch the value of ‘ar-verbose-p’ on."
  (interactive)
  (setq ar-verbose-p t))

(defun ar-verbose-off ()
  "Switch the value of ‘ar-verbose-p’ off."
  (interactive)
  (setq ar-verbose-p nil))

;;  Smart indentation
(defun ar-toggle-smart-indentation (&optional arg)
  "Toggle ‘ar-smart-indentation’ - on with positiv ARG.

Returns value of ‘ar-smart-indentation’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-smart-indentation -1 1))))
    (if (< 0 arg)
        (progn
          (setq ar-smart-indentation t)
          (ar-guess-indent-offset))
      (setq ar-smart-indentation nil)
      (setq ar-indent-offset (default-value (quote ar-indent-offset))))
    (when (called-interactively-p 'any) (message "ar-smart-indentation: %s" ar-smart-indentation))
    ar-smart-indentation))

(defun ar-smart-indentation-on (&optional arg)
  "Toggle‘ar-smart-indentation’ - on with positive ARG.

Returns value of ‘ar-smart-indentation’."
  (interactive "p")
  (let ((arg (or arg 1)))
    (ar-toggle-smart-indentation arg))
  (when (called-interactively-p 'any) (message "ar-smart-indentation: %s" ar-smart-indentation))
  ar-smart-indentation)

(defun ar-smart-indentation-off (&optional arg)
  "Toggle ‘ar-smart-indentation’ according to ARG.

Returns value of ‘ar-smart-indentation’."
  (interactive "p")
  (let ((arg (if arg (- arg) -1)))
    (ar-toggle-smart-indentation arg))
  (when (called-interactively-p 'any) (message "ar-smart-indentation: %s" ar-smart-indentation))
  ar-smart-indentation)

(defun ar-toggle-sexp-function ()
  "Opens customization."
  (interactive)
  (customize-variable (quote ar-sexp-function)))

;;  ar-switch-buffers-on-execute-p forms
(defun ar-toggle-switch-buffers-on-execute-p (&optional arg)
  "Toggle ‘ar-switch-buffers-on-execute-p’ according to ARG.

  Returns value of ‘ar-switch-buffers-on-execute-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-switch-buffers-on-execute-p -1 1))))
    (if (< 0 arg)
        (setq ar-switch-buffers-on-execute-p t)
      (setq ar-switch-buffers-on-execute-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-switch-buffers-on-execute-p: %s" ar-switch-buffers-on-execute-p))
    ar-switch-buffers-on-execute-p))

(defun ar-switch-buffers-on-execute-p-on (&optional arg)
  "Toggle ‘ar-switch-buffers-on-execute-p’ according to ARG.

Returns value of ‘ar-switch-buffers-on-execute-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-switch-buffers-on-execute-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-switch-buffers-on-execute-p: %s" ar-switch-buffers-on-execute-p))
  ar-switch-buffers-on-execute-p)

(defun ar-switch-buffers-on-execute-p-off ()
  "Make sure, ‘ar-switch-buffers-on-execute-p’ is off.

Returns value of ‘ar-switch-buffers-on-execute-p’."
  (interactive)
  (ar-toggle-switch-buffers-on-execute-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-switch-buffers-on-execute-p: %s" ar-switch-buffers-on-execute-p))
  ar-switch-buffers-on-execute-p)

;;  ar-split-window-on-execute forms
(defun ar-toggle-split-window-on-execute (&optional arg)
  "Toggle ‘ar-split-window-on-execute’ according to ARG.

  Returns value of ‘ar-split-window-on-execute’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-split-window-on-execute -1 1))))
    (if (< 0 arg)
        (setq ar-split-window-on-execute t)
      (setq ar-split-window-on-execute nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
    ar-split-window-on-execute))

(defun ar-split-window-on-execute-on (&optional arg)
  "Toggle ‘ar-split-window-on-execute’ according to ARG.

Returns value of ‘ar-split-window-on-execute’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-split-window-on-execute arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
  ar-split-window-on-execute)

(defun ar-split-window-on-execute-off ()
  "Make sure, ‘ar-split-window-on-execute’ is off.

Returns value of ‘ar-split-window-on-execute’."
  (interactive)
  (ar-toggle-split-window-on-execute -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-split-window-on-execute: %s" ar-split-window-on-execute))
  ar-split-window-on-execute)

;;  ar-fontify-shell-buffer-p forms
(defun ar-toggle-fontify-shell-buffer-p (&optional arg)
  "Toggle ‘ar-fontify-shell-buffer-p’ according to ARG.

  Returns value of ‘ar-fontify-shell-buffer-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-fontify-shell-buffer-p -1 1))))
    (if (< 0 arg)
        (progn
          (setq ar-fontify-shell-buffer-p t)
          (set (make-local-variable 'font-lock-defaults)
             '(ar-font-lock-keywords nil nil nil nil
                                         (font-lock-syntactic-keywords
                                          . ar-font-lock-syntactic-keywords)))
          (unless (looking-at comint-prompt-regexp)
            (when (re-search-backward comint-prompt-regexp nil t 1)
              (font-lock-fontify-region (line-beginning-position) (point-max)))))
      (setq ar-fontify-shell-buffer-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-fontify-shell-buffer-p: %s" ar-fontify-shell-buffer-p))
    ar-fontify-shell-buffer-p))

(defun ar-fontify-shell-buffer-p-on (&optional arg)
  "Toggle ‘ar-fontify-shell-buffer-p’ according to ARG.

Returns value of ‘ar-fontify-shell-buffer-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-fontify-shell-buffer-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-fontify-shell-buffer-p: %s" ar-fontify-shell-buffer-p))
  ar-fontify-shell-buffer-p)

(defun ar-fontify-shell-buffer-p-off ()
  "Make sure, ‘ar-fontify-shell-buffer-p’ is off.

Returns value of ‘ar-fontify-shell-buffer-p’."
  (interactive)
  (ar-toggle-fontify-shell-buffer-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-fontify-shell-buffer-p: %s" ar-fontify-shell-buffer-p))
  ar-fontify-shell-buffer-p)

;;  ar-mode-v5-behavior-p forms
(defun ar-toggle-ar-mode-v5-behavior-p (&optional arg)
  "Toggle ‘ar-mode-v5-behavior-p’ according to ARG.

  Returns value of ‘ar-mode-v5-behavior-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-mode-v5-behavior-p -1 1))))
    (if (< 0 arg)
        (setq ar-mode-v5-behavior-p t)
      (setq ar-mode-v5-behavior-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-mode-v5-behavior-p: %s" ar-mode-v5-behavior-p))
    ar-mode-v5-behavior-p))

(defun ar-ar-mode-v5-behavior-p-on (&optional arg)
  "To ‘ar-mode-v5-behavior-p’ according to ARG.

Returns value of ‘ar-mode-v5-behavior-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-ar-mode-v5-behavior-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-mode-v5-behavior-p: %s" ar-mode-v5-behavior-p))
  ar-mode-v5-behavior-p)

(defun ar-ar-mode-v5-behavior-p-off ()
  "Make sure, ‘ar-mode-v5-behavior-p’ is off.

Returns value of ‘ar-mode-v5-behavior-p’."
  (interactive)
  (ar-toggle-ar-mode-v5-behavior-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-mode-v5-behavior-p: %s" ar-mode-v5-behavior-p))
  ar-mode-v5-behavior-p)

;;  ar-jump-on-exception forms
(defun ar-toggle-jump-on-exception (&optional arg)
  "Toggle ‘ar-jump-on-exception’ according to ARG.

  Returns value of ‘ar-jump-on-exception’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-jump-on-exception -1 1))))
    (if (< 0 arg)
        (setq ar-jump-on-exception t)
      (setq ar-jump-on-exception nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-jump-on-exception: %s" ar-jump-on-exception))
    ar-jump-on-exception))

(defun ar-jump-on-exception-on (&optional arg)
  "Toggle ar-jump-on-exception' according to ARG.

Returns value of ‘ar-jump-on-exception’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-jump-on-exception arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-jump-on-exception: %s" ar-jump-on-exception))
  ar-jump-on-exception)

(defun ar-jump-on-exception-off ()
  "Make sure, ‘ar-jump-on-exception’ is off.

Returns value of ‘ar-jump-on-exception’."
  (interactive)
  (ar-toggle-jump-on-exception -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-jump-on-exception: %s" ar-jump-on-exception))
  ar-jump-on-exception)

;;  ar-use-current-dir-when-execute-p forms
(defun ar-toggle-use-current-dir-when-execute-p (&optional arg)
  "Toggle ‘ar-use-current-dir-when-execute-p’ according to ARG.

  Returns value of ‘ar-use-current-dir-when-execute-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-use-current-dir-when-execute-p -1 1))))
    (if (< 0 arg)
        (setq ar-use-current-dir-when-execute-p t)
      (setq ar-use-current-dir-when-execute-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-use-current-dir-when-execute-p: %s" ar-use-current-dir-when-execute-p))
    ar-use-current-dir-when-execute-p))

(defun ar-use-current-dir-when-execute-p-on (&optional arg)
  "Toggle ar-use-current-dir-when-execute-p' according to ARG.

Returns value of ‘ar-use-current-dir-when-execute-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-use-current-dir-when-execute-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-use-current-dir-when-execute-p: %s" ar-use-current-dir-when-execute-p))
  ar-use-current-dir-when-execute-p)

(defun ar-use-current-dir-when-execute-p-off ()
  "Make sure, ‘ar-use-current-dir-when-execute-p’ is off.

Returns value of ‘ar-use-current-dir-when-execute-p’."
  (interactive)
  (ar-toggle-use-current-dir-when-execute-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-use-current-dir-when-execute-p: %s" ar-use-current-dir-when-execute-p))
  ar-use-current-dir-when-execute-p)

;;  ar-electric-comment-p forms
(defun ar-toggle-electric-comment-p (&optional arg)
  "Toggle ‘ar-electric-comment-p’ according to ARG.

  Returns value of ‘ar-electric-comment-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-electric-comment-p -1 1))))
    (if (< 0 arg)
        (setq ar-electric-comment-p t)
      (setq ar-electric-comment-p nil))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-electric-comment-p: %s" ar-electric-comment-p))
    ar-electric-comment-p))

(defun ar-electric-comment-p-on (&optional arg)
  "Toggle ar-electric-comment-p' according to ARG.

Returns value of ‘ar-electric-comment-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-electric-comment-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-electric-comment-p: %s" ar-electric-comment-p))
  ar-electric-comment-p)

(defun ar-electric-comment-p-off ()
  "Make sure, ‘ar-electric-comment-p’ is off.

Returns value of ‘ar-electric-comment-p’."
  (interactive)
  (ar-toggle-electric-comment-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-electric-comment-p: %s" ar-electric-comment-p))
  ar-electric-comment-p)

;;  ar-underscore-word-syntax-p forms
(defun ar-toggle-underscore-word-syntax-p (&optional arg)
  "Toggle ‘ar-underscore-word-syntax-p’ according to ARG.

  Returns value of ‘ar-underscore-word-syntax-p’ switched to."
  (interactive)
  (let ((arg (or arg (if ar-underscore-word-syntax-p -1 1))))
    (if (< 0 arg)
        (progn
          (setq ar-underscore-word-syntax-p t)
          (modify-syntax-entry ?\_ "w" ar-mode-syntax-table))
      (setq ar-underscore-word-syntax-p nil)
      (modify-syntax-entry ?\_ "_" ar-mode-syntax-table))
    (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-underscore-word-syntax-p: %s" ar-underscore-word-syntax-p))
    ar-underscore-word-syntax-p))

(defun ar-underscore-word-syntax-p-on (&optional arg)
  "Toggle ar-underscore-word-syntax-p' according to ARG.

Returns value of ‘ar-underscore-word-syntax-p’."
  (interactive)
  (let ((arg (or arg 1)))
    (ar-toggle-underscore-word-syntax-p arg))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-underscore-word-syntax-p: %s" ar-underscore-word-syntax-p))
  ar-underscore-word-syntax-p)

(defun ar-underscore-word-syntax-p-off ()
  "Make sure, ‘ar-underscore-word-syntax-p’ is off.

Returns value of ‘ar-underscore-word-syntax-p’."
  (interactive)
  (ar-toggle-underscore-word-syntax-p -1)
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-underscore-word-syntax-p: %s" ar-underscore-word-syntax-p))
  ar-underscore-word-syntax-p)

(defcustom ar-underscore-word-syntax-p t
  "If underscore chars should be of ‘syntax-class’ word.

I.e. not of ‘symbol’.

Underscores in word-class like ‘forward-word’ travel the indentifiers.
Default is t.

See bug report at launchpad, lp:940812"
  :type 'boolean
  :tag "ar-underscore-word-syntax-p"
  :group 'ar-mode
  :set (lambda (symbol value)
         (set-default symbol value)
         (ar-toggle-underscore-word-syntax-p (if value 1 0))))

;; ar-toggle-underscore-word-syntax-p must be known already
;; circular: ar-toggle-underscore-word-syntax-p sets and calls it

(defun ar-toggle-ar-closing-list-dedents-bos ()
  "Toggle var ar-closing-list-dedents-bos.

Valid in current session only.
At start may be set by custom-file"
  (interactive)
  (setq ar-closing-list-dedents-bos
        (not ar-closing-list-dedents-bos))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-closing-list-dedents-bos: %s" ar-closing-list-dedents-bos)))

(defun ar-toggle-ar-register-shell-buffer-p ()
  "Toggle var ar-register-shell-buffer-p.

Valid in current session only.
At start may be set by custom-file"
  (interactive)
  (setq ar-register-shell-buffer-p
        (not ar-register-shell-buffer-p))
  (when (or ar-verbose-p (called-interactively-p 'any)) (message "ar-register-shell-buffer-p: %s" ar-register-shell-buffer-p)))

(provide 'ar-switches)
;;; ar-switches.el ends here
