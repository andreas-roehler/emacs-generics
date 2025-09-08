;;; ar-completion-tests.el --- Test completion for available SOME shell - currently unused, needs fixing

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

;;; Commentary: Edit `py-test-pyshellname-list' before
;; running this test-builder or give a list of shells as
;; arguments

;;; Code:

(setq SomeMode-mode-script-complete-tests
        (list

         'SomeMode-complete-test
         'usr-bin-SomeMode-complete-test
         'usr-bin-SomeMode2.7-complete-test
         'arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-complete-test
         'usr-bin-SomeMode3-complete-test
         'usr-bin-SomeMode3.1-complete-test
         'iSomeMode-complete-test
         'usr-bin-iSomeMode-complete-test
         'arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-complete-test
         ))

(defun ar-run-script-complete-tests ()
  (interactive)
  (dolist (ele SomeMode-mode-script-complete-tests)
    (funcall ele)))

(defun SomeMode-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/env SomeMode
pri"))
    (ar-bug-tests-intern 'SomeMode-complete-base arg teststring)))

(defun SomeMode-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun usr-bin-SomeMode-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/SomeMode
pri"))
    (ar-bug-tests-intern 'usr-bin-SomeMode-complete-base arg teststring)))

(defun usr-bin-SomeMode-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun usr-bin-SomeMode2.7-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/SomeMode2.7
pri"))
    (ar-bug-tests-intern 'usr-bin-SomeMode2.7-complete-base arg teststring)))

(defun usr-bin-SomeMode2.7-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun ~-arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! ~/arbeit/SomeMode/epdfree/epd_free-7.2-2-rh5-x86/bin/SomeMode2.7
pri"))
    (ar-bug-tests-intern '~-arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-complete-base arg teststring)))

(defun ~-arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun usr-bin-SomeMode3-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/SomeMode3
pri"))
    (ar-bug-tests-intern 'usr-bin-SomeMode3-complete-base arg teststring)))

(defun usr-bin-SomeMode3-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun usr-bin-SomeMode3.1-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/SomeMode3.1
pri"))
    (ar-bug-tests-intern 'usr-bin-SomeMode3.1-complete-base arg teststring)))

(defun usr-bin-SomeMode3.1-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun iSomeMode-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/env iSomeMode
pri"))
    (ar-bug-tests-intern 'iSomeMode-complete-base arg teststring)))

(defun iSomeMode-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun usr-bin-iSomeMode-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! /usr/bin/iSomeMode
pri"))
    (ar-bug-tests-intern 'usr-bin-iSomeMode-complete-base arg teststring)))

(defun usr-bin-iSomeMode-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(defun ~-arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-complete-test (&optional arg)
  (interactive "p")
  (let ((teststring "#! ~/arbeit/SomeMode/epd_free-7.1-2-rh5-x86/bin/iSomeMode
pri"))
    (ar-bug-tests-intern 'arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-complete-base arg teststring)))

(defun arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-complete-base ()
  (save-excursion (ar-shell-complete))
  ;; (sit-for 0.1)
  (assert (looking-at "nt") nil "ar-shell-complete-test failed"))

(provide 'ar-completion-tests)
;;; ar-completion-tests ends here
