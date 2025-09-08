;; ar-ert-delete-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

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

(ert-deftest ar-ert-electric-kill-backward-arg-test-b118-yQx574 ()
  (ar-test
   "asdf    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace)
   (should (eq ?f (char-before)))))

(ert-deftest ar-ert-electric-kill-backward-arg-test-b118-uWff3u ()
  (ar-test
   "asdf"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-backspace)
   (should (eq (char-before) ?d))))

(ert-deftest extra-trailing-space-120-M6opJl ()
  (ar-test
   "def bar():
x = 7"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max)) 
   (beginning-of-line)
   (insert (make-string 4 32))
   (end-of-line)
   (insert (make-string 1 32))
   (ar-electric-backspace)
   (should (eolp))
   (should (eq (char-before) ?7))))

(ert-deftest extra-trailing-space-120-pKGvL2 ()
  (ar-test
   "def bar():
        x = 7"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "x")
   (when ar-debug-p (whitespace-mode))
   (backward-char 2)
   (ar-electric-delete)
   (should (eq (current-column) 4))))

(ert-deftest extra-trailing-space-120-WX8PGG ()
  (ar-test
   "def bar():
       x = 7"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (beginning-of-line)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq (char-before) ?:))))

(ert-deftest extra-trailing-space-120-NahnQx ()
  (ar-test
   "def bar():
    x = 7    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (skip-chars-backward " \t\r\n\f")
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-before) ?7))))

(ert-deftest extra-trailing-space-120-F8qxoR ()
  (ar-test
   "def bar():
x = 7         "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (backward-char 3)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-before) ?7))
   ;; (should-not  (char-after))
   ))

(ert-deftest extra-trailing-space-120-YyL25g ()
  (ar-test
   "def bar():
    x = 7         "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (backward-char 3)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-before) ?7))
   ;; (should-not  (char-after))
   ))

(ert-deftest delete-test-120-F8qxoR ()
  (ar-test
   "var5: Sequence[Mapping[str, Sequence[str]]] = [
    {
     'red': ['scarlet', 'vermilion', 'ruby'],
     'green': ['emerald', 'aqua']
    },
    {
                'sword': ['cutlass', 'rapier']
    }
]"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "'sword")
   (backward-char)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (skip-chars-forward " \t\r\n\f")
   (should (eq (current-column) 5))
   (should (eq (char-after) ?'))))

(ert-deftest ar-ert-deletes-too-much-lp:1300270-dMegYd ()
  (ar-test "
x = {'abc':'def',
         'ghi':'jkl'}
"
           'SomeMode-mode
           'ar-verbose-p
           (when ar-debug-p (switch-to-buffer (current-buffer)))
           (goto-char 25)
           (ar-electric-delete)
           (should (eq 5 (current-indentation)))))

(ert-deftest delete-test-120-dMegYd ()
  (ar-test "x"
           'SomeMode-mode
           'ar-verbose-p
           (goto-char (point-max))
           (when ar-debug-p (switch-to-buffer (current-buffer)))
           (ar-electric-backspace)
           (should (bobp))))

(ert-deftest delete-test-120-v32Zaq ()
  (ar-test " "
           'SomeMode-mode
           'ar-verbose-p
           (goto-char (point-max))
           (when ar-debug-p (switch-to-buffer (current-buffer)))
           (ar-electric-backspace)
           (should (bobp))))

(ert-deftest delete-test-120-lXSC6t ()
  (ar-test
   "var5: Sequence[Mapping[str, Sequence[str]]] = [
    {
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (insert (make-string 8 32))
   (insert "'red': ['scarlet', 'vermilion', 'ruby'],\n")
   (insert (make-string 8 32))
   (insert "'green': ['emerald', 'aqua']")
   (insert (make-string 8 32))
   (insert "\n")
   (insert "    },
    {
")
   (insert (make-string 8 32))
   (insert "'sword': ['cutlass', 'rapier']
    }\n]")
   (search-backward "'aqua")
   (end-of-line)
   (backward-char 4)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq (char-before) 93))))

(ert-deftest delete-issue-123-M6opJl ()
  (ar-test
   "def bar():
    x = 7
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-electric-delete)
   (should (eq (char-before) 10))))

(ert-deftest delete-issue-123-zSR3y1 ()
  (ar-test
   "def bar():
    x = 7
  "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (beginning-of-line)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-before) 10))))

(ert-deftest delete-issue-123-n2kOH4 ()
  (ar-test
   "def bar():
    baz = 7
    bar = 9
    return baz + bar
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (search-backward "7")
   (forward-char 1)
   (ar-electric-delete)
   (should (looking-at "    bar = 9"))))

(ert-deftest delete-issue-124-n2kOH4 ()
  (ar-test
   "calling(
    123,
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "1")
   ;; (forward-char 1)
   (ar-electric-backspace)
   (should (eq (char-after) ?1))
   (should (eq (char-before) 10))))

(ert-deftest delete-issue-124-8qQxmm ()
  (ar-test
   "calling(
123,
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "1")
   ;; (forward-char 1)
   (ar-electric-backspace)
   (should (eq (char-after) ?1))
   (should (eq (char-before) 40))))

(ert-deftest delete-newline-125-8qQxmm ()
  (ar-test
   "123
234
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -2)
   (ar-electric-delete)
   (should (eq (char-after) ?2))))

(ert-deftest delete-newline-126-1FRaeJ ()
  (ar-test
   "def test():  a = 'a'"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward ":")
   (forward-char 1)
   (ar-electric-delete)
   (should (eq (char-before) ?:))
   (should (eq (char-after) 32))))

