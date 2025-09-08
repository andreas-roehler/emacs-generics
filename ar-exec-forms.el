;;; ar-exec-forms.el --- Forms with a reduced range of derived commands -*- lexical-binding: t; -*-

;; Execute forms at point

(defun ar-execute-try-block ()
  "Send try-block at point to SOME default interpreter."
  (interactive)
  (let ((beg (prog1
                 (or (ar--beginning-of-try-block-p)
                     (save-excursion
                       (ar-backward-try-block)))))
        (end (save-excursion
               (ar-forward-try-block))))
    (ar-execute-region beg end)))

(defun ar-execute-if-block ()
  "Send if-block at point to SOME default interpreter."
  (interactive)
  (let ((beg (prog1
                 (or (ar--beginning-of-if-block-p)
                     (save-excursion
                       (ar-backward-if-block)))))
        (end (save-excursion
               (ar-forward-if-block))))
    (ar-execute-region beg end)))

(defun ar-execute-for-block ()
  "Send for-block at point to SOME default interpreter."
  (interactive)
  (let ((beg (prog1
                 (or (ar--beginning-of-for-block-p)
                     (save-excursion
                       (ar-backward-for-block)))))
        (end (save-excursion
               (ar-forward-for-block))))
    (ar-execute-region beg end)))

(provide (quote ar-exec-forms))
;;; ar-exec-forms.el ends here
 
