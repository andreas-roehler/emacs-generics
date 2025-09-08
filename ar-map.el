;;; ar-map.el --- Install a ar-mode-map -*- lexical-binding: t; -*-

(defvar ar-use-menu-p t
  "If the menu should be loaded.

Default is t")

(defvar ar-menu nil
  "Make a dynamically bound variable ‘ar-menu’.")

(setq ar-mode-map
      (let ((map (make-sparse-keymap)))
        ;; electric keys
        (define-key map [(:)] (quote ar-electric-colon))
        (define-key map [(\#)] (quote ar-electric-comment))
        (define-key map [(delete)] (quote ar-electric-delete))
        (define-key map [(control backspace)] (quote ar-hungry-delete-backwards))
        (define-key map [(control c) (delete)] (quote ar-hungry-delete-forward))
        ;; (define-key map [(control y)] (quote ar-electric-yank))
        ;; moving point
        (define-key map [(control c) (control p)] (quote ar-backward-statement))
        (define-key map [(control c) (control n)] (quote ar-forward-statement))
        (define-key map [(control c) (control u)] (quote ar-backward-block))
        (define-key map [(control c) (control q)] (quote ar-forward-block))
        (define-key map [(control meta a)] (quote ar-backward-def-or-class))
        (define-key map [(control meta e)] (quote ar-forward-def-or-class))
        ;; (define-key map [(meta i)] (quote ar-indent-forward-line))
        ;; (define-key map [(control j)] (quote ar-newline-and-indent))
        (define-key map (kbd "C-j") (quote newline))
        ;; Most SOMEeers expect RET ‘ar-newline-and-indent’
        ;; which is default of var ar-return-key’
        (define-key map (kbd "RET") ar-return-key)
        ;; (define-key map (kbd "RET") (quote newline))
        ;; (define-key map (kbd "RET") (quote ar-newline-and-dedent))
        (define-key map [(super backspace)] (quote ar-dedent))
        ;; (define-key map [(control return)] (quote ar-newline-and-dedent))
        ;; indentation level modifiers
        (define-key map [(control c) (control l)] (quote ar-shift-left))
        (define-key map [(control c) (control r)] (quote ar-shift-right))
        (define-key map [(control c) (<)] (quote ar-shift-left))
        (define-key map [(control c) (>)] (quote ar-shift-right))
        ;; (define-key map [(control c) (tab)] (quote ar-indent-region))
        (define-key map (kbd "C-c TAB") (quote ar-indent-region))
        (define-key map [(control c) (:)] (quote ar-guess-indent-offset))
        ;; subprocess commands
        (define-key map [(control c) (control c)] (quote ar-execute-buffer))
        (define-key map [(control c) (control m)] (quote ar-execute-import-or-reload))
        (define-key map [(control c) (control s)] (quote ar-execute-string))
        (define-key map [(control c) (|)] (quote ar-execute-region))
        (define-key map [(control meta x)] (quote ar-execute-def-or-class))
        (define-key map [(control c) (!)] (quote ar-shell))
        (define-key map [(control c) (control t)] (quote ar-toggle-shell))
        (define-key map [(control meta h)] (quote ar-mark-def-or-class))
        (define-key map [(control c) (control k)] (quote ar-mark-block-or-clause))
        (define-key map [(control c) (.)] (quote ar-expression))
        (define-key map [(control c) (?,)] (quote ar-partial-expression))
        ;; Miscellaneous
        ;; (define-key map [(super q)] (quote ar-copy-statement))
        (define-key map [(control c) (control d)] (quote ar-pdbtrack-toggle-stack-tracking))
        (define-key map [(control c) (control f)] (quote ar-sort-imports))
        (define-key map [(control c) (\#)] (quote ar-comment-region))
        (define-key map [(control c) (\?)] (quote ar-describe-mode))
        (define-key map [(control c) (control e)] (quote ar-help-at-point))
        (define-key map [(control c) (-)] (quote ar-up-exception))
        (define-key map [(control c) (=)] (quote ar-down-exception))
        (define-key map [(control x) (n) (d)] (quote ar-narrow-to-def-or-class))
        ;; information
        (define-key map [(control c) (control b)] (quote ar-submit-bug-report))
        (define-key map [(control c) (control v)] (quote ar-version))
        (define-key map [(control c) (control w)] (quote ar-pychecker-run))
        ;; (define-key map (kbd "TAB") (quote ar-indent-line))
        (define-key map (kbd "TAB") (quote ar-indent-line))
        ;; (if ar-complete-function
        ;;     (progn
        ;;       (define-key map [(meta tab)] ar-complete-function)
        ;;       (define-key map [(esc) (tab)] ar-complete-function))
        ;;   (define-key map [(meta tab)] (quote ar-shell-complete))
        ;;   (define-key map [(esc) (tab)] (quote ar-shell-complete)))
        (substitute-key-definition (quote complete-symbol) (quote completion-at-point)
                                   map global-map)
        (substitute-key-definition (quote backward-up-list) (quote ar-up)
                                   map global-map)
        (substitute-key-definition (quote down-list) (quote ar-down)
                                   map global-map)
        (when ar-use-menu-p
          (setq map (ar-define-menu map)))
        map))

(defvar ar-shell-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c\C-r"            (quote ar-nav-last-prompt))
    (define-key map (kbd "RET") (quote comint-send-input))
    (define-key map (kbd "TAB") (quote ar-indent-line))
    (define-key map [(control c) (!)] (quote ar-shell))
    (define-key map [(control c) (-)] (quote ar-up-exception))
    (define-key map [(control c) (.)] (quote ar-expression))
    (define-key map [(control c) (:)] (quote ar-guess-indent-offset))
    (define-key map [(control c) (<)] (quote ar-shift-left))
    (define-key map [(control c) (=)] (quote ar-down-exception))
    (define-key map [(control c) (>)] (quote ar-shift-right))
    (define-key map [(control c) (\#)] (quote ar-comment-region))
    (define-key map [(control c) (\?)] (quote ar-describe-mode))
    (define-key map [(control c) (control b)] (quote ar-submit-bug-report))
    (define-key map [(control c) (control d)] (quote ar-pdbtrack-toggle-stack-tracking))
    (define-key map [(control c) (control e)] (quote ar-help-at-point))
    (define-key map [(control c) (control k)] (quote ar-mark-block-or-clause))
    (define-key map [(control c) (control l)] (quote comint-dynamic-list-input-ring))
    (define-key map [(control c) (control n)] (quote ar-forward-statement))
    (define-key map [(control c) (control p)] (quote ar-backward-statement))
    (define-key map [(control c) (control q)] (quote ar-forward-block))
    (define-key map [(control c) (control t)] (quote ar-toggle-shell))
    (define-key map [(control c) (control u)] (quote ar-backward-block))
    (define-key map [(control c) (control v)] (quote ar-version))
    (define-key map [(control c) (control w)] (quote ar-pychecker-run))
    (define-key map [(control c) (tab)] (quote ar-indent-region))
    (define-key map [(control j)] (quote ar-newline-and-indent))
    (define-key map [(control meta a)] (quote ar-backward-def-or-class))
    (define-key map [(control meta e)] (quote ar-forward-def-or-class))
    (define-key map [(control meta h)] (quote ar-mark-def-or-class))
    (define-key map [(control x) (n) (d)] (quote ar-narrow-to-def-or-class))
    (define-key map [(meta tab)] (quote ar-shell-complete))
    (define-key map [(super backspace)] (quote ar-dedent))
    ;; (define-key map "\C-c\C-r"         (quote comint-show-output))
    ;; (define-key map [(control c)(control r)] (quote ar-nav-last-prompt))
    (substitute-key-definition (quote complete-symbol) (quote completion-at-point)
                               map global-map)
    (substitute-key-definition (quote backward-up-list) (quote ar-up)
                               map global-map)
    (substitute-key-definition (quote down-list) (quote ar-down)
                               map global-map)
    map)
  "Used inside a SOME-shell.")

(defvar ar-iSomeMode-shell-mode-map ar-shell-mode-map
  "Copy ‘ar-shell-mode-map’ here.")

(provide (quote ar-map))

;;; ar-map.el ends here
