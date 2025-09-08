;;; ar-interactive-tests.el --- test interactively -*- lexical-binding: t; -*-

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

;;; Commentary: These tests fail in batch-mode

;;

;;; Code:

(require 'ar-setup-ert-tests)

;; (defun ar-imports-in-interactive-shell-lp-1290709-lZvVlc ()
;;   ""
;;   (interactive)
;;   (when (buffer-live-p (get-buffer "*SOME*"))
;;     (ar-kill-buffer-unconditional (get-buffer "*SOME*")))
;;   (when (buffer-live-p (get-buffer "*SOME3*")) (ar-kill-buffer-unconditional (get-buffer "*SOME3*")))
;;   (let ((buffer (ar-shell nil nil "SomeMode")))
;;     (set-buffer buffer)
;;     (delete-other-windows)
;;     (let ((full-height (window-height)))
;;       (ar-execute-string "import os" (get-buffer-process (current-buffer)))
;;       (sit-for 0.1)
;;       (goto-char (point-max))
;;       ;; (sit-for 0.1 t)
;;       (insert "print(os.get")
;;       (ar-indent-or-complete)
;;       (sit-for 0.1 t)
;;       (should (< (window-height) full-height)))))

(defun ar-fill-paragraph-lp-1291493-JPuJd3 ()
  ""
  (interactive)
  (ar-test-point-min
   "if True:
    if True:
        if True:
            if True:
                pass
def foo():
    \"\"\"Foo\"\"\"
"
   'SomeMode-mode
   'ar-verbose-p
   (sit-for 0.1 t)
   (search-forward "\"\"\"")
   (fill-paragraph)
   (sit-for 0.1 t)
   (should (eq 7 (current-column)))))

(defun ar-imports-in-interactive-shell-lp-1290709-lZvVlc ()
  ""
  (interactive)
  ""
  (when (buffer-live-p (get-buffer "*SOME*"))
    (ar-kill-buffer-unconditional (get-buffer "*SOME*")))
  (when (buffer-live-p (get-buffer "*SOME3*")) (ar-kill-buffer-unconditional (get-buffer "*SOME3*")))
  (let ((buffer (ar-shell nil nil "SomeMode")))
    (save-excursion
      (set-buffer buffer)
      (delete-other-windows)
      (let ((full-height (window-height)))
        (ar-execute-string "import os" (get-buffer-process (current-buffer)))
        (sit-for 0.1)
        (goto-char (point-max))
        ;; (sit-for 0.1 t)
        (insert "print(os.get")
        (ar-indent-or-complete)
        (sit-for 0.1 t)
        (should (eq (window-height) full-height))))))

(defun ar-execute-region-iSomeMode-lp-1294796-HePARg ()
  ""
  (interactive)
  (ar-test-point-min
   "print(1)
"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-shell-name "iSomeMode")
	 ar-split-window-on-execute
	 ar-switch-buffers-on-execute-p)
     (if (executable-find "iSomeMode")
	 (progn
	   (ar-execute-buffer)
	   (sit-for 0.5 t)
	   (set-buffer "*ISOME*")
	   (goto-char (point-max))
	   (should (search-backward "1")))
       (message "%s" "iSomeMode does not exist on your system.")))))

(defun ar-execute-region-iSomeMode3-lp-1294796-HePARg ()
  ""
  (interactive)
  (ar-test-point-min
   "print(1)
"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-shell-name "iSomeMode3")
	 ar-split-window-on-execute
	 ar-switch-buffers-on-execute-p)
     (if (executable-find "iSomeMode3")
	 (progn
	   (ar-execute-buffer)
	   (sit-for 0.5 t)
	   (set-buffer "*ISOME3*")
	   (goto-char (point-max))
	   (should (search-backward "1")))
       (message "%s" "iSomeMode3 does not exist on your system.")))))

