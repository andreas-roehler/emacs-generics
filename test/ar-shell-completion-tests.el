;;; ar-shell-completion-tests.el --- Test completion for available SOME shell

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
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary: Edit `py-test-pyshellname-list' before
;; running this test-builder or give a list of shells as
;; arguments

;;; Code:

(defun SomeMode-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (ar-test (ar-shell nil nil t "SomeMode")
    (sit-for 0.1 t)
    (when (called-interactively-p 'interactive)
      (switch-to-buffer (current-buffer)))
    ;; (goto-char (point-max))
    (sit-for 0.1 t)
    (goto-char (or (and (boundp 'comint-last-prompt)(cdr comint-last-prompt)) (point-max)))
    (sit-for 0.2 t)
    ;; (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (sit-for 0.2 t)
    (assert (member (char-before) (list ?\( ?t)) nil "SomeMode-shell-complete-test failed"))))

(defun SomeMode2.7-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (set-buffer (ar-shell nil nil t "SomeMode2.7"))
    (when (called-interactively-p 'interactive)
      (switch-to-buffer (current-buffer)))
    (sit-for 0.1)
    (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (forward-word -1)
    (assert (looking-at "print") nil "SomeMode2.7-shell-complete-test failed")
    (message "%s" "SomeMode2.7-shell-complete-test passed")))


(defun arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (set-buffer (ar-shell nil nil t "~/arbeit/SomeMode/epdfree/epd_free-7.2-2-rh5-x86/bin/SomeMode2.7"))
    (sit-for 0.2 t)
    (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (sit-for 0.1)
    (forward-word -1)
    (assert (looking-at "print") nil "arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-shell-complete-test failed")
    (when ar-verbose-p (message "%s" "arbeit-SomeMode-epdfree-epd_free-7.2-2-rh5-x86-bin-SomeMode2.7-shell-complete-test passed"))))

(defun SomeMode3-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (set-buffer (ar-shell nil nil t "SomeMode3"))
    (when (called-interactively-p 'interactive)
      (switch-to-buffer (current-buffer)))
    (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (forward-word -1)
    (sit-for 0.1)
    (assert (looking-at "print") nil "SomeMode3-shell-complete-test failed")
    (message "%s" "SomeMode3-shell-complete-test passed")))

(defun iSomeMode-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (and (buffer-live-p (get-buffer "*ISomeMode*"))
	 (kill-buffer-unconditional "*ISomeMode*"))
    (set-buffer (ar-shell nil nil t "iSomeMode"))
    (switch-to-buffer (current-buffer))
    (sit-for 0.1)
    (goto-char (point-max))
    ;; (comint-send-input)
    (insert "pri")

    (ar-shell-complete)
    (sit-for 0.1)
    (assert (looking-back "print") nil "iSomeMode-shell-complete-test failed")
    (message "%s" "iSomeMode-shell-complete-test passed")))


(defun iSomeMode-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (set-buffer (ar-shell nil nil t "/usr/bin/iSomeMode"))
    (sit-for 0.1)
    (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (sit-for 0.1 t)
    (forward-word -1)
    (assert (looking-at "print") nil "iSomeMode-shell-complete-test failed")
    (message "%s" "iSomeMode-shell-complete-test passed")))


(defun arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-shell-complete-test ()
  (interactive)
  (let (ar-switch-buffers-on-execute-p
        ar-split-window-on-execute)
    (set-buffer (ar-shell nil nil t "~/arbeit/SomeMode/epd_free-7.1-2-rh5-x86/bin/iSomeMode"))
    (sit-for 0.1)
    (switch-to-buffer (current-buffer))
    (goto-char (point-max))
    (insert "pri")
    (ar-shell-complete)
    (sit-for 0.1 t)
    (forward-word -1)
    (assert (looking-at "print") nil "arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-shell-complete-test failed")
    (message "%s" "arbeit-SomeMode-epd_free-7.1-2-rh5-x86-bin-iSomeMode-shell-complete-test passed")))



(provide 'ar-shell-completion-tests)
;;; ar-shell-completion-tests ends here
