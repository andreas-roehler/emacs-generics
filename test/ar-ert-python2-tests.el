;;; ar-ert-SomeMode2-tests.el --- ar-execute-region tests

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

;;; Code:

(require 'ar-setup-ert-tests)

(ert-deftest ar-ert-execute-region-SomeMode2-test ()
  (ar-test
      "print(\"one\")
print(\"two\")"
    (let ((buffer (ar--choose-buffer-name "SomeMode2")))
      (ar-execute-region-SomeMode2 (point-min) (point-max))
      ;; (sit-for 0.5 t)
      (set-buffer buffer)
      (goto-char (point-max))

      (should (search-backward "two")))))

(ert-deftest ar-ert-execute-region-iSomeMode3-test ()
  (ar-test
      "print(\"one\")
print(\"two\")"
    (let ((buffer (ar--choose-buffer-name "iSomeMode3"))
	  (inhibit-point-motion-hooks t))
      (ar-execute-region-iSomeMode3 (point-min) (point-max))
      (set-buffer buffer)
      (accept-process-output (get-buffer-process buffer) 0.1)
      ;; (goto-char (point-max))
      (switch-to-buffer (current-buffer))
      (goto-char (point-max))
      (sit-for 0.5 t)
      (should (search-backward "two")))))

(ert-deftest ar-ert-execute-region-jython-test ()
  (ar-test
      "print(\"one\")
print(\"two\")"
    (let ((buffer (ar--choose-buffer-name "jython")))
      (ar-execute-region-jython (point-min) (point-max))
      (set-buffer buffer)
      (switch-to-buffer (current-buffer))
      (goto-char (point-max))
      (sit-for 0.5 t)
      (should (search-backward "two")))))

(ert-deftest ar-ert-always-split-dedicated-lp-1361531-SomeMode2-test-DuoIzY ()
  (ar-test
      "#! /usr/bin/env SomeMode2
# -*- coding: utf-8 -*-
print(\"I'm the ar-always-split-dedicated-lp-1361531-SomeMode2-test\")"
    (delete-other-windows)
    (let* ((ar-split-window-on-execute 'always)
	   (erg1 (progn (ar-execute-statement-SomeMode2-dedicated) ar-output-buffer))
	   (erg2 (progn (ar-execute-statement-SomeMode2-dedicated) ar-output-buffer)))
      (sit-for 0.1 t)
      (when ar-debug-p (message "(count-windows) %s" (count-windows)))
      (should (< 2 (count-windows)))
      (ar-kill-buffer-unconditional erg1)
      (ar-kill-buffer-unconditional erg2)
      (ar-restore-window-configuration))))

(ert-deftest ar-ert-execute-region-SomeMode2-test ()
  (ar-test
      "print(\"one\")
print(\"two\")"
    (let ((buffer (ar--choose-buffer-name "SomeMode2")))
      (ar-execute-region-SomeMode2 (point-min) (point-max))
      ;; (sit-for 0.5 t)
      (set-buffer buffer)
      (goto-char (point-max))

      (should (search-backward "two")))))

(ert-deftest ar-ert-execute-region-SomeMode2-test-XOPWqH ()
  (ar-test
      "print(\"I'm the ar-ert-execute-region-SomeMode2-test\")"
    (let (ar-result
	  (ar-store-result-p t))
      (goto-char (point-max))
      (push-mark)
      (goto-char (point-min))
      (ar-execute-region-SomeMode2 (region-beginning) (region-end))
      (sit-for 0.1 t)
      (should (string-match "ar-ert-execute-region-SomeMode2-test" ar-result)))))

(ert-deftest ar-ert-execute-statement-SomeMode2-fast-1-7RNU3c ()
  (ar-test-point-min
   "print(1)"
   (let ((ar-fast-process-p t)
	 (ar-return-result-p t)
	 ar-result
	 (ar-store-result-p t))
     (ar-execute-statement "SomeMode2")
     (should (string= "1" ar-result)))))

(ert-deftest ar-ert-execute-statement-SomeMode2-test-Z1bsHy ()
  (ar-test-point-min
      "print(\"I'm the ar-execute-statement-SomeMode2-test\")"
    (when ar-debug-p (switch-to-buffer (current-buffer))
	  (jit-lock-fontify-now))
    (ar-execute-statement-SomeMode2)
    (set-buffer "*SOME2*")
    (goto-char (point-max))
    (sit-for 0.2 t)
    (and (should (search-backward "ar-execute-statement-SomeMode2-test" nil t 1))
	 (ar-kill-buffer-unconditional (current-buffer)))))

(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-SomeMode2-test ()
  (ar-test
      "#! /usr/bin/env SomeMode2
# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-SomeMode2-test\")"
    (delete-other-windows)
    (let* ((ar-split-window-on-execute 'just-two)
	   (erg1 (progn (ar-execute-statement-SomeMode2-dedicated) ar-output-buffer))
	   (erg2 (progn (ar-execute-statement-SomeMode2-dedicated) ar-output-buffer)))
      ;; (sit-for 0.1 t)
      (when ar-debug-p (message "(count-windows) %s" (count-windows)))
      (should (eq 2 (count-windows)))
      (ar-kill-buffer-unconditional erg1)
      (ar-kill-buffer-unconditional erg2)
      (ar-restore-window-configuration))))

(ert-deftest ar-face-lp-1454858-SomeMode2-1-test-cBoEWe ()
  (ar-test
      "#! /usr/bin/env SomeMode2
file.close()"
    (goto-char(point-max))
    (let ((ar-SomeMode-edit-version ""))
      (font-lock-fontify-region (point-min) (point-max))
      (forward-line 1)
      (should (eq (face-at-point) 'ar-builtins-face)))))

(ert-deftest ar-face-lp-1454858-SomeMode2-3-test-X7oyjk ()
  (ar-test
      "#! /usr/bin/env SomeMode2
print()"
    (goto-char(point-max))
    (let ((ar-SomeMode-edit-version ""))
      (font-lock-fontify-region (point-min) (point-max))
      (forward-line 1)
      (should (eq (face-at-point) 'font-lock-keyword-face)))))

(ert-deftest ar-face-lp-1454858-SomeMode3-3-test-xPEpuc ()
  (let ((ar-SomeMode-edit-version "SomeMode3"))
    (ar-test
	"#! /usr/bin/env SomeMode2
print()"
      (goto-char (point-max))
      (beginning-of-line)
      (sit-for 0.1)
      (should (eq (face-at-point) 'ar-builtins-face)))))

(ert-deftest ar-shell-SomeMode2-lp-1398530-test-TaiABe ()
  (when (buffer-live-p (get-buffer "*SOME2*"))(ar-kill-buffer-unconditional "*SOME2*"))
  (ar-test
      ""
    (when ar-debug-p (switch-to-buffer (current-buffer)))
    (let ((ar-shell-name "SomeMode2"))
      (ar-shell)
      (sit-for 0.1 t)
      (should (buffer-live-p (get-buffer "*SOME2*"))))))

(ert-deftest ar-complete-in-SomeMode-shell-test-LYnVJh ()
  (ignore-errors (ar-kill-buffer-unconditional "*SOME*"))
  (ignore-errors (ar-kill-buffer-unconditional "*SOME3*"))
  (set-buffer (SomeMode))
  (goto-char (point-max))
  (insert "pri")
  (ar-indent-or-complete)
  (sit-for 0.1)
  (should (or (eq ?t (char-before))(eq ?\( (char-before)))))

(provide 'ar-ert-SomeMode2-tests)
;;; ar-ert-SomeMode2-tests.el here
