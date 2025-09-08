;;; ar-forms-code.el --- Return SOME forms' code -*- lexical-binding: t; -*-

(defun ar-block (&optional decorators)
  "When called interactively, mark Block at point.

From a programm, return source of Block at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "block" (or decorators ar-mark-decorators))
    (ar--thing-at-point "block" (or decorators ar-mark-decorators))))

(defun ar-block-or-clause (&optional decorators)
  "When called interactively, mark Block-Or-Clause at point.

From a programm, return source of Block-Or-Clause at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "block-or-clause" (or decorators ar-mark-decorators))
    (ar--thing-at-point "block-or-clause" (or decorators ar-mark-decorators))))

(defun ar-buffer ()
  "When called interactively, mark Buffer at point.

From a programm, return source of Buffer at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "buffer")
    (ar--thing-at-point "buffer")))

(defun ar-class (&optional decorators)
  "When called interactively, mark Class at point.

From a programm, return source of Class at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "class" (or decorators ar-mark-decorators))
    (ar--thing-at-point "class" (or decorators ar-mark-decorators))))

(defun ar-clause ()
  "When called interactively, mark Clause at point.

From a programm, return source of Clause at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "clause")
    (ar--thing-at-point "clause")))

(defun ar-def (&optional decorators)
  "When called interactively, mark Def at point.

From a programm, return source of Def at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "def" (or decorators ar-mark-decorators))
    (ar--thing-at-point "def" (or decorators ar-mark-decorators))))

(defun ar-def-or-class (&optional decorators)
  "When called interactively, mark Def-Or-Class at point.

From a programm, return source of Def-Or-Class at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "def-or-class" (or decorators ar-mark-decorators))
    (ar--thing-at-point "def-or-class" (or decorators ar-mark-decorators))))

(defun ar-expression ()
  "When called interactively, mark Expression at point.

From a programm, return source of Expression at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "expression")
    (ar--thing-at-point "expression")))

(defun ar-indent ()
  "When called interactively, mark Indent at point.

From a programm, return source of Indent at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "indent")
    (ar--thing-at-point "indent")))

(defun ar-line ()
  "When called interactively, mark Line at point.

From a programm, return source of Line at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "line")
    (ar--thing-at-point "line")))

(defun ar-minor-block ()
  "When called interactively, mark Minor-Block at point.

From a programm, return source of Minor-Block at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "minor-block")
    (ar--thing-at-point "minor-block")))

(defun ar-paragraph ()
  "When called interactively, mark Paragraph at point.

From a programm, return source of Paragraph at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "paragraph")
    (ar--thing-at-point "paragraph")))

(defun ar-partial-expression ()
  "When called interactively, mark Partial-Expression at point.

From a programm, return source of Partial-Expression at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "partial-expression")
    (ar--thing-at-point "partial-expression")))

(defun ar-region ()
  "When called interactively, mark Region at point.

From a programm, return source of Region at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "region")
    (ar--thing-at-point "region")))

(defun ar-statement ()
  "When called interactively, mark Statement at point.

From a programm, return source of Statement at point, a string."
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "statement")
    (ar--thing-at-point "statement")))

(defun ar-top-level (&optional decorators)
  "When called interactively, mark Top-Level at point.

From a programm, return source of Top-Level at point, a string.

Optional arg DECORATORS: include decorators when called at def or class.
Also honors setting of ‘ar-mark-decorators’"
  (interactive)
  (if (called-interactively-p (quote interactive))
      (ar--mark-base "top-level" (or decorators ar-mark-decorators))
    (ar--thing-at-point "top-level" (or decorators ar-mark-decorators))))

;; ar-forms-code.el ends here
(provide (quote ar-forms-code))
