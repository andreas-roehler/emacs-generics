;;; ar-copy-forms.el --- copy forms -*- lexical-binding: t; -*-


(defun ar-copy-block ()
  "Copy block at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "block")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-block-or-clause ()
  "Copy block-or-clause at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "block-or-clause")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-buffer ()
  "Copy buffer at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "buffer")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-class ()
  "Copy class at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "class")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-clause ()
  "Copy clause at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "clause")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-def ()
  "Copy def at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "def")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-def-or-class ()
  "Copy def-or-class at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "def-or-class")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-expression ()
  "Copy expression at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "expression")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-indent ()
  "Copy indent at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "indent")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-line ()
  "Copy line at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "line")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-minor-block ()
  "Copy minor-block at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "minor-block")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-paragraph ()
  "Copy paragraph at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "paragraph")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-partial-expression ()
  "Copy partial-expression at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "partial-expression")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-region ()
  "Copy region at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "region")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-statement ()
  "Copy statement at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "statement")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-top-level ()
  "Copy top-level at point.

Store data in kill ring, so it might yanked back."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "top-level")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-block-bol ()
  "Delete block bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "block")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-block-or-clause-bol ()
  "Delete block-or-clause bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "block-or-clause")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-buffer-bol ()
  "Delete buffer bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "buffer")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-class-bol ()
  "Delete class bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "class")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-clause-bol ()
  "Delete clause bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "clause")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-def-bol ()
  "Delete def bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "def")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-def-or-class-bol ()
  "Delete def-or-class bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "def-or-class")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-expression-bol ()
  "Delete expression bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "expression")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-indent-bol ()
  "Delete indent bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "indent")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-line-bol ()
  "Delete line bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "line")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-minor-block-bol ()
  "Delete minor-block bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "minor-block")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-paragraph-bol ()
  "Delete paragraph bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "paragraph")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-partial-expression-bol ()
  "Delete partial-expression bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "partial-expression")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-region-bol ()
  "Delete region bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "region")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-statement-bol ()
  "Delete statement bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "statement")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(defun ar-copy-top-level-bol ()
  "Delete top-level bol at point.

Stores data in kill ring. Might be yanked back using ‘C-y’."
  (interactive "*")
  (save-excursion
    (let ((erg (ar--mark-base-bol "top-level")))
      (copy-region-as-kill (car erg) (cdr erg)))))

(provide (quote ar-copy-forms))
;; ar-copy-forms.el ends here
