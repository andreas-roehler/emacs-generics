;;; ar-mark-forms.el --- mark forms -*- lexical-binding: t; -*-


(defun ar-mark-comment ()
  "Mark comment at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "comment")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-expression ()
  "Mark expression at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "expression")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-line ()
  "Mark line at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "line")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-paragraph ()
  "Mark paragraph at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "paragraph")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-partial-expression ()
  "Mark partial-expression at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "partial-expression")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-section ()
  "Mark section at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "section")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-top-level ()
  "Mark top-level at point.

Return beginning and end positions of marked area, a cons."
  (interactive)
  (ar--mark-base "top-level")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(defun ar-mark-assignment ()
  "Mark assignment, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "assignment")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-block ()
  "Mark block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-block-or-clause ()
  "Mark block-or-clause, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "block-or-clause")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-class (&optional arg)
  "Mark class, take beginning of line positions.

With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, decorators are marked too.
Return beginning and end positions of region, a cons."
  (interactive "P")
  (let ((ar-mark-decorators (or arg ar-mark-decorators)))
    (ar--mark-base-bol "class" ar-mark-decorators))
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-clause ()
  "Mark clause, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "clause")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-def (&optional arg)
  "Mark def, take beginning of line positions.

With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, decorators are marked too.
Return beginning and end positions of region, a cons."
  (interactive "P")
  (let ((ar-mark-decorators (or arg ar-mark-decorators)))
    (ar--mark-base-bol "def" ar-mark-decorators))
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-def-or-class (&optional arg)
  "Mark def-or-class, take beginning of line positions.

With ARG \\[universal-argument] or ‘ar-mark-decorators’ set to t, decorators are marked too.
Return beginning and end positions of region, a cons."
  (interactive "P")
  (let ((ar-mark-decorators (or arg ar-mark-decorators)))
    (ar--mark-base-bol "def-or-class" ar-mark-decorators))
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-elif-block ()
  "Mark elif-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "elif-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-else-block ()
  "Mark else-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "else-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-except-block ()
  "Mark except-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "except-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-for-block ()
  "Mark for-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "for-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-if-block ()
  "Mark if-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "if-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-indent ()
  "Mark indent, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "indent")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-minor-block ()
  "Mark minor-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "minor-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-statement ()
  "Mark statement, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "statement")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))
(defun ar-mark-try-block ()
  "Mark try-block, take beginning of line positions.

Return beginning and end positions of region, a cons."
  (interactive)
  (ar--mark-base-bol "try-block")
  (exchange-point-and-mark)
  (cons (region-beginning) (region-end)))

(provide (quote ar-mark-forms))
;;; ar-mark-forms.el ends here
