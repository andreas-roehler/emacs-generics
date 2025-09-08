;;; ar-end-position-forms.el --- -*- lexical-binding: t; -*-


(defun ar--end-of-block-position ()
  "Return end of block position."
  (save-excursion (ar-forward-block)))

(defun ar--end-of-block-or-clause-position ()
  "Return end of block-or-clause position."
  (save-excursion (ar-forward-block-or-clause)))

(defun ar--end-of-class-position ()
  "Return end of class position."
  (save-excursion (ar-forward-class)))

(defun ar--end-of-clause-position ()
  "Return end of clause position."
  (save-excursion (ar-forward-clause)))

(defun ar--end-of-comment-position ()
  "Return end of comment position."
  (save-excursion (ar-forward-comment)))

(defun ar--end-of-def-position ()
  "Return end of def position."
  (save-excursion (ar-forward-def)))

(defun ar--end-of-def-or-class-position ()
  "Return end of def-or-class position."
  (save-excursion (ar-forward-def-or-class)))

(defun ar--end-of-expression-position ()
  "Return end of expression position."
  (save-excursion (ar-forward-expression)))

(defun ar--end-of-except-block-position ()
  "Return end of except-block position."
  (save-excursion (ar-forward-except-block)))

(defun ar--end-of-if-block-position ()
  "Return end of if-block position."
  (save-excursion (ar-forward-if-block)))

(defun ar--end-of-indent-position ()
  "Return end of indent position."
  (save-excursion (ar-forward-indent)))

(defun ar--end-of-line-position ()
  "Return end of line position."
  (save-excursion (ar-forward-line)))

(defun ar--end-of-minor-block-position ()
  "Return end of minor-block position."
  (save-excursion (ar-forward-minor-block)))

(defun ar--end-of-partial-expression-position ()
  "Return end of partial-expression position."
  (save-excursion (ar-forward-partial-expression)))

(defun ar--end-of-paragraph-position ()
  "Return end of paragraph position."
  (save-excursion (ar-forward-paragraph)))

(defun ar--end-of-section-position ()
  "Return end of section position."
  (save-excursion (ar-forward-section)))

(defun ar--end-of-statement-position ()
  "Return end of statement position."
  (save-excursion (ar-forward-statement)))

(defun ar--end-of-top-level-position ()
  "Return end of top-level position."
  (save-excursion (ar-forward-top-level)))

(defun ar--end-of-try-block-position ()
  "Return end of try-block position."
  (save-excursion (ar-forward-try-block)))

(defun ar--end-of-block-position-bol ()
  "Return end of block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-block-bol)))

(defun ar--end-of-block-or-clause-position-bol ()
  "Return end of block-or-clause position at ‘beginning-of-line’."
  (save-excursion (ar-forward-block-or-clause-bol)))

(defun ar--end-of-class-position-bol ()
  "Return end of class position at ‘beginning-of-line’."
  (save-excursion (ar-forward-class-bol)))

(defun ar--end-of-clause-position-bol ()
  "Return end of clause position at ‘beginning-of-line’."
  (save-excursion (ar-forward-clause-bol)))

(defun ar--end-of-def-position-bol ()
  "Return end of def position at ‘beginning-of-line’."
  (save-excursion (ar-forward-def-bol)))

(defun ar--end-of-def-or-class-position-bol ()
  "Return end of def-or-class position at ‘beginning-of-line’."
  (save-excursion (ar-forward-def-or-class-bol)))

(defun ar--end-of-elif-block-position-bol ()
  "Return end of elif-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-elif-block-bol)))

(defun ar--end-of-else-block-position-bol ()
  "Return end of else-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-else-block-bol)))

(defun ar--end-of-except-block-position-bol ()
  "Return end of except-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-except-block-bol)))

(defun ar--end-of-for-block-position-bol ()
  "Return end of for-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-for-block-bol)))

(defun ar--end-of-if-block-position-bol ()
  "Return end of if-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-if-block-bol)))

(defun ar--end-of-indent-position-bol ()
  "Return end of indent position at ‘beginning-of-line’."
  (save-excursion (ar-forward-indent-bol)))

(defun ar--end-of-minor-block-position-bol ()
  "Return end of minor-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-minor-block-bol)))

(defun ar--end-of-statement-position-bol ()
  "Return end of statement position at ‘beginning-of-line’."
  (save-excursion (ar-forward-statement-bol)))

(defun ar--end-of-try-block-position-bol ()
  "Return end of try-block position at ‘beginning-of-line’."
  (save-excursion (ar-forward-try-block-bol)))

(provide (quote ar-end-position-forms))
;;; ar-end-position-forms.el ends here
