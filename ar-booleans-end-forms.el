;;; ar-booleans-end-forms.el --- booleans-end forms -*- lexical-binding: t; -*-


(defun ar--end-of-comment-p ()
  "If cursor is at the end of a comment.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-comment)
      (ar-forward-comment)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-expression-p ()
  "If cursor is at the end of a expression.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-expression)
      (ar-forward-expression)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-line-p ()
  "If cursor is at the end of a line.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-line)
      (ar-forward-line)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-paragraph-p ()
  "If cursor is at the end of a paragraph.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-paragraph)
      (ar-forward-paragraph)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-partial-expression-p ()
  "If cursor is at the end of a partial-expression.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-partial-expression)
      (ar-forward-partial-expression)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-section-p ()
  "If cursor is at the end of a section.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-section)
      (ar-forward-section)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-top-level-p ()
  "If cursor is at the end of a top-level.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-top-level)
      (ar-forward-top-level)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-assignment-bol-p ()
  "If at ‘beginning-of-line’ at the end of a assignment.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-assignment-bol)
      (ar-forward-assignment-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-block-bol)
      (ar-forward-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-block-or-clause-bol-p ()
  "If at ‘beginning-of-line’ at the end of a block-or-clause.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-block-or-clause-bol)
      (ar-forward-block-or-clause-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-class-bol-p ()
  "If at ‘beginning-of-line’ at the end of a class.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-class-bol)
      (ar-forward-class-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-clause-bol-p ()
  "If at ‘beginning-of-line’ at the end of a clause.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-clause-bol)
      (ar-forward-clause-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-def-bol-p ()
  "If at ‘beginning-of-line’ at the end of a def.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-def-bol)
      (ar-forward-def-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-def-or-class-bol-p ()
  "If at ‘beginning-of-line’ at the end of a def-or-class.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-def-or-class-bol)
      (ar-forward-def-or-class-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-elif-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a elif-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-elif-block-bol)
      (ar-forward-elif-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-else-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a else-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-else-block-bol)
      (ar-forward-else-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-except-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a except-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-except-block-bol)
      (ar-forward-except-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-for-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a for-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-for-block-bol)
      (ar-forward-for-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-if-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a if-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-if-block-bol)
      (ar-forward-if-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-indent-bol-p ()
  "If at ‘beginning-of-line’ at the end of a indent.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-indent-bol)
      (ar-forward-indent-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-minor-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a minor-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-minor-block-bol)
      (ar-forward-minor-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-try-block-bol-p ()
  "If at ‘beginning-of-line’ at the end of a try-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-try-block-bol)
      (ar-forward-try-block-bol)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-assignment-p ()
  "If cursor is at the end of a assignment.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-assignment)
      (ar-forward-assignment)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-block-p ()
  "If cursor is at the end of a block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-block)
      (ar-forward-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-block-or-clause-p ()
  "If cursor is at the end of a block-or-clause.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-block-or-clause)
      (ar-forward-block-or-clause)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-class-p ()
  "If cursor is at the end of a class.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-class)
      (ar-forward-class)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-clause-p ()
  "If cursor is at the end of a clause.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-clause)
      (ar-forward-clause)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-def-p ()
  "If cursor is at the end of a def.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-def)
      (ar-forward-def)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-def-or-class-p ()
  "If cursor is at the end of a def-or-class.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-def-or-class)
      (ar-forward-def-or-class)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-elif-block-p ()
  "If cursor is at the end of a elif-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-elif-block)
      (ar-forward-elif-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-else-block-p ()
  "If cursor is at the end of a else-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-else-block)
      (ar-forward-else-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-except-block-p ()
  "If cursor is at the end of a except-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-except-block)
      (ar-forward-except-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-for-block-p ()
  "If cursor is at the end of a for-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-for-block)
      (ar-forward-for-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-if-block-p ()
  "If cursor is at the end of a if-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-if-block)
      (ar-forward-if-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-indent-p ()
  "If cursor is at the end of a indent.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-indent)
      (ar-forward-indent)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-minor-block-p ()
  "If cursor is at the end of a minor-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-minor-block)
      (ar-forward-minor-block)
      (when (eq orig (point))
        orig))))

(defun ar--end-of-try-block-p ()
  "If cursor is at the end of a try-block.
Return position, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-try-block)
      (ar-forward-try-block)
      (when (eq orig (point))
        orig))))

(provide (quote ar-booleans-end-forms))
;; ar-booleans-end-forms.el ends here
