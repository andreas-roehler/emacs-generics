;;; ar-ert-scope-tests.el --- testing SomeMode-mode.el  -*- lexical-binding: t; -*-

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'ar-setup-ert-tests)

(ert-deftest ar-partial-expression-test-2JmcBn ()
  (ar-test-point-min
   "foo=1"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (and (should (string= "foo" (ar-partial-expression)))
	(ar-kill-buffer-unconditional (current-buffer)))))

(ert-deftest ar-partial-expression-test-yS2wLf ()
  (ar-test-point-min
   "print(root.getchildren()[0])"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (search-forward "getchildren")
   (and (should (string= "getchildren()[0]" (ar-partial-expression)))
	(ar-kill-buffer-unconditional (current-buffer)))))

(ert-deftest ar-partial-expression-test-TmqVoM ()
  (ar-test-point-min
   "print(root.getchildren()[0])"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (search-forward "ro")
   (and (should (string= "root" (ar-partial-expression)))
	(ar-kill-buffer-unconditional (current-buffer)))))


(ert-deftest ar-partial-expression-test-HS6qOA ()
  (ar-test
   "def __init__(self):"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "_")
   (should (string= "__init__" (ar-partial-expression)))))

(ert-deftest ar-ert-which-def-or-class-test-1-0u94OU ()
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

if __name__ == \"__main__\":
    main()
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (search-forward "kugel")
   (should (string-match "kugel" (ar-which-def-or-class)))
   (search-forward "pylauf")
   (should (string-match "kugel.pylauf" (ar-which-def-or-class)))))

(ert-deftest ar-ert-which-def-or-class-test-2-8ivbIN ()
  (ar-test
   "except AttributeError:

    # To fix reloading, force it to create a new foo
    if hasattr(threading.currentThread(), '__decimal_foo__'):
        del threading.currentThread().__decimal_foo__

    def setfoo(foo):
        \"\"\"Set this thread's foo to foo.\"\"\"
        if foo in (DefaultContext, BasicContext, ExtendedContext):
            foo = foo.copy()
            foo.clear_flags()
        threading.currentThread().__decimal_foo__ = foo

    def getfoo():
        \"\"\"Returns this thread's foo.

        If this thread does not yet have a foo, returns
        \"\"\"
        try:
            return threading.currentThread().__decimal_foo__
        except AttributeError:
            foo = Context()
            threading.currentThread().__decimal_foo__ = foo
            return foo

else:
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (should (string= "???" (ar-which-def-or-class)))
   (forward-line -3)
   (should (string= "getfoo" (ar-which-def-or-class)))))

(ert-deftest ar-ert-which-def-or-class-test-3-UXT0vG ()
  (ar-test

   "class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    # zeit = time.strftime('%Y-%m-%d--%H-%M-%S')
    spiel = []
    gruen = [0]
    rot = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36]
    schwarz = [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35]
    ausgabe = []
    treffer = None
    fertig = ''
    treffer = random.randint(0, 36)

    def foo():
        bar

    def pylauf(self):
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-line -2)
   (should (string= "kugel.foo" (ar-which-def-or-class)))))

(ert-deftest ar-ert-match-paren-test-1-aUZjkz ()
  (ar-test
   "if __name__ == \"__main__\":
    main()"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-char -1)
   (ar-match-paren)
   (should (eq (char-after) ?\())))

(ert-deftest ar-ert-match-paren-test-2-Y12s7r ()
  (ar-test
   "if __name__ == \"__main__\":
    main()"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-char -2)
   (ar-match-paren)
   (should (eq (char-after) ?\)))))

(ert-deftest ar-ert-match-paren-test-4-yuGPRk ()
  (ar-test
   "if __name__ == \"__main__\":
    main()
    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-match-paren)
   (should (eq (char-after) ?m))))

(ert-deftest ar-ert-match-paren-test-5-Etk4zd ()
  (ar-test-point-min
   "if __name__ == \"__main__\":
    main()
    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (ar-match-paren)
   (should (ar-empty-line-p))
   (ar-match-paren)
   (should (eq (char-after) ?i))))

