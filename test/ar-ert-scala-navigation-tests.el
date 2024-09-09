;;; ar-ert-scala-navigation-tests.el --- scala-mode navigation tests  -*- lexical-binding: t; -*-

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

(require 'ar-generics-setup-tests)

(ert-deftest ar-ert-moves-up-def-or-class-bol-iPn4ge-u4t728 ()
  (ar-generics-test
"def toPairs[A](xs: Seq[A], default: A): Seq[(A, A)] = {
  type Acc = (Seq[(A, A)], Seq[A])
    // Type alias, for brevity.
  def init: Acc = (Seq(), Seq())
  def updater(acc: Acc, x: A): Acc = acc match {
    case (result, Seq())
        => (result, Seq(x))
    case (result, Seq(prev)) => (result :+ ((prev, x)), Seq())
  }
  val (result, holdover) = xs.foldLeft(init)(updater)
    holdover match {
      // May need to append the last element to the result.
      case Seq()
          => result
      case Seq(x)
          => result :+ ((x, default))
    }
}
"
      'scala-mode
    (goto-char (point-max))
    (ar-backward-def-or-class)
    (should (looking-at "class"))))

(provide 'ar-ert-scala-navigation-tests)
;;; ar-ert-python-navigation-tests.el ends here
