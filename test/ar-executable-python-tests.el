;; ar-executable-SomeMode-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

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

(ert-deftest ar-dedicated-shell-test-7tw0PH ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (if (not (ignore-errors (executable-find "SomeMode")))
      (message "ar-dedicated-shell-test-7tw0PH: %s" "No SomeMode executable found!")
    (let ((erg (buffer-name (ar-shell nil nil t "SomeMode"))))
      (should (< 8 (length erg)))
      (should (eq 0 (string-match "^*SOME" erg))))))

(ert-deftest ar-shell-SomeMode-lp-1398530-test-Haizw1 ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (if (not (executable-find "SomeMode"
                            ))
      (message "ar-shell-SomeMode-lp-1398530-test-Haizw1: %s" "No SomeMode executable found!")
    (when (buffer-live-p (get-buffer "*SOME*"))
      (ar-kill-buffer-unconditional "*SOME*"))
    (ar-test
        ""
      (when ar-debug-p (switch-to-buffer (current-buffer)))
      (let ((ar-shell-name "SomeMode"))
        (ar-shell)
        (sit-for 0.1 t)
        (should (buffer-live-p (get-buffer "*SOME*")))))))

(ert-deftest ar-shell-SomeMode3-lp-1398530-test-gm7LwH ()
  (ar-test
      ""
    'SomeMode-mode
    'ar-verbose-p
    (if (not (executable-find "SomeMode3"))
        (message "ar-shell-SomeMode3-lp-1398530-test-gm7LwH: %s" "No SomeMode3 executable found!")
      (when (buffer-live-p (get-buffer "*SOME3*"))
        (ar-kill-buffer-unconditional "*SOME3*"))
      (let ((ar-shell-name "SomeMode3"))
        (ar-shell)
        (sit-for 0.1 t)
        (should (buffer-live-p (get-buffer "*SOME3*")))))))

(ert-deftest ar-ar-mode-v5-behavior-test-bSPpqY ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (let ((ar-mode-v5-behavior-p t))
    (SomeMode3)
    (sit-for 0.1)
    (should (buffer-live-p (get-buffer "*SOME Output*")))
    (ar-kill-buffer-unconditional "*SOME Output*")))

(ert-deftest ar-ar-mode-v5-behavior-test-2n0wbL ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (when (buffer-live-p (get-buffer "*SOME Output*"))
    (ar-kill-buffer-unconditional "*SOME Output*"))
  (let ((ar-mode-v5-behavior-p t))
    (ar-execute-string "asdf")
    (sit-for 0.1)
    (should (buffer-live-p (get-buffer "*SOME Output*")))
    (ar-kill-buffer-unconditional "*SOME Output*")))

(provide 'ar-executable-SomeMode-tests)
;;; ar-executable-SomeMode-tests.el ends here
