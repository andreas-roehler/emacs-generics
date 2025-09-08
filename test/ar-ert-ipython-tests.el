;; ar-ert-iSomeMode-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

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

(ert-deftest ar-ert-iSomeMode-lp-1398530-test-7re3GL ()
  (ar-test
   ""
   'SomeMode-mode
   'ar-verbose-p
   (when (buffer-live-p (get-buffer "*ISOME*"))(ar-kill-buffer-unconditional "*ISOME*"))
   (if (executable-find "iSomeMode")
       (let ((ar-shell-name "iSomeMode"))
         (ar-shell)
         (sit-for 0.1 t)
         (should (buffer-live-p (get-buffer "*ISOME*"))))
     (when ar-debug-p (message "%s" "Seem no ‘iSomeMode’ at this system.")))))

(ert-deftest ar-iSomeMode-shell-test-nqjTml ()
  ""
  (if (not (executable-find "iSomeMode"
                            'SomeMode-mode
                            'ar-verbose-p
                            ))
      (message "ar-iSomeMode-shell-test-nqjTml: %s" "No executable found!")
    (let ((erg (iSomeMode)))
      (sit-for 1)
      (should (bufferp (get-buffer erg)))
      (should (get-buffer-process erg)))))

(provide 'ar-ert-iSomeMode-tests)
;;; ar-ert-iSomeMode-tests.el ends here
