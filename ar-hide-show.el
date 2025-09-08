;;; ar-hide-show.el --- Provide hs-minor-mode forms -*- lexical-binding: t; -*-

;; (setq hs-block-start-regexp (quote ar-extended-block-or-clause-re))
;; (setq hs-forward-sexp-func (quote ar-forward-block))

(defun ar-hide-base (form &optional beg end)
  "Hide visibility of existing form at point."
  (hs-minor-mode 1)
  (save-excursion
    (let* ((form (prin1-to-string form))
           (beg (or beg (or (funcall (intern-soft (concat "ar--beginning-of-" form "-p")))
                            (funcall (intern-soft (concat "ar-backward-" form))))))
           (end (or end (funcall (intern-soft (concat "ar-forward-" form)))))
           (modified (buffer-modified-p))
           (inhibit-read-only t))
      (if (and beg end)
          (progn
            (hs-make-overlay beg end (quote code))
            (set-buffer-modified-p modified))
        (error (concat "No " (format "%s" form) " at point"))))))

(defun ar-hide-show (&optional form beg end)
  "Toggle visibility of existing forms at point."
  (interactive)
  (save-excursion
    (let* ((form (prin1-to-string form))
           (beg (or beg (or (funcall (intern-soft (concat "ar--beginning-of-" form "-p")))
                            (funcall (intern-soft (concat "ar-backward-" form))))))
           (end (or end (funcall (intern-soft (concat "ar-forward-" form)))))
           (modified (buffer-modified-p))
           (inhibit-read-only t))
      (if (and beg end)
          (if (overlays-in beg end)
              (hs-discard-overlays beg end)
            (hs-make-overlay beg end (quote code)))
        (error (concat "No " (format "%s" form) " at point")))
      (set-buffer-modified-p modified))))

(defun ar-show ()
  "Remove invisibility of existing form at point."
  (interactive)
  (with-silent-modifications
    (save-excursion
      (back-to-indentation)
      (let ((end (next-overlay-change (point))))
        (hs-discard-overlays (point) end)))))

(defun ar-show-all ()
  "Remove invisibility of hidden forms in buffer."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let (end)
      (while (and (not (eobp))  (setq end (next-overlay-change (point))))
        (hs-discard-overlays (point) end)
        (goto-char end)))))

(defun ar-hide-region (beg end)
  "Hide active region."
  (interactive
   (list
    (and (use-region-p) (region-beginning))(and (use-region-p) (region-end))))
  (ar-hide-base (quote region) beg end))

(defun ar-show-region (beg end)
  "Un-hide active region."
  (interactive
   (list
    (and (use-region-p) (region-beginning))(and (use-region-p) (region-end))))
  (hs-discard-overlays beg end))

(defun ar-hide-block ()
  "Hide block at point."
  (interactive)
  (ar-hide-base (quote block)))

(defun ar-hide-block-or-clause ()
  "Hide block-or-clause at point."
  (interactive)
  (ar-hide-base (quote block-or-clause)))

(defun ar-hide-class ()
  "Hide class at point."
  (interactive)
  (ar-hide-base (quote class)))

(defun ar-hide-clause ()
  "Hide clause at point."
  (interactive)
  (ar-hide-base (quote clause)))

(defun ar-hide-comment ()
  "Hide comment at point."
  (interactive)
  (ar-hide-base (quote comment)))

(defun ar-hide-def ()
  "Hide def at point."
  (interactive)
  (ar-hide-base (quote def)))

(defun ar-hide-def-or-class ()
  "Hide def-or-class at point."
  (interactive)
  (ar-hide-base (quote def-or-class)))

(defun ar-hide-elif-block ()
  "Hide elif-block at point."
  (interactive)
  (ar-hide-base (quote elif-block)))

(defun ar-hide-else-block ()
  "Hide else-block at point."
  (interactive)
  (ar-hide-base (quote else-block)))

(defun ar-hide-except-block ()
  "Hide except-block at point."
  (interactive)
  (ar-hide-base (quote except-block)))

(defun ar-hide-expression ()
  "Hide expression at point."
  (interactive)
  (ar-hide-base (quote expression)))

(defun ar-hide-for-block ()
  "Hide for-block at point."
  (interactive)
  (ar-hide-base (quote for-block)))

(defun ar-hide-if-block ()
  "Hide if-block at point."
  (interactive)
  (ar-hide-base (quote if-block)))

(defun ar-hide-indent ()
  "Hide indent at point."
  (interactive)
  (ar-hide-base (quote indent)))

(defun ar-hide-line ()
  "Hide line at point."
  (interactive)
  (ar-hide-base (quote line)))

(defun ar-hide-minor-block ()
  "Hide minor-block at point."
  (interactive)
  (ar-hide-base (quote minor-block)))

(defun ar-hide-paragraph ()
  "Hide paragraph at point."
  (interactive)
  (ar-hide-base (quote paragraph)))

(defun ar-hide-partial-expression ()
  "Hide partial-expression at point."
  (interactive)
  (ar-hide-base (quote partial-expression)))

(defun ar-hide-section ()
  "Hide section at point."
  (interactive)
  (ar-hide-base (quote section)))

(defun ar-hide-statement ()
  "Hide statement at point."
  (interactive)
  (ar-hide-base (quote statement)))

(defun ar-hide-top-level ()
  "Hide top-level at point."
  (interactive)
  (ar-hide-base (quote top-level)))

(defun ar-dynamically-hide-indent ()
  (interactive)
  (ar-show)
  (ar-hide-indent))

(defun ar-dynamically-hide-further-indent (&optional arg)
  (interactive "P")
  (if (eq 4  (prefix-numeric-value arg))
      (ar-show)
  (ar-show)
  (ar-forward-indent)
  (ar-hide-indent)))

(provide (quote ar-hide-show))
;;; ar-hide-show.el ends here
