;;; ar-ert-hide-tests.el ---

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

(require 'ar-setup-ert-tests)

;; (ert-deftest ar-ert-hide-partial-expression-test-Li7vPR ()

;;   (ar-test-point-min "
;; class kugel(object):
;;     zeit = time.strftime('%Y%m%d--%H-%M-%S')

;;     def pylauf(self):
;;         \"\"\"Eine Doku fuer pylauf\"\"\"
;;         ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]

;;         ausgabe[0] = treffer
;;         if treffer in gruen:
;;             # print \"0, Gruen\"
;;             datei.write(str(spiel[i]) + \"\\n\")
;; "
;;     (font-lock-ensure)
;;     (search-forward "+ \"")
;;     (ar-hide-partial-expression)
;;     (should (string-match "overlay from 315 to 317" (prin1-to-string (car (overlays-at (point))))))
;;     (ar-show)
;;     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))
;;     ))

(ert-deftest ar-ert-hide-expression-test ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-expression)
                     (should (string-match "overlay from 286 to 319" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))

(ert-deftest ar-ert-hide-clause-test-qsv8kt ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-clause)
                     (should (string-match "overlay from 222 to 319" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))


(ert-deftest ar-ert-hide-clause-test-rO7k4k ()
  (ar-test "if 0 < treffer:
    if 18 < treffer:
        ausgabe[6] = treffer
    else:
        ausgabe[7] = treffer
"
           'SomeMode-mode
           'ar-verbose-p
           (font-lock-ensure)
           (goto-char (point-max))
           (search-backward "6")
           (ar-hide-clause)
           ;; (should (search-forward "else"))
           (should-not (string-match (prin1-to-string (car (overlays-at (point)))) "overlay from 21 to 105" ))
           (should-not (string-match (prin1-to-string (car (overlays-at (point)))) "overlay from 21 to 65"))))

(ert-deftest ar-ert-hide-block-test-5j57vC ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     ;; (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-block)
                     (should (string-match "overlay from 222 to 319" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))

(ert-deftest ar-ert-hide-def-test ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     ;; (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-def)
                     (should (string-match "overlay from 73 to 319" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))

(ert-deftest ar-ert-hide-class-test ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     (switch-to-buffer (current-buffer))
                     ;; (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-class)
                     (should (string-match "overlay from 2 to 319" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))

(ert-deftest ar-ert-hide-indent-test-dTRpuQ ()
  (ar-test-point-min "
class kugel(object):
    zeit = time.strftime('%Y%m%d--%H-%M-%S')
    def pylauf(self):
        \"\"\"Eine Doku fuer pylauf\"\"\"
        ausgabe = [\" \",\" \",\" \",\" \",\" \",\" \",\" \",\" \", \" \"]
        ausgabe[0] = treffer
        if treffer in gruen:
            print \"0, Gruen\"
            # print \"0, Gruen\"
            datei.write(str(spiel[i]) + \"\\n\")
"
                     'SomeMode-mode
                     'ar-verbose-p
                     ;; (font-lock-ensure)
                     (search-forward "+ \"")
                     (ar-hide-indent)
                     (should (string-match "overlay from 255 to 348" (prin1-to-string (car (overlays-at (point))))))
                     (ar-show)
                     (should (not (string-match "overlay" (prin1-to-string (car (overlays-at (point)))))))))

(ert-deftest ar-ert-hide-block-test-dTRpuQ ()
  (ar-test
   "def f(first, second):
    if first    == 1:
        return 11
    elif first  == 2:
        return 22
    if second   == 12:
        return 211
    elif second == 22:
        return 244
    else:
        return 25
"
   'SomeMode-mode
   'ar-verbose-p
   (goto-char (point-max))
   (should (search-backward "else"))
   (ar-hide-block)
   (should (string-match "overlay from 109 to 216" (prin1-to-string (car (overlays-at (point))))))))


(provide 'ar-ert-hide-tests)
;;; ar-ert-hide-tests.el ends here
