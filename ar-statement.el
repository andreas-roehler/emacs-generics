;;; ar-statement.el -- Searching downwards in buffer -*- lexical-binding: t; -*-

(defun ar-forward-statement (&optional orig done repeat)
  "Go to the last char of current statement.

ORIG - consider original position or point.
DONE - transaktional argument
REPEAT - count and consider repeats"
  (interactive)
  (unless (eobp)
    (let ((repeat (or (and repeat (1+ repeat)) 0))
          (orig (or orig (point)))
          last
          ;; use by scan-lists
          (pps (parse-partial-sexp (point-min) (point)))
          forward-sexp-function err)
      ;; (origline (or origline (ar-count-lines)))
      (cond
       ;; which-function-mode, lp:1235375
       ((< ar-max-specpdl-size repeat)
        (error "forward-statement reached loops max. If no error, customize ‘max-specpdl-size’"))
       ((looking-at (symbol-value (quote ar-def-or-class-re)))
        (end-of-line)
        (skip-chars-backward " \t\r\n\f"))
       ;; list
       ((nth 1 pps)
        (if (<= orig (point))
            (progn
              (setq orig (point))
              ;; do not go back at a possible unclosed list
              (goto-char (nth 1 pps))
              (if
                  (ignore-errors (forward-list))
                  (progn
                    (when (looking-at ":[ \t]*$")
                      (forward-char 1))
                    (setq done t)
                    (skip-chars-forward "^#" (line-end-position))
                    (skip-chars-backward " \t\r\n\f" (line-beginning-position))
                    (ar-forward-statement orig done repeat))
                (setq err (ar--record-list-error pps))
                (goto-char orig)))))
       ;; in comment
       ((and comment-start (looking-at (concat " *" comment-start)))
        (ar--end-of-comment-intern (point))
        (ar-forward-statement orig))
       ;; (goto-char (match-end 0))
       ;; (ar-forward-statement orig done repeat))
       ((nth 4 pps)
        (ar--end-of-comment-intern (point))
        (ar--skip-to-comment-or-semicolon)
        (while (and (eq (char-before (point)) ?\\)
                    (ar-escaped-p) (setq last (point)))
          (forward-line 1) (end-of-line))
        (and last (goto-char last)
             (forward-line 1)
             (back-to-indentation))
        ;; ar-forward-statement-test-3JzvVW
        (unless (or (looking-at (concat " *" comment-start))(eolp))
          (ar-forward-statement orig done repeat)))
       ;; string
       ((looking-at ar-string-delim-re)
        (goto-char (match-end 0))
        (ar-forward-statement (match-beginning 0) done repeat))
       ((nth 3 pps)
        (when (ar-end-of-string)
          (end-of-line)
          (skip-chars-forward " \t\r\n\f")
          (setq pps (parse-partial-sexp (point-min) (point)))
          (unless (and done (not (or (nth 1 pps) (nth 8 pps))) (eolp)) (ar-forward-statement orig done repeat))))
       ((ar-current-line-backslashed-p)
        (end-of-line)
        (skip-chars-backward " \t\r\n\f" (line-beginning-position))
        (while (and (eq (char-before (point)) ?\\)
                    (ar-escaped-p))
          (forward-line 1)
          (end-of-line)
          (skip-chars-backward " \t\r\n\f" (line-beginning-position)))
        (unless (eobp)
          (ar-forward-statement orig done repeat)))
       ((eq orig (point))
        (if (eolp)
            ;; (skip-chars-forward " \t\r\n\f#'\"")
            (skip-chars-forward " \t\r\n\f")
          (end-of-line)
          (skip-chars-backward " \t\r\n\f" orig))
        ;; point at orig due to a trailing whitespace
        (and (eq (point) orig) (skip-chars-forward " \t\r\n\f"))
        ;; (setq done t)
        (ar-forward-statement orig done repeat))
       ((eq (current-indentation) (current-column))
        ;; ‘ar--skip-to-comment-or-semicolon’ may return nil
        (setq done (ignore-errors (< 0 (ignore-errors (abs (ar--skip-to-comment-or-semicolon))))))
        (and done (skip-chars-backward " \t\r\n\f"))
        (setq pps (parse-partial-sexp orig (point)))
        (if (nth 1 pps)
            (ar-forward-statement orig done repeat)
          (unless done
            (ar-forward-statement orig done repeat))))
       ((and (looking-at "[[:print:]]+$") (not done) (ar--skip-to-comment-or-semicolon))
        (ar-forward-statement orig done repeat)))
      (or err
          (and (< orig (point))
               (not (member (char-before) (list 10 32 9 ?#)))
               (point))))))


(defun ar-backward-statement (&optional orig done limit ignore-in-string-p repeat maxindent)
  "Go to the initial line of a simple statement.

Statement is understood in an editorial sense, not syntactically.
Nonetheless, while travelling code, it should match syntactic bounderies too.

For beginning of compound statement use ‘ar-backward-block’.
For beginning of clause ‘ar-backward-clause’.

‘ignore-in-string-p’ allows moves inside a docstring, used when
computing indents
ORIG - consider original position or point.
DONE - transaktional argument
LIMIT - honor limit
IGNORE-IN-STRING-P - also much inside a string
REPEAT - count and consider repeats
Optional MAXINDENT: do not stop if indentation is larger"
  (interactive)
  (save-restriction
    (unless (bobp)
      (let ((repeat (or (and repeat (1+ repeat)) 0))
            (orig (or orig (point)))
            (pps (parse-partial-sexp (or limit (point-min))(point)))
            (done done))
        ;; lp:1382788
        ;; (unless done
        ;;   (and (< 0 (abs (skip-chars-backward " \t\r\n\f")))
        ;;        (setq pps (parse-partial-sexp (or limit (point-min))(point)))))
        (cond
         ((< ar-max-specpdl-size repeat)
          (error "ar-forward-statement reached loops max. If no error, customize ‘ar-max-specpdl-size’"))
         ((and (bolp) (eolp))
          (skip-chars-backward " \t\r\n\f")
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; inside string
         ((and (nth 3 pps) (not ignore-in-string-p))
          (setq done t)
          (goto-char (nth 8 pps))
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((nth 4 pps)
          (goto-char (nth 8 pps))
          (skip-chars-backward " \t\r\n\f")
          ;; (setq pps (parse-partial-sexp (line-beginning-position) (point)))
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((and (nth 1 pps)(or (< 1 (nth 0 pps))(eq major-mode (quote SomeMode-mode))))
          (if (and
               (< (nth 1 pps) (line-beginning-position))
               (save-excursion
                 (beginning-of-line)
                 (skip-chars-backward ",] \t\r\n\f")
                 (< (nth 1 pps) (nth 1 (parse-partial-sexp (point-min) (point))))))
              (progn
                (beginning-of-line)
                (skip-chars-backward ",] \t\r\n\f")
                (goto-char (nth 1 (parse-partial-sexp (point-min) (point)))))
            (goto-char (1- (nth 1 pps))))
          (when (ar--skip-to-semicolon-backward (save-excursion (back-to-indentation) (point)))
            (setq done t))
          ;; (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent)
          )
         ((ar-preceding-line-backslashed-p)
          (forward-line -1)
          (back-to-indentation)
          (setq done t)
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((looking-at comment-start-skip)
          (setq done t)
          (forward-char -1)
          (skip-chars-backward " \t\r\n\f")
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; at raw-string
         ;; (and (looking-at "\"\"\"\\|'''") (member (char-before) (list ?u ?U ?r ?R)))
         ((and (looking-at "\"\"\"\\|'''") (member (char-before) (list ?u ?U ?r ?R)))
          (forward-char -1)
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; BOL or at space before comment
         ((and (looking-at "[ \t]*#") (looking-back "^[ \t]*" (line-beginning-position)))
          (forward-comment -1)
          (while (and (not (bobp)) (looking-at "[ \t]*#") (looking-back "^[ \t]*" (line-beginning-position)))
            (forward-comment -1))
          (unless (bobp)
            (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent)))
         ;; at inline comment
         ((looking-at "[ \t]*#")
          (when (ar--skip-to-semicolon-backward (save-excursion (back-to-indentation) (point)))
            (setq done t))
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; at beginning of string
         ;; ((looking-at ar-string-delim-re)
         ;;  (ar-end-of-string))
         ((and (not done) (eq (char-before) ?\;))
          (skip-chars-backward ";")
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; travel until indentation or semicolon
         ((and (not done) (ar--skip-to-semicolon-backward))
          (unless (and maxindent (< maxindent (current-indentation)))
            (setq done t))
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ;; at current indent
         ((and (not done) (not (eq 0 (skip-chars-backward " \t\r\n\f"))))
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((and maxindent (< maxindent (current-indentation)))
          (forward-line -1)
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((eq orig (point))
          (skip-chars-backward " \t\r\n\f")
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent))
         ((not (eq (current-indentation) (current-column)))
          (back-to-indentation)
          (ar-backward-statement orig done limit ignore-in-string-p repeat maxindent)))
        ;; return nil when before comment
        (unless (and (looking-at "[ \t]*#") (looking-back "^[ \t]*" (line-beginning-position)))
          (when (< (point) orig) (point)))))))

;; ar-statement.el ends here
(provide 'ar-statement)
