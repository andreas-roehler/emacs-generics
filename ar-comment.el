;;; ar-comment.el -- Comment/uncomment SomeMode constructs at point -*- lexical-binding: t; -*-


(defun ar-comment-region (beg end &optional arg)
  "Like `comment-region’ but uses double hash ‘#’ comment starter."
  (interactive "r\nP")
  (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start)))
    (comment-region beg end arg)))

(defun ar-comment-block (&optional beg end arg)
  "Comments block at point.

Uses double hash ‘#’ comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-block-position)))
          (end (or end (ar--end-of-block-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-block-or-clause (&optional beg end arg)
  "Comments block-or-clause at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-block-or-clause-position)))
          (end (or end (ar--end-of-block-or-clause-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-class (&optional beg end arg)
  "Comments class at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-class-position)))
          (end (or end (ar--end-of-class-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-clause (&optional beg end arg)
  "Comments clause at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-clause-position)))
          (end (or end (ar--end-of-clause-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-def (&optional beg end arg)
  "Comments def at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-def-position)))
          (end (or end (ar--end-of-def-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-def-or-class (&optional beg end arg)
  "Comments def-or-class at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-def-or-class-position)))
          (end (or end (ar--end-of-def-or-class-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-indent (&optional beg end arg)
  "Comments indent at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-indent-position)))
          (end (or end (ar--end-of-indent-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-minor-block (&optional beg end arg)
  "Comments minor-block at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-minor-block-position)))
          (end (or end (ar--end-of-minor-block-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-section (&optional beg end arg)
  "Comments section at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-section-position)))
          (end (or end (ar--end-of-section-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-statement (&optional beg end arg)
  "Comments statement at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-statement-position)))
          (end (or end (ar--end-of-statement-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))

(defun ar-comment-top-level (&optional beg end arg)
  "Comments top-level at point.

Uses double hash (`#’) comment starter when ‘ar-block-comment-prefix-p’ is  t,
the default"
  (interactive "*")
  (save-excursion
    (let ((comment-start (if ar-block-comment-prefix-p
                             ar-block-comment-prefix
                           comment-start))
          (beg (or beg (ar--beginning-of-top-level-position)))
          (end (or end (ar--end-of-top-level-position))))
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (comment-region beg end arg))))


;; ar-comment ends here
(provide (quote ar-comment))
