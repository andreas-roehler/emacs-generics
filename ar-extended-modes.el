;;; ar-extended-modes.el --  -*- lexical-binding: t; -*-


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

;;; Code:

;; (defvar-local ar-extended-modes-map
;;   (let ((map (make-sparse-keymap)))
;;     (set-keymap-parent map scala-mode-map))
;;   "")

;; (add-to-list 'load-path (expand-file-name  "./extended-scala-mode"))

;; (defun ar-load-generic-modes ()
;;   ""
;;   (interactive)
;;     (pcase major-mode
;;       (`scala-mode
;;        (define-minor-mode extended-scala-mode ""
;;          :lighter "E"
;;          :require 'scala-mode
;;          :require 'ar-scala-vars
;;          :require 'extended-scala-mode
;;          :map extendend-scala-mode-map
;;          (all-mode-setting)
;;          (force-mode-line-update)))
;;       (_ nil)))

;; (ar-load-generic-modes)


;; ar-extended-modes.el ends here
(provide 'ar-extended-modes)
