;;; ar-kill-forms.el --- kill forms -*- lexical-binding: t; -*-


(defun ar-kill-comment ()
  "Delete comment at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "comment")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-line ()
  "Delete line at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "line")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-paragraph ()
  "Delete paragraph at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "paragraph")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-expression ()
  "Delete expression at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "expression")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-partial-expression ()
  "Delete partial-expression at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "partial-expression")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-section ()
  "Delete section at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "section")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-top-level ()
  "Delete top-level at point.

Stores data in kill ring"
  (interactive "*")
  (let ((erg (ar--mark-base "top-level")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-block ()
  "Delete block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-block-or-clause ()
  "Delete block-or-clause at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "block-or-clause")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-class ()
  "Delete class at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "class")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-clause ()
  "Delete clause at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "clause")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-def ()
  "Delete def at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "def")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-def-or-class ()
  "Delete def-or-class at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "def-or-class")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-elif-block ()
  "Delete elif-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "elif-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-else-block ()
  "Delete else-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "else-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-except-block ()
  "Delete except-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "except-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-for-block ()
  "Delete for-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "for-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-if-block ()
  "Delete if-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "if-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-indent ()
  "Delete indent at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "indent")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-minor-block ()
  "Delete minor-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "minor-block")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-statement ()
  "Delete statement at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "statement")))
    (kill-region (car erg) (cdr erg))))

(defun ar-kill-try-block ()
  "Delete try-block at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (let ((erg (ar--mark-base-bol "try-block")))
    (kill-region (car erg) (cdr erg))))

(provide (quote ar-kill-forms))
;;; ar-kill-forms.el ends here
