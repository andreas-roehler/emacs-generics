;;; ar-ert-interactive-tests.el --- test interactively -*- lexical-binding: t; -*-

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

(ert-deftest ar-ert-fill-paragraph-lp-1291493-JPuJd3 ()
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

(ert-deftest ar-ert-execute-region-iSomeMode-lp-1294796-HePARg ()
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

(ert-deftest ar-ert-execute-region-iSomeMode3-lp-1294796-HePARg ()
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

(ert-deftest ar-ert-execute-expression-test-bogDOp ()
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

(ert-deftest ar-ert-execute-line-test-jU3Xgu ()
  (ar-test-point-min
   "print(\"I'm the ar-execute-line-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (ar-execute-line)
   (set-buffer ar-output-buffer)
   ;; (sit-for 0.1 t)
   (goto-char (point-max))
   (should (search-backward "ar-execute-line-test"))))

(ert-deftest ar-ert-always-reuse-lp-1361531-test-dJBO5C ()
  (ar-test
   "#! /usr/bin/env SomeMode3
# -*- coding: utf-8 -*-
print(\"I'm the ar-always-reuse-lp-1361531-test\")
from datetime import datetime; datetime.now()"
   'SomeMode-mode
   'ar-verbose-p
   ;; (delete-other-windows)
   (let* ((ar-split-window-on-execute 'always)
	  ar-switch-buffers-on-execute-p
	  ar-dedicated-process-p
          (oldbuf (current-buffer)))
     (ar-execute-statement-SomeMode3)
     ;; (save-excursion (ar-execute-statement-SomeMode))
     ;; (set-buffer oldbuf)
     ;; (when ar-debug-p (switch-to-buffer (current-buffer)))
     (ar-execute-statement-SomeMode)
     ;; (message "(window-list): %s" (window-list))
     ;; (sit-for 0.1 t)
     (should (eq 3 (count-windows)))
     ;; (ar-restore-window-configuration)
     )))

(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-iSomeMode-test-zGlzYP ()
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

(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-iSomeMode3-test-zGlzYP ()
  (ar-test
   "#! /usr/bin/env iSomeMode
# -*- coding: utf-8 -*-
print(\"I'm the ar-just-two-split-dedicated-lp-1361531-iSomeMode-test\")"
   'SomeMode-mode
   'ar-verbose-p
   (if (executable-find "iSomeMode3")
       (progn
	 ;; (delete-other-windows)
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

(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-jython-test-Nh6zdU ()
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

;; (ert-deftest ar-flycheck-mode-5Yz7A2 ()
;;   (ar-test
;;    ""
;;    (ar-flycheck-mode -1)
;;    (should-not flycheck-mode)
;;    (ar-flycheck-mode 1)
;;    (should flycheck-mode)
;;    (ar-flycheck-mode -1)
;;    (should-not flycheck-mode)))

(ert-deftest ar-face-lp-1454858-SomeMode3-1-test-3lRWI6 ()
  (ar-test
   "#! /usr/bin/env SomeMode3
file.close()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version ""))
     (goto-char (point-max))
     (beginning-of-line)
     (should-not (face-at-point)))))

(ert-deftest ar-face-lp-1454858-SomeMode3-2-test-R3JIC9 ()
  (ar-test
   "#! /usr/bin/env SomeMode3
file.close()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version "SomeMode3"))
     (goto-char (point-max))
     (beginning-of-line)
     (should-not (face-at-point)))))

(ert-deftest ar-face-lp-1454858-SomeMode3-4-test-dHIVmf ()
  (ar-test
   "#! /usr/bin/env SomeMode3
print()"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-SomeMode-edit-version ""))
     (goto-char (point-max))
     (search-backward "print")
     (sit-for 0.1)
     (should (eq (face-at-point) 'ar-builtins-face)))))

(ert-deftest ar-ert-execute-statement-split-rGDJdi ()
  (ar-test-point-min
   "print(123)"
   'SomeMode-mode
   'ar-verbose-p
   (let ((ar-split-window-on-execute t))
     (delete-other-windows)
     (ar-execute-statement)
     (sit-for 0.1 t)
     (should (not (one-window-p))))))

(ert-deftest ar-ert-ar-execute-section-test-bsHl0k ()
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

(ert-deftest ar-ert-match-paren-test-3-xtdxLn ()
  (ar-test
   "if __name__ == \"__main__\":
    main()
"
   'SomeMode-mode
   'ar-verbose-p
   (skip-chars-backward " \t\r\n\f")
   (back-to-indentation)
   (ar-match-paren)
   (should (eq 0 (current-indentation)))))

(ert-deftest ar-ert-match-paren-test-6-p1JAuq ()
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

(ert-deftest ar-ert-moves-up-fill-paragraph-pep-257-nn-2-rq3mat ()
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

(ert-deftest ar-ert-split-window-on-execute-1361535-test-fK4Nqy ()
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

(ert-deftest ar-backward-toplevel-test-Rfa4ZA ()
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

(ert-deftest ar-pdbtrack-input-prompt-45-test-xhbEyD ()
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

(ert-deftest ar-pdbtrack-input-prompt-45-test-7V1h5F ()
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

(ert-deftest ar-pdbtrack-is-tracking-45-test-N1CTvI ()
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

(ert-deftest ar-pdbtrack-is-tracking-45-test-ra9WRA ()
  (ar-test
   "def exercise():
  import pdb\\; pdb.set_trace()
  x = \"hello\"
  y = \"darkness\"
  print(x)
exercise()"
   'SomeMode-mode
   ar-verbose-p))

(ert-deftest ar-ert-moves-up-fill-paragraph-lp-1286318 ()
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

(ert-deftest ar-ert-if-name-main-permission-lp-326620-test-CZefpG ()
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

(ert-deftest ar-in-list-indent-test-LEON2Q ()
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

(ert-deftest ar-indent-inconsistent-test-Zh2hP0 ()
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

(ert-deftest ar-indentation-lp-1375122-test-yx67am ()
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

(ert-deftest ar-ert-just-two-split-dedicated-lp-1361531-SomeMode3-test ()
  (ar-test
   "#! /usr/bin/env SomeMode3
# -*- coding: utf-8 -*-
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

(ert-deftest ar-shell-dedicated-buffer-test-t3Sizn ()
  (let ((buffer (ar-shell nil nil t)))
  (should (buffer-live-p buffer))))

(ert-deftest ar-SomeMode3-shell-test-YW7ToN ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (let ((erg (SomeMode3))
        erg)
    (should (bufferp (get-buffer erg)))
    (should (get-buffer-process erg))))

(ert-deftest ar-SomeMode2-shell-test-8Ostfe ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (let ((erg (SomeMode2)))
    (sit-for 0.1)
    (should (bufferp (get-buffer erg)))
    (should (get-buffer-process erg))))

(ert-deftest ar-keep-windows-configuration-test-Hh2GD6 ()
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

(ert-deftest ar-shell-test-t3Sizn ()
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

(ert-deftest ar-shell-test-3uMnzx ()
  (ar-test
      ""
    'SomeMode-mode
    'ar-verbose-p
    (with-current-buffer (ar-shell nil nil t)
      (goto-char (point-max))
      (insert "def")
      (should (looking-back "def" (line-beginning-position))))))

(ert-deftest ar-execute-import-or-reload-test-ZYUvdh ()
  (ar-test
   "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
import os"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (should (ar-execute-import-or-reload))))

(ert-deftest ar-master-file-not-honored-lp-794850-test-P6QZmU ()
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

(ert-deftest ar-ert-moves-up-fill-paragraph-symmetric-i6vspv ()
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

(ert-deftest ar-run-SomeMode-test-QDE84k ()
  "Test built-in SomeMode.el."
  (let ((SomeMode-indend-offset 4))
    (run-SomeMode)
    (should (buffer-live-p (get-buffer "*SOME*")))))

(ert-deftest ar-ert-wrong-indent-inside-string-lp-1574731-test-P19RGY ()
  (ar-test
   "def foo():
    print(\"\"\"
    Bar
\"\"\")
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "Bar")
   (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-ert-moves-up-fill-paragraph-django-76Aw4O ()
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

(ert-deftest ar-ert-moves-up-fill-paragraph-django-w8Rbx5 ()
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

(ert-deftest ar-up-string-test-DVKVO2 ()
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

(ert-deftest ar-backspace-test-86TyUY ()
  (ar-test
   "a = b = c = 5     "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace-mode -1)
   (execute-kbd-macro (kbd "<backspace>"))
   (should (eq (point) 18))))

(ert-deftest ar-backspace-test-xyFFow ()
  (ar-test
   "a = b = c = 5     "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace-mode 1)
   (execute-kbd-macro (kbd "<backspace>"))
   (should (eq (point) 14))))

(ert-deftest ar-up-string-test-NJ7sie ()
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

(ert-deftest ar--pdb-versioned-test-QoHSpJ ()
  (ar-test
      ""
    'SomeMode-mode
    'ar-verbose-p
    (require 'gud)
    (let ((ar-shell-name "SomeMode3"))
      (goto-char (point-max))
      (should (string= "pdb3" (ar--pdb-versioned))))))

;; (defun ar-up-string-test-NJ7sie ()
;;   ""
;;   (interactive)
;;   (ar-test
;;       "class M:
;;     def __init__(self):
;;         \"\"\"Helper function implementing the current module loader policy.1
;;         In SOME 3.14, the end state is to require and use the module's
;;         __spec__.loader and ignore any __loader__ attribute on the
;;         module.
;;         * If you have a __loader__ and a __spec__.loader but they are not the
;;         same, in SOME 3.12 we issue a DeprecationWarning and fall back to
;;         __loader__ for backward compatibility.  In SOME 3.14, we'll flip
;;         this case to ignoring __loader__ entirely, without error.
;;         \"\"\"
;;         self.a = 1
;;         self.b = 2"
;;     'SomeMode-mode
;;     ar-verbose-p
;;     ;; (font-lock-ensure)
;;     (goto-char (point-max))
;;     (search-backward "\"\"\"")
;;     (ar-up)
;;     (should (eq (char-after) 34))
;;     (should (eq (char-before) 32))))

(provide 'ar-ert-interactive-tests)
;;; ar-ert-interactive-tests.el ends here
