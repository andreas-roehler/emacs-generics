;; ar-ert-misc-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

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

(ert-deftest ar-ert-borks-all-lp-1294820-sIKMyz ()
  (ar-test-point-min
      "# M-q within some code (not in= a docstring) completely borks all previous
# code in the file:
#
# E.g. here, if I M-q within the last function:
def foo(self):
    some_actual_code()
def bar(self):
    some_actual_code()
def baz(self):
    some_actual_code()
# def foo(self): some_actual_code() def bar(self): some_actual_code() def
# baz(self):
#     some_actual_code()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    ;; (font-lock-fontify-region (point-min)(point-max))
    (search-forward "def baz(self):")
    (fill-paragraph)
    (forward-line -1)
    (should (bolp))
    (should (looking-at "    some_"))))

(ert-deftest ar-ert-in-comment-p-test-G6FUaB ()
  (ar-test
      "# "
    'SomeMode-mode
    'ar-verbose-p
    (should (ar--in-comment-p))))

(ert-deftest ar-ert-in-sq-string-p-test-nwha1D ()
  (ar-test
      "' "
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (ar-in-string-p))))

(ert-deftest ar-ert-in-dq-string-p-test-lYrt9b ()
  (ar-test
      "\" "
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (ar-in-string-p))))

(ert-deftest ar-ert-in-sq-tqs-string-p-test-EwMSzz ()
  (ar-test
      "''' "
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (ar-in-string-p))))

(ert-deftest ar-ert-in-dq-tqs-string-p-test-jkHHQH ()
  (ar-test
      "\"\"\" "
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (ar-in-string-p))))

(ert-deftest ar-ert-electric-delete-test-HecKiw ()
  (ar-test-point-min
      "  {}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (ar-electric-delete)
    (should (eq (char-after) ?{))))

(ert-deftest ar-ert-fill-plain-string-test-OEykwr ()
  (ar-test-point-min
      "'''asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdfasdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf
'''"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (forward-char 4)
    (fill-paragraph)
    (forward-line 1)
    (should (not (ar-empty-line-p)))))

(ert-deftest ar-ert-nil-docstring-style-lp-1477422-test-6wpqLB ()
  (ar-test-point-min
      "def foo():
    '''asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf asdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdfasdf' asdf asdf asdf asdf asdfasdf asdfasdf a asdf asdf asdf asdfasdfa asdf asdf asdf asdf'''"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (let (ar-docstring-style)
      (search-forward "'''")
      (save-excursion
        (fill-paragraph))
      (forward-line 1)
      (should (not (ar-empty-line-p))))))

(ert-deftest ar-markup-region-as-section-test-KetMYL ()
  (ar-test-point-min
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
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "fertig")
    (ar-sectionize-region (match-beginning 0) (line-end-position))
    (ar-mark-section)
    (should (eq (region-beginning) 377 ))
    (should (eq (region-end) 414 ))))

(ert-deftest ar-test-embedded-51-test-sgaO9V ()
  (ar-test
      "from Foo import *
FooFoo."
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (skip-chars-backward " \t\r\n\f") 
    (ignore-errors (ar-indent-or-complete))
    ;; (sit-for 0.1)
    (should (eq (char-before) ?.))))



(ert-deftest ar-ert-copy-indent-test-UbzMto ()
  (ar-test-point-min
      "class A(object):
    def a(self):
        sdfasde
        pass"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (search-forward "sdfasde")
    (ar-copy-indent)
    (should (string-match "sdfasde" (car kill-ring)))
    (should (not (ar--beginning-of-indent-p)))
    (ar-backward-statement)
    (should (ar--beginning-of-indent-p))))

(ert-deftest ar-ert-delete-indent-test-HhZNOr ()
  (ar-test-point-min
      "class A(object):
    def a(self):
        sdfasde
        pass"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (search-forward "sdfasde")
    (ar-delete-indent)
    (should (eobp))
    (should (bolp))))

(ert-deftest ar-ert-kill-indent-test-ECwA5u ()
  (ar-test-point-min
      "class A(object):
    def a(self):
        sdfasde
        pass"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (search-forward "sdfasde")
    (ar-kill-indent)
    (should (string= (concat (make-string 8 ?\ ) "sdfasde\n" (make-string 8 ?\ ) "pass") (car kill-ring)))
    (should (eobp))
    (should (bolp))))

