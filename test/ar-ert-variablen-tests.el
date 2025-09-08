;;; ar-ert-variablen-tests.el --- Just some more tests -*- lexical-binding: t; -*-

;; URL: https://github.com/andreas-roehler/emacs-generics
;; Keywords: languages, convenience

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

;; Protect against unnoticed deletes.

;;; Code:

(ert-deftest ar-ert-last-exeption-buffer-test-3sKjIQ ()
  (should (boundp 'ar-last-exeption-buffer)))

(ert-deftest ar-ert-pdbtrack-is-tracking-p-test-VcB8BB ()
  (should (boundp 'ar-pdbtrack-is-tracking-p)))

(ert-deftest ar-ert-underscore-word-syntax-p-test-BHl93t ()
  (should (boundp 'ar-underscore-word-syntax-p)))

(ert-deftest ar-ert-kill-empty-line-test-TsQNSe ()
  (should (boundp 'ar-kill-empty-line)))

(ert-deftest ar-ert-match-paren-key-test-p6hzf7 ()
  (should (boundp 'ar-match-paren-key)))

(ert-deftest ar-ert-match-paren-mode-test-lvvuDZ ()
  (should (boundp 'ar-match-paren-mode)))

(ert-deftest ar-ert-iSomeMode-shell-mode-map-test-zr50XR ()
  (should (boundp 'ar-iSomeMode-shell-mode-map)))

(ert-deftest ar-ert-shell-map-test-zr6lBC ()
  (should (boundp 'ar-shell-mode-map)))

;; (ert-deftest ar-ert-eldoc-string-code-test-zOpVTu ()
;;   (should (boundp 'ar-eldoc-string-code)))

(ert-deftest ar-ert-chars-after-test-TNpn9m ()
  (should (boundp 'ar-chars-after)))

(ert-deftest ar-ert-chars-before-test-rW2cnf ()
  (should (boundp 'ar-chars-before)))

(ert-deftest ar-ert-ask-about-save-test-Z8LAB7 ()
  (should (boundp 'ar-ask-about-save)))

(ert-deftest ar-ert-auto-complete-p-test-VbWXNZ ()
  (should (boundp 'ar-auto-complete-p)))

(ert-deftest ar-ert--auto-complete-timer-delay-test-55hfWR ()
  (should (boundp 'ar--auto-complete-timer-delay)))

(ert-deftest ar-ert-auto-fill-mode-test-XmSP2J ()
  (should (boundp 'ar-auto-fill-mode)))

(ert-deftest ar-ert-autofill-timer-delay-test-f1Dh7B ()
  (should (boundp 'ar-autofill-timer-delay)))

;; (ert-deftest ar-ert-autopair-mode-test-9agvcu ()
;;   (should (boundp 'ar-autopair-mode)))

(ert-deftest ar-ert-backslashed-lines-indent-offset-test-L7tlfm ()
  (should (boundp 'ar-backslashed-lines-indent-offset)))

(ert-deftest ar-ert-beep-if-tab-change-test-Bdlzge ()
  (should (boundp 'ar-beep-if-tab-change)))

(ert-deftest ar-ert-block-comment-prefix-test-jPEif6 ()
  (should (boundp 'ar-block-comment-prefix)))

(ert-deftest ar-ert-block-comment-prefix-p-test-1E3GbY ()
  (should (boundp 'ar-block-comment-prefix-p)))

(ert-deftest ar-ert-check-command-test-toPIgR ()
  (should (boundp 'ar-check-command)))

(ert-deftest ar-ert-close-provides-newline-test-DUcnjK ()
  (should (boundp 'ar-close-provides-newline)))

(ert-deftest ar-ert-closing-list-dedents-bos-test-ZsQQjD ()
  (should (boundp 'ar-closing-list-dedents-bos)))

(ert-deftest ar-ert-closing-list-keeps-space-test-X8JNhw ()
  (should (boundp 'ar-closing-list-keeps-space)))

(ert-deftest ar-ert-closing-list-space-test-t8MGfp ()
  (should (boundp 'ar-closing-list-space)))

(ert-deftest ar-ert-comment-fill-column-test-7nMS9h ()
  (should (boundp 'ar-comment-fill-column)))

(ert-deftest ar-ert-company-pycomplete-p-test-D9tQ5a ()
  (should (boundp 'ar-company-pycomplete-p)))

(ert-deftest ar-ert-compilation-regexp-alist-test-lPfxY3 ()
  (should (boundp 'ar-compilation-regexp-alist)))

(ert-deftest ar-ert-complete-ac-sources-test-9JZ3RW ()
  (should (boundp 'ar-complete-ac-sources)))

(ert-deftest ar-ert-complete-function-test-rYd5HP ()
  (should (boundp 'ar-complete-function)))

(ert-deftest ar-ert-continuation-offset-test-JQalzI ()
  (should (boundp 'ar-continuation-offset)))

(ert-deftest ar-ert-current-defun-delay-test-5s8znB ()
  (should (boundp 'ar-current-defun-delay)))

(ert-deftest ar-ert-current-defun-show-test-Rec1bu ()
  (should (boundp 'ar-current-defun-show)))

(ert-deftest ar-ert-custom-temp-directory-test-HKgrXm ()
  (should (boundp 'ar-custom-temp-directory)))

(ert-deftest ar-ert-debug-p-test-ZckRGf ()
  (should (boundp 'ar-debug-p)))

(ert-deftest ar-ert-dedent-keep-relative-column-test-N5uAr8 ()
  (should (boundp 'ar-dedent-keep-relative-column)))

(ert-deftest ar-ert-dedicated-process-p-test-tkTr80 ()
  (should (boundp 'ar-dedicated-process-p)))

(ert-deftest ar-ert-defun-use-top-level-p-test-BxjANT ()
  (should (boundp 'ar-defun-use-top-level-p)))

(ert-deftest ar-ert-delete-function-test-x0E6sM ()
  (should (boundp 'ar-delete-function)))

(ert-deftest ar-ert-docstring-fill-column-test-Fzm06E ()
  (should (boundp 'ar-docstring-fill-column)))

(ert-deftest ar-ert-docstring-style-test-ducuIx ()
  (should (boundp 'ar-docstring-style)))

(ert-deftest ar-ert-edit-only-p-test-BFVOfq ()
  (should (boundp 'ar-edit-only-p)))

(ert-deftest ar-ert-electric-colon-active-p-test-peQ0Ki ()
  (should (boundp 'ar-electric-colon-active-p)))

(ert-deftest ar-ert-electric-colon-bobl-only-test-VLOQKe ()
  (should (boundp 'ar-electric-colon-bobl-only)))

(ert-deftest ar-ert-electric-colon-greedy-p-test-FkeYHa ()
  (should (boundp 'ar-electric-colon-greedy-p)))

(ert-deftest ar-ert-electric-colon-newline-and-indent-p-test-J7ZVC6 ()
  (should (boundp 'ar-electric-colon-newline-and-indent-p)))

(ert-deftest ar-ert-electric-comment-add-space-p-test-BmJFv2 ()
  (should (boundp 'ar-electric-comment-add-space-p)))

(ert-deftest ar-ert-electric-comment-p-test-h1mUlY ()
  (should (boundp 'ar-electric-comment-p)))

(ert-deftest ar-ert-electric-yank-active-p-test-9Ag3XP ()
  (should (boundp 'ar-electric-yank-active-p)))

(ert-deftest ar-ert-empty-comment-line-separates-paragraph-p-test-3oxFML ()
  (should (boundp 'ar-empty-comment-line-separates-paragraph-p)))

(ert-deftest ar-ert-empty-line-closes-p-test-LwzXxH ()
  (should (boundp 'ar-empty-line-closes-p)))

(ert-deftest ar-ert-encoding-string-test-3en7kD ()
  (should (boundp 'ar-encoding-string)))

(ert-deftest ar-ert-error-markup-delay-test-7H8N4y ()
  (should (boundp 'ar-error-markup-delay)))

(ert-deftest ar-ert-execute-directory-test-jvcCPu ()
  (should (boundp 'ar-execute-directory)))

(ert-deftest ar-ert-execute-no-temp-p-test-tRo7wq ()
  (should (boundp 'ar-execute-no-temp-p)))

(ert-deftest ar-ert-extensions-test-912Xem ()
  (should (boundp 'ar-extensions)))

(ert-deftest ar-ert-fast-completion-delay-test-fYcITh ()
  (should (boundp 'ar-fast-completion-delay)))

(ert-deftest ar-ert-fast-process-p-test-RWTswd ()
  (should (boundp 'ar-fast-process-p)))

(ert-deftest ar-ert-fileless-buffer-use-default-directory-p-test-DkdCa9 ()
  (should (boundp 'ar-fileless-buffer-use-default-directory-p)))

(ert-deftest ar-ert-flake8-command-test-l6bmK4 ()
  (should (boundp 'ar-flake8-command)))

(ert-deftest ar-ert-flake8-command-args-test-D4lFi0 ()
  (should (boundp 'ar-flake8-command-args)))

(ert-deftest ar-ert-fontify-shell-buffer-p-test-DF8tRV ()
  (should (boundp 'ar-fontify-shell-buffer-p)))

(ert-deftest ar-ert-force-ar-shell-name-p-test-1CSqoR ()
  (should (boundp 'ar-force-ar-shell-name-p)))

(ert-deftest ar-ert-guess-ar-install-directory-p-test-L9qrRM ()
  (should (boundp 'ar-guess-ar-install-directory-p)))

(ert-deftest ar-ert-hide-comments-when-hiding-all-test-zw9fiI ()
  (should (boundp 'ar-hide-comments-when-hiding-all)))

(ert-deftest ar-ert-hide-show-hide-docstrings-test-vrDjSE ()
  (should (boundp 'ar-hide-show-hide-docstrings)))

(ert-deftest ar-ert-hide-show-keywords-test-HsSVpB ()
  (should (boundp 'ar-hide-show-keywords)))

(ert-deftest ar-ert-hide-show-minor-mode-p-test-h8v9Xx ()
  (should (boundp 'ar-hide-show-minor-mode-p)))

(ert-deftest ar-ert-highlight-error-source-p-test-7ruluu ()
  (should (boundp 'ar-highlight-error-source-p)))

(ert-deftest ar-ert-history-filter-regexp-test-zpf9Xq ()
  (should (boundp 'ar-history-filter-regexp)))

(ert-deftest ar-ert-honor-ISOMEDIR-p-test-FzAHpn ()
  (should (boundp 'ar-honor-ISOMEDIR-p)))

(ert-deftest ar-ert-honor-PYTHONHISTORY-p-test-pqZROj ()
  (should (boundp 'ar-honor-PYTHONHISTORY-p)))

(ert-deftest ar-ert-if-name-main-permission-p-test-lDSlag ()
  (should (boundp 'ar-if-name-main-permission-p)))

(ert-deftest ar-ert--imenu-create-index-function-test-pgdMxc ()
  (should (boundp 'ar--imenu-create-index-function)))

(ert-deftest ar-ert--imenu-create-index-p-test-f8YAR8 ()
  (should (boundp 'ar--imenu-create-index-p)))

(ert-deftest ar-ert-imenu-show-method-args-p-test-n5WGc5 ()
  (should (boundp 'ar-imenu-show-method-args-p)))

(ert-deftest ar-ert-import-check-point-max-test-7xviu1 ()
  (should (boundp 'ar-import-check-point-max)))

(ert-deftest ar-ert-indent-comments-test-Zkm1MX ()
  (should (boundp 'ar-indent-comments)))

(ert-deftest ar-ert-indent-honors-inline-comment-test-TMTr2T ()
  (should (boundp 'ar-indent-honors-inline-comment)))

(ert-deftest ar-ert-indent-list-style-test-TZVQiQ ()
  (should (boundp 'ar-indent-list-style)))

(ert-deftest ar-ert-indent-no-completion-p-test-l1K9vM ()
  (should (boundp 'ar-indent-no-completion-p)))

(ert-deftest ar-ert-indent-offset-test-Xj0KJI ()
  (should (boundp 'ar-indent-offset)))

(ert-deftest ar-ert-indent-tabs-mode-test-xnGHVE ()
  (should (boundp 'ar-indent-tabs-mode)))

(ert-deftest ar-ert-input-filter-re-test-NA4z4A ()
  (should (boundp 'ar-input-filter-re)))

(ert-deftest ar-ert-install-directory-test-TCbZdx ()
  (should (boundp 'ar-install-directory)))

(ert-deftest ar-ert-iSomeMode-command-test-FqGhlt ()
  (should (boundp 'ar-iSomeMode-command)))

(ert-deftest ar-ert-iSomeMode-command-args-test-hzaZop ()
  (should (boundp 'ar-iSomeMode-command-args)))

(ert-deftest ar-ert-iSomeMode-execute-delay-test-j7SOql ()
  (should (boundp 'ar-iSomeMode-execute-delay)))

(ert-deftest ar-ert-iSomeMode-history-test-hLHzfg ()
  (should (boundp 'ar-iSomeMode-history)))

(ert-deftest ar-ert-iSomeMode-send-delay-test-ftCS4a ()
  (should (boundp 'ar-iSomeMode-send-delay)))

(ert-deftest ar-ert-jump-on-exception-test-9odFS5 ()
  (should (boundp 'ar-jump-on-exception)))

(ert-deftest ar-ert-jython-command-test-bftZD0 ()
  (should (boundp 'ar-jython-command)))

(ert-deftest ar-ert-jython-command-args-test-jY97mV ()
  (should (boundp 'ar-jython-command-args)))

(ert-deftest ar-ert-jython-packages-test-Buxr2P ()
  (should (boundp 'ar-jython-packages)))

(ert-deftest ar-ert-keep-shell-dir-when-execute-p-test-rAcDFK ()
  (should (boundp 'ar-keep-shell-dir-when-execute-p)))

(ert-deftest ar-ert-keep-windows-configuration-test-jrHlgF ()
  (should (boundp 'ar-keep-windows-configuration)))

(ert-deftest ar-ert-kill-empty-line-test-fO7nQz ()
  (should (boundp 'ar-kill-empty-line)))

(ert-deftest ar-ert-lhs-inbound-indent-test-T9rHpu ()
  (should (boundp 'ar-lhs-inbound-indent)))

(ert-deftest ar-ert-load-pymacs-p-test-L2JqWo ()
  (should (boundp 'ar-load-pymacs-p)))

(ert-deftest ar-ert-load-skeletons-p-test-l6d5tj ()
  (should (boundp 'ar-load-skeletons-p)))

(ert-deftest ar-ert-mark-decorators-test-Nz1pYd ()
  (should (boundp 'ar-mark-decorators)))

(ert-deftest ar-ert-master-file-test-9lqks8 ()
  (should (boundp 'ar-master-file)))

(ert-deftest ar-ert-match-paren-key-test-Ds7lX2 ()
  (should (boundp 'ar-match-paren-key)))

(ert-deftest ar-ert-match-paren-mode-test-xih0oX ()
  (should (boundp 'ar-match-paren-mode)))

(ert-deftest ar-ert-max-help-buffer-p-test-b2pPOR ()
  (should (boundp 'ar-max-help-buffer-p)))

(ert-deftest ar-ert-max-specpdl-size-test-5LqEfM ()
  (should (boundp 'ar-max-specpdl-size)))

(ert-deftest ar-ert-message-executing-temporary-file-test-LkvyDG ()
  (should (boundp 'ar-message-executing-temporary-file)))

(ert-deftest ar-ert-modeline-acronym-display-home-p-test-v1aK1A ()
  (should (boundp 'ar-modeline-acronym-display-home-p)))

(ert-deftest ar-ert-modeline-display-full-path-p-test-ZV3Amv ()
  (should (boundp 'ar-modeline-display-full-path-p)))

(ert-deftest ar-ert-newline-delete-trailing-whitespace-p-test-n1lVFp ()
  (should (boundp 'ar-newline-delete-trailing-whitespace-p)))

(ert-deftest ar-ert-new-shell-delay-test-F9QCWj ()
  (should (boundp 'ar-new-shell-delay)))

(ert-deftest ar-ert-org-cycle-p-test-de8Lde ()
  (should (boundp 'ar-org-cycle-p)))

(ert-deftest ar-ert-outline-minor-mode-p-test-1yNjE9 ()
  (should (boundp 'ar-outline-minor-mode-p)))

(ert-deftest ar-ert-outline-mode-keywords-test-jFnW04 ()
  (should (boundp 'ar-outline-mode-keywords)))

(ert-deftest ar-ert-pdb-executable-test-PiVYk0 ()
  (should (boundp 'ar-pdb-executable)))

(ert-deftest ar-ert-pdb-path-test-7SIcDV ()
  (should (boundp 'ar-pdb-path)))

(ert-deftest ar-ert-pdbtrack-do-tracking-p-test-JHSgTQ ()
  (should (boundp 'ar-pdbtrack-do-tracking-p)))

(ert-deftest ar-ert-pdbtrack-filename-mapping-test-H9cdaM ()
  (should (boundp 'ar-pdbtrack-filename-mapping)))

(ert-deftest ar-ert-pdbtrack-minor-mode-string-test-pXWUoH ()
  (should (boundp 'ar-pdbtrack-minor-mode-string)))

(ert-deftest ar-ert-pep8-command-test-PxifBC ()
  (should (boundp 'ar-pep8-command)))

(ert-deftest ar-ert-pep8-command-args-test-J5QiLx ()
  (should (boundp 'ar-pep8-command-args)))

(ert-deftest ar-ert-prompt-on-changed-p-test-zht9Ss ()
  (should (boundp 'ar-prompt-on-changed-p)))

(ert-deftest ar-ert-pychecker-command-test-pxVhXn ()
  (should (boundp 'ar-pychecker-command)))

(ert-deftest ar-ert-pychecker-command-args-test-Ron12i ()
  (should (boundp 'ar-pychecker-command-args)))

(ert-deftest ar-ert-pyflakes3-command-args-test-LNwt78 ()
  (should (boundp 'ar-pyflakes3-command-args)))

(ert-deftest ar-ert-pyflakespep8-command-test-1ApQa4 ()
  (should (boundp 'ar-pyflakespep8-command)))

(ert-deftest ar-ert-pyflakespep8-command-args-test-15YJaZ ()
  (should (boundp 'ar-pyflakespep8-command-args)))

(ert-deftest ar-ert-pylint-command-test-bsBCbU ()
  (should (boundp 'ar-pylint-command)))

(ert-deftest ar-ert-pylint-command-args-test-RGv88O ()
  (should (boundp 'ar-pylint-command-args)))

(ert-deftest ar-ert-SomeMode2-command-test-LwtC4J ()
  (should (boundp 'ar-SomeMode2-command)))

(ert-deftest ar-ert-SomeMode2-command-args-test-lysz1E ()
  (should (boundp 'ar-SomeMode2-command-args)))

(ert-deftest ar-ert-SomeMode3-command-test-9U6hUz ()
  (should (boundp 'ar-SomeMode3-command)))

(ert-deftest ar-ert-SomeMode3-command-args-test-DBIjLu ()
  (should (boundp 'ar-SomeMode3-command-args)))

(ert-deftest ar-ert-SomeMode-command-test-NXOFDp ()
  (should (boundp 'ar-SomeMode-command)))

(ert-deftest ar-ert-SomeMode-command-args-test-rFCaYn ()
  (should (boundp 'ar-SomeMode-command-args)))

(ert-deftest ar-ert-SomeMode-history-test-TStZgm ()
  (should (boundp 'ar-SomeMode-history)))

(ert-deftest ar-ert-SomeMode-send-delay-test-f1BlAk ()
  (should (boundp 'ar-SomeMode-send-delay)))

(ert-deftest ar-ert-remove-cwd-from-path-test-LcP4Ri ()
  (should (boundp 'ar-remove-cwd-from-path)))

(ert-deftest ar-ert-return-key-test-l0QG5g ()
  (should (boundp 'ar-return-key)))

(ert-deftest ar-ert-separator-char-test-FBIEgf ()
  (should (boundp 'ar-separator-char)))

(ert-deftest ar-ert-session-p-test-vPJjqd ()
  (should (boundp 'ar-session-p)))

(ert-deftest ar-ert-set-complete-keymap-p-test-D8GZwb ()
  (should (boundp 'ar-set-complete-keymap-p)))

(ert-deftest ar-ert-set-pager-cat-p-test-FwUjB9 ()
  (should (boundp 'ar-set-pager-cat-p)))

(ert-deftest ar-ert-sexp-function-test-xZY6D7 ()
  (should (boundp 'ar-sexp-function)))

(ert-deftest ar-ert-shebang-startstring-test-nFUPE5 ()
  (should (boundp 'ar-shebang-startstring)))

(ert-deftest ar-ert-shell-input-prompt-1-regexp-test-Hi3hD3 ()
  (should (boundp 'ar-shell-input-prompt-1-regexp)))

(ert-deftest ar-ert-shell-input-prompt-2-regexp-test-1DKgz1 ()
  (should (boundp 'ar-shell-input-prompt-2-regexp)))

(ert-deftest ar-ert-shell-local-path-test-5Go2vZ ()
  (should (boundp 'ar-shell-local-path)))

(ert-deftest ar-ert-shell-name-test-Dr7AsX ()
  (should (boundp 'ar-shell-name)))

(ert-deftest ar-ert-shell-prompt-output-regexp-test-NJtWlV ()
  (should (boundp 'ar-shell-prompt-output-regexp)))

(ert-deftest ar-ert-shell-prompt-read-only-test-XBsYfT ()
  (should (boundp 'ar-shell-prompt-read-only)))

(ert-deftest ar-ert-shell-prompt-regexp-test-TMYW6Q ()
  (should (boundp 'ar-shell-prompt-regexp)))

(ert-deftest ar-ert-shell-toggle-1-test-REuaZO ()
  (should (boundp 'ar-shell-toggle-1)))

(ert-deftest ar-ert-shell-toggle-2-test-5Y2HNM ()
  (should (boundp 'ar-shell-toggle-2)))

(ert-deftest ar-ert-smart-indentation-test-dsXrAK ()
  (should (boundp 'ar-smart-indentation)))

(ert-deftest ar-ert-split-window-on-execute-test-dlr8nI ()
  (should (boundp 'ar-split-window-on-execute)))

(ert-deftest ar-ert-split-windows-on-execute-function-test-LJuBjH ()
  (should (boundp 'ar-split-windows-on-execute-function)))

(ert-deftest ar-ert-store-result-p-test-Z9jafG ()
  (should (boundp 'ar-store-result-p)))

(ert-deftest ar-ert-switch-buffers-on-execute-p-test-NA2D7E ()
  (should (boundp 'ar-switch-buffers-on-execute-p)))

(ert-deftest ar-ert-tab-indent-test-TKpnYD ()
  (should (boundp 'ar-tab-indent)))

(ert-deftest ar-ert-tab-indents-region-p-test-HzsTPC ()
  (should (boundp 'ar-tab-indents-region-p)))

(ert-deftest ar-ert-tab-shifts-region-p-test-9EbIFB ()
  (should (boundp 'ar-tab-shifts-region-p)))

(ert-deftest ar-ert-timer-close-completions-p-test-7w3krA ()
  (should (boundp 'ar-timer-close-completions-p)))

(ert-deftest ar-ert-trailing-whitespace-smart-delete-p-test-3zJCaz ()
  (should (boundp 'ar-trailing-whitespace-smart-delete-p)))

(ert-deftest ar-ert-uncomment-indents-p-test-PHgnSx ()
  (should (boundp 'ar-uncomment-indents-p)))

(ert-deftest ar-ert-update-gud-pdb-history-p-test-1Epzxw ()
  (should (boundp 'ar-update-gud-pdb-history-p)))

(ert-deftest ar-ert-use-current-dir-when-execute-p-test-ntBKdv ()
  (should (boundp 'ar-use-current-dir-when-execute-p)))

(ert-deftest ar-ert-use-font-lock-doc-face-p-test-7xBeRt ()
  (should (boundp 'ar-use-font-lock-doc-face-p)))

(ert-deftest ar-ert-use-local-default-test-LHRmss ()
  (should (boundp 'ar-use-local-default)))

(ert-deftest ar-ert-verbose-p-test-lvbi1q ()
  (should (boundp ar-verbose-p)))

(ert-deftest ar-ert--warn-tmp-files-left-p-test-z3Enyp ()
  (should (boundp 'ar--warn-tmp-files-left-p)))

(ert-deftest ar-ert-already-guessed-indent-offset-test-BnkJ1n ()
  (should (boundp 'ar-already-guessed-indent-offset)))

(ert-deftest ar-ert-assignment-re-test-1Z6Uwm ()
  (should (boundp 'ar-assignment-re)))

(ert-deftest ar-ert--auto-complete-timer-test-n8KNYk ()
  (should (boundp 'ar--auto-complete-timer)))

(ert-deftest ar-ert-auto-completion-buffer-test-rV4srj ()
  (should (boundp 'ar-auto-completion-buffer)))

(ert-deftest ar-ert-auto-completion-mode-p-test-HCsRQh ()
  (should (boundp 'ar-auto-completion-mode-p)))

(ert-deftest ar-ert-autofill-timer-test-5D8mhg ()
  (should (boundp 'ar-autofill-timer)))

(ert-deftest ar-ert-block-or-clause-re-test-rcUiEe ()
  (should (boundp 'ar-block-or-clause-re)))

(ert-deftest ar-ert-buffer-name-test-fzIo2c ()
  (should (boundp 'ar-output-buffer)))

(ert-deftest ar-ert-builtins-face-test-Lws0ba ()
  (should (boundp 'ar-builtins-face)))

(ert-deftest ar-ert-class-name-face-test-N4i2j7 ()
  (should (boundp 'ar-class-name-face)))

(ert-deftest ar-ert-complete-last-modified-test-Tma3o4 ()
  (should (boundp 'ar-complete-last-modified)))

(ert-deftest ar-ert-completion-last-window-configuration-test-p09Dr1 ()
  (should (boundp 'ar-last-window-configuration)))

(ert-deftest ar-ert-decorators-face-test-PgZisY ()
  (should (boundp 'ar-decorators-face)))

(ert-deftest ar-ert-def-class-face-test-ZTNmqS ()
  (should (boundp 'ar-def-class-face)))

(ert-deftest ar-ert-delimiter-re-test-DRzylP ()
  (should (boundp 'ar-delimiter-re)))

(ert-deftest ar-ert-dotted-expression-syntax-table-test-540RcM ()
  (should (boundp 'ar-dotted-expression-syntax-table)))

;; (ert-deftest ar-ert-eldoc-setup-code-test-T9HI2I ()
;;   (should (boundp 'ar-eldoc-setup-code)))

(ert-deftest ar-ert-encoding-string-re-test-zgodQF ()
  (should (boundp 'ar-encoding-string-re)))

(ert-deftest ar-ert-error-test-LJ5sEC ()
  (should (boundp 'ar-error)))

(ert-deftest ar-ert-ert-test-default-executables-test-33agqz ()
  (should (boundp 'ar-ert-test-default-executables)))

(ert-deftest ar-ert-exception-buffer-test-17AF9v ()
  (should (boundp 'ar-exception-buffer)))

(ert-deftest ar-ert-exception-name-face-test-tfnDRs ()
  (should (boundp 'ar-exception-name-face)))

(ert-deftest ar-ert-exec-command-test-7SShxp ()
  (should (boundp 'ar-exec-command)))

(ert-deftest ar-ert-expression-re-test-ZvMW9l ()
  (should (boundp 'ar-expression-re)))

(ert-deftest ar-ert-expression-skip-chars-test-FA1PUj ()
  (should (boundp 'ar-expression-skip-chars)))

(ert-deftest ar-ert-expression-skip-regexp-test-pZToDh ()
  (should (boundp 'ar-expression-skip-regexp)))

(ert-deftest ar-ert-fast-filter-re-test-pS7Omf ()
  (should (boundp 'ar-fast-filter-re)))

(ert-deftest ar-ert-file-queue-test-Jb0J5c ()
  (should (boundp 'ar-file-queue)))

(ert-deftest ar-ert-fill-column-orig-test-xiQ0Ka ()
  (should (boundp 'ar-fill-column-orig)))

(ert-deftest ar-ert-flake8-history-test-RNKjr8 ()
  (should (boundp 'ar-flake8-history)))

(ert-deftest ar-ert-import-from-face-test-BltII3 ()
  (should (boundp 'ar-import-from-face)))

(ert-deftest ar-ert-iSomeMode0.10-completion-command-string-test-dGVPj1 ()
  (should (boundp 'ar-iSomeMode0.10-completion-command-string)))

(ert-deftest ar-ert-iSomeMode0.11-completion-command-string-test-lpsZVY ()
  (should (boundp 'ar-iSomeMode0.11-completion-command-string)))

(ert-deftest ar-ert-iSomeMode-completion-command-string-test-h6s3vW ()
  (should (boundp 'ar-iSomeMode-completion-command-string)))

(ert-deftest ar-ert-iSomeMode-completions-test-hxu62T ()
  (should (boundp 'ar-iSomeMode-completions)))

(ert-deftest ar-ert-iSomeMode-input-prompt-re-test-HFbLAR ()
  (should (boundp 'ar-iSomeMode-input-prompt-re)))

(ert-deftest ar-ert-iSomeMode-module-completion-code-test-nsdo6O ()
  (should (boundp 'ar-iSomeMode-module-completion-code)))

(ert-deftest ar-ert-iSomeMode-module-completion-string-test-xuDXxM ()
  (should (boundp 'ar-iSomeMode-module-completion-string)))

(ert-deftest ar-ert-iSomeMode-output-prompt-re-test-FhuSXJ ()
  (should (boundp 'ar-iSomeMode-output-prompt-re)))

(ert-deftest ar-ert-labelled-re-test-ZYEMoH ()
  (should (boundp 'ar-labelled-re)))

(ert-deftest ar-ert-line-number-offset-test-7FmSNE ()
  (should (boundp 'ar-line-number-offset)))

(ert-deftest ar-ert-match-paren-no-use-syntax-pps-test-NmawLw ()
  (should (boundp 'ar-match-paren-no-use-syntax-pps)))

(ert-deftest ar-ert-mode-output-map-test-NBRRZt ()
  (should (boundp 'ar-mode-output-map)))

(ert-deftest ar-ert-new-session-p-test-xcYYbr ()
  (should (boundp 'ar-new-session-p)))

(ert-deftest ar-ert-not-expression-chars-test-rQjQRr ()
  (should (boundp 'ar-not-expression-chars)))

(ert-deftest ar-ert-not-expression-regexp-test-3MNsvs ()
  (should (boundp 'ar-not-expression-regexp)))

(ert-deftest ar-ert-number-face-test-1msX9s ()
  (should (boundp 'ar-number-face)))

(ert-deftest ar-ert-object-reference-face-test-tSgULt ()
  (should (boundp 'ar-object-reference-face)))

(ert-deftest ar-ert-operator-re-test-BtXuou ()
  (should (boundp 'ar-operator-re)))

(ert-deftest ar-ert-orig-buffer-or-file-test-1t4Q0u ()
  (should (boundp 'ar-orig-buffer-or-file)))

(ert-deftest ar-ert-output-buffer-test-XQWHzv ()
  (should (boundp 'ar-output-buffer)))

(ert-deftest ar-ert-partial-expression-forward-chars-test-bcP0Hw ()
  (should (boundp 'ar-partial-expression-forward-chars)))

(ert-deftest ar-ert-pdbtrack-input-prompt-test-RciQcx ()
  (should (boundp 'ar-pdbtrack-input-prompt)))

(ert-deftest ar-ert-pep8-history-test-bQYZIx ()
  (should (boundp 'ar-pep8-history)))

(ert-deftest ar-ert-pseudo-keyword-face-test-LRBVay ()
  (should (boundp 'ar-pseudo-keyword-face)))

(ert-deftest ar-ert-pychecker-history-test-LG3hEy ()
  (should (boundp 'ar-pychecker-history)))

(ert-deftest ar-ert-pydbtrack-input-prompt-test-RqZJ5y ()
  (should (boundp 'ar-pydbtrack-input-prompt)))

(ert-deftest ar-ert-pyflakes3-history-test-dbxVtz ()
  (should (boundp 'ar-pyflakes3-history)))

(ert-deftest ar-ert-pyflakespep8-history-test-bpSBSz ()
  (should (boundp 'ar-pyflakespep8-history)))

(ert-deftest ar-ert-pylint-history-test-DEwzfA ()
  (should (boundp 'ar-pylint-history)))

(ert-deftest ar-ert-SomeMode-completions-test-XJRwyA ()
  (should (boundp 'ar-SomeMode-completions)))

(ert-deftest ar-ert-result-test-x16RPA ()
  (should (boundp 'ar-result)))

(ert-deftest ar-ert-return-result-p-test-ff414A ()
  (should (boundp 'ar-return-result-p)))

(ert-deftest ar-ert-separator-char-test-LetIkB ()
  (should (boundp 'ar-separator-char)))

(ert-deftest ar-ert-shebang-regexp-test-nzJNxB ()
  (should (boundp 'ar-shebang-regexp)))

(ert-deftest ar-ert-shell-complete-debug-test-FFnMIB ()
  (should (boundp 'ar-shell-complete-debug)))

(ert-deftest ar-ert-shell-completion-setup-code-test-JKkdSB ()
  (should (boundp 'ar-shell-completion-setup-code)))

(ert-deftest ar-ert-shell-hook-test-L2w29C ()
  (should (boundp 'ar-shell-hook)))

(ert-deftest ar-ert-shell-module-completion-code-test-louBpE ()
  (should (boundp 'ar-shell-module-completion-code)))

(ert-deftest ar-ert-shell-template-test-FZH6BF ()
  (should (boundp 'ar-shell-template)))

(ert-deftest ar-ert-string-delim-re-test-BeIdMG ()
  (should (boundp 'ar-string-delim-re)))

(ert-deftest ar-ert-temp-directory-test-bEfOTH ()
  (should (boundp 'ar-temp-directory)))

(ert-deftest ar-ert-traceback-line-re-test-zCXm7J ()
  (should (boundp 'ar-traceback-line-re)))

(ert-deftest ar-ert-try-if-face-test-1Zn3bL ()
  (should (boundp 'ar-try-if-face)))

(ert-deftest ar-ert-underscore-word-syntax-p-test-t1wYhM ()
  (should (boundp 'ar-underscore-word-syntax-p)))

(ert-deftest ar-ert-variable-name-face-test-pSGwkN ()
  (should (boundp 'ar-variable-name-face)))

(ert-deftest ar-ert-which-bufname-test-Ho4doO ()
  (should (boundp 'ar-which-bufname)))

(ert-deftest ar-ert-XXX-tag-face-test-jO4QpQ ()
  (should (boundp 'ar-XXX-tag-face)))

(ert-deftest ar-ert-block-closing-keywords-re-test-fjHnpR ()
  (should (boundp 'ar-block-closing-keywords-re)))

(ert-deftest ar-ert-iSomeMode-input-prompt-re-test-f2NKlS ()
  (should (boundp 'ar-iSomeMode-input-prompt-re)))

(ert-deftest ar-ert-imenu-class-regexp-test-5xAniT ()
  (should (boundp 'ar-imenu-class-regexp)))

(ert-deftest ar-ert-imenu-generic-expression-test-NtGGbU ()
  (should (boundp 'ar-imenu-generic-expression)))

(ert-deftest ar-ert-imenu-generic-parens-test-jVPj3U ()
  (should (boundp 'ar-imenu-generic-parens)))

(ert-deftest ar-ert-imenu-generic-regexp-test-dxUGVV ()
  (should (boundp 'ar-imenu-generic-regexp)))

(ert-deftest ar-ert-imenu-method-arg-parens-test-rpobMW ()
  (should (boundp 'ar-imenu-method-arg-parens)))

(ert-deftest ar-ert-imenu-method-no-arg-parens-test-prZMyX ()
  (should (boundp 'ar-imenu-method-no-arg-parens)))

(ert-deftest ar-ert-imenu-method-regexp-test-JcEPiY ()
  (should (boundp 'ar-imenu-method-regexp)))

(provide 'ar-ert-variablen-tests)
;;; ar-ert-variablen-tests.el ends here
