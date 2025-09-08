;; ar-ert-indent-tests.el --- testing SomeMode-mode.el -*- lexical-binding: t; -*-

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

;; (setq ar-verbose-p t)

(require 'ar-setup-ert-tests)

(ert-deftest ar-ert-indent-list-style-test-UVqzej ()
  (should ar-indent-list-style))

(ert-deftest ar-ert-indent-dedenters-WoWM6j-YhnDUf ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-4qujpk-8S5Su6 ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-OmirYx ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-P9MB72-6D8DxN ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-SFnpJ4-GyGW0D ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)
    else:
        try:"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-m0FUAw-ohKXqu ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)
    else:
        try:
            print(c.pop())"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 12 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-0sEVRk ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)
    else:
        try:
            print(c.pop())
        except (IndexError, AttributeError):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-F9didu ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)
    else:
        try:
            print(c.pop())
        except (IndexError, AttributeError):
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 12 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-dedenters-WRXYEM-aKmUgb ()
  "Check all dedenters."
  (ar-test
      "def foo(a, b, c):
    if a:
        print(a)
    elif b:
        print(b)
    else:
        try:
            print(c.pop())
        except (IndexError, AttributeError):
            print(c)
        finally:
            print('nor a, nor b are true')"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 12 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-after-backslash-lp-852052-ztz4Yn-cTO9B1 ()
  (ar-test
      "from foo.bar.baz import something, something_1 \\"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-after-backslash-lp-852052-LlOrDK-sHqVVR ()
  (ar-test
      "from foo.bar.baz import something, something_1 \\
     something_2 something_3, \\"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 5 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-after-backslash-lp-852052-nvVJgu-QTa6cI ()
  (ar-test
      "from foo.bar.baz import something, something_1 \\
     something_2 something_3, \\
     something_4, something_5"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 5 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-after-backslash-lp-852052-orr7uy ()
  "The most common case."
  (ar-test-point-min
      "
from foo.bar.baz import something, something_1 \\
     something_2 something_3, \\
     something_4, something_5
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "something_2 something_3,")
    (should (= (ar-compute-indentation) 5))
    (search-forward "something_4, something_5")
    (should (= (ar-compute-indentation) 5))))

(ert-deftest indent-region-lp-997958-lp-1426903-no-arg-test-wF0CYZ ()
  "Indent line-by-line as first line is okay "
  (ar-test-point-min
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
def foo ():
if True:
    print(123)
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (search-backward "True")
    (save-excursion
      (ar-indent-region (line-beginning-position) (point-max) t))
    (search-forward "with file")
    (should (eq 8 (current-indentation)))))

(ert-deftest indent-region-lp-997958-lp-1426903-no-arg-test-yAzv0R ()
  "Indent line-by-line as first line is okay "
  (ar-test
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
def foo ():
if True:
    print(123)
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (search-backward "True")
    (save-excursion
      (ar-indent-region (line-beginning-position) (point-max) t))
    (search-forward "for i ")
    (should (eq 12 (current-indentation)))))

(ert-deftest indent-region-lp-997958-lp-1426903-no-arg-test-MvlWZJ ()
  "Indent line-by-line as first line is okay "
  (ar-test
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
def foo ():
if True:
    print(123)
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (search-backward "True")
    (save-excursion
      (ar-indent-region (line-beginning-position) (point-max) t))
    (search-forward "bar.")
    (should (eq 16 (current-indentation)))))

(ert-deftest indent-region-lp-997958-lp-1426903-no-arg-test-cXQ3WB ()
  "Indent line-by-line as first line is okay "
  (ar-test
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
def foo ():
if True:
    print(123)
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (search-backward "True")
    (save-excursion
      (ar-indent-region (line-beginning-position) (point-max) t))
    (search-forward "datei.write")
    (should (eq 16 (current-indentation)))))

(ert-deftest indent-region-lp-997958-lp-1426903-arg-test-gDZcSt ()
  "Indent line-by-line as first line is okay "
  (ar-test
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        # called from correct first line
        # wrong indent should to be fixed
            datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (set-mark (point))
    (search-backward "with file")
    (save-excursion
      (ar-indent-region (point) (point-max) t))
    (should (eq 0 (current-indentation)))
    (search-forward "for i ")
    (should (eq 4 (current-indentation)))
    (search-forward "bar.")
    (should (eq 8 (current-indentation)))
    (search-forward "datei.write")
    (should (eq 8 (current-indentation)))))

(ert-deftest ar-compute-indentation-after-import-test-XvL29H ()
  (ar-test
      "import pdb
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-compute-indentation-bob-test-HcSwMS ()
  (ar-test-point-min
      "def foo():
    if True:
        pass
    else:
        pass
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-ld9am7 ()
  (ar-test
      "
asdf = {
    'a':{"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (beginning-of-line)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-Pg4yts ()
  (ar-test
      "
asdf = {
    'a':{"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (forward-char -2)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-2qSrrt ()
  (ar-test
      "
asdf = {
    'a':{
         'b':3,
         'c':4"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (beginning-of-line)
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-CNMePW ()
  (ar-test
      "
asdf = {
    'a':{
         'b':3,
         'c':4"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-I73t1i ()
  (ar-test
      "
asdf = {
    'a':{
         'b':4,
         'c':5"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-9UP0Kr ()
  (ar-test
      "# hanging, ar-closing-list-dedents-bos nil
asdf = {
    'a':{
         'b':3,
         'c':4
         }"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (beginning-of-line)
    (let ((ar-closing-list-dedents-bos nil))
      (should (eq 8 (ar-compute-indentation))))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-ABORqFr ()
  (ar-test
      "# hanging, ar-closing-list-dedents-bos nil
asdf = {
    'a':{
         'b':3,
         'c':4
         }"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (forward-char -1)
    (let ((ar-closing-list-dedents-bos nil))
      (should (eq 8 (ar-compute-indentation))))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-NzoaiZ ()
  (ar-test
      "# hanging, ar-closing-list-dedents-bos nil
asdf = {
    'a':{
         'b':3,
         'c':4
        }
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-closing-list-dedents-bos nil))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-10-uGdWJg ()
  (ar-test
      "# closing, ar-closing-list-dedents-bos t
asdf = {
    'a':{
         'b':3,
         'c':4
    }
    }"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (beginning-of-line)
    (let ((ar-closing-list-dedents-bos t))
      (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-11-3JVKy7 ()
  (ar-test
      "# closing, ar-closing-list-dedents-bos t
asdf = {
    'a':{
         'b':3,
         'c':4
    }
    }"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (forward-char -1)
    (let ((ar-closing-list-dedents-bos t))
      (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-12-ygoJUM4 ()
  (ar-test
      "# closing, ar-closing-list-dedents-bos t
asdf = {
    'a':{
         'b':3,
         'c':4
    }
    }"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-closing-list-dedents-bos t))
      (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-flexible-indentation-lp-328842-test-8L9T1k ()
  (ar-test
      "(long, sequence, of_items,
 that, needs, to_be, wrapped) = input_list"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-indent-list-style 'line-up-with-first-element))
      (goto-char (point-max))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-list-indent-test-THFplR ()
  (ar-test
      "if (release_time != -1 and
    datetime.datetime.now() > release_time + CLOCK_SLOP):
    # Yes, so break the lock.
    self._break()
    log.error('lifetime has expired, breaking')"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-indent-list-style 'line-up-with-first-element))
      (goto-char (point-max))
      (search-backward "datetime.datetime.now")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-flexible-indentation-lp-328842-test-akkTLs ()
  (ar-test
      "packed_entry = (long, sequence, of_items,
that, needs, to_be, wrapped)"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (search-backward "d")
    (let ((ar-indent-list-style 'line-up-with-first-element))
      (should (eq 16 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-in-arglist-test-pGszAP ()
  (ar-test
      "def foo (a,\n):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (search-backward ")")
    (let ((ar-indent-list-style 'line-up-with-first-element))
      (should (eq 9 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-in-arglist-test-3kW4RJ ()
  (ar-test
      "def foo (
a):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (search-backward ")")
    (let ((ar-indent-list-style 'line-up-with-first-element))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-in-arglist-test-2TmrDT ()
  (ar-test
      "def foo (a,\n):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-indent-list-style 'one-level-to-beginning-of-statement))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-in-arglist-test-kYc1wJ ()
  (ar-test
      "def foo (\na,"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-indent-list-style 'one-level-to-beginning-of-statement))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-close-block-test-8LPQD3 ()
  (ar-test-point-min
      "# -*- coding: utf-8 -*-
def main():
    if len(sys.argv)==1:
        usage()
        sys.exit()
if __name__==\"__main__\":
    main()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "exit()")
    (should (eq 4 (ar-close-block)))))

(ert-deftest ar-ert-indent-in-arglist-test-euyfAZ ()
  (ar-test
      "def foo (a,\n):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-indent-list-style 'one-level-from-first-element)
          ar-closing-list-dedents-bos)
      (should (eq 13 (ar-compute-indentation))))))

(ert-deftest ar-ert-close-def-or-class-test-7Kc5SQ ()
  (ar-test-point-min
      "# -*- coding: utf-8 -*-
def main():
    if len(sys.argv)==1:
        usage()
        sys.exit()
if __name__==\"__main__\":
    main()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "exit()")
    (should (eq 0 (ar-close-def-or-class)))))

(ert-deftest ar-ert-close-def-test-nKOJaZ ()
  (ar-test-point-min
      "# -*- coding: utf-8 -*-
def main():
    if len(sys.argv)==1:
        usage()
        sys.exit()
if __name__==\"__main__\":
    main()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "exit()")
    (should (eq 0 (ar-close-def)))))

(ert-deftest ar-ert-close-class-test-FPi2i3 ()
  (ar-test-point-min
      "# -*- coding: utf-8 -*-
class asdf:
    def main():
        if len(sys.argv)==1:
            usage()
            sys.exit()
    if __name__==\"__main__\":
        main()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min))
    (search-forward "exit()")
    (should (eq 0 (ar-close-class)))))

(ert-deftest ar-ert-dedent-forward-test-61dWA6 ()
  (ar-test
      "with file(\"roulette-\" + zeit + \".csv\", 'w') as datei:
    for i in range(anzahl):
        klauf.pylauf()
        datei.write(str(spiel[i]) + \"\\n\")"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (skip-chars-backward " \t\r\n\f")
    (ar-dedent-forward-line)
    (should (ar-empty-line-p))
    (forward-line -1)
    (should (eq 4 (current-indentation)))))

(ert-deftest ar-ert-async-backward-block-test-aAFOA0 () ()
             (ar-test
                 "async def coro(name, lock):
    print('coro {}: waiting for lock'.format(name))
    async with lock:
        print('coro {}: holding the lock'.format(name))
        await asyncio.sleep(1)
        print('coro {}: releasing the lock'.format(name))"
               'SomeMode-mode
               'ar-verbose-p
               (goto-char (point-max))
               (ar-backward-block)
               (should (looking-at "async with"))))

(ert-deftest ar-ert-indent-try-test-zg6QYI ()
  (ar-test-point-min
      "#! /usr/bin/env SomeMode
import sys
import os
        try:"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (search-forward "try")
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-ert-indent-closing-tx8E5Q ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6
    ]
"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-1vO0ER ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6
    7, 8, 9]
"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (skip-chars-backward " \t\r\n\f")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-OUClAx ()
  (ar-test
      "
my_list = [1, 2, 3,
    4, 5, 6
    ]"
    'SomeMode-mode
    'ar-verbose-p
    (let (ar-closing-list-dedents-bos)
      (goto-char (point-max))
      (search-backward "4")
      ;; line-up-with-first-element (default)
      (should (eq 11 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-EcP0BS ()
  (ar-test
      "
my_list = [1, 2, 3,
    4, 5, 6
    ]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (search-backward "4")
      ;; line-up-with-first-element (default)
      (should (eq 11 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-vmqBXD ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6
    ]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-indent-list-style 'one-level-to-beginning-of-statement))
      (goto-char (point-max))
      (search-backward "]")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-0yQS1n ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6
    ]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (search-backward "]")
      (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-Juf3lq ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t)
          (ar-indent-list-style 'one-level-to-beginning-of-statement))
      (goto-char (point-max))
      (search-backward "]")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-6IYou0 ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t)
          (ar-indent-list-style 'line-up-with-first-element))
      (goto-char (point-max))
      ;; previous line matters
      (search-backward "]")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-closing-TGnvyS ()
  (ar-test
      "
my_list = [
    1, 2, 3,
    4, 5, 6]"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (search-backward "3")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-async-indent-test-MFS8IW ()
  (ar-test-point-min
      "async def coro(name, lock):
    print('coro {}: waiting for lock'.format(name))
    async with lock:
        print('coro {}: holding the lock'.format(name))
        await asyncio.sleep(1)
        print('coro {}: releasing the lock'.format(name))"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (forward-line 1)
    (should (eq 4 (ar-compute-indentation)))
    (forward-line 3)
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-parens-span-multiple-lines-lp-1191225-test-AkoTP3 ()
  (ar-test-point-min
      "# -*- coding: utf-8 -*-
def foo():
    if (foo &&
        baz):
        bar()
# >> This example raises a pep8 warning[0],
# >> I've been dealing with it and manually
# >> adding another indentation level to not leave 'baz' aligned with 'baz
# ()'
# >>
def foo():
    if (foo &&
            baz):
        bar()
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-min) )
    (let ((ar-indent-list-style 'one-level-from-first-element))
      (search-forward "b")
      (should (eq 12 (ar-compute-indentation))))))

(ert-deftest ar-ert-indent-else-clause-test-gIyr2H ()
  (ar-test
      "def foo()
    if aaa:
        if bbb:
            x = 1
        y = 1
    else:
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-ert-list-indent-test-48C7hO ()
  (ar-test
      "print('test'
          'string'
          'here')"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "s")
    (should (eq 6 (ar-compute-indentation)))))

(ert-deftest ar-ert-list-indent-test-GXE2bT ()
  (ar-test
      "if (release_time != -1 and
    datetime.datetime.now() > release_time + CLOCK_SLOP):
    # Yes, so break the lock.
    self._break()
    log.error('lifetime has expired, breaking')"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (let ((ar-indent-list-style 'one-level-from-first-element))
      (search-backward "datetime.datetime.now")
      (should (eq 8 (ar-compute-indentation))))))

(ert-deftest ar-ert-flexible-indentation-lp-328842-test-70Eccx ()
  (ar-test
      "(long, sequence, of_items,
 that, needs, to_be, wrapped) = input_list"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (skip-chars-backward " \t\r\n\f")
    (let ((ar-indent-list-style 'one-level-from-first-element))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-flexible-indentation-lp-328842-test-umQ6Tk ()
  (ar-test
      "( whitespaced, long, sequence, of_items,
    that, needs, to_be, wrapped) = input_list"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (let ((ar-indent-list-style 'one-level-from-first-element))
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-list-indent-test-hvCk3U ()
  (ar-test
      "if (release_time != -1 and
    datetime.datetime.now() > release_time + CLOCK_SLOP):"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar--indent-line-by-line-lp-1621672-GmsSN3 ()
  (ar-test
      "def asdf()
     pass"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (goto-char (point-min))
    (ar-indent-region (point-min) (point-max) t)
    (should (eq 4 (current-indentation)))))

(ert-deftest ar--indent-line-by-line-lp-1621672-b-tACrr5 ()
  (ar-test
      "    print(\"asdf\")"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (goto-char (point-min))
    (ar-indent-region (point-min) (point-max) t)
    (should (eq 0 (current-indentation)))))

(ert-deftest ar-indentation-after-an-explicit-dedent-61-test-lpYaIp ()
  (ar-test
      "mport sys
def main():
    if len(sys.argv) == 2:
        print('hey')
    x = 7
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (goto-char (point-max))
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-clause-indent-test-UXZsX9 ()
  (ar-test
      "def ziffernraten ()
    ziffer = random.randint(1,20)
    guess = 0
    tries = 0
    print('Try to guess a number between 1 and 20, using the four clues if you need them, You have 5 guesses')
    while (guess!=ziffer) and (tries<5):
        print(\"Falsch\")
        tries += 1
        guess = int(input ('What is your guess? '))
    if guess == ziffer:
        print(\"Erfolg\")
else: "
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 4 (ar-compute-indentation)))))

;; (ert-deftest ar-multline-arguments-with-literal-lists-79-test-7NWa5T ()
;;   (ar-test
;;       ;; Improper indentation for multline arguments with literal lists (#79)
;;       "def foo():
;;     bar = dosomething([
;;                        x <- point"
;;     (goto-char (point-max))
;;     (search-backward "x")
;;     (should (eq 8 (ar-compute-indentation)))))

(ert-deftest lines-after-return-80-Ahdpe8 ()
  (ar-test
      "def empty():
    return
    yield"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (beginning-of-line)
    (should (eq 4 (ar-compute-indentation)))
    (search-backward "return")
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-electric-indent-test-KaDCGx ()
  (ar-test
      "def main():
if len(sys.argv) == 1"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (let (ar-electric-colon-greedy-p
	  (ar-electric-colon-active-p t))
      (ar-electric-colon 1))
    (should (eq 4 (current-indentation)))))

(ert-deftest ar-98-indent-test-KaDCGx ()
  (ar-test
      "def some_fct():
    \"\"\" Test for ar-indent-or-complete.
    To test place point on the first statement.
    If this line is here, ar-compute-indentation returns 0.
    \"\"\"
    if the_cursor_is_here:"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (should (eq 4 (current-indentation)))))

(ert-deftest ar-indent-test-W5dPqP ()
  (ar-test
      "#! /usr/bin/env iSomeMode
# -*- coding: utf-8 -*-
import os"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (backward-char 6)
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-indent-gnu-bug34268-i1nySM ()
  (ar-test
      "def long_function_name(var_one, var_two, var_three,
                       var_four):
    print(var_one)
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "print")
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-incorrect-indentation-for-functions-bug113-i1nySM ()
  (ar-test
      "def draw(
    handlecolor=\"blue\",
    handleline=\"blue\"
):
foo"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (beginning-of-line)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest indent-region-lp-997958-lp-1426903-no-arg-test-2H3ET7 ()
  "Indent line-by-line as first line is okay "
  (ar-test
      "#! /usr/bin/env SomeMode
# -*- coding: utf-8 -*-
def foo ():
if True:
    print(123)
with file(\"foo\" + zeit + \".ending\", 'w') as datei:
    for i in range(anzahl):
        bar.dosomething()
        datei.write(str(baz[i]) + \"\\n\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (push-mark)
    (search-backward "True")
    (save-excursion
      (ar-indent-region (line-beginning-position) (point-max) t))
    (should (eq 4 (current-indentation)))))

(ert-deftest ar-match-case-test-i1nySM ()
  (ar-test
      "match (100, 200):
    case (100, 300):  # Mismatch: 200 != 300
        print('Case 1')
    case (100, 200) if flag:  # Successful match, but guard fails
        print('Case 2')
    case (100, y):  # Matches and binds y to 200
        print(f'Case 3, y: {y}')
    case _:  # Pattern not attempted
        print('Case 4, I match anything!')"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "print")
    ;; (beginning-of-line)
    (should (eq 8 (ar-compute-indentation)))
    (search-backward "case")
    (should (eq 4 (ar-compute-indentation)))
    (search-backward "print")
    (should (eq 8 (ar-compute-indentation)))
    (search-backward "case")
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-indent-on-first-line-i1nySM ()
  (ar-test
      "test()"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward ")")
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-ert-nested-dictionaries-indent-lp:328791-test-EH1WJl ()
  (ar-test
      "
 asdf = {
     'a':{"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char(point-max))
    (should (eq 5 (ar-compute-indentation)))))

(ert-deftest ar-compute-indent-crasher-136-i1nySM ()
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
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-bug-56742-indendation-problem-after-comment-hOliT8 ()
  (ar-test
      "def test(n):
    if n < 0:
        return -1
    # test
    else:
        return 0"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "else")
    (should (eq 4 (current-indentation)))))

(ert-deftest ar-match-case-indent-137-XVkUIJ ()
  (ar-test
      "def http_error(status):
    match status:
    case 400:
        return \"Bad request\"
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "case")
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-match-case-indent-137-b1Kuye ()
  (ar-test
      "def http_error(status):
    match status:
        case 400:
        return \"Bad request\"
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "return")
    (should (eq 12 (ar-compute-indentation)))))

(ert-deftest ar-emacs-bug-57262-indent-test-8iPIh0 ()
  (ar-test
      "for long_variable_name \\
        in (1, 2):
    print(long_variable_name)
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "print")
    (should (eq 4 (ar-compute-indentation)))
    (search-backward "in")
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-comment-shouldnt-outdent-109-test-vkJNom ()
  (ar-test
      "def addProductToShopify(sample)
    try:
        a = sample
    except NoResultFound as e:
        return False
    # comment 1
    # comment 2
    # comment 3
    return True
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "comment" nil t 2)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-indent-test-NobJ29 ()
  (ar-test
      "for i in b:
    c = len(foo)
    print(\"asdf\")
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "print" nil t 1)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-Lc2wzd ()
  (ar-test
      "for infix in [ # some description
              \"_cdata\", \"_cmeta\", \"_corig\", \"_cpool\", \"_cvol\", \"_wcorig\",
              \"indentation is broken here\", \"bar\"]:
    print(infix)
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "is" nil t 1)
    (should (eq 14 (ar-compute-indentation)))
    (search-backward "ata" nil t 1)
    (should (eq 14 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-SCEA4j ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "name" nil t 1)
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-Nhdprq ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "name" nil t 1)
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-vn8oBL ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "pk" nil t 1)
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-MFw6EK ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "name" nil t 2)
    (should (eq 9 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-Zy6iEE ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "pk" nil t 2)
    (should (eq 8 (ar-compute-indentation)))))

(ert-deftest ar-indent-in-tuple-test-8y1ZyT ()
  (ar-test
      "_PN34 = (-1475, -1438, -1427, -1401, -1398, -1380, -1376, -1363, -1354,
        -1277)"
    'SomeMode-mode
    'ar-verbose-p
    (let ((ar-closing-list-dedents-bos t))
      (goto-char (point-max))
      (should (eq (ar-compute-indentation) 9)))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-tZmIx7 ()
  ";; bug#42513: SOME indentation bug when using multi-line on an if-conditition"
  (ar-test "def fun(arg):
    if(
args.suppliername == \"Messingschlager\" or
args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "args" nil t 1)
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-KaDCGx ()
  ";; bug#42513: SOME indentation bug when using multi-line on an if-conditition"
  (ar-test "def fun(arg):
    if(
args.suppliername == \"Messingschlager\" or
args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "args" nil t 2)
    (should (eq 0 (ar-compute-indentation)))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-3qcJU7 ()
  ";; bug#42513: SOME indentation bug when using multi-line on an if-conditition"
  (ar-test "def fun(arg):
    if(
args.suppliername == \"Messingschlager\" or
args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (let (ar-closing-list-dedents-bos)
      (goto-char (point-max))
      (search-backward "else:")
      (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-4RSTQF ()
  ";; bug#42513: SOME indentation bug when using multi-line on an if-conditition"
  (ar-test "def fun(arg):
    if(args.suppliername == \"Messingschlager\" or
       args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (let (ar-closing-list-dedents-bos)
      (goto-char (point-max))
      (search-backward ")")
      (should (eq 7 (ar-compute-indentation))))))

(ert-deftest ar-indent-bug63959-test-6sVElZ ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "obj" nil t 1)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-dgPK5O ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-WQJF2a ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "}")
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-AsmMX4 ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "}" nil t 2)
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-ZdzpFK ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "]")
    (forward-char 1)
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-nSKy69 ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "]")
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-4HtEoV ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "]")
    (beginning-of-line)
    (should (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-xhNrCD ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "name")
    (forward-char -1)
    (should-not (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-HnA9Ko ()
  (ar-test
      "data = {'key': {
    'objlist': [
        {'pk': 1,
         'name': 'first'},
        {'pk': 2,
         'name': 'second'}
    ]
}}
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "}" nil t 3)
    (should-not (ar-compute-indentation--at-closer-p))))

(ert-deftest ar-indent-bug63959-test-VCIfFY ()
  (ar-test
      "var5: Sequence[Mapping[str, Sequence[str]]] = [
    {
     'red': ['scarlet', 'vermilion', 'ruby'],
     'green': ['emerald', 'aqua']
    },
    {
                'sword': ['cutlass', 'rapier']
    }
]
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "sword" nil t)
    (beginning-of-line)
    (should (eq 5 (ar-compute-indentation)))))

(ert-deftest ar-indent-bug63959-test-7JiI5a ()
  (ar-test
      "def f():
    \"\"\"
    Return nothing.
    .. NOTE::
        First note line
    second note line\"\"\"
    pass
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "pass")
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-7YHplS ()
  ";; bug#42513: SOME indentation bug when using multi-line on an if-conditition"
  (ar-test
      "def fun(arg):
    if(args.suppliername == \"Messingschlager\" or
args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "args.")
    (should (eq 7 (ar-compute-indentation)))))

(ert-deftest ar-gnu-bug42513-indent-multi-line-if-test-eE5Kpl ()
  ""
  (ar-test
      "def fun(arg):
    if(args.suppliername == \"Messingschlager\" or
args.suppliercodename == \"MS\"
	): #<- culprit
		#do something
else: #<- this else is not possible to indent 1 tab
		#do something"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "else" nil t 2)
    (beginning-of-line)
    (should (eq 4 (ar-compute-indentation)))))

(ert-deftest ar-else-test-YYL42q ()
  (ar-test
  "def foo():
    if True:
        pass
    else:
        if True:
            pass
        else:
           pass
"
    'SomeMode-mode
    'ar-verbose-p
    (goto-char (point-max))
    (search-backward "else" nil t 2)
    (beginning-of-line)
    (should (eq 4 (ar-compute-indentation)))))


(provide 'ar-ert-indent-tests)
;;; ar-ert-indent-tests.el ends here
