;;; ar-start2.el --- Edit, debug, develop and run programs. -*- lexical-binding: t; -*-


(defun ar--fix-start (strg)
  "Internal use by ar-execute... functions.

Takes STRG
Avoid empty lines at the beginning."
  ;; (when ar-debug-p (message "ar--fix-start:"))
  (let (ar--imenu-create-index-p
        ar-guess-ar-install-directory-p
        ;; ar-autopair-mode
        ar-complete-function
        ar-load-pymacs-p
        ar-load-skeletons-p
        erg)
    (with-temp-buffer
      (with-current-buffer (current-buffer)
        (ar-mode)
        (when ar-debug-p
          (switch-to-buffer (current-buffer)))
        ;; (ar-mode)
        (insert strg)
        (goto-char (point-min))
        (when (< 0 (setq erg (skip-chars-forward " \t\r\n\f" (line-end-position))))
          (dotimes (_ erg)
            (indent-rigidly-left (point-min) (point-max))))
        (unless (ar--beginning-of-statement-p)
          (ar-forward-statement))
        (while (not (eq (current-indentation) 0))
          (ar-shift-left ar-indent-offset))
        (goto-char (point-max))
        (unless (ar-empty-line-p)
          (newline 1))
        (buffer-substring-no-properties 1 (point-max))))))

(defun ar-fast-send-string (strg  &optional proc output-buffer result no-output argprompt args dedicated shell exception-buffer)
  (interactive
   (list (read-string "SOME command: ")))
  (ar-execute-string strg proc result no-output nil output-buffer t argprompt args dedicated shell exception-buffer))

(defun ar--fast-send-string-no-output (strg  &optional proc output-buffer result)
  (ar-fast-send-string strg proc output-buffer result t))

(defun ar--send-to-fast-process (strg proc output-buffer result)
  "Called inside of ‘ar--execute-base-intern’.

Optional STRG PROC OUTPUT-BUFFER RETURN"
  (let ((output-buffer (or output-buffer (process-buffer proc)))
        (inhibit-read-only t))
    ;; (switch-to-buffer (current-buffer))
    (with-current-buffer output-buffer
      ;; (erase-buffer)
      (ar-fast-send-string strg
                           proc
                           output-buffer result))))

(defun ar--point (position)
  "Returns the value of point at certain commonly referenced POSITIONs.
POSITION can be one of the following symbols:

  bol -- beginning of line
  eol -- end of line
  bod -- beginning of def or class
  eod -- end of def or class
  bob -- beginning of buffer
  eob -- end of buffer
  boi -- back to indentation
  bos -- beginning of statement

This function does not modify point or mark."
  (save-excursion
    (progn
      (cond
       ((eq position (quote bol)) (beginning-of-line))
       ((eq position (quote eol)) (end-of-line))
       ((eq position (quote bod)) (ar-backward-def-or-class))
       ((eq position (quote eod)) (ar-forward-def-or-class))
       ;; Kind of funny, I know, but useful for ar-up-exception.
       ((eq position (quote bob)) (goto-char (point-min)))
       ((eq position (quote eob)) (goto-char (point-max)))
       ((eq position (quote boi)) (back-to-indentation))
       ((eq position (quote bos)) (ar-backward-statement))
       (t (error "Unknown buffer position requested: %s" position))))))

;; (defun ar-backward-top-level ()
;;   "Go up to beginning of statments until level of indentation is null.

;; Returns position if successful, nil otherwise "
;;   (interactive)
;;   (let (erg done)
;;     (unless (bobp)
;;       (while (and (not done)(not (bobp))
;;                   (setq erg (re-search-backward "^[[:alpha:]_'\"]" nil t 1)))
;;         (if
;;             (nth 8 (parse-partial-sexp (point-min) (point)))
;;             (setq erg nil)
;;           (setq done t)))
;;       erg)))

(defun ar-backward-top-level ()
  "Go up to beginning of statments until level of indentation is null.

Returns position if successful, nil otherwise "
  (interactive)
  (let ((orig (point)))
    (while (and
            (not (bobp))
            (re-search-backward "^[[:alpha:]_'\"]" nil t 1)
            (nth 8 (parse-partial-sexp (point-min) (point)))))
    (and (< (point) orig)(point))))

;; might be slow due to repeated calls of ‘ar-down-statement’
(defun ar-forward-top-level ()
  "Go to end of top-level form at point.

Returns position if successful, nil otherwise"
  (interactive)
  (let ((orig (point))
        erg)
    (unless (eobp)
      (unless (ar--beginning-of-statement-p)
        (ar-backward-statement))
      (unless (eq 0 (current-column))
        (ar-backward-top-level))
      (cond ((looking-at ar-def-re)
             (setq erg (ar-forward-def)))
            ((looking-at ar-class-re)
             (setq erg (ar-forward-class)))
            ((looking-at ar-block-re)
             (setq erg (ar-forward-block)))
            (t (setq erg (ar-forward-statement))))
      (unless (< orig (point))
        (while (and (not (eobp)) (ar-down-statement)(< 0 (current-indentation))))
        (if (looking-at ar-block-re)
            (setq erg (ar-forward-block))
          (setq erg (ar-forward-statement))))
      erg)))

(provide (quote ar-start2))
;;; ar-start2.el ends here