(ert-deftest delete-newline-126-uWqng3 ()
  (ar-test
   "def test(): a = 'a'"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward ":")
   (forward-char 1)
   (ar-electric-delete)
   (should (eq (char-before) ?:))
   (should (eq (char-after) ?a))))

(ert-deftest ar-ert-moves-up-honor-dedent-lp-1280982-K6OICS ()
  (ar-test
   "def foo():
    def bar():
        asdf
    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-newline-and-indent)
   ;; Indent is set back, this is honoured in following lines.
   (should (eq 4 (current-indentation)))))

(ert-deftest ar-ert-moves-up-honor-dedent-lp-1280982-APU5fK ()
  (ar-test
   "def foo():
    def bar():
        asdf
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-newline-and-indent)
   (ar-electric-backspace)
   (should (eq 4 (current-indentation)))))

(ert-deftest delete-newline-126-XSjV1R ()
  (ar-test
   "def test():
    a = 'a'"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -1)
   (end-of-line)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-after) 32))))

(ert-deftest delete-newline-126-tzqfcf ()
  (ar-test-point-min
   "def test():
    a = 'a'"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (ar-electric-delete)
   (should (eq (char-after) ?e))))

(ert-deftest extra-trailing-space-120-yC7gXH ()
  (ar-test
   "def bar():
    x = 7"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (beginning-of-line)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq (char-before) 10))
   (should (eq (char-after) ?x))))

(ert-deftest delete-issue-123-KoplQh ()
  (ar-test
   "def bar():
       x = 7
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -1)
   (beginning-of-line)
   (forward-char 3)
   (when ar-debug-p (whitespace-mode))
   (ar-electric-delete)
   (should (eq 4 (current-indentation)))))

(ert-deftest backspacing-indentation-127-KoplQh ()
  (ar-test
   "def test():
    if True:
        print('ok')
        "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq (current-column) 4))))

(ert-deftest backspacing-indentation-127-S0ykuo ()
  (ar-test
   "def test():
    if True:
        print('ok')
           "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq (current-column) 8))))

(ert-deftest backspacing-indentation-127-3fQXLA ()
  (ar-test
   "def test():
    if True:
        print('ok')
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq (char-before) 41))))

(ert-deftest delete-indentation-128-3fQXLA ()
  (ar-test
   "def test():
    if True:
        print('in')
    print('out')"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (forward-line -1)
   ;; at BOL, line is empty
   (ar-electric-delete)
   (should (eq 4 (current-indentation)))))

(ert-deftest delete-indentation-128-iLkoVk ()
  (ar-test
   "def test():
    if True:
        print('in')
           print('out')"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (beginning-of-line)
   (forward-char 3)
   (ar-electric-delete)
   (should (eq 8 (current-indentation)))))

(ert-deftest extra-trailing-space-yC7gXH ()
  (ar-test
   "def bar():
    x = 7
            "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (ar-electric-backspace)
   (should (eq 4 (current-indentation)))))

(ert-deftest ar-electric-backspace-after-colon-yC7gXH ()
  (ar-test
   "def test():          a = 'a'"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (when ar-debug-p (whitespace-mode))
   (forward-char -9)
   (ar-electric-backspace)
   (should (eq (char-before) ?:))
   (should (eq (char-after) 32))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-OJeEWO ()
  (ar-test
   "test()"
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (search-backward ")")
     (ar-electric-backspace)
     (should-not (eq (char-after) 41)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-8exKMk ()
  (ar-test
   "test()"
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (ar-electric-backspace)
     (should-not (eq (char-after) 41))
     (should (eq (char-before) 40)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-WpGhqV ()
  (ar-test
   "\"\""
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (backward-char)
     (ar-electric-backspace)
     (should-not (eq (char-after) 34)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-tgdTi2 ()
  (ar-test
   "\"\""
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (backward-char)
     (ar-electric-backspace)
     (should-not (eq (char-after) 34))
     (should-not (eq (char-before) 34)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-Jgj06W ()
  (ar-test
   "asdf\"\""
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (ar-electric-backspace)
     (should (eq (char-before) 34)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-I69FaW ()
  (ar-test
   "asdf\"\""
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (backward-char)
     (ar-electric-backspace)
     (should (eq (char-before) ?f)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-55KXXV ()
  (ar-test
   "\"asdf\""
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (ar-electric-backspace)
     (should (eq (char-before) ?f)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-VY1yk7 ()
  (ar-test
   "''"
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (backward-char)
     (ar-electric-backspace)
     (should-not (eq (char-after) ?'))
     (should-not (eq (char-before) ?')))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-MnlR0p ()
  (ar-test
   "asdf''"
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (backward-char)
     (ar-electric-backspace)
     (should (eq (char-before) ?f)))))

(ert-deftest ar-incompatibility-with-electric-pair-mode-133-OtBSzw ()
  (ar-test
   "'asdf'"
   'SomeMode-mode
   'ar-verbose-p
   (call-interactively 'electric-pair-mode t)
   (let ((electric-pair-mode t))
     (goto-char (point-max))
     (ar-electric-backspace)
     (should (eq (char-before) ?f)))))

(ert-deftest ar-compute-indentation-crasher-breaks-editing-136-HUiwu9 ()
  (ar-test
   "def my_func(self):
    this_line() # is bad
    if condition:
        pass
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "#")
   (ar-electric-backspace)
   (should (eq (char-before) 41))))

(provide 'ar-ert-delete-tests)
;;; ar-ert-delete-tests.el ends here
