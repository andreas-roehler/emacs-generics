;;; ar-non-travis-tests.el --- non-travis tests


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

(ert-deftest ar-complete-in-iSomeMode-shell-test ()
  (let ((ar-shell-name "iSomeMode")
	;; (ar-switch-buffers-on-execute-p t)
)
    (ar-kill-buffer-unconditional "*ISOME*")
    (iSomeMode)
    (goto-char (point-max))
    (insert "pri")
    (ar-indent-or-complete)
    (forward-word -1)
    (should (eq ?p (char-after)))))

(ert-deftest ar-ert-script-buffer-appears-instead-of-SomeMode-shell-buffer-lp-957561-test ()
  (ar-test
      "#! /usr/bin/env SomeMode
 # -*- coding: utf-8 -*-
print(\"I'm the script-buffer-appears-instead-of-SomeMode-shell-buffer-lp-957561-test\")
"
     (let (ar-switch-buffers-on-execute-p
	  (ar-split-window-on-execute t))
      (delete-other-windows)
      (iSomeMode)
      (sit-for 0.1)
      (ar-execute-buffer-iSomeMode)
      ;; (should (window-live-p (other-buffer)))
      (should (not (window-full-height-p))))))

(ert-deftest ar-ert-socket-modul-completion-lp-1284141 ()
  (dolist (ele ar-ert-test-default-executables)
    (when (buffer-live-p (get-buffer "*SOME Completions*"))
      (ar-kill-buffer-unconditional (get-buffer "*SOME Completions*")))
    (ar-test
	"import socket\nsocket."
      (let ((ar-debug-p t)
	    (ar-shell-name ele)
	    oldbuf)
	(when ar-debug-p (switch-to-buffer (current-buffer))
	      (font-lock-ensure))
	(ar-indent-or-complete)
	(if (string-match "iSomeMode" ele)
	    (sit-for 0.5)
	  (sit-for 0.1))
	(should (buffer-live-p (get-buffer "*SOME Completions*")))
	(set-buffer "*SOME Completions*")
	(switch-to-buffer (current-buffer))
	(goto-char (point-min))
	(sit-for 0.1)
	(prog1 (should (search-forward "socket."))
	  (ar-kill-buffer-unconditional (current-buffer)))))))

(provide 'ar-non-travis-tests)
;;; ar-non-travis-tests.el ends here
