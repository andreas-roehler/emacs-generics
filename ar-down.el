;;; ar-down.el -- Searching downwards in buffer -*- lexical-binding: t; -*- 


(defun ar-down-block (&optional indent)
  "Go to the beginning of next block downwards according to INDENT.

Return position if block found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-block-re) indent))

(defun ar-down-class (&optional indent)
  "Go to the beginning of next class downwards according to INDENT.

Return position if class found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-class-re) indent))

(defun ar-down-clause (&optional indent)
  "Go to the beginning of next clause downwards according to INDENT.

Return position if clause found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-clause-re) indent))

(defun ar-down-block-or-clause (&optional indent)
  "Go to the beginning of next block-or-clause downwards according to INDENT.

Return position if block-or-clause found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-block-or-clause-re) indent))

(defun ar-down-def (&optional indent)
  "Go to the beginning of next def downwards according to INDENT.

Return position if def found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-def-re) indent))

(defun ar-down-def-or-class (&optional indent)
  "Go to the beginning of next def-or-class downwards according to INDENT.

Return position if def-or-class found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-def-or-class-re) indent))

(defun ar-down-minor-block (&optional indent)
  "Go to the beginning of next minor-block downwards according to INDENT.

Return position if minor-block found, nil otherwise."
  (interactive)
  (ar-down-base (quote ar-minor-block-re) indent))

(defun ar-down-block-bol (&optional indent)
  "Go to the beginning of next block below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if block found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-block-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-class-bol (&optional indent)
  "Go to the beginning of next class below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if class found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-class-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-clause-bol (&optional indent)
  "Go to the beginning of next clause below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if clause found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-clause-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-block-or-clause-bol (&optional indent)
  "Go to the beginning of next block-or-clause below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if block-or-clause found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-block-or-clause-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-def-bol (&optional indent)
  "Go to the beginning of next def below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if def found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-def-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-def-or-class-bol (&optional indent)
  "Go to the beginning of next def-or-class below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if def-or-class found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-def-or-class-re) indent t)
  (progn (beginning-of-line)(point)))

(defun ar-down-minor-block-bol (&optional indent)
  "Go to the beginning of next minor-block below according to INDENT.

Go to beginning of line
Optional INDENT: honor indentation
Return position if minor-block found, nil otherwise "
  (interactive)
  (ar-down-base (quote ar-minor-block-re) indent t)
  (progn (beginning-of-line)(point)))

;; ar-down.el ends here
(provide (quote ar-down))
