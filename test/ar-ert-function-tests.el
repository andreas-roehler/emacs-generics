;;; ar-ert-function-tests.el --- functionp ert tests  -*- lexical-binding: t; -*-

;; URL: https://github.com/andreas-roehler/emacs-generics
;; Keywords: lisp

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

(ert-deftest ar-ert-virtualenv-filter-functionp-test-2b5yDV ()
  (should (functionp 'virtualenv-filter)))

(ert-deftest ar-ert-ar--beginning-of-statement-p-functionp-test-sHNAQu ()
  (should (functionp 'ar--beginning-of-statement-p)))

(ert-deftest ar-ert-virtualenv-append-path-functionp-test-isLD43 ()
  (should (functionp 'virtualenv-append-path)))

(ert-deftest ar-ert-virtualenv-add-to-path-functionp-test-aoWwfD ()
  (should (functionp 'virtualenv-add-to-path)))

(ert-deftest ar-ert-virtualenv-current-functionp-test-mmrSqc ()
  (should (functionp 'virtualenv-current)))

(ert-deftest ar-ert-virtualenv-deactivate-functionp-test-uoLMJM ()
  (should (functionp 'virtualenv-deactivate)))

(ert-deftest ar-ert-virtualenv-activate-functionp-test-YHIx0m ()
  (should (functionp 'virtualenv-activate)))

(ert-deftest ar-ert-virtualenv-p-functionp-test-K2L1hX ()
  (should (functionp 'virtualenv-p)))

(ert-deftest ar-ert-virtualenv-workon-complete-functionp-test-iQBPxx ()
  (should (functionp 'virtualenv-workon-complete)))

(ert-deftest ar-ert-virtualenv-workon-functionp-test-ULMEJ7 ()
  (should (functionp 'virtualenv-workon)))

(ert-deftest ar-ert--beginning-of-block-p-functionp-test-uYUXTH ()
  (should (functionp 'ar--beginning-of-block-p)))

(ert-deftest ar-ert--beginning-of-clause-p-functionp-test-i4xI4h ()
  (should (functionp 'ar--beginning-of-clause-p)))

(ert-deftest ar-ert--beginning-of-block-or-clause-p-functionp-test-A5kVcS ()
  (should (functionp 'ar--beginning-of-block-or-clause-p)))

(ert-deftest ar-ert--beginning-of-def-p-functionp-test-IHvJjs ()
  (should (functionp 'ar--beginning-of-def-p)))

(ert-deftest ar-ert--beginning-of-class-p-functionp-test-olo0n2 ()
  (should (functionp 'ar--beginning-of-class-p)))

(ert-deftest ar-ert--beginning-of-def-or-class-p-functionp-test-IHnaqC ()
  (should (functionp 'ar--beginning-of-def-or-class-p)))

(ert-deftest ar-ert--beginning-of-if-block-p-functionp-test-y4Q3pc ()
  (should (functionp 'ar--beginning-of-if-block-p)))

(ert-deftest ar-ert--beginning-of-try-block-p-functionp-test-Q34spM ()
  (should (functionp 'ar--beginning-of-try-block-p)))

(ert-deftest ar-ert--beginning-of-minor-block-p-functionp-test-Setglm ()
  (should (functionp 'ar--beginning-of-minor-block-p)))

(ert-deftest ar-ert--beginning-of-for-block-p-functionp-test-iESliW ()
  (should (functionp 'ar--beginning-of-for-block-p)))

(ert-deftest ar-ert--beginning-of-top-level-p-functionp-test-WYzTbw ()
  (should (functionp 'ar--beginning-of-top-level-p)))

(ert-deftest ar-ert--beginning-of-expression-p-functionp-test-04H1WF ()
  (should (functionp 'ar--beginning-of-expression-p)))

(ert-deftest ar-ert--beginning-of-partial-expression-p-functionp-test-2Xo5Lf ()
  (should (functionp 'ar--beginning-of-partial-expression-p)))

(ert-deftest ar-ert--beginning-of-block-bol-p-functionp-test-qymzCP ()
  (should (functionp 'ar--beginning-of-block-bol-p)))

(ert-deftest ar-ert--beginning-of-clause-bol-p-functionp-test-KOq7qp ()
  (should (functionp 'ar--beginning-of-clause-bol-p)))

(ert-deftest ar-ert--beginning-of-block-or-clause-bol-p-functionp-test-8MsncZ ()
  (should (functionp 'ar--beginning-of-block-or-clause-bol-p)))

(ert-deftest ar-ert--beginning-of-def-bol-p-functionp-test-I7edYy ()
  (should (functionp 'ar--beginning-of-def-bol-p)))

(ert-deftest ar-ert--beginning-of-class-bol-p-functionp-test-Q3vzdc ()
  (should (functionp 'ar--beginning-of-class-bol-p)))

(ert-deftest ar-ert--beginning-of-def-or-class-bol-p-functionp-test-8wlarP ()
  (should (functionp 'ar--beginning-of-def-or-class-bol-p)))

(ert-deftest ar-ert--beginning-of-if-block-bol-p-functionp-test-Qb4XAs ()
  (should (functionp 'ar--beginning-of-if-block-bol-p)))

(ert-deftest ar-ert--beginning-of-try-block-bol-p-functionp-test-YJuLI5 ()
  (should (functionp 'ar--beginning-of-try-block-bol-p)))

(ert-deftest ar-ert--beginning-of-minor-block-bol-p-functionp-test-UdmcOI ()
  (should (functionp 'ar--beginning-of-minor-block-bol-p)))

(ert-deftest ar-ert--beginning-of-for-block-bol-p-functionp-test-MNH0Ql ()
  (should (functionp 'ar--beginning-of-for-block-bol-p)))

(ert-deftest ar-ert--beginning-of-statement-bol-p-functionp-test-iADzRY ()
  (should (functionp 'ar--beginning-of-statement-bol-p)))

(ert-deftest ar-ert-up-statement-functionp-test-uEtaQB ()
  (should (functionp 'ar-up-statement)))

(ert-deftest ar-ert-down-statement-functionp-test-Se3rMe ()
  (should (functionp 'ar-down-statement)))

(ert-deftest ar-ert-up-base-functionp-test-0wzwJR ()
  (should (functionp 'ar-up-base)))

(ert-deftest ar-ert-down-base-functionp-test-yEH2Du ()
  (should (functionp 'ar-down-base)))

(ert-deftest ar-ert-up-block-functionp-test-GKVsz7 ()
  (should (functionp 'ar-up-block)))

(ert-deftest ar-ert-up-minor-block-functionp-test-mMIwrK ()
  (should (functionp 'ar-up-minor-block)))

(ert-deftest ar-ert-up-def-functionp-test-Ebagjn ()
  (should (functionp 'ar-up-def)))

(ert-deftest ar-ert-up-class-functionp-test-6BD58Z ()
  (should (functionp 'ar-up-class)))

(ert-deftest ar-ert-up-def-or-class-functionp-test-Gmp2ZC ()
  (should (functionp 'ar-up-def-or-class)))

(ert-deftest ar-ert-down-block-functionp-test-Yh7DNf ()
  (should (functionp 'ar-down-block)))

(ert-deftest ar-ert-down-minor-block-functionp-test-kV2dCS ()
  (should (functionp 'ar-down-minor-block)))

(ert-deftest ar-ert-down-def-functionp-test-QVhFnv ()
  (should (functionp 'ar-down-def)))

(ert-deftest ar-ert-down-class-functionp-test-EVzy97 ()
  (should (functionp 'ar-down-class)))

(ert-deftest ar-ert-down-def-or-class-functionp-test-qu08RK ()
  (should (functionp 'ar-down-def-or-class)))

(ert-deftest ar-ert-up-block-bol-functionp-test-aMONyn ()
  (should (functionp 'ar-up-block-bol)))

(ert-deftest ar-ert-up-minor-block-bol-functionp-test-GMNYf0 ()
  (should (functionp 'ar-up-minor-block-bol)))

(ert-deftest ar-ert-up-def-bol-functionp-test-YLt45D ()
  (should (functionp 'ar-up-def-bol)))

(ert-deftest ar-ert-up-class-bol-functionp-test-QFTfSh ()
  (should (functionp 'ar-up-class-bol)))

(ert-deftest ar-ert-up-def-or-class-bol-functionp-test-KYRcDV ()
  (should (functionp 'ar-up-def-or-class-bol)))

(ert-deftest ar-ert-down-block-bol-functionp-test-QLwzlz ()
  (should (functionp 'ar-down-block-bol)))

(ert-deftest ar-ert-down-minor-block-bol-functionp-test-8WYM4c ()
  (should (functionp 'ar-down-minor-block-bol)))

(ert-deftest ar-ert-down-def-bol-functionp-test-Gc9hLQ ()
  (should (functionp 'ar-down-def-bol)))

(ert-deftest ar-ert-down-class-bol-functionp-test-88epqu ()
  (should (functionp 'ar-down-class-bol)))

(ert-deftest ar-ert-down-def-or-class-bol-functionp-test-OEld37 ()
  (should (functionp 'ar-down-def-or-class-bol)))

(ert-deftest ar-ert-kill-clause-functionp-test-cZ6UDL ()
  (should (functionp 'ar-kill-clause)))

(ert-deftest ar-ert-kill-block-or-clause-functionp-test-E7Y9bp ()
  (should (functionp 'ar-kill-block-or-clause)))

(ert-deftest ar-ert-kill-def-functionp-test-kloeI2 ()
  (should (functionp 'ar-kill-def)))

(ert-deftest ar-ert-kill-class-functionp-test-kBRuaG ()
  (should (functionp 'ar-kill-class)))

(ert-deftest ar-ert-kill-def-or-class-functionp-test-Oeb4Dj ()
  (should (functionp 'ar-kill-def-or-class)))

(ert-deftest ar-ert-kill-if-block-functionp-test-oZgn7W ()
  (should (functionp 'ar-kill-if-block)))

(ert-deftest ar-ert-kill-try-block-functionp-test-AdUUwA ()
  (should (functionp 'ar-kill-try-block)))

(ert-deftest ar-ert-kill-minor-block-functionp-test-s5YvXd ()
  (should (functionp 'ar-kill-minor-block)))

(ert-deftest ar-ert-kill-for-block-functionp-test-qcMGkR ()
  (should (functionp 'ar-kill-for-block)))

(ert-deftest ar-ert-kill-top-level-functionp-test-uAAYIu ()
  (should (functionp 'ar-kill-top-level)))

(ert-deftest ar-ert-kill-statement-functionp-test-8uOj47 ()
  (should (functionp 'ar-kill-statement)))

(ert-deftest ar-ert-kill-expression-functionp-test-M1HCqL ()
  (should (functionp 'ar-kill-expression)))

(ert-deftest ar-ert-kill-partial-expression-functionp-test-cZkYKo ()
  (should (functionp 'ar-kill-partial-expression)))

(ert-deftest ar-ert-backward-expression-functionp-test-E7aa21 ()
  (should (functionp 'ar-backward-expression)))

(ert-deftest ar-ert-forward-expression-functionp-test-uqW5jF ()
  (should (functionp 'ar-forward-expression)))

(ert-deftest ar-ert-backward-partial-expression-functionp-test-6Btcph ()
  (should (functionp 'ar-backward-partial-expression)))

(ert-deftest ar-ert-forward-partial-expression-functionp-test-czVnqT ()
  (should (functionp 'ar-forward-partial-expression)))

(ert-deftest ar-ert-backward-line-functionp-test-q4Klqv ()
  (should (functionp 'ar-backward-line)))

(ert-deftest ar-ert-forward-line-functionp-test-6rtLn7 ()
  (should (functionp 'ar-forward-line)))

(ert-deftest ar-ert-backward-statement-functionp-test-Q1S0lJ ()
  (should (functionp 'ar-backward-statement)))

(ert-deftest ar-ert-backward-statement-bol-functionp-test-K2HFhl ()
  (should (functionp 'ar-backward-statement-bol)))

(ert-deftest ar-ert-end-of-statement-functionp-test-yeWNbX ()
  (should (functionp 'ar-forward-statement)))

(ert-deftest ar-ert-end-of-statement-bol-functionp-test-ysqL3y ()
  (should (functionp 'ar-forward-statement-bol)))

(ert-deftest ar-ert-backward-decorator-functionp-test-ob9uTa ()
  (should (functionp 'ar-backward-decorator)))

(ert-deftest ar-ert-end-of-decorator-functionp-test-qqBVGM ()
  (should (functionp 'ar-forward-decorator)))

(ert-deftest ar-ert-forward-line-functionp-test-4Idhro ()
  (should (functionp 'ar-forward-line)))

(ert-deftest ar-ert--go-to-keyword-functionp-test-iE10QB ()
  (should (functionp 'ar--go-to-keyword)))

(ert-deftest ar-ert-leave-comment-or-string-backward-functionp-test-GWv6vd ()
  (should (functionp 'ar-leave-comment-or-string-backward)))

(ert-deftest ar-ert-beginning-of-list-pps-functionp-test-8YgrcP ()
  (should (functionp 'ar-beginning-of-list-pps)))

(ert-deftest ar-ert-forward-into-nomenclature-functionp-test-8WApPq ()
  (should (functionp 'ar-forward-into-nomenclature)))

(ert-deftest ar-ert-backward-into-nomenclature-functionp-test-KWhit2 ()
  (should (functionp 'ar-backward-into-nomenclature)))

(ert-deftest ar-ert--travel-current-indent-functionp-test-CYDb4D ()
  (should (functionp 'ar--travel-current-indent)))

(ert-deftest ar-ert-backward-block-current-column-functionp-test-GUj4Ff ()
  (should (functionp 'ar-backward-block-current-column)))

(ert-deftest ar-ert--end-of-block-p-functionp-test-kJGLdR ()
  (should (functionp 'ar--end-of-block-p)))

(ert-deftest ar-ert--end-of-clause-p-functionp-test-eKXQJs ()
  (should (functionp 'ar--end-of-clause-p)))

(ert-deftest ar-ert--end-of-block-or-clause-p-functionp-test-sTHdh4 ()
  (should (functionp 'ar--end-of-block-or-clause-p)))

(ert-deftest ar-ert--end-of-def-p-functionp-test-qe0qVG ()
  (should (functionp 'ar--end-of-def-p)))

(ert-deftest ar-ert--end-of-class-p-functionp-test-2PYWxj ()
  (should (functionp 'ar--end-of-class-p)))

(ert-deftest ar-ert--end-of-def-or-class-p-functionp-test-SksUaW ()
  (should (functionp 'ar--end-of-def-or-class-p)))

(ert-deftest ar-ert--end-of-if-block-p-functionp-test-EVpfLy ()
  (should (functionp 'ar--end-of-if-block-p)))

(ert-deftest ar-ert--end-of-try-block-p-functionp-test-4O69jb ()
  (should (functionp 'ar--end-of-try-block-p)))

(ert-deftest ar-ert--end-of-minor-block-p-functionp-test-i8HzQN ()
  (should (functionp 'ar--end-of-minor-block-p)))

(ert-deftest ar-ert--end-of-for-block-p-functionp-test-sBTUkq ()
  (should (functionp 'ar--end-of-for-block-p)))

(ert-deftest ar-ert--end-of-top-level-p-functionp-test-ycCUM2 ()
  (should (functionp 'ar--end-of-top-level-p)))

(ert-deftest ar-ert--end-of-statement-p-functionp-test-4EZCcF ()
  (should (functionp 'ar--end-of-statement-p)))

(ert-deftest ar-ert--end-of-expression-p-functionp-test-WSt3zh ()
  (should (functionp 'ar--end-of-expression-p)))

(ert-deftest ar-ert--end-of-block-bol-p-functionp-test-Ok38UT ()
  (should (functionp 'ar--end-of-block-bol-p)))

(ert-deftest ar-ert--end-of-clause-bol-p-functionp-test-ABKWfw ()
  (should (functionp 'ar--end-of-clause-bol-p)))

(ert-deftest ar-ert--end-of-block-or-clause-bol-p-functionp-test-2Z6ox8 ()
  (should (functionp 'ar--end-of-block-or-clause-bol-p)))

(ert-deftest ar-ert--end-of-def-bol-p-functionp-test-w1myPK ()
  (should (functionp 'ar--end-of-def-bol-p)))

(ert-deftest ar-ert--end-of-class-bol-p-functionp-test-8mFy4m ()
  (should (functionp 'ar--end-of-class-bol-p)))

(ert-deftest ar-ert--end-of-def-or-class-bol-p-functionp-test-kdABkZ ()
  (should (functionp 'ar--end-of-def-or-class-bol-p)))

(ert-deftest ar-ert--end-of-if-block-bol-p-functionp-test-a8SixB ()
  (should (functionp 'ar--end-of-if-block-bol-p)))

(ert-deftest ar-ert--end-of-try-block-bol-p-functionp-test-cXvZKd ()
  (should (functionp 'ar--end-of-try-block-bol-p)))

(ert-deftest ar-ert--end-of-minor-block-bol-p-functionp-test-4EHuVP ()
  (should (functionp 'ar--end-of-minor-block-bol-p)))

(ert-deftest ar-ert--end-of-for-block-bol-p-functionp-test-yyf13r ()
  (should (functionp 'ar--end-of-for-block-bol-p)))

(ert-deftest ar-ert--fast-completion-get-completions-functionp-test-uAfhjG ()
  (should (functionp 'ar--fast-completion-get-completions)))

(ert-deftest ar-ert--fast--do-completion-at-point-functionp-test-yQ7QSl ()
  (should (functionp 'ar--fast--do-completion-at-point)))

(ert-deftest ar-ert--fast-complete-base-functionp-test-G0fNq1 ()
  (should (functionp 'ar--fast-complete-base)))

(ert-deftest ar-ert-fast-complete-functionp-test-qGevZG ()
  (should (functionp 'ar-fast-complete)))

(ert-deftest ar-ert-fast-process-functionp-test-GUgmwm ()
  (should (functionp 'ar-fast-process)))

(ert-deftest ar-ert--filter-result-functionp-test-gP5D01 ()
  (should (functionp 'ar--filter-result)))

(ert-deftest ar-ert-fast-send-string-functionp-test-MdJlrH ()
  (should (functionp 'ar-fast-send-string)))

(ert-deftest ar-ert-execute-region-fast-functionp-test-ANrTPm ()
  (should (functionp 'ar-execute-region-fast)))

(ert-deftest ar-ert-execute-statement-fast-functionp-test-sHN6b2 ()
  (should (functionp 'ar-execute-statement-fast)))

(ert-deftest ar-ert-execute-block-fast-functionp-test-uA88vH ()
  (should (functionp 'ar-execute-block-fast)))

(ert-deftest ar-ert-execute-block-or-clause-fast-functionp-test-wb2HNm ()
  (should (functionp 'ar-execute-block-or-clause-fast)))

(ert-deftest ar-ert-execute-def-fast-functionp-test-c9Ko41 ()
  (should (functionp 'ar-execute-def-fast)))

(ert-deftest ar-ert-execute-class-fast-functionp-test-Q19NkH ()
  (should (functionp 'ar-execute-class-fast)))

(ert-deftest ar-ert-execute-def-or-class-fast-functionp-test-w1Fvxm ()
  (should (functionp 'ar-execute-def-or-class-fast)))

(ert-deftest ar-ert-execute-expression-fast-functionp-test-q0PtL1 ()
  (should (functionp 'ar-execute-expression-fast)))

(ert-deftest ar-ert-execute-partial-expression-fast-functionp-test-cZVOWG ()
  (should (functionp 'ar-execute-partial-expression-fast)))

(ert-deftest ar-ert-execute-top-level-fast-functionp-test-kDfj9l ()
  (should (functionp 'ar-execute-top-level-fast)))

(ert-deftest ar-ert-execute-clause-fast-functionp-test-C2cHh1 ()
  (should (functionp 'ar-execute-clause-fast)))

(ert-deftest ar-ert-restore-window-configuration-functionp-test-eyA5qG ()
  (should (functionp 'ar-restore-window-configuration)))

(ert-deftest ar-ert-switch-to-SomeMode-functionp-test-ItywB0 ()
  (should (functionp 'ar-switch-to-SomeMode)))

(ert-deftest ar-ert-force-ar-shell-name-p-on-functionp-test-yud7j3 ()
  (should (functionp 'force-ar-shell-name-p-on)))

(ert-deftest ar-ert-force-ar-shell-name-p-off-functionp-test-wLjToJ ()
  (should (functionp 'force-ar-shell-name-p-off)))

(ert-deftest ar-ert-toggle-split-windows-on-execute-functionp-test-4Yc2pp ()
  (should (functionp 'ar-toggle-split-windows-on-execute)))

(ert-deftest ar-ert-split-windows-on-execute-on-functionp-test-0sUto5 ()
  (should (functionp 'ar-split-windows-on-execute-on)))

(ert-deftest ar-ert-split-windows-on-execute-off-functionp-test-gd12kL ()
  (should (functionp 'ar-split-windows-on-execute-off)))

(ert-deftest ar-ert-toggle-switch-buffers-on-execute-functionp-test-gjxnfr ()
  (should (functionp 'ar-toggle-switch-buffers-on-execute)))

(ert-deftest ar-ert-switch-buffers-on-execute-on-functionp-test-WO9P86 ()
  (should (functionp 'ar-switch-buffers-on-execute-on)))

(ert-deftest ar-ert-switch-buffers-on-execute-off-functionp-test-uA6R1M ()
  (should (functionp 'ar-switch-buffers-on-execute-off)))

(ert-deftest ar-ert-guess-default-SomeMode-functionp-test-kpWDRs ()
  (should (functionp 'ar-guess-default-SomeMode)))

(ert-deftest ar-ert-dirstack-hook-functionp-test-GANaI8 ()
  (should (functionp 'ar-dirstack-hook)))

(ert-deftest ar-ert-set-iSomeMode-completion-command-string-functionp-test-EhfdvO ()
  (should (functionp 'ar-set-iSomeMode-completion-command-string)))

(ert-deftest ar-ert-iSomeMode--module-completion-import-functionp-test-0eLOju ()
  (should (functionp 'ar-iSomeMode--module-completion-import)))

(ert-deftest ar-ert--compose-buffer-name-initials-functionp-test-Ed7S49 ()
  (should (functionp 'ar--compose-buffer-name-initials)))

(ert-deftest ar-ert--remove-home-directory-from-list-functionp-test-8eh9NP ()
  (should (functionp 'ar--remove-home-directory-from-list)))

(ert-deftest ar-ert--choose-buffer-name-functionp-test-K6fFyv ()
  (should (functionp 'ar--choose-buffer-name)))

(ert-deftest ar-ert--jump-to-exception-intern-functionp-test-mwykfb ()
  (should (functionp 'ar--jump-to-exception-intern)))

(ert-deftest ar-ert--jump-to-exception-functionp-test-mgLQTQ ()
  (should (functionp 'ar--jump-to-exception)))

(ert-deftest ar-ert-toggle-split-window-function-functionp-test-sdTVyw ()
  (should (functionp 'ar-toggle-split-window-function)))

(ert-deftest ar-ert--alternative-split-windows-on-execute-function-functionp-test-cBDqBQ ()
  (should (functionp 'ar--alternative-split-windows-on-execute-function)))

(ert-deftest ar-ert--get-splittable-window-functionp-test-2HeUXu ()
  (should (functionp 'ar--get-splittable-window)))

(ert-deftest ar-ert--manage-windows-split-functionp-test-qo7fi9 ()
  (should (functionp 'ar--manage-windows-split)))

(ert-deftest ar-ert--shell-manage-windows-functionp-test-W6QfBN ()
  (should (functionp 'ar--shell-manage-windows)))

(ert-deftest ar-ert-kill-shell-unconditional-functionp-test-mUQTRr ()
  (should (functionp 'ar-kill-shell-unconditional)))

(ert-deftest ar-ert-kill-default-shell-unconditional-functionp-test-eCMg65 ()
  (should (functionp 'ar-kill-default-shell-unconditional)))

(ert-deftest ar-ert--report-executable-functionp-test-cd9riK ()
  (should (functionp 'ar--report-executable)))

(ert-deftest ar-ert--guess-buffer-name-functionp-test-6PTsro ()
  (should (functionp 'ar--guess-buffer-name)))

(ert-deftest ar-ert--configured-shell-functionp-test-Wyo7B2 ()
  (should (functionp 'ar--configured-shell)))

(ert-deftest ar-ert-shell-functionp-test-OQlBTk ()
  (should (functionp 'ar-shell)))

(ert-deftest ar-ert-get-process-functionp-test-0OqP1Y ()
  (should (functionp 'ar--get-process)))

(ert-deftest ar-ert-switch-to-shell-functionp-test-I9gy6C ()
  (should (functionp 'ar-switch-to-shell)))

(ert-deftest ar-ert-execute-file-command-functionp-test-q8Pvch ()
  (should (functionp 'ar-execute-file-command)))

(ert-deftest ar-ert--store-result-functionp-test-CUmPeV ()
  (should (functionp 'ar--store-result)))

(ert-deftest ar-ert--close-execution-functionp-test-8sPofz ()
  (should (functionp 'ar--close-execution)))

(ert-deftest ar-ert--execute-base-functionp-test-8o8ghd ()
  (should (functionp 'ar--execute-base)))

(ert-deftest ar-ert--send-to-fast-process-functionp-test-SsvZeR ()
  (should (functionp 'ar--send-to-fast-process)))

(ert-deftest ar-ert--execute-base-intern-functionp-test-OsfYdv ()
  (should (functionp 'ar--execute-base-intern)))

(ert-deftest ar-ert--execute-buffer-finally-functionp-test-WWFma9 ()
  (should (functionp 'ar--execute-buffer-finally)))

(ert-deftest ar-ert--fetch-error-functionp-test-8km74M ()
  (should (functionp 'ar--fetch-error)))

(ert-deftest ar-ert--fetch-result-functionp-test-SCyeWq ()
  (should (functionp 'ar--fetch-result)))

(ert-deftest ar-ert--execute-ge24.3-functionp-test-qsfpW5 ()
  (should (functionp 'ar--execute-ge24.3)))

(ert-deftest ar-ert-delete-temporary-functionp-test-qaP1TK ()
  (should (functionp 'ar-delete-temporary)))

(ert-deftest ar-ert-execute-SomeMode-mode-v5-functionp-test-S8RoSp ()
  (should (functionp 'ar-execute-SomeMode-mode-v5)))

(ert-deftest ar-ert--insert-offset-lines-functionp-test-mSKiO4 ()
  (should (functionp 'ar--insert-offset-lines)))

(ert-deftest ar-ert--execute-file-base-functionp-test-6NxAIJ ()
  (should (functionp 'ar--execute-file-base)))

(ert-deftest ar-ert-execute-file-functionp-test-WCLGAo ()
  (should (functionp 'ar-execute-file)))

(ert-deftest ar-ert-current-working-directory-functionp-test-OGibq3 ()
  (should (functionp 'ar-current-working-directory)))

(ert-deftest ar-ert--update-execute-directory-intern-functionp-test-QLRLdI ()
  (should (functionp 'ar--update-execute-directory-intern)))

(ert-deftest ar-ert--update-execute-directory-functionp-test-IlF8Ym ()
  (should (functionp 'ar--update-execute-directory)))

(ert-deftest ar-ert-execute-string-functionp-test-YzBQG1 ()
  (should (functionp 'ar-execute-string)))

(ert-deftest ar-ert-execute-string-dedicated-functionp-test-u8D2nG ()
  (should (functionp 'ar-execute-string-dedicated)))

(ert-deftest ar-ert--insert-execute-directory-functionp-test-aAMu6k ()
  (should (functionp 'ar--insert-execute-directory)))

(ert-deftest ar-ert--fix-if-name-main-permission-functionp-test-UbjfLZ ()
  (should (functionp 'ar--fix-if-name-main-permission)))

(ert-deftest ar-ert--fix-start-functionp-test-0u6prE ()
  (should (functionp 'ar--fix-start)))

(ert-deftest ar-ert-execute-import-or-reload-functionp-test-y6CSEX ()
  (should (functionp 'ar-execute-import-or-reload)))

(ert-deftest ar-ert--qualified-module-name-functionp-test-8al8gC ()
  (should (functionp 'ar--qualified-module-name)))

(ert-deftest ar-ert-execute-buffer-functionp-test-uUR5Og ()
  (should (functionp 'ar-execute-buffer)))

(ert-deftest ar-ert-execute-buffer-dedicated-functionp-test-m4vmoV ()
  (should (functionp 'ar-execute-buffer-dedicated)))

(ert-deftest ar-ert-execute-region-SomeMode-functionp-test-g59lNA ()
  (should (functionp 'ar-execute-region-SomeMode)))

(ert-deftest ar-ert-execute-region-SomeMode2-functionp-test-8c7pvI ()
  (should (functionp 'ar-execute-region-SomeMode2)))

(ert-deftest ar-ert-execute-region-SomeMode3-functionp-test-m8bqUP ()
  (should (functionp 'ar-execute-region-SomeMode3)))

(ert-deftest ar-ert-execute-region-iSomeMode-functionp-test-0GyaYW ()
  (should (functionp 'ar-execute-region-iSomeMode)))

(ert-deftest ar-ert-execute-region-jython-functionp-test-eSdxV3 ()
  (should (functionp 'ar-execute-region-jython)))

(ert-deftest ar-ert-process-file-functionp-test-kv2RaS ()
  (should (functionp 'ar-process-file)))

(ert-deftest ar-ert-execute-line-functionp-test-mCIXEz ()
  (should (functionp 'ar-execute-line)))

(ert-deftest ar-ert-remove-overlays-at-point-functionp-test-6n4P9g ()
  (should (functionp 'ar-remove-overlays-at-point)))

(ert-deftest ar-ert--find-next-exception-functionp-test-6ByApn ()
  (should (functionp 'ar--find-next-exception)))

(ert-deftest ar-ert-down-exception-functionp-test-qC0eV5 ()
  (should (functionp 'ar-down-exception)))

(ert-deftest ar-ert-up-exception-functionp-test-GC3HrO ()
  (should (functionp 'ar-up-exception)))

(ert-deftest ar-ert--postprocess-intern-functionp-test-Se7GVw ()
  (should (functionp 'ar--postprocess-intern)))

(ert-deftest ar-ert--find-next-exception-prepare-functionp-test-46iCnf ()
  (should (functionp 'ar--find-next-exception-prepare)))

(ert-deftest ar-ert-SomeMode-functionp-test-eajcNX ()
  (should (functionp 'SomeMode)))

(ert-deftest ar-ert-iSomeMode-functionp-test-IV8taG ()
  (should (functionp 'iSomeMode)))

(ert-deftest ar-ert-SomeMode2-functionp-test-odIsvo ()
  (should (functionp 'SomeMode2)))

(ert-deftest ar-ert-jython-functionp-test-gxxgO6 ()
  (should (functionp 'jython)))

(ert-deftest ar-ert-SomeMode3-functionp-test-WKKq4O ()
  (should (functionp 'SomeMode3)))

(ert-deftest ar-ert-hide-base-functionp-test-CADylx ()
  (should (functionp 'ar-hide-base)))

(ert-deftest ar-ert-hide-show-functionp-test-wHlaCf ()
  (should (functionp 'ar-hide-show)))

(ert-deftest ar-ert-hide-region-functionp-test-a0daPX ()
  (should (functionp 'ar-hide-region)))

(ert-deftest ar-ert-hide-statement-functionp-test-8qzr3F ()
  (should (functionp 'ar-hide-statement)))

(ert-deftest ar-ert-hide-block-functionp-test-Mt3eeo ()
  (should (functionp 'ar-hide-block)))

(ert-deftest ar-ert-hide-block-or-clause-functionp-test-CWnaq6 ()
  (should (functionp 'ar-hide-block-or-clause)))

(ert-deftest ar-ert-hide-def-functionp-test-ENfGyO ()
  (should (functionp 'ar-hide-def)))

(ert-deftest ar-ert-show-all-functionp-test-MpCaIw ()
  (should (functionp 'ar-show-all)))

(ert-deftest ar-ert-show-functionp-test-mQLyOe ()
  (should (functionp 'ar-show)))

(ert-deftest ar-ert-hide-expression-functionp-test-CyPYSW ()
  (should (functionp 'ar-hide-expression)))

(ert-deftest ar-ert-hide-partial-expression-functionp-test-2FvNYE ()
  (should (functionp 'ar-hide-partial-expression)))

(ert-deftest ar-ert-hide-line-functionp-test-qieL0m ()
  (should (functionp 'ar-hide-line)))

(ert-deftest ar-ert-hide-top-level-functionp-test-4yhH04 ()
  (should (functionp 'ar-hide-top-level)))

(ert-deftest ar-ert-copy-statement-functionp-test-wBM90M ()
  (should (functionp 'ar-copy-statement)))

(ert-deftest ar-ert-copy-statement-bol-functionp-test-ugrj0u ()
  (should (functionp 'ar-copy-statement-bol)))

(ert-deftest ar-ert-copy-top-level-functionp-test-mi9RKb ()
  (should (functionp 'ar-copy-top-level)))

(ert-deftest ar-ert-copy-top-level-bol-functionp-test-U7hBtS ()
  (should (functionp 'ar-copy-top-level-bol)))

(ert-deftest ar-ert-copy-block-functionp-test-YVRM9y ()
  (should (functionp 'ar-copy-block)))

(ert-deftest ar-ert-copy-block-bol-functionp-test-e8ePQf ()
  (should (functionp 'ar-copy-block-bol)))

(ert-deftest ar-ert-copy-clause-functionp-test-s1WEvW ()
  (should (functionp 'ar-copy-clause)))

(ert-deftest ar-ert-copy-clause-bol-functionp-test-ukzZ7C ()
  (should (functionp 'ar-copy-clause-bol)))

(ert-deftest ar-ert-copy-block-or-clause-functionp-test-mCTXHj ()
  (should (functionp 'ar-copy-block-or-clause)))

(ert-deftest ar-ert-copy-block-or-clause-bol-functionp-test-8u0If0 ()
  (should (functionp 'ar-copy-block-or-clause-bol)))

(ert-deftest ar-ert-copy-def-functionp-test-kJf4KG ()
  (should (functionp 'ar-copy-def)))

(ert-deftest ar-ert-copy-def-bol-functionp-test-cHP1dn ()
  (should (functionp 'ar-copy-def-bol)))

(ert-deftest ar-ert-copy-class-functionp-test-cXEPH3 ()
  (should (functionp 'ar-copy-class)))

(ert-deftest ar-ert-copy-class-bol-functionp-test-0mgcbK ()
  (should (functionp 'ar-copy-class-bol)))

(ert-deftest ar-ert-copy-def-or-class-functionp-test-WAnhBq ()
  (should (functionp 'ar-copy-def-or-class)))

(ert-deftest ar-ert-copy-def-or-class-bol-functionp-test-Oiz216 ()
  (should (functionp 'ar-copy-def-or-class-bol)))

(ert-deftest ar-ert-copy-expression-functionp-test-OiKnpN ()
  (should (functionp 'ar-copy-expression)))

(ert-deftest ar-ert-copy-expression-bol-functionp-test-U5sYNt ()
  (should (functionp 'ar-copy-expression-bol)))

(ert-deftest ar-ert-copy-partial-expression-functionp-test-EZCu99 ()
  (should (functionp 'ar-copy-partial-expression)))

(ert-deftest ar-ert-copy-partial-expression-bol-functionp-test-6dY2sQ ()
  (should (functionp 'ar-copy-partial-expression-bol)))

(ert-deftest ar-ert-copy-minor-block-functionp-test-IRVZNw ()
  (should (functionp 'ar-copy-minor-block)))

(ert-deftest ar-ert-copy-minor-block-bol-functionp-test-EtRA4c ()
  (should (functionp 'ar-copy-minor-block-bol)))

(ert-deftest ar-ert-statement-functionp-test-wjtFjT ()
  (should (functionp 'ar-statement)))

(ert-deftest ar-ert-top-level-functionp-test-eYNgzz ()
  (should (functionp 'ar-top-level)))

(ert-deftest ar-ert-block-functionp-test-OeKcNf ()
  (should (functionp 'ar-block)))

(ert-deftest ar-ert-clause-functionp-test-4yDH7W ()
  (should (functionp 'ar-clause)))

(ert-deftest ar-ert-block-or-clause-functionp-test-g7cGqE ()
  (should (functionp 'ar-block-or-clause)))

(ert-deftest ar-ert-def-functionp-test-oNjjHl ()
  (should (functionp 'ar-def)))

(ert-deftest ar-ert-class-functionp-test-2lYPY2 ()
  (should (functionp 'ar-class)))

(ert-deftest ar-ert-def-or-class-functionp-test-8MvOdK ()
  (should (functionp 'ar-def-or-class)))

(ert-deftest ar-ert-expression-functionp-test-i8i9qr ()
  (should (functionp 'ar-expression)))

(ert-deftest ar-ert-partial-expression-functionp-test-25EmC8 ()
  (should (functionp 'ar-partial-expression)))

(ert-deftest ar-ert-minor-block-functionp-test-QxDmIP ()
  (should (functionp 'ar-minor-block)))

(ert-deftest ar-ert-copy-statement-functionp-test-ik7wzB ()
  (should (functionp 'ar-copy-statement)))

(ert-deftest ar-ert-copy-top-level-functionp-test-wXsdti ()
  (should (functionp 'ar-copy-top-level)))

(ert-deftest ar-ert-copy-block-functionp-test-25nunZ ()
  (should (functionp 'ar-copy-block)))

(ert-deftest ar-ert-copy-clause-functionp-test-cPdyeG ()
  (should (functionp 'ar-copy-clause)))

(ert-deftest ar-ert-copy-block-or-clause-functionp-test-wvfq7m ()
  (should (functionp 'ar-copy-block-or-clause)))

(ert-deftest ar-ert-copy-def-functionp-test-iY0UW3 ()
  (should (functionp 'ar-copy-def)))

(ert-deftest ar-ert-copy-class-functionp-test-OA9MMK ()
  (should (functionp 'ar-copy-class)))

(ert-deftest ar-ert-copy-def-or-class-functionp-test-Qz39yr ()
  (should (functionp 'ar-copy-def-or-class)))

(ert-deftest ar-ert-copy-expression-functionp-test-637Vm8 ()
  (should (functionp 'ar-copy-expression)))

(ert-deftest ar-ert-copy-partial-expression-functionp-test-yGLJES ()
  (should (functionp 'ar-copy-partial-expression)))

(ert-deftest ar-ert-copy-minor-block-functionp-test-QHuuTC ()
  (should (functionp 'ar-copy-minor-block)))

(ert-deftest ar-ert-delete-statement-functionp-test-esFW8m ()
  (should (functionp 'ar-delete-statement)))

(ert-deftest ar-ert-delete-top-level-functionp-test-0wKfm7 ()
  (should (functionp 'ar-delete-top-level)))

(ert-deftest ar-ert-delete-block-functionp-test-aeVCvR ()
  (should (functionp 'ar-delete-block)))

(ert-deftest ar-ert-delete-clause-functionp-test-mO7CDB ()
  (should (functionp 'ar-delete-clause)))

(ert-deftest ar-ert-delete-block-or-clause-functionp-test-Y5ZeMl ()
  (should (functionp 'ar-delete-block-or-clause)))

(ert-deftest ar-ert-delete-def-functionp-test-MRygS5 ()
  (should (functionp 'ar-delete-def)))

(ert-deftest ar-ert-delete-class-functionp-test-4GtQWP ()
  (should (functionp 'ar-delete-class)))

(ert-deftest ar-ert-delete-def-or-class-functionp-test-8S1UYz ()
  (should (functionp 'ar-delete-def-or-class)))

(ert-deftest ar-ert-delete-expression-functionp-test-emWEYj ()
  (should (functionp 'ar-delete-expression)))

(ert-deftest ar-ert-delete-partial-expression-functionp-test-aEjFU3 ()
  (should (functionp 'ar-delete-partial-expression)))

(ert-deftest ar-ert-delete-minor-block-functionp-test-cjBlON ()
  (should (functionp 'ar-delete-minor-block)))

(ert-deftest ar-ert-fill-labelled-string-functionp-test-ysNVft ()
  (should (functionp 'ar-fill-labelled-string)))

(ert-deftest ar-ert--in-or-behind-or-before-a-docstring-functionp-test-I15y0d ()
  (should (functionp 'ar--in-or-behind-or-before-a-docstring)))

(ert-deftest ar-ert--string-fence-delete-spaces-functionp-test-GQjALY ()
  (should (functionp 'ar--string-fence-delete-spaces)))

(ert-deftest ar-ert--fill-fix-end-functionp-test-M5IhuJ ()
  (should (functionp 'ar--fill-fix-end)))

(ert-deftest ar-ert-insert-default-shebang-functionp-test-kvspuZ ()
  (should (functionp 'ar-insert-default-shebang)))

(ert-deftest ar-ert--top-level-form-p-functionp-test-qmv1WJ ()
  (should (functionp 'ar--top-level-form-p)))

(ert-deftest ar-ert-indent-line-outmost-functionp-test-8kO6mu ()
  (should (functionp 'ar-indent-line-outmost)))

(ert-deftest ar-ert--indent-fix-region-intern-functionp-test-kHXuOe ()
  (should (functionp 'ar--indent-fix-region-intern)))

(ert-deftest ar-ert--indent-line-intern-functionp-test-qsB1bZ ()
  (should (functionp 'ar--indent-line-intern)))

(ert-deftest ar-compute-comment-indentation-functionp-test-27PIAJ ()
  (should (functionp 'ar-compute-comment-indentation)))

(ert-deftest ar-ert--calculate-indent-backwards-functionp-test-0YyrWt ()
  (should (functionp 'ar--calculate-indent-backwards)))

(ert-deftest ar-ert-indent-line-functionp-test-COMfie ()
  (should (functionp 'ar-indent-line)))

(ert-deftest ar-ert--delete-trailing-whitespace-functionp-test-G8ytCY ()
  (should (functionp 'ar--delete-trailing-whitespace)))

(ert-deftest ar-ert-newline-and-indent-functionp-test-wJrUIH ()
  (should (functionp 'ar-newline-and-indent)))

(ert-deftest ar-ert-newline-and-dedent-functionp-test-Q5uGPq ()
  (should (functionp 'ar-newline-and-dedent)))

(ert-deftest ar-ert-toggle-indent-tabs-mode-functionp-test-mmCbT9 ()
  (should (functionp 'ar-toggle-indent-tabs-mode)))

(ert-deftest ar-ert-indent-tabs-mode-functionp-test-UXbUUS ()
  (should (functionp 'ar-indent-tabs-mode)))

(ert-deftest ar-ert-indent-tabs-mode-on-functionp-test-0sxfXB ()
  (should (functionp 'ar-indent-tabs-mode-on)))

(ert-deftest ar-ert-indent-tabs-mode-off-functionp-test-QNLdXk ()
  (should (functionp 'ar-indent-tabs-mode-off)))

(ert-deftest ar-ert-guessed-sanity-check-functionp-test-YTHIV3 ()
  (should (functionp 'ar-guessed-sanity-check)))

(ert-deftest ar-ert--guess-indent-final-functionp-test-m8bNNM ()
  (should (functionp 'ar--guess-indent-final)))

(ert-deftest ar-ert--guess-indent-forward-functionp-test-wLmDDv ()
  (should (functionp 'ar--guess-indent-forward)))

(ert-deftest ar-ert--guess-indent-backward-functionp-test-eYOlre ()
  (should (functionp 'ar--guess-indent-backward)))

(ert-deftest ar-ert-guess-indent-offset-functionp-test-eQPLcX ()
  (should (functionp 'ar-guess-indent-offset)))

(ert-deftest ar-ert-backward-paragraph-functionp-test-uaQLCo ()
  (should (functionp 'ar-backward-paragraph)))

(ert-deftest ar-ert-end-of-paragraph-functionp-test-K6idh7 ()
  (should (functionp 'ar-forward-paragraph)))

(ert-deftest ar-ert-indent-and-forward-functionp-test-sPLxWP ()
  (should (functionp 'ar-indent-and-forward)))

(ert-deftest ar-ert-indent-region-functionp-test-m2Uhzy ()
  (should (functionp 'ar-indent-region)))

(ert-deftest ar-ert-backward-declarations-functionp-test-cH5qch ()
  (should (functionp 'ar-backward-declarations)))

(ert-deftest ar-ert-end-of-declarations-functionp-test-0UohMZ ()
  (should (functionp 'ar-forward-declarations)))

(ert-deftest ar-ert-declarations-functionp-test-oDkanI ()
  (should (functionp 'ar-declarations)))

(ert-deftest ar-ert-kill-declarations-functionp-test-S6uLUq ()
  (should (functionp 'ar-kill-declarations)))

(ert-deftest ar-ert-backward-statements-functionp-test-C40dt9 ()
  (should (functionp 'ar-backward-statements)))

(ert-deftest ar-ert-end-of-statements-functionp-test-iCSn9S ()
  (should (functionp 'ar-forward-statements)))

(ert-deftest ar-ert-statements-functionp-test-ITJBQC ()
  (should (functionp 'ar-statements)))

(ert-deftest ar-ert-kill-statements-functionp-test-IjGQvm ()
  (should (functionp 'ar-kill-statements)))

(ert-deftest ar-ert--join-words-wrapping-functionp-test-iEmb75 ()
  (should (functionp 'ar--join-words-wrapping)))

(ert-deftest ar-ert-insert-super-functionp-test-gd4NJP ()
  (should (functionp 'ar-insert-super)))

(ert-deftest ar-ert-comment-region-functionp-test-icyVkz ()
  (should (functionp 'ar-comment-region)))

(ert-deftest ar-ert-delete-comments-in-def-or-class-functionp-test-usc5Ri ()
  (should (functionp 'ar-delete-comments-in-def-or-class)))

(ert-deftest ar-ert-delete-comments-in-class-functionp-test-2rUFm2 ()
  (should (functionp 'ar-delete-comments-in-class)))

(ert-deftest ar-ert-delete-comments-in-block-functionp-test-wbPSPL ()
  (should (functionp 'ar-delete-comments-in-block)))

(ert-deftest ar-ert-delete-comments-in-region-functionp-test-oH4wgv ()
  (should (functionp 'ar-delete-comments-in-region)))

(ert-deftest ar-ert--delete-comments-intern-functionp-test-UfVOHe ()
  (should (functionp 'ar--delete-comments-intern)))

(ert-deftest ar-ert-update-gud-pdb-history-functionp-test-0qkZ6X ()
  (should (functionp 'ar-update-gud-pdb-history)))

(ert-deftest ar-ert--pdbtrack-overlay-arrow-functionp-test-4KuxtH ()
  (should (functionp 'ar--pdbtrack-overlay-arrow)))

(ert-deftest ar-ert--pdbtrack-track-stack-file-functionp-test-eszLNq ()
  (should (functionp 'ar--pdbtrack-track-stack-file)))

(ert-deftest ar-ert--pdbtrack-map-filename-functionp-test-YNf959 ()
  (should (functionp 'ar--pdbtrack-map-filename)))

(ert-deftest ar-ert--pdbtrack-get-source-buffer-functionp-test-e0aTkT ()
  (should (functionp 'ar--pdbtrack-get-source-buffer)))

(ert-deftest ar-ert--pdbtrack-grub-for-buffer-functionp-test-mIOoBC ()
  (should (functionp 'ar--pdbtrack-grub-for-buffer)))

(ert-deftest ar-ert-pdbtrack-toggle-stack-tracking-functionp-test-QzTEOl ()
  (should (functionp 'ar-pdbtrack-toggle-stack-tracking)))

(ert-deftest ar-ert-turn-on-pdbtrack-functionp-test-SoQ524 ()
  (should (functionp 'turn-on-pdbtrack)))

(ert-deftest ar-ert-turn-off-pdbtrack-functionp-test-gRH8dO ()
  (should (functionp 'turn-off-pdbtrack)))

(ert-deftest ar-ert-execute-statement-pdb-functionp-test-WQb3px ()
  (should (functionp 'ar-execute-statement-pdb)))

(ert-deftest ar-ert-execute-region-pdb-functionp-test-GsuQxg ()
  (should (functionp 'ar-execute-region-pdb)))

(ert-deftest ar-ert-pdb-execute-statement-functionp-test-cR3HGZ ()
  (should (functionp 'ar-pdb-execute-statement)))

(ert-deftest ar-ert-pdb-help-functionp-test-ALfsiM ()
  (should (functionp 'ar-pdb-help)))

;; (ert-deftest ar-ert-pdb-break-functionp-test ()
;;   (should (functionp 'ar-pdb-break)))

(ert-deftest ar-ert-end-of-block-functionp-test-8IwzSy ()
  (should (functionp 'ar-forward-block)))

(ert-deftest ar-ert-end-of-block-bol-functionp-test-qkEVsl ()
  (should (functionp 'ar-forward-block-bol)))

(ert-deftest ar-ert-end-of-clause-functionp-test-wVit17 ()
  (should (functionp 'ar-forward-clause)))

(ert-deftest ar-ert-end-of-clause-bol-functionp-test-OQo3vU ()
  (should (functionp 'ar-forward-clause-bol)))

(ert-deftest ar-ert-end-of-block-or-clause-functionp-test-21doZG ()
  (should (functionp 'ar-forward-block-or-clause)))

(ert-deftest ar-ert-end-of-block-or-clause-bol-functionp-test-ElVbtt ()
  (should (functionp 'ar-forward-block-or-clause-bol)))

(ert-deftest ar-ert-end-of-def-functionp-test-CoGqUf ()
  (should (functionp 'ar-forward-def)))

(ert-deftest ar-ert-end-of-def-bol-functionp-test-MtHuj2 ()
  (should (functionp 'ar-forward-def-bol)))

(ert-deftest ar-ert-end-of-class-functionp-test-aeS4GO ()
  (should (functionp 'ar-forward-class)))

(ert-deftest ar-ert-end-of-class-bol-functionp-test-u6zj2A ()
  (should (functionp 'ar-forward-class-bol)))

(ert-deftest ar-ert-end-of-def-or-class-functionp-test-Mb9tln ()
  (should (functionp 'ar-forward-def-or-class)))

(ert-deftest ar-ert-end-of-def-or-class-bol-functionp-test-0SIaC9 ()
  (should (functionp 'ar-forward-def-or-class-bol)))

(ert-deftest ar-ert-end-of-if-block-functionp-test-cH0XPV ()
  (should (functionp 'ar-forward-if-block)))

(ert-deftest ar-ert-end-of-if-block-bol-functionp-test-6fR60H ()
  (should (functionp 'ar-forward-if-block-bol)))

(ert-deftest ar-ert-end-of-try-block-functionp-test-2tEddu ()
  (should (functionp 'ar-forward-try-block)))

(ert-deftest ar-ert-end-of-try-block-bol-functionp-test-Ip8Qlg ()
  (should (functionp 'ar-forward-try-block-bol)))

(ert-deftest ar-ert-end-of-minor-block-functionp-test-IhN7t2 ()
  (should (functionp 'ar-forward-minor-block)))

(ert-deftest ar-ert-end-of-minor-block-bol-functionp-test-eywqDO ()
  (should (functionp 'ar-forward-minor-block-bol)))

(ert-deftest ar-ert-end-of-for-block-functionp-test-OwdrJA ()
  (should (functionp 'ar-forward-for-block)))

(ert-deftest ar-ert-end-of-for-block-bol-functionp-test-OU8zNm ()
  (should (functionp 'ar-forward-for-block-bol)))

(ert-deftest ar-ert-end-of-except-block-functionp-test-U3yHS8 ()
  (should (functionp 'ar-forward-except-block)))

(ert-deftest ar-ert-end-of-except-block-bol-functionp-test-CM3k5V ()
  (should (functionp 'ar-forward-except-block-bol)))

(ert-deftest ar-ert-execute-statement-functionp-test-2DHCiJ ()
  (should (functionp 'ar-execute-statement)))

(ert-deftest ar-ert-execute-block-functionp-test-kznPtw ()
  (should (functionp 'ar-execute-block)))

(ert-deftest ar-ert-execute-block-or-clause-functionp-test-6LufBj ()
  (should (functionp 'ar-execute-block-or-clause)))

(ert-deftest ar-ert-execute-def-functionp-test-QdwSG6 ()
  (should (functionp 'ar-execute-def)))

(ert-deftest ar-ert-execute-class-functionp-test-8yj8MT ()
  (should (functionp 'ar-execute-class)))

(ert-deftest ar-ert-execute-def-or-class-functionp-test-W0JWRG ()
  (should (functionp 'ar-execute-def-or-class)))

(ert-deftest ar-ert-execute-expression-functionp-test-gLPHSt ()
  (should (functionp 'ar-execute-expression)))

(ert-deftest ar-ert-execute-partial-expression-functionp-test-iguOQg ()
  (should (functionp 'ar-execute-partial-expression)))

(ert-deftest ar-ert-execute-top-level-functionp-test-qKIyN3 ()
  (should (functionp 'ar-execute-top-level)))

(ert-deftest ar-ert-execute-clause-functionp-test-aUMbIQ ()
  (should (functionp 'ar-execute-clause)))

(ert-deftest ar-ert-toggle-smart-indentation-functionp-test-AjIzAD ()
  (should (functionp 'ar-toggle-smart-indentation)))

(ert-deftest ar-ert-smart-indentation-on-functionp-test-CSWHqq ()
  (should (functionp 'ar-smart-indentation-on)))

(ert-deftest ar-ert-smart-indentation-off-functionp-test-gzrjed ()
  (should (functionp 'ar-smart-indentation-off)))

(ert-deftest ar-ert-toggle-sexp-function-functionp-test-ymnQYZ ()
  (should (functionp 'ar-toggle-sexp-function)))

;; (ert-deftest ar-ert-toggle-autopair-mode-functionp-test-i4umLM ()
;;   (should (functionp 'ar-toggle-autopair-mode)))

;; (ert-deftest ar-ert-autopair-mode-on-functionp-test-GOXfuz ()
;;   (should (functionp 'ar-autopair-mode-on)))

;; (ert-deftest ar-ert-autopair-mode-off-functionp-test-cpfpem ()
;;   (should (functionp 'ar-autopair-mode-off)))

(ert-deftest ar-ert-switch-buffers-on-execute-p-on-functionp-test-2hUpEV ()
  (should (functionp 'ar-switch-buffers-on-execute-p-on)))

(ert-deftest ar-ert-switch-buffers-on-execute-p-off-functionp-test-ikuTiI ()
  (should (functionp 'ar-switch-buffers-on-execute-p-off)))

(ert-deftest ar-ert-split-window-on-execute-on-functionp-test-MbK0pg ()
  (should (functionp 'ar-split-window-on-execute-on)))

(ert-deftest ar-ert-split-window-on-execute-off-functionp-test-Co4jS1 ()
  (should (functionp 'ar-split-window-on-execute-off)))

(ert-deftest ar-ert-fontify-shell-buffer-p-on-functionp-test-O8aUEy ()
  (should (functionp 'ar-fontify-shell-buffer-p-on)))

(ert-deftest ar-ert-fontify-shell-buffer-p-off-functionp-test-yijvZj ()
  (should (functionp 'ar-fontify-shell-buffer-p-off)))

(ert-deftest ar-ert-jump-on-exception-on-functionp-test-iqoFl8 ()
  (should (functionp 'ar-jump-on-exception-on)))

(ert-deftest ar-ert-jump-on-exception-off-functionp-test-C4mwuT ()
  (should (functionp 'ar-jump-on-exception-off)))

(ert-deftest ar-ert-use-current-dir-when-execute-p-on-functionp-test-OA44Gp ()
  (should (functionp 'ar-use-current-dir-when-execute-p-on)))

(ert-deftest ar-ert-use-current-dir-when-execute-p-off-functionp-test-OSeJMa ()
  (should (functionp 'ar-use-current-dir-when-execute-p-off)))

(ert-deftest ar-ert-electric-comment-p-on-functionp-test-wLrwRG ()
  (should (functionp 'ar-electric-comment-p-on)))

(ert-deftest ar-ert-electric-comment-p-off-functionp-test-4EG3Qr ()
  (should (functionp 'ar-electric-comment-p-off)))

(ert-deftest ar-ert-underscore-word-syntax-p-on-functionp-test-6N2HPX ()
  (should (functionp 'ar-underscore-word-syntax-p-on)))

(ert-deftest ar-ert-underscore-word-syntax-p-off-functionp-test-olSdLI ()
  (should (functionp 'ar-underscore-word-syntax-p-off)))

(ert-deftest ar-ert-backward-block-functionp-test-m4IcIt ()
  (should (functionp 'ar-backward-block)))

(ert-deftest ar-ert-backward-clause-functionp-test-KYsoBe ()
  (should (functionp 'ar-backward-clause)))

(ert-deftest ar-ert-backward-block-or-clause-functionp-test-m0a9C0 ()
  (should (functionp 'ar-backward-block-or-clause)))

(ert-deftest ar-ert-backward-def-functionp-test-i4cmFM ()
  (should (functionp 'ar-backward-def)))

(ert-deftest ar-ert-backward-class-functionp-test-wnqXFy ()
  (should (functionp 'ar-backward-class)))

(ert-deftest ar-ert-backward-def-or-class-functionp-test-8kMTCk ()
  (should (functionp 'ar-backward-def-or-class)))

(ert-deftest ar-ert-backward-if-block-functionp-test-67k6x6 ()
  (should (functionp 'ar-backward-if-block)))

(ert-deftest ar-ert-backward-try-block-functionp-test-mypJqS ()
  (should (functionp 'ar-backward-try-block)))

(ert-deftest ar-ert-backward-minor-block-functionp-test-wzg9gE ()
  (should (functionp 'ar-backward-minor-block)))

(ert-deftest ar-ert-backward-for-block-functionp-test-6Njj8p ()
  (should (functionp 'ar-backward-for-block)))

(ert-deftest ar-ert-backward-except-block-functionp-test-WabjXb ()
  (should (functionp 'ar-backward-except-block)))

(ert-deftest ar-ert-backward-block-bol-functionp-test-C2g5JX ()
  (should (functionp 'ar-backward-block-bol)))

(ert-deftest ar-ert-backward-clause-bol-functionp-test-wtnyuJ ()
  (should (functionp 'ar-backward-clause-bol)))

(ert-deftest ar-ert-backward-block-or-clause-bol-functionp-test-OQNz9u ()
  (should (functionp 'ar-backward-block-or-clause-bol)))

(ert-deftest ar-ert-backward-def-bol-functionp-test-0I7OPg ()
  (should (functionp 'ar-backward-def-bol)))

(ert-deftest ar-ert-backward-class-bol-functionp-test-U7UKv2 ()
  (should (functionp 'ar-backward-class-bol)))

(ert-deftest ar-ert-backward-def-or-class-bol-functionp-test-8yMS7N ()
  (should (functionp 'ar-backward-def-or-class-bol)))

(ert-deftest ar-ert-backward-if-block-bol-functionp-test-IFR9Kz ()
  (should (functionp 'ar-backward-if-block-bol)))

(ert-deftest ar-ert-backward-try-block-bol-functionp-test-ozeqll ()
  (should (functionp 'ar-backward-try-block-bol)))

(ert-deftest ar-ert-backward-minor-block-bol-functionp-test-00LUW6 ()
  (should (functionp 'ar-backward-minor-block-bol)))

(ert-deftest ar-ert-backward-for-block-bol-functionp-test-sNiOuS ()
  (should (functionp 'ar-backward-for-block-bol)))

(ert-deftest ar-ert-backward-except-block-bol-functionp-test-I3PK0D ()
  (should (functionp 'ar-backward-except-block-bol)))

(ert-deftest ar-ert-toggle-comment-auto-fill-functionp-test-4Cr5xp ()
  (should (functionp 'ar-toggle-comment-auto-fill)))

(ert-deftest ar-ert-comment-auto-fill-on-functionp-test-uQUz1a ()
  (should (functionp 'ar-comment-auto-fill-on)))

(ert-deftest ar-ert-comment-auto-fill-off-functionp-test-UVllZZ ()
  (should (functionp 'ar-comment-auto-fill-off)))

(ert-deftest ar-ert-backward-elif-block-functionp-test-m89EXO ()
  (should (functionp 'ar-backward-elif-block)))

(ert-deftest ar-ert-backward-else-block-functionp-test-gj0fUD ()
  (should (functionp 'ar-backward-else-block)))

(ert-deftest ar-ert-backward-elif-block-bol-functionp-test-wx8LMs ()
  (should (functionp 'ar-backward-elif-block-bol)))

(ert-deftest ar-ert-backward-else-block-bol-functionp-test-4oMICh ()
  (should (functionp 'ar-backward-else-block-bol)))

(ert-deftest ar-ert-indent-forward-line-functionp-test-sRNgr6 ()
  (should (functionp 'ar-indent-forward-line)))

(ert-deftest ar-ert-dedent-forward-line-functionp-test-IPhkdV ()
  (should (functionp 'ar-dedent-forward-line)))

(ert-deftest ar-ert-dedent-functionp-test-2BSUWJ ()
  (should (functionp 'ar-dedent)))

(ert-deftest ar-ert--close-intern-functionp-test-OU4bFy ()
  (should (functionp 'ar--close-intern)))

(ert-deftest ar-ert-close-def-functionp-test-aqcMhn ()
  (should (functionp 'ar-close-def)))

(ert-deftest ar-ert-close-class-functionp-test-esN2Tb ()
  (should (functionp 'ar-close-class)))

(ert-deftest ar-ert-close-block-functionp-test-aqe8s0 ()
  (should (functionp 'ar-close-block)))

(ert-deftest ar-ert-class-at-point-functionp-test-KycHZO ()
  (should (functionp 'ar-class-at-point)))

(ert-deftest ar-ert-ar-match-paren-mode-functionp-test-y8e7wD ()
  (should (functionp 'ar-match-paren-mode)))

(ert-deftest ar-ert-ar-match-paren-functionp-test-eu8e4r ()
  (should (functionp 'ar-match-paren)))

(ert-deftest ar-ert-pst-here-functionp-test-KE7U14 ()
  (should (functionp 'pst-here)))

(ert-deftest ar-ert-printform-insert-functionp-test-IdTTsT ()
  (should (functionp 'ar-printform-insert)))

(ert-deftest ar-ert-line-to-printform-SomeMode2-functionp-test-oZT4UH ()
  (should (functionp 'ar-line-to-printform-SomeMode2)))

(ert-deftest ar-ert-end-of-elif-block-functionp-test-YtomSl ()
  (should (functionp 'ar-forward-elif-block)))

(ert-deftest ar-ert-end-of-elif-block-bol-functionp-test-6pREqb ()
  (should (functionp 'ar-forward-elif-block-bol)))

(ert-deftest ar-ert-end-of-else-block-functionp-test-2RnhX0 ()
  (should (functionp 'ar-forward-else-block)))

(ert-deftest ar-ert-end-of-else-block-bol-functionp-test-gnNDqQ ()
  (should (functionp 'ar-forward-else-block-bol)))

(ert-deftest ar-ert-mark-paragraph-functionp-test-wv6GUF ()
  (should (functionp 'ar-mark-paragraph)))

(ert-deftest ar-ert-mark-block-functionp-test-iCQcmv ()
  (should (functionp 'ar-mark-block)))

(ert-deftest ar-ert-mark-minor-block-functionp-test-Epf9Lk ()
  (should (functionp 'ar-mark-minor-block)))

(ert-deftest ar-ert-mark-clause-functionp-test-YFDX79 ()
  (should (functionp 'ar-mark-clause)))

(ert-deftest ar-ert-mark-block-or-clause-functionp-test-OybtsZ ()
  (should (functionp 'ar-mark-block-or-clause)))

(ert-deftest ar-ert-mark-def-functionp-test-kFxsKO ()
  (should (functionp 'ar-mark-def)))

(ert-deftest ar-ert-mark-class-functionp-test-GCFf3D ()
  (should (functionp 'ar-mark-class)))

(ert-deftest ar-ert-mark-def-or-class-functionp-test-Kkmojt ()
  (should (functionp 'ar-mark-def-or-class)))

(ert-deftest ar-ert-mark-line-functionp-test-kz3oxi ()
  (should (functionp 'ar-mark-line)))

(ert-deftest ar-ert-mark-statement-functionp-test-ewA7I7 ()
  (should (functionp 'ar-mark-statement)))

(ert-deftest ar-ert-mark-comment-functionp-test-SMtkSW ()
  (should (functionp 'ar-mark-comment)))

(ert-deftest ar-ert-mark-top-level-functionp-test-YtPoZL ()
  (should (functionp 'ar-mark-top-level)))

(ert-deftest ar-ert-mark-partial-expression-functionp-test-wDGB4A ()
  (should (functionp 'ar-mark-partial-expression)))

(ert-deftest ar-ert-mark-expression-functionp-test-mMk05p ()
  (should (functionp 'ar-mark-expression)))

(ert-deftest ar-ert--kill-emacs-hook-functionp-test-Q7Op9e ()
  (should (functionp 'ar--kill-emacs-hook)))

(ert-deftest ar-ert-SomeMode-version-functionp-test-Cs6083 ()
  (should (functionp 'ar-SomeMode-version)))

(ert-deftest ar-ert-version-functionp-test-GSzT9S ()
  (should (functionp 'ar-version)))

(ert-deftest ar-ert-load-file-functionp-test-6jBlYv ()
  (should (functionp 'ar-load-file)))

(ert-deftest ar-ert-proc-functionp-test-y8qUIj ()
  (should (functionp 'ar-proc)))

(ert-deftest ar-ert-guess-pdb-path-functionp-test-WQvRcV ()
  (should (functionp 'ar-guess-pdb-path)))

(ert-deftest ar-ert-toggle-local-default-use-functionp-test-imh2VI ()
  (should (functionp 'ar-toggle-local-default-use)))

(ert-deftest ar-ert--set-auto-fill-values-functionp-test-EnQdgk ()
  (should (functionp 'ar--set-auto-fill-values)))

(ert-deftest ar-ert--run-auto-fill-timer-functionp-test-SM8FR7 ()
  (should (functionp 'ar--run-auto-fill-timer)))

(ert-deftest ar-ert-complete-auto-functionp-test-iybItV ()
  (should (functionp 'ar-complete-auto)))

(ert-deftest ar-ert-emacs-version-greater-23-functionp-test-AnhhAw ()
  (should (functionp 'ar---emacs-version-greater-23)))

(ert-deftest ar-ert-symbol-at-point-functionp-test-8YC24j ()
  (should (functionp 'ar-symbol-at-point)))

(ert-deftest ar-ert-kill-buffer-unconditional-functionp-test-IlOkx7 ()
  (should (functionp 'ar-kill-buffer-unconditional)))

(ert-deftest ar-ert--line-backward-maybe-functionp-test-oBqrXU ()
  (should (functionp 'ar--line-backward-maybe)))

(ert-deftest ar-ert--after-empty-line-functionp-test-aeXdlI ()
  (should (functionp 'ar--after-empty-line)))

(ert-deftest ar-ert-compute-indentation-functionp-test-sRXJGv ()
  (should (functionp 'ar-compute-indentation)))

(ert-deftest ar-ert--ar--fetch-indent-statement-above-functionp-test-Yzv5Zi ()
  (should (functionp 'ar--fetch-indent-statement-above)))

(ert-deftest ar-ert-continuation-offset-functionp-test-gFGVg6 ()
  (should (functionp 'ar-continuation-offset)))

(ert-deftest ar-ert-indentation-of-statement-functionp-test-O60wxT ()
  (should (functionp 'ar-indentation-of-statement)))

(ert-deftest ar-ert--in-comment-p-functionp-test-kBdXOG ()
  (should (functionp 'ar--in-comment-p)))

(ert-deftest ar-ert-in-triplequoted-string-p-functionp-test-UNn52t ()
  (should (functionp 'ar-in-triplequoted-string-p)))

(ert-deftest ar-ert-in-string-p-functionp-test-QLUbjh ()
  (should (functionp 'ar-in-string-p)))

(ert-deftest ar-ert-backward-top-level-functionp-test-CqtW4T ()
  (should (functionp 'ar-backward-top-level)))

(ert-deftest ar-ert--beginning-of-line-p-functionp-test-cDLgpI ()
  (should (functionp 'ar--beginning-of-line-p)))

(ert-deftest ar-ert--beginning-of-buffer-p-functionp-test-MZiYKw ()
  (should (functionp 'ar--beginning-of-buffer-p)))

(ert-deftest ar-ert--beginning-of-paragraph-p-functionp-test-ExVv4k ()
  (should (functionp 'ar--beginning-of-paragraph-p)))

(ert-deftest ar-ert--end-of-line-p-functionp-test-Wgrgk9 ()
  (should (functionp 'ar--end-of-line-p)))

(ert-deftest ar-ert--end-of-paragraph-p-functionp-test-EhfjBX ()
  (should (functionp 'ar--end-of-paragraph-p)))

(ert-deftest ar-ert--statement-opens-block-p-functionp-test-akDOQL ()
  (should (functionp 'ar--statement-opens-block-p)))

(ert-deftest ar-ert--statement-opens-base-functionp-test-qu591z ()
  (should (functionp 'ar--statement-opens-base)))

(ert-deftest ar-ert--statement-opens-clause-p-functionp-test-yg9Pbo ()
  (should (functionp 'ar--statement-opens-clause-p)))

(ert-deftest ar-ert--statement-opens-block-or-clause-p-functionp-test-YFIWic ()
  (should (functionp 'ar--statement-opens-block-or-clause-p)))

(ert-deftest ar-ert--statement-opens-class-p-functionp-test-yqOTq0 ()
  (should (functionp 'ar--statement-opens-class-p)))

(ert-deftest ar-ert--statement-opens-def-p-functionp-test-KQJJwO ()
  (should (functionp 'ar--statement-opens-def-p)))

(ert-deftest ar-ert--statement-opens-def-or-class-p-functionp-test-YZrPzC ()
  (should (functionp 'ar--statement-opens-def-or-class-p)))

(ert-deftest ar-ert--record-list-error-functionp-test-yqNLAq ()
  (should (functionp 'ar--record-list-error)))

(ert-deftest ar-ert--message-error-functionp-test-mq9oze ()
  (should (functionp 'ar--message-error)))

(ert-deftest ar-ert--end-base-functionp-test-Sgddw2 ()
  (should (functionp 'ar--end-base)))

(ert-deftest ar-ert--look-downward-for-beginning-functionp-test-4GmgpQ ()
  (should (functionp 'ar--look-downward-for-beginning)))

(ert-deftest ar-ert-look-downward-for-clause-functionp-test-OaxjkE ()
  (should (functionp 'ar-look-downward-for-clause)))

(ert-deftest ar-ert-current-defun-functionp-test-UfzHbs ()
  (should (functionp 'ar-current-defun)))

(ert-deftest ar-ert-sort-imports-functionp-test-SgHa4f ()
  (should (functionp 'ar-sort-imports)))

(ert-deftest ar-ert--in-literal-functionp-test-ozViW3 ()
  (should (functionp 'ar--in-literal)))

(ert-deftest ar-ert-count-lines-functionp-test-2980KR ()
  (should (functionp 'ar-count-lines)))

(ert-deftest ar-ert--point-functionp-test-iwvO3I ()
  (should (functionp 'ar--point)))

(ert-deftest ar-ert-install-local-shells-functionp-test-8S0MnA ()
  (should (functionp 'ar-install-local-shells)))

(ert-deftest ar-ert--until-found-functionp-test-6zyCEr ()
  (should (functionp 'ar--until-found)))

(ert-deftest ar-ert-which-def-or-class-functionp-test-IL7FVi ()
  (should (functionp 'ar-which-def-or-class)))

(ert-deftest ar-ert--fetch-first-SomeMode-buffer-functionp-test-uk0A99 ()
  (should (functionp 'ar--fetch-first-SomeMode-buffer)))

(ert-deftest ar-ert-unload-SomeMode-el-functionp-test-EhTUl1 ()
  (should (functionp 'ar-unload-SomeMode-el)))

(ert-deftest ar-ert--skip-to-semicolon-backward-functionp-test-MfBMyS ()
  (should (functionp 'ar--skip-to-semicolon-backward)))

(ert-deftest ar-ert--end-of-comment-intern-functionp-test-euILJJ ()
  (should (functionp 'ar--end-of-comment-intern)))

(ert-deftest ar-ert--skip-to-comment-or-semicolon-functionp-test-gDzQQA ()
  (should (functionp 'ar--skip-to-comment-or-semicolon)))

(ert-deftest ar-ert-backward-top-level-functionp-test-2zghVr ()
  (should (functionp 'ar-backward-top-level)))

(ert-deftest ar-ert-end-of-top-level-functionp-test-MjrkYi ()
  (should (functionp 'ar-forward-top-level)))

(ert-deftest ar-ert-end-of-top-level-bol-functionp-test-IxiNY9 ()
  (should (functionp 'ar-forward-top-level-bol)))

(ert-deftest ar-ert--beginning-of-line-form-functionp-test-2536W0 ()
  (should (functionp 'ar--beginning-of-line-form)))

(ert-deftest ar-ert--mark-base-functionp-test-iiTdTR ()
  (should (functionp 'ar--mark-base)))

(ert-deftest ar-ert--mark-base-bol-functionp-test-2rV3MI ()
  (should (functionp 'ar--mark-base-bol)))

(ert-deftest ar-ert-mark-base-functionp-test-C6bGEz ()
  (should (functionp 'ar-mark-base)))

(ert-deftest ar-ert-backward-same-level-functionp-test-W4OMtq ()
  (should (functionp 'ar-backward-same-level)))

(ert-deftest ar-ert--end-of-buffer-p-functionp-test-Ss9Pih ()
  (should (functionp 'ar--end-of-buffer-p)))

(ert-deftest ar-ert-info-lookup-symbol-functionp-test-wZCx87 ()
  (should (functionp 'ar-info-lookup-symbol)))

(ert-deftest ar-ert-SomeMode-after-info-look-functionp-test-aeFLVY ()
  (should (functionp 'SomeMode-after-info-look)))

(ert-deftest ar-ert--warn-tmp-files-left-functionp-test-K0RdKP ()
  (should (functionp 'ar--warn-tmp-files-left)))

(ert-deftest ar-ert-fetch-docu-functionp-test-O6yavG ()
  (should (functionp 'ar-fetch-docu)))

(ert-deftest ar-ert-info-current-defun-functionp-test-g11hoy ()
  (should (functionp 'ar-info-current-defun)))

(ert-deftest ar-ert-help-at-point-functionp-test-QHd7hq ()
  (should (functionp 'ar-help-at-point)))

(ert-deftest ar-ert--dump-help-string-functionp-test-yUJrai ()
  (should (functionp 'ar--dump-help-string)))

(ert-deftest ar-ert-describe-mode-functionp-test-c1rvY9 ()
  (should (functionp 'ar-describe-mode)))

(ert-deftest ar-ert-find-definition-functionp-test-gVYZN1 ()
  (should (functionp 'ar-find-definition)))

(ert-deftest ar-ert-find-imports-functionp-test-eqihBT ()
  (should (functionp 'ar-find-imports)))

(ert-deftest ar-ert-update-imports-functionp-test-aqEHkL ()
  (should (functionp 'ar-update-imports)))

(ert-deftest ar-ert-pep8-run-functionp-test-Upxj2C ()
  (should (functionp 'ar-pep8-run)))

(ert-deftest ar-ert-pep8-help-functionp-test-QLavKu ()
  (should (functionp 'ar-pep8-help)))

(ert-deftest ar-ert-pylint-run-functionp-test-WaT3qm ()
  (should (functionp 'ar-pylint-run)))

(ert-deftest ar-ert-pylint-help-functionp-test-8iN33d ()
  (should (functionp 'ar-pylint-help)))

(ert-deftest ar-ert-pylint-doku-functionp-test-uS6sE5 ()
  (should (functionp 'ar-pylint-doku)))

(ert-deftest ar-ert-pyflakes3-run-functionp-test-Gue4cX ()
  (should (functionp 'ar-pyflakes3-run)))

(ert-deftest ar-ert-pyflakes3-help-functionp-test-iuxwJO ()
  (should (functionp 'ar-pyflakes3-help)))

(ert-deftest ar-ert-pyflakespep8-run-functionp-test-oNAJgG ()
  (should (functionp 'ar-pyflakespep8-run)))

(ert-deftest ar-ert-pyflakespep8-help-functionp-test-2FVOLx ()
  (should (functionp 'ar-pyflakespep8-help)))

(ert-deftest ar-ert-pychecker-run-functionp-test-IPCzep ()
  (should (functionp 'ar-pychecker-run)))

(ert-deftest ar-ert-check-command-functionp-test-SWw3Eg ()
  (should (functionp 'ar-check-command)))

(ert-deftest ar-ert-flake8-run-functionp-test-Kmzi37 ()
  (should (functionp 'ar-flake8-run)))

(ert-deftest ar-ert-flake8-help-functionp-test-Y1b7oZ ()
  (should (functionp 'ar-flake8-help)))

(ert-deftest ar-ert--string-strip-functionp-test-s7pwwP ()
  (should (functionp 'ar--string-strip)))

(ert-deftest ar-ert-nesting-level-functionp-test-o7PUFF ()
  (should (functionp 'ar-nesting-level)))

(ert-deftest ar-ert-toggle-flymake-intern-functionp-test-e6m8Lv ()
  (should (functionp 'ar-toggle-flymake-intern)))

(ert-deftest ar-ert-pylint-flymake-mode-functionp-test-m6Z4Sl ()
  (should (functionp 'pylint-flymake-mode)))

(ert-deftest ar-ert-pyflakes-flymake-mode-functionp-test-eOjyWb ()
  (should (functionp 'pyflakes-flymake-mode)))

(ert-deftest ar-ert-pychecker-flymake-mode-functionp-test-m21901 ()
  (should (functionp 'pychecker-flymake-mode)))

(ert-deftest ar-ert-pep8-flymake-mode-functionp-test-aopq2R ()
  (should (functionp 'pep8-flymake-mode)))

(ert-deftest ar-ert-pyflakespep8-flymake-mode-functionp-test-iUif5H ()
  (should (functionp 'pyflakespep8-flymake-mode)))

(ert-deftest ar-display-state-of-variables-functionp-test-A9MG3x ()
  (should (functionp 'ar-display-state-of-variables)))

(ert-deftest ar-ert--quote-syntax-functionp-test-c3gy3n ()
  (should (functionp 'ar--quote-syntax)))

(ert-deftest ar-ert--SomeMode-send-setup-code-intern-functionp-test-iquh1d ()
  (should (functionp 'ar--SomeMode-send-setup-code-intern)))

(ert-deftest ar-ert--SomeMode-send-completion-setup-code-functionp-test-2jwfV3 ()
  (should (functionp 'ar--SomeMode-send-completion-setup-code)))

;; (ert-deftest ar-ert--SomeMode-send-eldoc-setup-code-functionp-test-AJBxNT ()
;;   (should (functionp 'ar--SomeMode-send-eldoc-setup-code)))

(ert-deftest ar-ert--iSomeMode-import-module-completion-functionp-test-q8JhGJ ()
  (should (functionp 'ar--iSomeMode-import-module-completion)))

(ert-deftest ar-ert--docstring-p-functionp-test-kXEwxz ()
  (should (functionp 'ar--docstring-p)))

(ert-deftest ar-ert--font-lock-syntactic-face-function-functionp-test-ysmcmp ()
  (should (functionp 'ar--font-lock-syntactic-face-function)))

(ert-deftest ar-ert-choose-shell-by-shebang-functionp-test-sdVC8e ()
  (should (functionp 'ar-choose-shell-by-shebang)))

(ert-deftest ar-ert--choose-shell-by-import-functionp-test-4gCOS4 ()
  (should (functionp 'ar--choose-shell-by-import)))

(ert-deftest ar-ert-choose-shell-by-path-functionp-test-iuCKAU ()
  (should (functionp 'ar-choose-shell-by-path)))

(ert-deftest ar-ert-which-SomeMode-functionp-test-EFnMgK ()
  (should (functionp 'ar-which-SomeMode)))

(ert-deftest ar-ert-SomeMode-current-environment-functionp-test-aQ7CUz ()
  (should (functionp 'ar-SomeMode-current-environment)))

(ert-deftest ar-ert--cleanup-process-name-functionp-test-OUw1vp ()
  (should (functionp 'ar--cleanup-process-name)))

(ert-deftest ar-ert-choose-shell-functionp-test-6xboeg ()
  (should (functionp 'ar-choose-shell)))

(ert-deftest ar-ert--normalize-directory-functionp-test-uYn0X6 ()
  (should (functionp 'ar--normalize-directory)))

(ert-deftest ar-ert-install-directory-check-functionp-test-6jS4DX ()
  (should (functionp 'ar-install-directory-check)))

(ert-deftest ar-ert-guess-ar-install-directory-functionp-test-GKhflO ()
  (should (functionp 'ar-guess-ar-install-directory)))

(ert-deftest ar-ert-load-pymacs-functionp-test-8A05YE ()
  (should (functionp 'ar-load-pymacs)))

(ert-deftest ar-ert-set-load-path-functionp-test-oPQqEv ()
  (should (functionp 'ar-set-load-path)))

;; (ert-deftest ar-ert-machine-separator-char-functionp-test-SYYdgm ()
;;   (should (functionp 'ar-machine-separator-char)))

(ert-deftest ar-ert-in-string-or-comment-p-functionp-test-SyBtr3 ()
  (should (functionp 'ar-in-string-or-comment-p)))

(ert-deftest ar-ert-electric-colon-functionp-test-UZzFYT ()
  (should (functionp 'ar-electric-colon)))

(ert-deftest ar-ert-electric-close-functionp-test-wrH2wK ()
  (should (functionp 'ar-electric-close)))

(ert-deftest ar-ert-electric-comment-functionp-test-WE0F1A ()
  (should (functionp 'ar-electric-comment)))

(ert-deftest ar-ert-empty-out-list-backward-functionp-test-Y5IBur ()
  (should (functionp 'ar-empty-out-list-backward)))

(ert-deftest ar-ert-electric-backspace-functionp-test-IDxUXh ()
  (should (functionp 'ar-electric-backspace)))

(ert-deftest ar-ert-electric-delete-functionp-test-uqFBo8 ()
  (should (functionp 'ar-electric-delete)))

(ert-deftest ar-ert-electric-yank-functionp-test-k95VNY ()
  (should (functionp 'ar-electric-yank)))

(ert-deftest ar-ert-backward-comment-functionp-test-uyjHaP ()
  (should (functionp 'ar-backward-comment)))

(ert-deftest ar-ert-forward-comment-functionp-test-E1mKtF ()
  (should (functionp 'ar-forward-comment)))

(ert-deftest ar-ert--uncomment-intern-functionp-test-W6YXYl ()
  (should (functionp 'ar--uncomment-intern)))

(ert-deftest ar-ert-uncomment-functionp-test-qewUac ()
  (should (functionp 'ar-uncomment)))

(ert-deftest ar-ert-comment-block-functionp-test-6njGk2 ()
  (should (functionp 'ar-comment-block)))

(ert-deftest ar-ert-comment-minor-block-functionp-test-8owmYV ()
  (should (functionp 'ar-comment-minor-block)))

(ert-deftest ar-ert-comment-top-level-functionp-test-0M1YCP ()
  (should (functionp 'ar-comment-top-level)))

(ert-deftest ar-ert-comment-clause-functionp-test-2BW0eJ ()
  (should (functionp 'ar-comment-clause)))

(ert-deftest ar-ert-comment-block-or-clause-functionp-test-0Y1gSC ()
  (should (functionp 'ar-comment-block-or-clause)))

(ert-deftest ar-ert-comment-def-functionp-test-M7iNrw ()
  (should (functionp 'ar-comment-def)))

(ert-deftest ar-ert-comment-class-functionp-test-qcGo2p ()
  (should (functionp 'ar-comment-class)))

(ert-deftest ar-ert-comment-def-or-class-functionp-test-2jFyzj ()
  (should (functionp 'ar-comment-def-or-class)))

(ert-deftest ar-ert-comment-statement-functionp-test-6Ngi8c ()
  (should (functionp 'ar-comment-statement)))

(ert-deftest ar-ert-delete-statement-functionp-test-sjIuD6 ()
  (should (functionp 'ar-delete-statement)))

(ert-deftest ar-ert-delete-top-level-functionp-test-slec9Z ()
  (should (functionp 'ar-delete-top-level)))

(ert-deftest ar-ert-delete-block-functionp-test-KW9LBT ()
  (should (functionp 'ar-delete-block)))

(ert-deftest ar-ert-delete-block-or-clause-functionp-test-0eq91M ()
  (should (functionp 'ar-delete-block-or-clause)))

(ert-deftest ar-ert-delete-def-functionp-test-ojpetG ()
  (should (functionp 'ar-delete-def)))

(ert-deftest ar-ert-delete-class-functionp-test-S8C1Qz ()
  (should (functionp 'ar-delete-class)))

(ert-deftest ar-ert-delete-def-or-class-functionp-test-C4Bnct ()
  (should (functionp 'ar-delete-def-or-class)))

(ert-deftest ar-ert-delete-expression-functionp-test-8WQUvm ()
  (should (functionp 'ar-delete-expression)))

(ert-deftest ar-ert-delete-partial-expression-functionp-test-ekIuQf ()
  (should (functionp 'ar-delete-partial-expression)))

(ert-deftest ar-ert-delete-minor-block-functionp-test-86tz88 ()
  (should (functionp 'ar-delete-minor-block)))

(ert-deftest ar-ert--imenu-create-index-functionp-test-4Ke0o2 ()
  (should (functionp 'ar--imenu-create-index)))

(ert-deftest ar-ert--imenu-create-index-engine-functionp-test-GCNUCV ()
  (should (functionp 'ar--imenu-create-index-engine)))

(ert-deftest ar-ert--imenu-create-index-new-functionp-test-y6DwOO ()
  (should (functionp 'ar--imenu-create-index-new)))

(ert-deftest ar-ert-execute-file-SomeMode-functionp-test-eyY2XH ()
  (should (functionp 'ar-execute-file-SomeMode)))

(ert-deftest ar-ert-execute-file-SomeMode-dedicated-functionp-test-Ipd44A ()
  (should (functionp 'ar-execute-file-SomeMode-dedicated)))

(ert-deftest ar-ert-execute-file-iSomeMode-functionp-test-Yf9Zkv ()
  (should (functionp 'ar-execute-file-iSomeMode)))

(ert-deftest ar-ert-execute-file-SomeMode3-functionp-test-Yfc3wp ()
  (should (functionp 'ar-execute-file-SomeMode3)))

(ert-deftest ar-ert-execute-file-SomeMode3-dedicated-functionp-test-oRLSIj ()
  (should (functionp 'ar-execute-file-SomeMode3-dedicated)))

(ert-deftest ar-ert-execute-file-SomeMode2-functionp-test-cHm0Vd ()
  (should (functionp 'ar-execute-file-SomeMode2)))

(ert-deftest ar-ert-execute-file-SomeMode2-dedicated-functionp-test-MhVE57 ()
  (should (functionp 'ar-execute-file-SomeMode2-dedicated)))

(ert-deftest ar-ert-execute-file-jython-functionp-test-iU7og2 ()
  (should (functionp 'ar-execute-file-jython)))

(ert-deftest ar-ert-execute-file-jython-dedicated-functionp-test-eKgDnW ()
  (should (functionp 'ar-execute-file-jython-dedicated)))

(ert-deftest ar-ert--shell-completion-get-completions-functionp-test-C2UZsQ ()
  (should (functionp 'ar--shell-completion-get-completions)))

(ert-deftest ar-ert--after-change-function-functionp-test-iWhMzK ()
  (should (functionp 'ar--after-change-function)))

(ert-deftest ar-ert--try-completion-intern-functionp-test-szwmCE ()
  (should (functionp 'ar--try-completion-intern)))

(ert-deftest ar-ert--try-completion-functionp-test-SeGdGy ()
  (should (functionp 'ar--try-completion)))

(ert-deftest ar--shell-do-completion-at-point-functionp-test-kfiiIs ()
  (should (functionp 'ar--shell-do-completion-at-point)))

(ert-deftest ar--shell-insert-completion-maybe-functionp-test-UtNoGm ()
  (should (functionp 'ar--shell-insert-completion-maybe)))

(ert-deftest ar-ert--complete-base-functionp-test-6l56Bg ()
  (should (functionp 'ar--complete-base)))

(ert-deftest ar-ert-shell-complete-functionp-test-uOc4va ()
  (should (functionp 'ar-shell-complete)))

(ert-deftest ar-ert-indent-or-complete-functionp-test-ySINq4 ()
  (should (functionp 'ar-indent-or-complete)))

(ert-deftest ar-ert-shift-left-functionp-test-WC1XiY ()
  (should (functionp 'ar-shift-left)))

(ert-deftest ar-ert-shift-right-functionp-test-KKvZ8R ()
  (should (functionp 'ar-shift-right)))

(ert-deftest ar-ert--shift-intern-functionp-test-SGYxXL ()
  (should (functionp 'ar--shift-intern)))

(ert-deftest ar-ert--shift-forms-base-functionp-test-4W4LJF ()
  (should (functionp 'ar--shift-forms-base)))

(ert-deftest ar-ert-shift-paragraph-right-functionp-test-MdFJtz ()
  (should (functionp 'ar-shift-paragraph-right)))

(ert-deftest ar-ert-shift-paragraph-left-functionp-test-gjjMat ()
  (should (functionp 'ar-shift-paragraph-left)))

(ert-deftest ar-ert-shift-block-right-functionp-test-isk6El ()
  (should (functionp 'ar-shift-block-right)))

(ert-deftest ar-ert-shift-block-left-functionp-test-0gAu6d ()
  (should (functionp 'ar-shift-block-left)))

(ert-deftest ar-ert-shift-minor-block-left-functionp-test-k9f4y6 ()
  (should (functionp 'ar-shift-minor-block-left)))

(ert-deftest ar-ert-shift-minor-block-right-functionp-test-amERXY ()
  (should (functionp 'ar-shift-minor-block-right)))

(ert-deftest ar-ert-shift-clause-right-functionp-test-OqD0nR ()
  (should (functionp 'ar-shift-clause-right)))

(ert-deftest ar-ert-shift-clause-left-functionp-test-kppHKJ ()
  (should (functionp 'ar-shift-clause-left)))

(ert-deftest ar-ert-shift-block-or-clause-right-functionp-test-ABEj8B ()
  (should (functionp 'ar-shift-block-or-clause-right)))

(ert-deftest ar-ert-shift-block-or-clause-left-functionp-test-U3q3su ()
  (should (functionp 'ar-shift-block-or-clause-left)))

(ert-deftest ar-ert-shift-def-right-functionp-test-U3v1Nm ()
  (should (functionp 'ar-shift-def-right)))

(ert-deftest ar-ert-shift-def-left-functionp-test-eGhS5e ()
  (should (functionp 'ar-shift-def-left)))

(ert-deftest ar-ert-shift-class-right-functionp-test-WCXzl7 ()
  (should (functionp 'ar-shift-class-right)))

(ert-deftest ar-ert-shift-class-left-functionp-test-WAJ0BZ ()
  (should (functionp 'ar-shift-class-left)))

(ert-deftest ar-ert-shift-def-or-class-right-functionp-test-88kGQR ()
  (should (functionp 'ar-shift-def-or-class-right)))

(ert-deftest ar-ert-shift-def-or-class-left-functionp-test-A7Vo1J ()
  (should (functionp 'ar-shift-def-or-class-left)))

(ert-deftest ar-ert-shift-statement-right-functionp-test-a6kuaC ()
  (should (functionp 'ar-shift-statement-right)))

(ert-deftest ar-ert-shift-statement-left-functionp-test-wPXmku ()
  (should (functionp 'ar-shift-statement-left)))

(ert-deftest ar-ert-end-of-block-functionp-test-02Rtsm ()
  (should (functionp 'ar-forward-block)))

(ert-deftest ar-ert-end-of-clause-functionp-test-0ed3xe ()
  (should (functionp 'ar-forward-clause)))

(ert-deftest ar-ert-end-of-block-or-clause-functionp-test-KMXnB6 ()
  (should (functionp 'ar-forward-block-or-clause)))

(ert-deftest ar-ert-end-of-def-functionp-test-2HHWAY ()
  (should (functionp 'ar-forward-def)))

(ert-deftest ar-ert-end-of-class-functionp-test-84ohyQ ()
  (should (functionp 'ar-forward-class)))

(ert-deftest ar-ert-ar-toggle-smart-indentation-functionp-test ()   (should (functionp 'ar-toggle-smart-indentation)))
(ert-deftest ar-ert-ar-smart-indentation-on-functionp-test ()   (should (functionp 'ar-smart-indentation-on)))
(ert-deftest ar-ert-ar-smart-indentation-off-functionp-test ()   (should (functionp 'ar-smart-indentation-off)))
(ert-deftest ar-ert-ar-toggle-sexp-function-functionp-test ()   (should (functionp 'ar-toggle-sexp-function)))
(ert-deftest ar-ert-ar-toggle-switch-buffers-on-execute-p-functionp-test ()   (should (functionp 'ar-toggle-switch-buffers-on-execute-p)))
(ert-deftest ar-ert-ar-switch-buffers-on-execute-p-on-functionp-test ()   (should (functionp 'ar-switch-buffers-on-execute-p-on)))
(ert-deftest ar-ert-ar-switch-buffers-on-execute-p-off-functionp-test ()   (should (functionp 'ar-switch-buffers-on-execute-p-off)))
(ert-deftest ar-ert-ar-toggle-split-window-on-execute-functionp-test ()   (should (functionp 'ar-toggle-split-window-on-execute)))
(ert-deftest ar-ert-ar-split-window-on-execute-on-functionp-test ()   (should (functionp 'ar-split-window-on-execute-on)))
(ert-deftest ar-ert-ar-split-window-on-execute-off-functionp-test ()   (should (functionp 'ar-split-window-on-execute-off)))
(ert-deftest ar-ert-ar-toggle-fontify-shell-buffer-p-functionp-test ()   (should (functionp 'ar-toggle-fontify-shell-buffer-p)))
(ert-deftest ar-ert-ar-fontify-shell-buffer-p-on-functionp-test ()   (should (functionp 'ar-fontify-shell-buffer-p-on)))
(ert-deftest ar-ert-ar-fontify-shell-buffer-p-off-functionp-test ()   (should (functionp 'ar-fontify-shell-buffer-p-off)))
(ert-deftest ar-ert-ar-toggle-ar-mode-v5-behavior-p-functionp-test ()   (should (functionp 'ar-toggle-ar-mode-v5-behavior-p)))
(ert-deftest ar-ert-ar-ar-mode-v5-behavior-p-on-functionp-test ()   (should (functionp 'ar-ar-mode-v5-behavior-p-on)))
(ert-deftest ar-ert-ar-ar-mode-v5-behavior-p-off-functionp-test ()   (should (functionp 'ar-ar-mode-v5-behavior-p-off)))
(ert-deftest ar-ert-ar-toggle-jump-on-exception-functionp-test ()   (should (functionp 'ar-toggle-jump-on-exception)))
(ert-deftest ar-ert-ar-jump-on-exception-on-functionp-test ()   (should (functionp 'ar-jump-on-exception-on)))
(ert-deftest ar-ert-ar-jump-on-exception-off-functionp-test ()   (should (functionp 'ar-jump-on-exception-off)))
(ert-deftest ar-ert-ar-toggle-use-current-dir-when-execute-p-functionp-test ()   (should (functionp 'ar-toggle-use-current-dir-when-execute-p)))
(ert-deftest ar-ert-ar-use-current-dir-when-execute-p-on-functionp-test ()   (should (functionp 'ar-use-current-dir-when-execute-p-on)))
(ert-deftest ar-ert-ar-use-current-dir-when-execute-p-off-functionp-test ()   (should (functionp 'ar-use-current-dir-when-execute-p-off)))
(ert-deftest ar-ert-ar-toggle-electric-comment-p-functionp-test ()   (should (functionp 'ar-toggle-electric-comment-p)))
(ert-deftest ar-ert-ar-electric-comment-p-on-functionp-test ()   (should (functionp 'ar-electric-comment-p-on)))
(ert-deftest ar-ert-ar-electric-comment-p-off-functionp-test ()   (should (functionp 'ar-electric-comment-p-off)))
(ert-deftest ar-ert-ar-toggle-underscore-word-syntax-p-functionp-test ()   (should (functionp 'ar-toggle-underscore-word-syntax-p)))
(ert-deftest ar-ert-ar-underscore-word-syntax-p-on-functionp-test ()   (should (functionp 'ar-underscore-word-syntax-p-on)))
(ert-deftest ar-ert-ar-underscore-word-syntax-p-off-functionp-test ()   (should (functionp 'ar-underscore-word-syntax-p-off)))

(provide 'ar-ert-function-tests)
;;; ar-ert-function-tests.el ends here
