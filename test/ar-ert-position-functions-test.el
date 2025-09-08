;;; ar-ert-position-functions-test.el --- test	     -*- lexical-binding: t; -*-

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(ert-deftest ar-ert--beginning-of-def-position-functionp-test ()
  (should (functionp 'ar--beginning-of-def-position)))

(ert-deftest ar-ert--beginning-of-class-position-functionp-test ()
  (should (functionp 'ar--beginning-of-class-position)))

(ert-deftest ar-ert--beginning-of-def-or-class-position-functionp-test ()
  (should (functionp 'ar--beginning-of-def-or-class-position)))

(ert-deftest ar-ert--beginning-of-expression-position-functionp-test ()
  (should (functionp 'ar--beginning-of-expression-position)))

(ert-deftest ar-ert--beginning-of-partial-expression-position-functionp-test ()
  (should (functionp 'ar--beginning-of-partial-expression-position)))

(ert-deftest ar-ert--beginning-of-minor-block-position-functionp-test ()
  (should (functionp 'ar--beginning-of-minor-block-position)))

(ert-deftest ar-ert--beginning-of-if-block-position-functionp-test ()
  (should (functionp 'ar--beginning-of-if-block-position)))

(ert-deftest ar-ert--beginning-of-try-block-position-functionp-test ()
  (should (functionp 'ar--beginning-of-try-block-position)))

(ert-deftest ar-ert--beginning-of-except-block-position-functionp-test ()
  (should (functionp 'ar--beginning-of-except-block-position)))

(ert-deftest ar-ert--beginning-of-statement-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-statement-position-bol)))

(ert-deftest ar-ert--beginning-of-block-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-block-position-bol)))

(ert-deftest ar-ert--beginning-of-clause-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-clause-position-bol)))

(ert-deftest ar-ert--beginning-of-block-or-clause-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-block-or-clause-position-bol)))

(ert-deftest ar-ert--beginning-of-def-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-def-position-bol)))

(ert-deftest ar-ert--beginning-of-class-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-class-position-bol)))

(ert-deftest ar-ert--beginning-of-def-or-class-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-def-or-class-position-bol)))

(ert-deftest ar-ert--beginning-of-minor-block-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-minor-block-position-bol)))

(ert-deftest ar-ert--beginning-of-if-block-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-if-block-position-bol)))

(ert-deftest ar-ert--beginning-of-try-block-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-try-block-position-bol)))

(ert-deftest ar-ert--beginning-of-except-block-position-bol-functionp-test ()
  (should (functionp 'ar--beginning-of-except-block-position-bol)))

(ert-deftest ar-ert--beginning-of-statement-position-functionp-test ()
  (should (functionp 'ar--beginning-of-statement-position)))

(ert-deftest ar-ert--beginning-of-block-position-functionp-test ()
  (should (functionp 'ar--beginning-of-block-position)))

(ert-deftest ar-ert--beginning-of-clause-position-functionp-test ()
  (should (functionp 'ar--beginning-of-clause-position)))

(ert-deftest ar-ert--beginning-of-block-or-clause-position-functionp-test ()
  (should (functionp 'ar--beginning-of-block-or-clause-position)))

(ert-deftest ar-ert--beginning-of-buffer-position-functionp-test ()
  (should (functionp 'ar--beginning-of-buffer-position)))

(ert-deftest ar-ert--beginning-of-comment-position-functionp-test ()
  (should (functionp 'ar--beginning-of-comment-position)))

(ert-deftest ar-ert--end-of-comment-position-functionp-test ()
  (should (functionp 'ar--end-of-comment-position)))

(ert-deftest ar-ert--beginning-of-paragraph-position-functionp-test ()
  (should (functionp 'ar--beginning-of-paragraph-position)))

(ert-deftest ar-ert--end-of-paragraph-position-functionp-test ()
  (should (functionp 'ar--end-of-paragraph-position)))

(ert-deftest ar-ert-end-of-list-position-functionp-test ()
  (should (functionp 'ar-end-of-list-position)))

(ert-deftest ar-ert--end-of-buffer-position-functionp-test ()
  (should (functionp 'ar--end-of-buffer-position)))

(ert-deftest ar-ert-list-beginning-position-functionp-test ()
  (should (functionp 'ar-list-beginning-position)))

(ert-deftest ar-ert--end-of-statement-position-functionp-test ()
  (should (functionp 'ar--end-of-statement-position)))

(ert-deftest ar-ert--end-of-block-position-functionp-test ()
  (should (functionp 'ar--end-of-block-position)))

(ert-deftest ar-ert--end-of-clause-position-functionp-test ()
  (should (functionp 'ar--end-of-clause-position)))

(ert-deftest ar-ert--end-of-block-or-clause-position-functionp-test ()
  (should (functionp 'ar--end-of-block-or-clause-position)))

(ert-deftest ar-ert--end-of-def-position-functionp-test ()
  (should (functionp 'ar--end-of-def-position)))

(ert-deftest ar-ert--end-of-class-position-functionp-test ()
  (should (functionp 'ar--end-of-class-position)))

(ert-deftest ar-ert--end-of-def-or-class-position-functionp-test ()
  (should (functionp 'ar--end-of-def-or-class-position)))

(ert-deftest ar-ert--end-of-buffer-position-functionp-test ()
  (should (functionp 'ar--end-of-buffer-position)))

(ert-deftest ar-ert--end-of-expression-position-functionp-test ()
  (should (functionp 'ar--end-of-expression-position)))

(ert-deftest ar-ert--end-of-partial-expression-position-functionp-test ()
  (should (functionp 'ar--end-of-partial-expression-position)))

(ert-deftest ar-ert--end-of-minor-block-position-functionp-test ()
  (should (functionp 'ar--end-of-minor-block-position)))

(ert-deftest ar-ert--end-of-if-block-position-functionp-test ()
  (should (functionp 'ar--end-of-if-block-position)))

(ert-deftest ar-ert--end-of-try-block-position-functionp-test ()
  (should (functionp 'ar--end-of-try-block-position)))

(ert-deftest ar-ert--end-of-except-block-position-functionp-test ()
  (should (functionp 'ar--end-of-except-block-position)))

(ert-deftest ar-ert--end-of-top-level-position-functionp-test ()
  (should (functionp 'ar--end-of-top-level-position)))

(ert-deftest ar-ert--end-of-statement-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-statement-position-bol)))

(ert-deftest ar-ert--end-of-block-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-block-position-bol)))

(ert-deftest ar-ert--end-of-clause-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-clause-position-bol)))

(ert-deftest ar-ert--end-of-block-or-clause-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-block-or-clause-position-bol)))

(ert-deftest ar-ert--end-of-def-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-def-position-bol)))

(ert-deftest ar-ert--end-of-class-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-class-position-bol)))

(ert-deftest ar-ert--end-of-minor-block-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-minor-block-position-bol)))

(ert-deftest ar-ert--end-of-if-block-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-if-block-position-bol)))

(ert-deftest ar-ert--end-of-try-block-position-bol-functionp-test ()
  (should (functionp 'ar--end-of-try-block-position-bol)))

(ert-deftest ar-ert-kill-block-functionp-test ()
  (should (functionp 'ar-kill-block)))

(provide 'ar-ert-position-functions-test)
;;; ar-ert-position-functions-test.el ends here
