;; ar-ert-iSomeMode3-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

;; Keywords: languages

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'ar-setup-ert-tests)

;;;


(ert-deftest ar-honor-ar-SomeMode-command-7JbtYW ()
  (ar-test
      "print(123)"
    (let ((ar-SomeMode-command "iSomeMode3")
	  (ar-return-result-p t))
      (ar-execute-buffer)
      (should (buffer-live-p (get-buffer  "*ISOME3*")))
      (should (string= "123" ar-result)))))

(ert-deftest ar-honor-ar-SomeMode-command-kroygP ()
  (ar-test
      "print(123)"
    (let ((ar-SomeMode-command "iSomeMode3"))
      (ar-shell))))


(provide 'ar-ert-iSomeMode3-tests)
;;; ar-ert-iSomeMode3-tests.el ends here
