;;; ar-delete-forms.el --- delete forms -*- lexical-binding: t; -*-


(defun ar-delete-block ()
  "Delete BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-block-or-clause ()
  "Delete BLOCK-OR-CLAUSE at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "block-or-clause")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-class (&optional arg)
  "Delete CLASS at point until ‘beginning-of-line’.

Do not store data in kill ring.
With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, ‘decorators’ are included."
  (interactive "P")
 (let* ((ar-mark-decorators (or arg ar-mark-decorators))
        (erg (ar--mark-base "class" ar-mark-decorators)))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-clause ()
  "Delete CLAUSE at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "clause")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-def (&optional arg)
  "Delete DEF at point until ‘beginning-of-line’.

Do not store data in kill ring.
With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, ‘decorators’ are included."
  (interactive "P")
 (let* ((ar-mark-decorators (or arg ar-mark-decorators))
        (erg (ar--mark-base "def" ar-mark-decorators)))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-def-or-class (&optional arg)
  "Delete DEF-OR-CLASS at point until ‘beginning-of-line’.

Do not store data in kill ring.
With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, ‘decorators’ are included."
  (interactive "P")
 (let* ((ar-mark-decorators (or arg ar-mark-decorators))
        (erg (ar--mark-base "def-or-class" ar-mark-decorators)))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-elif-block ()
  "Delete ELIF-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "elif-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-else-block ()
  "Delete ELSE-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "else-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-except-block ()
  "Delete EXCEPT-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "except-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-for-block ()
  "Delete FOR-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "for-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-if-block ()
  "Delete IF-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "if-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-indent ()
  "Delete INDENT at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "indent")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-minor-block ()
  "Delete MINOR-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "minor-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-statement ()
  "Delete STATEMENT at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "statement")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-try-block ()
  "Delete TRY-BLOCK at point until ‘beginning-of-line’.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base-bol "try-block")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-comment ()
  "Delete COMMENT at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "comment")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-line ()
  "Delete LINE at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "line")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-paragraph ()
  "Delete PARAGRAPH at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "paragraph")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-expression ()
  "Delete EXPRESSION at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "expression")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-partial-expression ()
  "Delete PARTIAL-EXPRESSION at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "partial-expression")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-section ()
  "Delete SECTION at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "section")))
    (delete-region (car erg) (cdr erg))))

(defun ar-delete-top-level ()
  "Delete TOP-LEVEL at point.

Do not store data in kill ring."
  (interactive)
  (let ((erg (ar--mark-base "top-level")))
    (delete-region (car erg) (cdr erg))))

(provide (quote ar-delete-forms))
;; ar-delete-forms.el ends here