(ert-deftest ar-ert-match-paren-test-7-27w0f6 ()
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
   (goto-char (point-max))
   (skip-chars-backward "^\]")
   (forward-char -1)
   (ar-match-paren)
   (should (eq (char-after) ?\[))
   (ar-match-paren)
   (should (eq (char-after) ?\]))))

(ert-deftest ar-ert-match-paren-test-8-qsfcTY ()
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
   (goto-char (point-max))
   (skip-chars-backward "^:")
   (ar-match-paren)
   (should (eq (char-after) ?i))))

(ert-deftest ar-ert-match-paren-test-9-SEatuR ()
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
   (goto-char (point-max))
   (search-backward "pylauf")
   (ar-match-paren)
   (should (eq (char-after) ?\"))
   (ar-match-paren)
   (should (eq (char-after) ?\"))))

(ert-deftest ar-ert-match-paren-test-faMqA3-A1WQ3J ()
  (ar-test
   "def main():
    if len(sys.argv) == 1:
        usage()
        sys.exit()
              "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "if")
   (ar-match-paren)
   (should (ar-empty-line-p))
   (ar-match-paren)
   (should (eq (char-after) ?i))))

(ert-deftest ar-ert-match-paren-test-AOADGb-cVptAC ()
  (ar-test-point-min
   "import re
import sys
import os
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-min))
   (ar-match-paren)
   (should (looking-at "import sys"))
   (setq last-command 'ar-match-paren)
   (ar-match-paren)
   (should (looking-at "import re"))))

(ert-deftest ar-ert-match-paren-nonempty-test-6-SA6Izy ()
  (ar-test
   "def main():
    if len(sys.argv) == 1:
        usage()
        sys.exit()

    class asdf(object):
        zeit = time.strftime('%Y%m%d--%H-%M-%S')

        def Utf8_Exists(filename):
            return os.path.exists(filename.encode('utf-8'))
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "class")
   (ar-match-paren)
   (should (ar-empty-line-p))
   (should (eq 4 (current-column)))))

(ert-deftest ar-ert-match-paren-nonempty-test-7-i8ISwu ()
  (ar-test
   "try:
    anzahl = int(args[1])
except:
    print \"Setze anzahl auf 1\"
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward "arg")
   (ar-match-paren)
   (should (eq (char-after) ?\())))

(ert-deftest ar-ert-match-paren-nonempty-test-8-4Q5jvq ()
  (ar-test
   "try:
    anzahl = int(args[1])
except:
    print \"Setze anzahl auf 1\"
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (search-backward " int")
   (ar-match-paren)
   (should (eq (char-after) ?a))
   (ar-match-paren)
   (should (eq (char-before) 32))
   (should (ar-empty-line-p))
   (should (eq 4 (current-column)))))

(ert-deftest ar-ert-match-paren-test-9-ym4nrm ()
  (ar-test
   "if __name__ == \"__main__\":
    main()
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (ar-match-paren)
   (should (eq (char-after) ?i))))

(ert-deftest ar-ert-narrow-to-block-test-uDQtR1-tqncYG ()
  (ar-test
   "with file(\"roulette-\" + zeit + \".csv\", 'w') as datei:
    for i in range(anzahl):
        klauf.pylauf()
                    "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char(point-max))
   (skip-chars-backward " \t\r\n\f")
   (ar-narrow-to-block)
   (should (< (length (buffer-substring-no-properties (point-min)(point-max))) 50))))

(ert-deftest ar-ert-narrow-to-block-test-xnEs46-GPBOHw ()
  (ar-test
   "with file(\"roulette-\" + zeit + \".csv\", 'w') as datei:
    for i in range(anzahl):
        klauf.pylauf()
        "
   'SomeMode-mode
   'ar-verbose-p
   (goto-char(point-max))
   (skip-chars-backward " \t\r\n\f")
   (ar-narrow-to-block)
   (should (< (length (buffer-substring-no-properties (point-min)(point-max))) 50))))

(ert-deftest ar-ert-narrow-to-block-or-clause-test-43VsYV ()
  (ar-test
   "if treffer in gruen:
    # print \"0, Gruen\"
    ausgabe[1] = treffer
    ausgabe[2] = treffer

elif treffer in schwarz:
    # print \"%i, Schwarz\" % (treffer)
    ausgabe[1] = treffer
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char(point-max))
   (skip-chars-backward " \t\r\n\f")
   (ar-narrow-to-block-or-clause)
   (should (eq 87 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-narrow-to-clause-test-rHLyyW ()
  (ar-test
   "if treffer in gruen:
    # print \"0, Gruen\"
    ausgabe[1] = treffer
    ausgabe[2] = treffer

elif treffer in schwarz:
    # print \"%i, Schwarz\" % (treffer)
    ausgabe[1] = treffer
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char(point-max))
   (ar-narrow-to-clause)
   (should (eq 87 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-narrow-to-class-test-MNaZDI ()
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
   (goto-char(point-max))
   (search-backward "treffer")
   (ar-narrow-to-class)
   (should (eq 710 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-narrow-to-def-test-wGwY45 ()
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
   (goto-char(point-max))
   (search-backward "treffer")
   (ar-narrow-to-def)
   (sit-for 1) 
   (should (< 477 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-narrow-to-def-or-class-test-46QGK4 ()
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
   (goto-char(point-max))
   (search-backward "treffer")
   (ar-narrow-to-def-or-class)
   (should (< 480 (length (buffer-substring-no-properties (point-min)(point-max)))))
   (should (> 490 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-narrow-to-statement-test-7WyEtz ()
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
   (goto-char(point-max))
   (search-backward "treffer")
   (ar-narrow-to-statement)
   (should (eq 32 (length (buffer-substring-no-properties (point-min)(point-max)))))))

(ert-deftest ar-ert-bracket-closing-1-4wPEHo ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (ar-test
   "
my_list = [
    1, 2, 3,
    4, 5, 6,
    ]"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (beginning-of-line)
   (let ((ar-closing-list-dedents-bos t))
     (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-bracket-closing-2-Ef3fSe ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (ar-test
   "
my_list = [
    1, 2, 3,
    4, 5, 6,
    ]"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (forward-char -1)
   (let ((ar-closing-list-dedents-bos t))
     (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-bracket-closing-3-4Q5V34 ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (ar-test
   "
my_list = [
    1, 2, 3,
    4, 5, 6,
    ]"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (let ((ar-closing-list-dedents-bos t))
     (should (eq 0 (ar-compute-indentation))))))

(ert-deftest ar-ert-bracket-closing-4-q2feIY ()
  ""
  'SomeMode-mode
  'ar-verbose-p
  (ar-test
   "
my_list = [
    1, 2, 3,
    4, 5, 6,
    ]"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (beginning-of-line)
   (let ((ar-closing-list-dedents-bos nil)
         (ar-indent-list-style 'one-level-to-beginning-of-statement))
     (should (eq 4 (ar-compute-indentation))))))

(ert-deftest ar-ert-multiple-decorators-test-1-KyE0zL ()
  (ar-test
   "@blah
@blub
def foo():
    pass
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (let ((ar-mark-decorators t))
     (ar-backward-def-or-class)
     (should (bobp)))))

(ert-deftest ar-ert-multiple-decorators-test-2-D9kV8N ()
  (ar-test
   "@blah
@blub
def foo():
    pass
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (let* (ar-mark-decorators
          (erg (ar-backward-def-or-class)))
     (should (eq 13 erg)))))

(ert-deftest ar-ert-async-backward-block-test-OdiTDQ ()
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

(ert-deftest ar-ert-async-backward-def-test-lF1w7S ()
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
   (ar-backward-def)
   (should (looking-at "async def"))))

(provide 'ar-ert-scope-tests)
;;; ar-ert-scope-tests.el ends here
