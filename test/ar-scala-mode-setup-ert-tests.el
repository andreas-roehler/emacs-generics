;;; ar-scala-mode-setup-ert-tests.el --- Provide needed forms -*- lexical-binding: t; -*-

;; Keywords: lisp

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

;; (require 'org)

(defvar ar-scala-debug-p nil
  "Internal use only.")

;; (setq ar-scala-debug-p t)
(require 'scala-mode)

(unless (functionp 'ar-syntax-class-atpt)
  (defun ar-syntax-class-atpt (&optional pos)
    "Return the syntax class part of the syntax at point. "
    (interactive "p")
    (let* ((pos (or pos (point)))
	   (erg (logand (car (syntax-after pos)) 65535)))
      (when erg (message "%s" erg)) erg)))

(unless (functionp 'ar-syntax-atpt)
  (defun ar-syntax-atpt (&optional arg docu pos)
    (interactive "p")
    (when pos
      (goto-char pos))
    (let* ((elt (car (if (featurep 'xemacs)
			 (char-syntax (char-after))
		       (syntax-after (point)))))
	   (stax (cond ((eq elt 0) "0 whitespace")
		       ((eq elt 5) "5 close parenthesis")
		       ((eq elt 10) "10 character quote")
		       ((eq elt 1) "1 punctuation")
		       ((eq elt 6) "6 expression prefix")
		       ((eq elt 11) "11 comment-start")
		       ((eq elt 2) "2 word")
		       ((eq elt 7) "7 string quote")
		       ((eq elt 12) "12 comment-end")
		       ((eq elt 3) "3 symbol")
		       ((eq elt 8) "8 paired delimiter")
		       ((eq elt 13) "13 inherit")
		       ((eq elt 4) "4 open parenthesis")
		       ((eq elt 9) "9 escape")
		       ((eq elt 14) "14 generic comment")
		       ((eq elt 15) "15 generic string"))))
      (when arg
	(message (format "%s" stax)))
      (if docu
	  (format "%s" stax)
	elt))))

(defmacro ar-scala-test-with-temp-buffer (contents &rest body)
  "Create temp buffer in `scala-mode' inserting CONTENTS.
BODY is code to be executed within the temp buffer.  Point is
 at the end of buffer."
  (declare (indent 1) (debug t))
  `(with-temp-buffer
     (let (hs-minor-mode ar-scala-imenu-create-index-p)
       ;; (and (featurep 'python) (unload-feature 'python))
       (scala-mode)
       (insert ,contents)
       (when ar-scala-debug-p
	 (switch-to-buffer (current-buffer))
	 (font-lock-fontify-region (point-min) (point-max)))
       ,@body)))

(defmacro ar-scala-test-with-temp-buffer-point-min (contents &rest body)
  "Create temp buffer in `scala-mode' inserting CONTENTS.
BODY is code to be executed within the temp buffer.  Point is
 at the beginning of buffer."
  (declare (indent 1) (debug t))
  `(with-temp-buffer
     (let (hs-minor-mode ar-scala-imenu-create-index-p)
       (scala-mode)
       (insert ,contents)
       (goto-char (point-min))
       (when ar-scala-debug-p
	 (switch-to-buffer (current-buffer))
	 (font-lock-fontify-region (point-min) (point-max)))
       ,@body)))

;; from jit-lock.el
(defmacro with-buffer-prepared-for-jit-lock (&rest body)
  "Execute BODY in current buffer, overriding several variables.
Preserves the `buffer-modified-p' state of the current buffer."
  (declare (debug t))
  `(let ((inhibit-point-motion-hooks t))
     (with-silent-modifications
       ,@body)))


(provide 'ar-scala-mode-setup-ert-tests)
;; ar-scala-mode-setup-ert-tests.el ends here