(defun ar-execute-expression-test-bogDOp ()
  ""
  (interactive)
  (ar-test-point-min
   "print(\"I'm the ar-execute-expression-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-shell-name "SomeMode"))
     (ar-execute-expression)
     (sit-for 0.1 t)
     ;; (switch-to-buffer (current-buffer))
     (sit-for 0.1 t)
     (and (should
	   (or
	    (search-backward "ar-execute-expression-test" nil t 1)
	    (search-forward "ar-execute-expression-test" nil t 1)))
	  (ar-kill-buffer-unconditional (current-buffer))))))

(defun ar-execute-line-test-jU3Xgu ()
  ""
  (interactive)
  (ar-test-point-min
   "print(\"I'm the ar-execute-line-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-shell-name (or
                         (executable-find "SomeMode")
                         (executable-find "SomeMode3"))))
     (sit-for 0.1 t)
     (ar-execute-line)
     (set-buffer ar-output-buffer)
     (sit-for 0.1 t)
     (and (should
	   (or
	    (search-backward "ar-execute-line-test" nil t 1)
	    (search-forward "ar-execute-line-test" nil t 1)))
	  (ar-kill-buffer-unconditional (current-buffer))))))

(defun ar-always-reuse-lp-1361531-test-dJBO5C ()
  ""
  (interactive)
  (ar-test
      "# -*- coding: utf-8 -*-
print(\"I'm the ar-always-reuse-lp-1361531-test\")
from datetime import datetime; datetime.now()"
    'SomeMode-mode
    'ar-verbose-p
    (delete-other-windows)
    (let* ((ar-split-window-on-execute 'always)
	   ar-switch-buffers-on-execute-p
	   ar-dedicated-process-p)
      (ar-execute-statement-SomeMode3)
      (ar-execute-statement-SomeMode3)
      (set-buffer "*SOME3*")
      (goto-char (point-max))
      (should (< 1 (count-matches "lp-1361531-test" (point-min) (point))))
      ;; (ar-restore-window-configuration)
      )))

(defun ar-just-two-split-dedicated-lp-1361531-iSomeMode-test-zGlzYP ()
  ""
  (interactive)
  (ar-test
   "#! /usr/bin/env iSomeMode
# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-iSomeMode-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (if (executable-find "iSomeMode")
       (progn
	 (delete-other-windows)
	 (let* ((ar-split-window-on-execute 'just-two)
		(erg1 (progn (ar-execute-statement-iSomeMode-dedicated) ar-output-buffer))
		(erg2 (progn (ar-execute-statement-iSomeMode-dedicated) ar-output-buffer)))
	   ;; (sit-for 0.1 t)
	   (when ar-debug-p (message "(count-windows) %s" (count-windows)))
	   (should (eq 2 (count-windows)))
	   (ar-kill-buffer-unconditional erg1)
	   (ar-kill-buffer-unconditional erg2)
	   (ar-restore-window-configuration)))
     (message "%s" "iSomeMode does not exist on your system."))))

(defun ar-just-two-split-dedicated-lp-1361531-iSomeMode3-test-zGlzYP ()
  ""
  (interactive)
  (ar-test
   "#! /usr/bin/env iSomeMode
# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-iSomeMode-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (if (executable-find "iSomeMode3")
       (progn
	 (delete-other-windows)
	 (let* ((ar-split-window-on-execute 'just-two)
		(erg1 (progn (ar-execute-statement-iSomeMode3-dedicated) ar-output-buffer))
		(erg2 (progn (ar-execute-statement-iSomeMode3-dedicated) ar-output-buffer)))
	   ;; (sit-for 0.1 t)
	   (when ar-debug-p (message "(count-windows) %s" (count-windows)))
	   (should (eq 2 (count-windows)))
	   (ar-kill-buffer-unconditional erg1)
	   (ar-kill-buffer-unconditional erg2)
	   (ar-restore-window-configuration)))
     (message "%s" "iSomeMode3 does not exist on your system."))))

(defun ar-just-two-split-dedicated-lp-1361531-jython-test-Nh6zdU ()
  ""
  (interactive)
  (ar-test
   "#! /usr/bin/env jython
# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-jython-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (delete-other-windows)
   (let* ((ar-split-window-on-execute 'just-two)
	  (erg1 (progn (ar-execute-statement-jython-dedicated) ar-output-buffer))
	  (erg2 (progn (ar-execute-statement-jython-dedicated) ar-output-buffer)))
     ;; (sit-for 0.1 t)
     (when ar-debug-p (message "(count-windows) %s" (count-windows)))
     (should (eq 2 (count-windows)))
     (ar-kill-buffer-unconditional erg1)
     (ar-kill-buffer-unconditional erg2)
     (ar-restore-window-configuration))))

;; (defun ar-flycheck-mode-test-5Yz7A2 ()
;;   ""
;;   (interactive)
;;   (ar-test
;;    ""
;;    (ar-flycheck-mode -1)
;;    (should-not flycheck-mode)
;;    (ar-flycheck-mode 1)
;;    (should flycheck-mode)
;;    (ar-flycheck-mode -1)
;;    (should-not flycheck-mode)))

(defun ar-face-lp-1454858-SomeMode3-1-test-3lRWI6 ()
  ""
  (interactive)
  (ar-test
   "file.close()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version ""))
     (goto-char (point-max))
     (beginning-of-line)
     (should-not (face-at-point)))))

(defun ar-face-lp-1454858-SomeMode3-2-test-R3JIC9 ()
  ""
  (interactive)
  (ar-test
   "file.close()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version "SomeMode3"))
     (goto-char (point-max))
     (beginning-of-line)
     (should-not (face-at-point)))))

(defun ar-face-lp-1454858-SomeMode3-4-test-dHIVmf ()
  ""
  (interactive)
  (ar-test
   "print()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version ""))
     (goto-char (point-max))
     (search-backward "print")
     (sit-for 0.1)
     (should (eq (face-at-point) 'ar-builtins-face)))))

(defun ar-execute-statement-split-rGDJdi ()
  ""
  (interactive)
  (ar-test-point-min
   "print(123)"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-split-window-on-execute t))
     (delete-other-windows)
     (ar-execute-statement)
     (sit-for 0.1 t)
     (should (not (one-window-p))))))

(defun ar-ar-execute-section-test-bsHl0k ()
  ""
  (interactive)
  (ar-test
   "# {{
print(3+3)
# }}"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-store-result-p t))
     (search-backward "print")
     (ar-execute-section)
     (sleep-for 0.1)
     (should (string= ar-result "6")))))

(defun ar-match-paren-test-3-xtdxLn ()
  ""
  (interactive)
  (ar-test
   "if __name__ == \"__main__\":
    main()
"
   'SomeMode-mode
   'ar-verbose-p
   (skip-chars-backward " \t\r\n\f")
   (back-to-indentation)
   (ar-match-paren)
   (should (eq 4 (current-column)))))

(defun ar-match-paren-test-6-p1JAuq ()
  ""
  (interactive)
  (ar-test
   "class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    # zeit = time.strftime('%Y-%m-%d--%H-%M-%S')
    spiel = []
    gruen = [0]
    rot = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        fertig = ''
#        print \"treffer, schwarz, gruen, rot, pair, impair, passe, manque, spiel\"
        if treffer in gruen:
            # print \"0, Gruen\"
            ausgabe[1] = treffer
            ausgabe[2] = treffer
        elif treffer in schwarz:
            # print \"%i, Schwarz\" % (treffer)
            ausgabe[1] = treffer
if __name__ == \"__main__\":
    main()
"
   'SomeMode-mode
   'ar-verbose-p
   (search-backward "(treffer)")
   (skip-chars-backward "^\"")
   (forward-char -1)
   (ar-match-paren)
   (should (eq (char-after) ?#))
   (ar-match-paren)
   (should (eq (char-before) ?\)))
   (should (eolp))))

(defun ar-moves-up-fill-paragraph-pep-257-nn-2-rq3mat ()
  ""
  (interactive)
  (ar-test-point-min
   "class MyClass(object):
    def my_method(self):
        \"\"\"Some long line with more than 70 characters in the docstring. Some more text.\"\"\"
"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-docstring-style 'pep-257-nn))
     (goto-char (point-min))
     (search-forward "\"\"\"")
     (fill-paragraph)
     (search-forward "\"\"\"")
     (should (eq 8 (current-indentation))))))

(defun ar-split-window-on-execute-1361535-test-fK4Nqy ()
  ""
  (interactive)
  (ar-test-point-min
   "print(\"%(language)s has %(number)03d quote types.\" %
       {'language': \"SOME\", \"number\": 2})"
   'SomeMode-mode
   'ar-verbose-p
   (let ((oldbuf (current-buffer))
	 (ar-split-window-on-execute t)
	 (ar-split-window-on-execute-threshold 3))
     (ar-shell)
     (set-buffer oldbuf)
     (switch-to-buffer (current-buffer))
     (delete-other-windows)
     (split-window-vertically)
     (dired "~")
     (set-buffer oldbuf)
     (switch-to-buffer (current-buffer))
     (split-window-horizontally)
     (ar-execute-statement)
     (should (eq 3 (length (window-list)))))))

(defun ar-backward-toplevel-test-Rfa4ZA ()
  ""
  (interactive)
  (ar-test
   "''' asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf
'''
a, b, c = (1, 2, 3)"
   'SomeMode-mode
   'ar-verbose-p
   (beginning-of-line)
   (ar-backward-top-level)
   (should (bobp))
   ;; (should (eq (point) 1))
   ))

(defun ar-pdbtrack-input-prompt-45-test-xhbEyD ()
  ""
  (interactive)
  (ar-test
   "def exercise():
  import pdb\\; pdb.set_trace()
  x = \"hello\"
  y = \"darkness\"
  print(x)
exercise()"
   'SomeMode-mode
   'ar-verbose-p
   (ar-execute-buffer)
   (set-buffer ar-output-buffer)
   (switch-to-buffer (current-buffer))
   (message "prompt-45: %s" (buffer-name (current-buffer)))
   (message "Nach Prompt: %s" (buffer-substring-no-properties (1- (line-beginning-position)) (point)))
   (sit-for 1)
   (should (looking-back ar-pdbtrack-input-prompt))))

(defun ar-pdbtrack-input-prompt-45-test-7V1h5F ()
  ""
  (interactive)
  (ar-test
   "def exercise():
  import pdb\\; pdb.set_trace()
  x = \"hello\"
  y = \"darkness\"
  print(x)
exercise()"
   'SomeMode-mode
   'ar-verbose-p
   (ar-execute-buffer)
   (set-buffer ar-output-buffer)
   (switch-to-buffer (current-buffer))
   (message "prompt-45: %s" (buffer-name (current-buffer)))
   (message "Nach Prompt: %s" (buffer-substring-no-properties (1- (line-beginning-position)) (point)))
   (sit-for 1)
   (should (looking-back ar-pdbtrack-input-prompt (line-beginning-position)))))

(defun ar-pdbtrack-is-tracking-45-test-N1CTvI ()
  ""
  (interactive)
  (ar-test
   "def exercise():
  import pdb\\; pdb.set_trace()
  x = \"hello\"
  y = \"darkness\"
  print(x)
exercise()"
   'SomeMode-mode
   'ar-verbose-p
   (ar-execute-buffer)
   (switch-to-buffer ar-output-buffer)
   (should ar-pdbtrack-is-tracking-p)))

(defun ar-pdbtrack-is-tracking-45-test-ra9WRA ()
  ""
  (interactive)
  (ar-test
   "def exercise():
  import pdb\\; pdb.set_trace()
  x = \"hello\"
  y = \"darkness\"
  print(x)
exercise()"
   'SomeMode-mode
   ar-verbose-p))

(defun ar-moves-up-fill-paragraph-lp-1286318 ()
  ""
  (interactive)
  (ar-test-point-min
   "# r1416
def baz():
    \"\"\"Hello there.
    This is a multiline function definition. Don= 't worry, be happy. Be very very happy. Very. happy.
    \"\"\"
    return 7
# The last line of the docstring is longer than fill-column (set to
# 78 = for me). Put point on the 'T' in 'This' and hit M-q= . Nothing
# happens.
#
# Another example:
#
def baz():
    \"\"\"Hello there.
    This is a multiline
    function definition.
    Don't worry, be happy.
    Be very very happy.
    Very. happy.
    \"\"\"
    return 7
# All of those lines are shorter than fill-column. Put point anywhere
# = in that paragraph and hit M-q. Nothing happens.
#
# In both cases I would expect to end up with:
#
def baz():
    \"\"\"Hello there.
    This is a multiline function definition. Don= 't worry, be happy. Be very
    very happy. Very. happy.
    \"\"\"
    return 7
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char 49)
   ;; (sit-for 0.1 t)
   (fill-paragraph)
   (end-of-line)
   (should (<= (current-column) 72))
   (goto-char 409)
   (fill-paragraph)
   (end-of-line)
   (should (<= (current-column) 72))
   (goto-char 731)
   (fill-paragraph)
   (end-of-line)
   (should (<= (current-column) 72))
   (search-forward "\"\"\"")
   (forward-line -1)
   ;; (sit-for 0.1 t)
   (should (not (ar-empty-line-p)))))

(defun ar-if-name-main-permission-lp-326620-test-CZefpG ()
  ""
  (interactive)
  (ar-test-point-min
   "#! /usr/bin/env SomeMode2
# -*- coding: utf-8 -*-
def py_if_name_main_permission_test():
    if __name__ == \"__main__\" :
        print(\"__name__ == '__main__' run\")
        return True
    else:
        print(\"__name__ == '__main__' supressed\")
        return False
py_if_name_main_permission_test()
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (let ((ar-if-name-main-permission-p t))
     (ar-execute-buffer-SomeMode2)
     (set-buffer "*SOME2*")
     (goto-char (point-max))
     (sit-for 0.1)
     (should (search-backward "run" nil t)))))

(defun ar-in-list-indent-test-LEON2Q ()
  ""
  (interactive)
  (ar-test
   "def foo():
print(rest)"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "rest")
   (ar-indent-or-complete)
   ;; (switch-to-buffer (current-buffer))
   ;; (message "ar-in-list-indent-test-LEON2Q (current-buffer):  %s" (current-buffer))
   ;; (sit-for 1)
   (should (eq 4 (current-indentation)))))

(defun ar-indent-inconsistent-test-Zh2hP0 ()
  ""
  (interactive)
  (ar-test
   "def lcs (first):
    for i in range(len(first)):
        print(first[i])
        print(i)
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "print" nil t 2)
   (ar-indent-line)
   (should (eq 8 (current-indentation)))
   (forward-line 1)
   (back-to-indentation)
   (ar-indent-line)
   (should (eq 8 (current-indentation)))))

(defun ar-indentation-lp-1375122-test-yx67am ()
  ""
  (interactive)
  (ar-test
   "def foo():
    if True:
pass
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -1)
   (ar-indent-or-complete)
   (sit-for 0.1 t)
   (should (eq 8 (current-column)))
   (beginning-of-line)
   (delete-horizontal-space)
   (indent-to 4)
   (ar-indent-or-complete)
   (sit-for 0.1 t)
   (should (eq 8 (current-column)))))

(defun ar-just-two-split-dedicated-lp-1361531-SomeMode3-test ()
  ""
  (interactive)
  (ar-test
   "# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-SomeMode3-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (delete-other-windows)
   (let* ((ar-split-window-on-execute 'just-two)
	  (erg1 (progn (ar-execute-statement-SomeMode3-dedicated) ar-output-buffer))
	  (erg2 (progn (ar-execute-statement-SomeMode3-dedicated) ar-output-buffer)))
     ;; (sit-for 0.1 t)
     (when ar-debug-p (message "(count-windows) %s" (count-windows)))
     (should (eq 2 (count-windows)))
     (ar-kill-buffer-unconditional erg1)
     (ar-kill-buffer-unconditional erg2)
     (ar-restore-window-configuration))))

(defun ar-shell-dedicated-buffer-test-t3Sizn ()
  ""
  (interactive)
  (let ((buffer (ar-shell nil nil t)))
  (should (buffer-live-p buffer))))

(defun ar-SomeMode3-shell-test-YW7ToN ()
  ""
  (interactive)
  ""
  'SomeMode-mode
  'ar-verbose-p
  (let ((erg (SomeMode3))
        erg)
    (should (bufferp (get-buffer erg)))
    (should (get-buffer-process erg))))

(defun ar-SomeMode2-shell-test-8Ostfe ()
  ""
  (interactive)
  ""
  'SomeMode-mode
  'ar-verbose-p
  (let ((erg (SomeMode2)))
    (sit-for 0.1)
    (should (bufferp (get-buffer erg)))
    (should (get-buffer-process erg))))

(defun ar-keep-windows-configuration-test-Hh2GD6 ()
  ""
  (interactive)
  (ar-test
   "print('ar-keep-windows-configuration-test-string')"
   'SomeMode-mode
   'ar-verbose-p
   (delete-other-windows)
   (let ((ar-keep-windows-configuration t)
         (ar-split-window-on-execute t)
         (full-height (window-height)))
     (ar-execute-statement)
     (should (eq (window-height) full-height)))))

(defun ar-shell-test-t3Sizn ()
  ""
  (interactive)
  (ar-test
      ""
    'SomeMode-mode
    'ar-verbose-p
    (let ((buffer (ar-shell nil nil t)))
      (sit-for 0.1)
      (with-current-buffer buffer
        (goto-char (point-max))
        (insert "def")
        (should (looking-back "def" (line-beginning-position)))))))

(defun ar-shell-test-3uMnzx ()
  ""
  (interactive)
  (ar-test
      ""
    'SomeMode-mode
    'ar-verbose-p
    (with-current-buffer (ar-shell nil nil t)
      (goto-char (point-max))
      (insert "def")
      (should (looking-back "def" (line-beginning-position))))))

(defun ar-execute-import-or-reload-test-ZYUvdh ()
  ""
  (interactive)
  (ar-test
   "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
import os"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (should (ar-execute-import-or-reload))))

(defun ar-master-file-not-honored-lp-794850-test-P6QZmU ()
  ""
  (interactive)
  (ar-test
   "
# -*- coding: utf-8 -*-
# Local Variables:
# ar-master-file: \"/tmp/my-master.py\"
# End:
 "
   'SomeMode-mode
   'ar-verbose-p
   (let ((oldbuf (current-buffer)))
     (save-excursion
       (set-buffer (get-buffer-create "test-master.py"))
       (erase-buffer)
       (insert "#! /usr/bin/env SomeMode
 # -*- coding: utf-8 -*-
print(\"Hello, I'm your master!\")
")
       (write-file "/tmp/my-master.py"))
     (set-buffer oldbuf)
     (unwind-protect
         (ar-execute-buffer)
       (when (file-readable-p "/tmp/my-master.py") (delete-file "/tmp/my-master.py"))))))

(defun ar-moves-up-fill-paragraph-test-symmetric-i6vspv ()
  ""
  (interactive)
  (let ((ar-docstring-style 'symmetric))
    (ar-test-point-min
     "# r1416
def baz():
    \"\"\"Hello there. This is a multiline function definition. Don= 't worry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don= 't worry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don= 't worry, be happy. Be very very happy. Very. happy.
    This is a multiline function definition. Don= 't worry, be happy. Be very very happy. Very. happy.
    \"\"\"
    return 7
"
     'SomeMode-mode
     'ar-verbose-p
     (goto-char (point-min))
     (font-lock-fontify-region (point-min)(point-max))
     (goto-char 49)
     (fill-paragraph)
     (search-backward "\"\"\"")
     (goto-char (match-end 0))
     (eolp)
     (forward-line 1)
     (end-of-line)
     (should (<= (current-column) 72))
     (search-forward "\"\"\"")
     (forward-line -1)
     (should (not (ar-empty-line-p))))))

(defun ar-run-SomeMode-test-QDE84k ()
    "Test built-in SomeMode.el."
  (interactive)
  (let (SomeMode-indent-guess-indent-offset-verbose)
    (run-SomeMode)
    (should (buffer-live-p (get-buffer "*SOME*")))))

(defun ar-wrong-indent-inside-string-lp-1574731-test-P19RGY ()
  ""
  (interactive)
  (ar-test
   "def foo():
    print(\"\"\"
Bar
\"\"\")
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -3)
   (should (eq 10 (ar-compute-indentation)))))

(defun ar-moves-up-fill-paragraph-test-django-76Aw4O ()
  ""
  (interactive)
  (ar-test-point-min
   "# r1416
def baz():
    \"\"\"Hello there. This is a multiline function definition. Don't wor ry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy.
    This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy.
    Line below should not be empty, when ‘ar-docstring-style’ is not ‘PEP-257’.
    \"\"\"
    return 7
"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-docstring-style 'django))
     (goto-char 49)
     (fill-paragraph)
     (search-backward "\"\"\"")
     (goto-char (match-end 0))
     (should (eolp))
     (forward-line 1)
     (end-of-line)
     (when ar-debug-p (message "fill-column: %s" fill-column))
     (should (<= (current-column) 72)))))

(defun ar-moves-up-fill-paragraph-test-django-w8Rbx5 ()
  ""
  (interactive)
  (ar-test-point-min
   "# r1416
def baz():
    \"\"\"Hello there. This is a multiline function definition. Don't wor ry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy. This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy.
    This is a multiline function definition. Don't worry, be happy. Be very very happy. Very. happy.
    Line below should not be empty, when ‘ar-docstring-style’ is not ‘PEP-257’.
    \"\"\"
    return 7
"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-docstring-style 'django))
     (goto-char 49)
     (when ar-debug-p (message "fill-column: %s" fill-column))
     (fill-paragraph)
     (ar-end-of-string)
     (forward-line -1)
     (should-not (ar-empty-line-p)))))

(defun ar-up-string-test-DVKVO2 ()
  ""
  (interactive)
  (ar-test
   "class M:
    def __init__(self):
        \"\"\"Helper function implementing the current module loader policy.1
        In SOME 3.14, the end state is to require and use the module's
        __spec__.loader and ignore any __loader__ attribute on the
        module.
        * If you have a __loader__ and a __spec__.loader but they are not the
        same, in SOME 3.12 we issue a DeprecationWarning and fall back to
        __loader__ for backward compatibility.  In SOME 3.14, we'll flip
        this case to ignoring __loader__ entirely, without error.
        \"\"\"
        self.a = 1
        self.b = 2"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "error")
   ;; (and ar-debug-p (message "ar-version: %s" ar-version))
   ;; (font-lock-ensure)
   ;; (sit-for 0.1)
   (ignore-errors (call-interactively (ar-up)))
   (should (eq (char-after) 34))
   (should (eq (char-before) 32))))

(defun ar-backspace-test-86TyUY ()
  ""
  (interactive)
  (ar-test
   "a = b = c = 5     "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace-mode -1)
   (execute-kbd-macro (kbd "<backspace>"))
   (should (eq (point) 18))))

(defun ar-backspace-test-xyFFow ()
  ""
  (interactive)
  (ar-test
   "a = b = c = 5     "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace-mode 1)
   (execute-kbd-macro (kbd "<backspace>"))
   (should (eq (point) 14))))

(defun ar-up-string-test-NJ7sie ()
  ""
  (interactive)
  (ar-test
   "class M:
    def __init__(self):
        \"\"\"Helper function implementing the current module loader policy.1
        In SOME 3.14, the end state is to require and use the module's
        __spec__.loader and ignore any __loader__ attribute on the
        module.
        * If you have a __loader__ and a __spec__.loader but they are not the
        same, in SOME 3.12 we issue a DeprecationWarning and fall back to
        __loader__ for backward compatibility.  In SOME 3.14, we'll flip
        this case to ignoring __loader__ entirely, without error.
        \"\"\"
        self.a = 1
        self.b = 2"
   'SomeMode-mode
   'ar-verbose-p
   ;; (font-lock-ensure)
   (goto-char (point-max))
   (search-backward "\"\"\"")
   (ar-up)
   (should (eq (char-after) 34))
   (should (eq (char-before) 32))))

(funcall 'ar-fill-paragraph-lp-1291493-JPuJd3)
(funcall 'ar-imports-in-interactive-shell-lp-1290709-lZvVlc)
(funcall 'ar-execute-region-iSomeMode-lp-1294796-HePARg)
(funcall 'ar-execute-region-iSomeMode3-lp-1294796-HePARg)
(funcall 'ar-execute-expression-test-bogDOp)
(funcall 'ar-execute-line-test-jU3Xgu)
(funcall 'ar-always-reuse-lp-1361531-test-dJBO5C)
(funcall 'ar-just-two-split-dedicated-lp-1361531-iSomeMode-test-zGlzYP)
(funcall 'ar-just-two-split-dedicated-lp-1361531-iSomeMode3-test-zGlzYP)
(funcall 'ar-just-two-split-dedicated-lp-1361531-jython-test-Nh6zdU)
(funcall 'ar-face-lp-1454858-SomeMode3-1-test-3lRWI6)
(funcall 'ar-face-lp-1454858-SomeMode3-2-test-R3JIC9)
(funcall 'ar-face-lp-1454858-SomeMode3-4-test-dHIVmf)
(funcall 'ar-execute-statement-split-rGDJdi)
(funcall 'ar-ar-execute-section-test-bsHl0k)
(funcall 'ar-match-paren-test-3-xtdxLn)
(funcall 'ar-match-paren-test-6-p1JAuq)
(funcall 'ar-moves-up-fill-paragraph-pep-257-nn-2-rq3mat)
(funcall 'ar-split-window-on-execute-1361535-test-fK4Nqy)
(funcall 'ar-backward-toplevel-test-Rfa4ZA)
(funcall 'ar-pdbtrack-input-prompt-45-test-xhbEyD)
(funcall 'ar-pdbtrack-input-prompt-45-test-7V1h5F)
(funcall 'ar-pdbtrack-is-tracking-45-test-N1CTvI)
(funcall 'ar-pdbtrack-is-tracking-45-test-ra9WRA)
(funcall 'ar-moves-up-fill-paragraph-lp-1286318)
(funcall 'ar-if-name-main-permission-lp-326620-test-CZefpG)
(funcall 'ar-in-list-indent-test-LEON2Q)
(funcall 'ar-indent-inconsistent-test-Zh2hP0)
(funcall 'ar-indentation-lp-1375122-test-yx67am)
(funcall 'ar-just-two-split-dedicated-lp-1361531-SomeMode3-test)
(funcall 'ar-shell-dedicated-buffer-test-t3Sizn)
(funcall 'ar-SomeMode3-shell-test-YW7ToN)
(funcall 'ar-SomeMode2-shell-test-8Ostfe)
(funcall 'ar-keep-windows-configuration-test-Hh2GD6)
(funcall 'ar-shell-test-t3Sizn)
(funcall 'ar-shell-test-3uMnzx)
(funcall 'ar-execute-import-or-reload-test-ZYUvdh)
(funcall 'ar-master-file-not-honored-lp-794850-test-P6QZmU)
(funcall 'ar-moves-up-fill-paragraph-test-symmetric-i6vspv)
(funcall 'ar-run-SomeMode-test-QDE84k)
(funcall 'ar-wrong-indent-inside-string-lp-1574731-test-P19RGY)
(funcall 'ar-moves-up-fill-paragraph-test-django-76Aw4O)
(funcall 'ar-moves-up-fill-paragraph-test-django-w8Rbx5)
(funcall 'ar-up-string-test-DVKVO2)
(funcall 'ar-backspace-test-86TyUY)
(funcall 'ar-backspace-test-xyFFow)
(funcall 'ar-up-string-test-NJ7sie)
(funcall 'ar-up-string-test-NJ7sie)

(provide 'ar-interactive-tests)
;;; ar-interactive-tests.el ends here
