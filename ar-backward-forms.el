;;; ar-backward-forms.el --- Go to beginning of form or further backward -*- lexical-binding: t; -*-

(defun ar-backward-region ()
  "Go to the beginning of current region."
  (interactive)
  (let ((beg (region-beginning)))
    (when beg (goto-char beg))))

(defun ar-backward-block ()
  "Go to beginning of ‘block’.

If already at beginning, go one ‘block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (if ar-mark-decorators
      (when (ar--go-to-keyword 'ar-block-re '<)
        (ar-backward-decorator)(point))
    (ar--go-to-keyword 'ar-block-re '<)))

(defun ar-backward-class ()
  "Go to beginning of ‘class’.

If already at beginning, go one ‘class’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (if ar-mark-decorators
      (when (ar--go-to-keyword 'ar-class-re '<)
        (ar-backward-decorator)(point))
    (ar--go-to-keyword 'ar-class-re '<)))

(defun ar-backward-def ()
  "Go to beginning of ‘def’.

If already at beginning, go one ‘def’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (if ar-mark-decorators
      (when (ar--go-to-keyword 'ar-def-re '<)
        (ar-backward-decorator)(point))
    (ar--go-to-keyword 'ar-def-re '<)))

(defun ar-backward-def-or-class ()
  "Go to beginning of ‘def-or-class’.

If already at beginning, go one ‘def-or-class’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (if ar-mark-decorators
      (when (ar--go-to-keyword 'ar-def-or-class-re '<)
        (ar-backward-decorator)(point))
    (ar--go-to-keyword 'ar-def-or-class-re '<)))

(defun ar-backward-block-bol ()
  "Go to beginning of ‘block’, go to BOL.
If already at beginning, go one ‘block’ backward.
Return beginning of ‘block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-class-bol ()
  "Go to beginning of ‘class’, go to BOL.
If already at beginning, go one ‘class’ backward.
Return beginning of ‘class’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-class)
       (progn (beginning-of-line)(point))))

(defun ar-backward-def-bol ()
  "Go to beginning of ‘def’, go to BOL.
If already at beginning, go one ‘def’ backward.
Return beginning of ‘def’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-def)
       (progn (beginning-of-line)(point))))

(defun ar-backward-def-or-class-bol ()
  "Go to beginning of ‘def-or-class’, go to BOL.
If already at beginning, go one ‘def-or-class’ backward.
Return beginning of ‘def-or-class’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-def-or-class)
       (progn (beginning-of-line)(point))))

(defun ar-backward-assignment ()
  "Go to beginning of ‘assignment’.

If already at beginning, go one ‘assignment’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-assignment-re '<))

(defun ar-backward-block-or-clause ()
  "Go to beginning of ‘block-or-clause’.

If already at beginning, go one ‘block-or-clause’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-block-or-clause-re '<))

(defun ar-backward-clause ()
  "Go to beginning of ‘clause’.

If already at beginning, go one ‘clause’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-clause-re '<))

(defun ar-backward-elif-block ()
  "Go to beginning of ‘elif-block’.

If already at beginning, go one ‘elif-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-elif-re '<))

(defun ar-backward-else-block ()
  "Go to beginning of ‘else-block’.

If already at beginning, go one ‘else-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-else-re '<))

(defun ar-backward-except-block ()
  "Go to beginning of ‘except-block’.

If already at beginning, go one ‘except-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-except-re '<))

(defun ar-backward-for-block ()
  "Go to beginning of ‘for-block’.

If already at beginning, go one ‘for-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-for-re '<))

(defun ar-backward-if-block ()
  "Go to beginning of ‘if-block’.

If already at beginning, go one ‘if-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-if-re '<))

(defun ar-backward-minor-block ()
  "Go to beginning of ‘minor-block’.

If already at beginning, go one ‘minor-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-minor-block-re '<))

(defun ar-backward-try-block ()
  "Go to beginning of ‘try-block’.

If already at beginning, go one ‘try-block’ backward.
Return position if successful, nil otherwise"
  (interactive)
  (ar--go-to-keyword 'ar-try-re '<))

(defun ar-backward-assignment-bol ()
  "Go to beginning of ‘assignment’, go to BOL.
If already at beginning, go one ‘assignment’ backward.
Return beginning of ‘assignment’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-assignment)
       (progn (beginning-of-line)(point))))

(defun ar-backward-block-or-clause-bol ()
  "Go to beginning of ‘block-or-clause’, go to BOL.
If already at beginning, go one ‘block-or-clause’ backward.
Return beginning of ‘block-or-clause’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-block-or-clause)
       (progn (beginning-of-line)(point))))

(defun ar-backward-clause-bol ()
  "Go to beginning of ‘clause’, go to BOL.
If already at beginning, go one ‘clause’ backward.
Return beginning of ‘clause’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-clause)
       (progn (beginning-of-line)(point))))

(defun ar-backward-elif-block-bol ()
  "Go to beginning of ‘elif-block’, go to BOL.
If already at beginning, go one ‘elif-block’ backward.
Return beginning of ‘elif-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-elif-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-else-block-bol ()
  "Go to beginning of ‘else-block’, go to BOL.
If already at beginning, go one ‘else-block’ backward.
Return beginning of ‘else-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-else-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-except-block-bol ()
  "Go to beginning of ‘except-block’, go to BOL.
If already at beginning, go one ‘except-block’ backward.
Return beginning of ‘except-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-except-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-for-block-bol ()
  "Go to beginning of ‘for-block’, go to BOL.
If already at beginning, go one ‘for-block’ backward.
Return beginning of ‘for-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-for-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-if-block-bol ()
  "Go to beginning of ‘if-block’, go to BOL.
If already at beginning, go one ‘if-block’ backward.
Return beginning of ‘if-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-if-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-minor-block-bol ()
  "Go to beginning of ‘minor-block’, go to BOL.
If already at beginning, go one ‘minor-block’ backward.
Return beginning of ‘minor-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-minor-block)
       (progn (beginning-of-line)(point))))

(defun ar-backward-try-block-bol ()
  "Go to beginning of ‘try-block’, go to BOL.
If already at beginning, go one ‘try-block’ backward.
Return beginning of ‘try-block’ if successful, nil otherwise"
  (interactive)
  (and (ar-backward-try-block)
       (progn (beginning-of-line)(point))))

(provide 'ar-backward-forms)
;;; ar-backward-forms.el ends here
