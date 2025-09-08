;;; ar-beginning-position-forms.el --- -*- lexical-binding: t; -*-


(defun ar--beginning-of-block-position ()
  "Return beginning of block position."
  (save-excursion
    (or (ar--beginning-of-block-p)
        (ar-backward-block))))

(defun ar--beginning-of-block-or-clause-position ()
  "Return beginning of block-or-clause position."
  (save-excursion
    (or (ar--beginning-of-block-or-clause-p)
        (ar-backward-block-or-clause))))

(defun ar--beginning-of-class-position ()
  "Return beginning of class position."
  (save-excursion
    (or (ar--beginning-of-class-p)
        (ar-backward-class))))

(defun ar--beginning-of-clause-position ()
  "Return beginning of clause position."
  (save-excursion
    (or (ar--beginning-of-clause-p)
        (ar-backward-clause))))

(defun ar--beginning-of-comment-position ()
  "Return beginning of comment position."
  (save-excursion
    (or (ar--beginning-of-comment-p)
        (ar-backward-comment))))

(defun ar--beginning-of-def-position ()
  "Return beginning of def position."
  (save-excursion
    (or (ar--beginning-of-def-p)
        (ar-backward-def))))

(defun ar--beginning-of-def-or-class-position ()
  "Return beginning of def-or-class position."
  (save-excursion
    (or (ar--beginning-of-def-or-class-p)
        (ar-backward-def-or-class))))

(defun ar--beginning-of-expression-position ()
  "Return beginning of expression position."
  (save-excursion
    (or (ar--beginning-of-expression-p)
        (ar-backward-expression))))

(defun ar--beginning-of-except-block-position ()
  "Return beginning of except-block position."
  (save-excursion
    (or (ar--beginning-of-except-block-p)
        (ar-backward-except-block))))

(defun ar--beginning-of-if-block-position ()
  "Return beginning of if-block position."
  (save-excursion
    (or (ar--beginning-of-if-block-p)
        (ar-backward-if-block))))

(defun ar--beginning-of-indent-position ()
  "Return beginning of indent position."
  (save-excursion
    (or (ar--beginning-of-indent-p)
        (ar-backward-indent))))

(defun ar--beginning-of-line-position ()
  "Return beginning of line position."
  (save-excursion
    (or (ar--beginning-of-line-p)
        (ar-backward-line))))

(defun ar--beginning-of-minor-block-position ()
  "Return beginning of minor-block position."
  (save-excursion
    (or (ar--beginning-of-minor-block-p)
        (ar-backward-minor-block))))

(defun ar--beginning-of-partial-expression-position ()
  "Return beginning of partial-expression position."
  (save-excursion
    (or (ar--beginning-of-partial-expression-p)
        (ar-backward-partial-expression))))

(defun ar--beginning-of-paragraph-position ()
  "Return beginning of paragraph position."
  (save-excursion
    (or (ar--beginning-of-paragraph-p)
        (ar-backward-paragraph))))

(defun ar--beginning-of-section-position ()
  "Return beginning of section position."
  (save-excursion
    (or (ar--beginning-of-section-p)
        (ar-backward-section))))

(defun ar--beginning-of-statement-position ()
  "Return beginning of statement position."
  (save-excursion
    (or (ar--beginning-of-statement-p)
        (ar-backward-statement))))

(defun ar--beginning-of-top-level-position ()
  "Return beginning of top-level position."
  (save-excursion
    (or (ar--beginning-of-top-level-p)
        (ar-backward-top-level))))

(defun ar--beginning-of-try-block-position ()
  "Return beginning of try-block position."
  (save-excursion
    (or (ar--beginning-of-try-block-p)
        (ar-backward-try-block))))

(defun ar--beginning-of-block-position-bol ()
  "Return beginning of block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-block-bol-p)
        (ar-backward-block-bol))))

(defun ar--beginning-of-block-or-clause-position-bol ()
  "Return beginning of block-or-clause position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-block-or-clause-bol-p)
        (ar-backward-block-or-clause-bol))))

(defun ar--beginning-of-class-position-bol ()
  "Return beginning of class position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-class-bol-p)
        (ar-backward-class-bol))))

(defun ar--beginning-of-clause-position-bol ()
  "Return beginning of clause position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-clause-bol-p)
        (ar-backward-clause-bol))))

(defun ar--beginning-of-def-position-bol ()
  "Return beginning of def position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-def-bol-p)
        (ar-backward-def-bol))))

(defun ar--beginning-of-def-or-class-position-bol ()
  "Return beginning of def-or-class position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-def-or-class-bol-p)
        (ar-backward-def-or-class-bol))))

(defun ar--beginning-of-elif-block-position-bol ()
  "Return beginning of elif-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-elif-block-bol-p)
        (ar-backward-elif-block-bol))))

(defun ar--beginning-of-else-block-position-bol ()
  "Return beginning of else-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-else-block-bol-p)
        (ar-backward-else-block-bol))))

(defun ar--beginning-of-except-block-position-bol ()
  "Return beginning of except-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-except-block-bol-p)
        (ar-backward-except-block-bol))))

(defun ar--beginning-of-for-block-position-bol ()
  "Return beginning of for-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-for-block-bol-p)
        (ar-backward-for-block-bol))))

(defun ar--beginning-of-if-block-position-bol ()
  "Return beginning of if-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-if-block-bol-p)
        (ar-backward-if-block-bol))))

(defun ar--beginning-of-indent-position-bol ()
  "Return beginning of indent position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-indent-bol-p)
        (ar-backward-indent-bol))))

(defun ar--beginning-of-minor-block-position-bol ()
  "Return beginning of minor-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-minor-block-bol-p)
        (ar-backward-minor-block-bol))))

(defun ar--beginning-of-statement-position-bol ()
  "Return beginning of statement position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-statement-bol-p)
        (ar-backward-statement-bol))))

(defun ar--beginning-of-try-block-position-bol ()
  "Return beginning of try-block position at ‘beginning-of-line’."
  (save-excursion
    (or (ar--beginning-of-try-block-bol-p)
        (ar-backward-try-block-bol))))

(provide (quote ar-beginning-position-forms))
;;; ar-beginning-position-forms.el ends here