(ert-deftest ar-ert-mark-indent-test-lJ6Hny ()
  (ar-test-point-min
      "class A(object):
    def a(self):
        sdfasde
        pass"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (search-forward "sdfasde")
    (ar-mark-indent)
    ;; (message "%s" (buffer-substring-no-properties (region-beginning) (region-end)))
    (should (eq 28 (length (buffer-substring-no-properties (region-beginning) (region-end)))))))

(ert-deftest ar-ert-edit-docstring-write-content-back-test-mh1es0 ()
  (ar-test-point-min
      "def foo():
    \"\"\"def bar():
    pass\"\"\"
    pass
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (let ((ar-edit-buffer "Edit docstring"))
      (search-forward "pass" nil t 1)
      (ar-edit-docstring)
      (set-buffer ar-edit-buffer)
      (switch-to-buffer (current-buffer))
      (goto-char (point-min))
      (end-of-line)
      (newline)
      (insert "'''My edit-docstring ert-test'''")
      (beginning-of-line)
      (indent-according-to-mode)
      (ar--write-edit)
      ;; back in orginial test buffer
      (forward-line -1)
      (should (and (nth 3 (parse-partial-sexp (point-min) (point)))
                   (nth 8 (parse-partial-sexp (point-min) (point))))))))

(ert-deftest ar-execute-region-no-transmm-test-1-7nmEse ()
  (ar-test
      "print(u'\\xA9')"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (let (transient-mark-mode)
      (push-mark)
      (beginning-of-line)
      (ar-shift-region-right)
      (should (eq 4 (current-indentation))))))

(ert-deftest ar-named-shell-SomeMode3-794850-test-P6QZmU ()
  (ar-test
      "foo"
    'SomeMode-mode
    'ar-debug-p
    (let (;; also set in run-tests.sh
          (ar-mode-v5-behavior-p t))
      (when (executable-find "SomeMode3")
        (call-interactively 'SomeMode3)
        (should (buffer-live-p (get-buffer "*SOME Output*")))
        (ar-kill-buffer-unconditional (get-buffer "*SOME3*"))))))

(ert-deftest ar-named-shell-iSomeMode3-794850-test-P6QZmU ()
  (ar-test
      "foo"
    'SomeMode-mode
    'ar-debug-p
    (let (;; also set in run-tests.sh
          (ar-mode-v5-behavior-p t))
      (when (executable-find "iSomeMode3")
        (let ((erg (buffer-name (call-interactively 'iSomeMode3))))
          (should (string= "*SOME Output*" erg)))
        (ar-kill-buffer-unconditional (get-buffer "*ISOME3*"))))))

(ert-deftest ar-named-shell-iSomeMode3-794850-test-3U5kpY ()
  (ar-test
      "foo"
    'SomeMode-mode
    'ar-debug-p
    (when (executable-find "iSomeMode3")
      (let (;; also set in run-tests.sh
            (ar-mode-v5-behavior-p t)
            (erg (buffer-name (ar-shell nil nil nil "iSomeMode3"))))
        (should (string= "*SOME Output*" erg)))
      (ar-kill-buffer-unconditional (get-buffer "*ISOME3*")))))

(ert-deftest ar-named-shell-iSomeMode-794850-test-P6QZmU ()
  (ar-test
   "foo"
   'SomeMode-mode
   'ar-debug-p
   (let (;; also set in run-tests.sh
         (ar-mode-v5-behavior-p t))
   (when (executable-find "iSomeMode")
     (call-interactively 'iSomeMode)
     (should (buffer-live-p (get-buffer "SOME Output*")))
     (ar-kill-buffer-unconditional (get-buffer "*ISOME*"))))))

(when (featurep  'comint-mime)
  (ert-deftest ar-comint-mime-test-7JbtYW ()
    (ar-test
	"__COMINT_MIME_setup"
      'SomeMode-mode
      'ar-verbose-p
      (push '(inferior-SomeMode-mode . comint-mime-setup-SomeMode)
	    comint-mime-setup-function-alist)
      (push '(ar-shell-mode . comint-mime-setup-ar-shell)
	    comint-mime-setup-function-alist)
      (add-hook 'ar-shell-mode-hook 'comint-mime-setup)
      (ar-execute-buffer-iSomeMode3)
      (message "%s" ar-result)
      (should (string-match "__COMINT_MIME_setup" ar-result)))))

(provide 'ar-ert-misc-tests)
;;; ar-ert-misc-tests.el ends here
