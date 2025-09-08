;;; ar-up.el -- Searching upwards in buffer -*- lexical-binding: t; -*- 


(defun ar-up-block ()
  "Go to the beginning of next block upwards.

Return position if block found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-block-re)))

(defun ar-up-class ()
  "Go to the beginning of next class upwards.

Return position if class found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-class-re)))

(defun ar-up-clause ()
  "Go to the beginning of next clause upwards.

Return position if clause found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-clause-re)))

(defun ar-up-block-or-clause ()
  "Go to the beginning of next block-or-clause upwards.

Return position if block-or-clause found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-block-or-clause-re)))

(defun ar-up-def ()
  "Go to the beginning of next def upwards.

Return position if def found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-def-re)))

(defun ar-up-def-or-class ()
  "Go to the beginning of next def-or-class upwards.

Return position if def-or-class found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-def-or-class-re)))

(defun ar-up-minor-block ()
  "Go to the beginning of next minor-block upwards.

Return position if minor-block found, nil otherwise."
  (interactive)
  (ar-up-base (quote ar-minor-block-re)))

(defun ar-up-block-bol ()
  "Go to the beginning of next block upwards.

Go to beginning of line.
Return position if block found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-block-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-class-bol ()
  "Go to the beginning of next class upwards.

Go to beginning of line.
Return position if class found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-class-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-clause-bol ()
  "Go to the beginning of next clause upwards.

Go to beginning of line.
Return position if clause found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-clause-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-block-or-clause-bol ()
  "Go to the beginning of next block-or-clause upwards.

Go to beginning of line.
Return position if block-or-clause found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-block-or-clause-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-def-bol ()
  "Go to the beginning of next def upwards.

Go to beginning of line.
Return position if def found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-def-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-def-or-class-bol ()
  "Go to the beginning of next def-or-class upwards.

Go to beginning of line.
Return position if def-or-class found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-def-or-class-re))
    (progn (beginning-of-line)(point))))

(defun ar-up-minor-block-bol ()
  "Go to the beginning of next minor-block upwards.

Go to beginning of line.
Return position if minor-block found, nil otherwise."
  (interactive)
  (and (ar-up-base (quote ar-minor-block-re))
    (progn (beginning-of-line)(point))))

;; ar-up.el ends here
(provide (quote ar-up))
