;;; ar-move.el --- Functions moving point which need special treatment -*- lexical-binding: t; -*-

(defun ar-backward-paragraph ()
  "Go to beginning of current paragraph.

If already at beginning, go to start of next paragraph upwards"
  (interactive)
  (backward-paragraph)(point))

(defun ar-forward-paragraph ()
    "Go to end of current paragraph.

If already at end, go to end of next paragraph downwards"
  (interactive)
  (and (forward-paragraph)(point)))

;; Indentation
;; Travel current level of indentation
(defun ar--travel-this-indent-backward (&optional indent)
  "Travel current INDENT backward.

With optional INDENT travel bigger or equal indentation"
  (let ((indent (or indent (current-indentation)))
        last)
    (while (and (not (bobp))
                (ar-backward-statement)
                (<= indent (current-indentation))
                (setq last (point))))
    (when last (goto-char last))
    last))

(defun ar-backward-indent ()
  "Go to the beginning of a section of equal indent.

If already at the beginning or before a indent, go to next indent upwards
Returns final position when called from inside section, nil otherwise"
  (interactive)
  (unless (bobp)
    (let (erg)
      (setq erg (ar--travel-this-indent-backward))
      (when erg (goto-char erg))
      erg)))

(defun ar--travel-this-indent-backward-bol (indent)
  "Internal use.

Travel this INDENT backward until bol"
  (let (erg)
    (while (and (ar-backward-statement-bol)
                (or indent (setq indent (current-indentation)))
                (eq indent (current-indentation))(setq erg (point)) (not (bobp))))
    (when erg (goto-char erg))))

(defun ar-backward-indent-bol ()
  "Go to the beginning of line of a section of equal indent.

If already at the beginning or before an indent,
go to next indent in buffer upwards
Returns final position when called from inside section, nil otherwise"
  (interactive)
  (unless (bobp)
    (let ((indent (when (eq (current-indentation) (current-column)) (current-column)))
          erg)
      (setq erg (ar--travel-this-indent-backward-bol indent))
      erg)))

(defun ar--travel-this-indent-forward (indent)
  "Internal use.

Travel this INDENT forward"
  (let (last erg)
    (while (and (ar-down-statement)
                (eq indent (current-indentation))
                (setq last (point))))
    (when last (goto-char last))
    (setq erg (ar-forward-statement))
    erg))

(defun ar-forward-indent (&optional stop-at-empty-line)
  "Go to the end of a section of equal indentation.

If already at the end, go down to next indent in buffer
Returns final position when moved, nil otherwise"
  (interactive "P")
  (skip-chars-forward " \t\r\n\f")
  (let (done
        (orig (line-beginning-position))
        (indent (current-indentation))
        (last (progn (back-to-indentation) (point))))
    (while (and (not (eobp)) (not done)
                (progn (forward-line 1) (back-to-indentation) (or (and (ar-empty-line-p)(not stop-at-empty-line)) (and (<= indent (current-indentation))(< last (point))))))
      (unless (ar-empty-line-p) (skip-chars-forward " \t\r\n\f")(setq last (point)))
      (when (or (and (ar-empty-line-p)stop-at-empty-line) (and (not (ar-empty-line-p))(< (current-indentation) indent)))
                 (setq done t))
      )
    (goto-char last)
    (end-of-line)
    (skip-chars-backward " \t\r\n\f")
    (and (< orig (point))(point))))

(defun ar-forward-indent-bol ()
  "Go to beginning of line following of a section of equal indentation.

If already at the end, go down to next indent in buffer
Returns final position when called from inside section, nil otherwise"
  (interactive)
  (unless (eobp)
    (when (ar-forward-indent)
      (unless (eobp) (progn (forward-line 1) (beginning-of-line) (point))))))

;; (defun ar-forward-indent-bol ()
;;   "Go to beginning of line following of a section of equal indentation.

;; If already at the end, go down to next indent in buffer
;; Returns final position when called from inside section, nil otherwise"
;;   (interactive)
;;   (unless (eobp)
;;     (let (erg indent)
;;       ;; (when (ar-forward-statement)
;;       (when (ar-forward-indent)
;;      ;; (save-excursion
;;              ;; (setq indent (and (ar-backward-statement)(current-indentation))))
;;      ;; (setq erg (ar--travel-this-indent-forward indent))
;;      (unless (eobp) (forward-line 1) (beginning-of-line) (setq erg (point))))
;;       erg)))

(defun ar-backward-expression (&optional orig done repeat)
  "Go to the beginning of a SomeMode expression.

If already at the beginning or before a expression,
go to next expression in buffer upwards

ORIG - consider original position or point.
DONE - transaktional argument
REPEAT - count and consider repeats"
  (interactive)
  (unless (bobp)
    (unless done (skip-chars-backward " \t\r\n\f"))
    (let ((repeat (or (and repeat (1+ repeat)) 0))
          (pps (parse-partial-sexp (point-min) (point)))
          (orig (or orig (point)))
          erg)
      (if (< ar-max-specpdl-size repeat)
          (error "‘ar-backward-expression’ reached loops max")
        (cond
         ;; comments
         ((nth 8 pps)
          (goto-char (nth 8 pps))
          (ar-backward-expression orig done repeat))
         ;; lists
         ((nth 1 pps)
          (goto-char (nth 1 pps))
          (skip-chars-backward ar-expression-skip-chars)
          )
         ;; in string
         ((nth 3 pps)
          (goto-char (nth 8 pps)))
         ;; after operator
         ((and (not done) (looking-back ar-operator-re (line-beginning-position)))
          (skip-chars-backward "^ \t\r\n\f")
          (skip-chars-backward " \t\r\n\f")
          (ar-backward-expression orig done repeat))
         ((and (not done)
               (< 0 (abs (skip-chars-backward ar-expression-skip-chars))))
          (setq done t)
          (ar-backward-expression orig done repeat))))
      (unless (or (eq (point) orig)(and (bobp)(eolp)))
        (setq erg (point)))
      erg)))

(defun ar-forward-expression (&optional orig done repeat)
  "Go to the end of a compound SomeMode expression.

Operators are ignored.
ORIG - consider original position or point.
DONE - transaktional argument
REPEAT - count and consider repeats"
  (interactive)
  (unless done (skip-chars-forward " \t\r\n\f"))
  (unless (eobp)
    (let ((repeat (or (and repeat (1+ repeat)) 0))
          (pps (parse-partial-sexp (point-min) (point)))
          (orig (or orig (point)))
          erg)
      (if (< ar-max-specpdl-size repeat)
          (error "‘ar-forward-expression’ reached loops max")
        (cond
         ;; in comment
         ((nth 4 pps)
          (or (< (point) (progn (forward-comment 1) (point)))(forward-line 1))
          (ar-forward-expression orig done repeat))
         ;; empty before comment
         ((and (looking-at "[ \t]*#") (looking-back "^[ \t]*" (line-beginning-position)))
          (while (and (looking-at "[ \t]*#") (not (eobp)))
            (forward-line 1))
          (ar-forward-expression orig done repeat))
         ;; inside string
         ((nth 3 pps)
          (goto-char (nth 8 pps))
          (goto-char (scan-sexps (point) 1))
          (setq done t)
          (ar-forward-expression orig done repeat))
         ((looking-at "\"\"\"\\|'''\\|\"\\|'")
          (goto-char (scan-sexps (point) 1))
          (setq done t)
          (ar-forward-expression orig done repeat))
         ;; looking at opening delimiter
         ((eq 4 (car-safe (syntax-after (point))))
          (goto-char (scan-sexps (point) 1))
          (skip-chars-forward ar-expression-skip-chars)
          (setq done t))
         ((nth 1 pps)
          (goto-char (nth 1 pps))
          (goto-char (scan-sexps (point) 1))
          (skip-chars-forward ar-expression-skip-chars)
          (setq done t)
          (ar-forward-expression orig done repeat))
         ((and (eq orig (point)) (looking-at ar-operator-re))
          (goto-char (match-end 0))
          (ar-forward-expression orig done repeat))
         ((and (not done)
               (< 0 (skip-chars-forward ar-expression-skip-chars)))
          (setq done t)
          (ar-forward-expression orig done repeat))
         ;; at colon following arglist
         ((looking-at ":[ \t]*$")
          (forward-char 1)))
        (unless (or (eq (point) orig)(and (eobp) (bolp)))
          (setq erg (point)))
        erg))))

(defun ar-backward-partial-expression ()
  "Backward partial-expression."
  (interactive)
  (let ((orig (point)))
    (and (< 0 (abs (skip-chars-backward " \t\r\n\f")))(not (bobp))(forward-char -1))
    (when (ar--in-comment-p)
      (ar-backward-comment)
      (skip-chars-backward " \t\r\n\f"))
    ;; part of ar-partial-expression-forward-chars
    (when (member (char-after) (list ?\ ?\" ?' ?\) ?} ?\] ?: ?#))
      (forward-char -1))
    (skip-chars-backward ar-partial-expression-stop-backward-chars)
    (when (< 0 (abs (skip-chars-backward ar-partial-expression-stop-backward-chars)))
      (while (and (not (bobp)) (ar--in-comment-p) (< 0 (abs (skip-chars-backward ar-partial-expression-stop-backward-chars))))))
    (when (< (point) orig)
      (unless
          (and (bobp) (member (char-after) (list ?\ ?\t ?\r ?\n ?\f)))
        (point)))))

(defun ar-forward-partial-expression ()
  "Forward partial-expression.

Return position reached."
  (interactive)
  (skip-chars-forward ar-partial-expression-stop-backward-chars)
  ;; group arg
  (while
      (or (and (eq (char-after) ?\()
               (eq (char-after (1+ (point))) 41))
          (and (eq (char-after) ?\[)
               (or (eq (char-after (1+ (point))) ?\])
                   (eq (char-after (+ 2 (point))) ?\]))))
    (goto-char (scan-sexps (point) 1)))
  (point))

;; Partial- or Minor Expression
;;  Line
(defun ar-backward-line ()
  "Go to ‘beginning-of-line’, return position.

If already at ‘beginning-of-line’ and not at BOB,
go to beginning of previous line."
  (interactive)
  (unless (bobp)
    (forward-line -1)
    (point))) 

(defun ar-forward-line ()
  "Go to ‘end-of-line’, return position.

If already at ‘end-of-line’ and not at EOB, go to end of next line."
  (interactive)
  (unless (eobp)
    (let ((orig (point)))
      (when (eolp) (forward-line 1))
      (end-of-line)
      (when (< orig (point))(point)))))

(defun ar-forward-into-nomenclature (&optional arg)
  "Move forward to end of a nomenclature symbol.

With \\[universal-argument] (programmatically, optional argument ARG), do it that many times.
IACT - if called interactively
A ‘nomenclature’ is a fancy way of saying AWordWithMixedCaseNotUnderscores."
  (interactive "p")
  (or arg (setq arg 1))
  (let ((case-fold-search nil)
        (orig (point))
        erg)
    (if (> arg 0)
        (while (and (not (eobp)) (> arg 0))
          ;; (setq erg (re-search-forward "\\(\\W+[_[:lower:][:digit:]ß]+\\)" nil t 1))
          (cond
           ((or (not (eq 0 (skip-chars-forward "[[:blank:][:punct:]\n\r]")))
                (not (eq 0 (skip-chars-forward "_"))))
            (when (or
                   (< 1 (skip-chars-forward "[:upper:]"))
                   (not (eq 0 (skip-chars-forward "[[:lower:][:digit:]ß]")))
                   (not (eq 0 (skip-chars-forward "[[:lower:][:digit:]]"))))
              (setq arg (1- arg))))
           ((or
             (< 1 (skip-chars-forward "[:upper:]"))
             (not (eq 0 (skip-chars-forward "[[:lower:][:digit:]ß]")))
             (not (eq 0 (skip-chars-forward "[[:lower:][:digit:]]"))))
            (setq arg (1- arg)))))
      (while (and (not (bobp)) (< arg 0))
        (when (not (eq 0 (skip-chars-backward "[[:blank:][:punct:]\n\r\f_]")))

          (forward-char -1))
        (or
         (not (eq 0 (skip-chars-backward "[:upper:]")))
         (not (eq 0 (skip-chars-backward "[[:lower:][:digit:]ß]")))
         (skip-chars-backward "[[:lower:][:digit:]ß]"))
        (setq arg (1+ arg))))
    (if (< (point) orig)
        (progn
          (when (looking-back "[[:upper:]]" (line-beginning-position))
            ;; (looking-back "[[:blank:]]"
            (forward-char -1))
          (if (looking-at "[[:alnum:]ß]")
              (setq erg (point))
            (setq erg nil)))
      (if (and (< orig (point)) (not (eobp)))
          (setq erg (point))
        (setq erg nil)))
    erg))

(defun ar-backward-into-nomenclature (&optional arg)
  "Move backward to beginning of a nomenclature symbol.

With optional ARG, move that many times.  If ARG is negative, move
forward.

A ‘nomenclature’ is a fancy way of saying AWordWithMixedCaseNotUnderscores."
  (interactive "p")
  (setq arg (or arg 1))
  (ar-forward-into-nomenclature (- arg)))

(defun ar--travel-current-indent (indent &optional orig)
  "Move down until clause is closed, i.e. current indentation is reached.

Takes a list, INDENT and ORIG position."
  (unless (eobp)
    (let ((orig (or orig (point)))
          last)
      (while (and (setq last (point))(not (eobp))(ar-forward-statement)
                  (save-excursion (or (<= indent (progn  (ar-backward-statement)(current-indentation)))(eq last (line-beginning-position))))
                  ;; (ar--end-of-statement-p)
))
      (goto-char last)
      (when (< orig last)
        last))))

(defun ar-backward-block-current-column ()
"Reach next beginning of block upwards which start at current column.

Return position"
(interactive)
(let* ((orig (point))
       (cuco (current-column))
       (str (make-string cuco ?\s))
       pps erg)
  (while (and (not (bobp))(re-search-backward (concat "^" str ar-block-keywords) nil t)(or (nth 8 (setq pps (parse-partial-sexp (point-min) (point)))) (nth 1 pps))))
  (back-to-indentation)
  (and (< (point) orig)(setq erg (point)))
  erg))

(defun ar-backward-section ()
  "Go to next section start upward in buffer.

Return position if successful"
  (interactive)
  (let ((orig (point)))
    (while (and (re-search-backward ar-section-start nil t 1)
                (nth 8 (parse-partial-sexp (point-min) (point)))))
    (when (and (looking-at ar-section-start)(< (point) orig))
      (point))))

(defun ar-forward-section ()
  "Go to next section end downward in buffer.

Return position if successful"
  (interactive)
  (let ((orig (point))
        last)
    (while (and (re-search-forward ar-section-end nil t 1)
                (setq last (point))
                (goto-char (match-beginning 0))
                (nth 8 (parse-partial-sexp (point-min) (point)))
                (goto-char (match-end 0))))
    (and last (goto-char last))
    (when (and (looking-back ar-section-end (line-beginning-position))(< orig (point)))
      (point))))

(defun ar-beginning-of-assignment()
  "Go to beginning of assigment if inside.

Return position of successful, nil of not started from inside."
  (interactive)
  (let* (last
         (erg
          (or (ar--beginning-of-assignment-p)
              (progn
                (while (and (setq last (ar-backward-statement))
                            (not (looking-at ar-assignment-re))
                            ;; (not (bolp))
                            ))
                (and (looking-at ar-assignment-re) last)))))
    erg))

;; (defun ar--forward-assignment-intern ()
;;   (and (looking-at ar-assignment-re)
;;        (goto-char (match-end 2))
;;        (skip-chars-forward " \t\r\n\f")
;;        ;; (eq (car (syntax-after (point))) 4)
;;        (progn (forward-sexp) (point))))

;; (defun ar-forward-assignment()
;;   "Go to end of assigment at point if inside.

;; Return position of successful, nil of not started from inside"
;;   (interactive)
;;   (unless (eobp)
;;     (if (eq last-command (quote ar-backward-assignment))
;;      ;; assume at start of an assignment
;;      (ar--forward-assignment-intern)
;;       ;; ‘ar-backward-assignment’ here, avoid ‘ar--beginning-of-assignment-p’ a second time
;;       (let* (last
;;           (beg
;;            (or (ar--beginning-of-assignment-p)
;;                (progn
;;                  (while (and (setq last (ar-backward-statement))
;;                              (not (looking-at ar-assignment-re))
;;                              ;; (not (bolp))
;;                              ))
;;                  (and (looking-at ar-assignment-re) last))))
;;           erg)
;;      (and beg (setq erg (ar--forward-assignment-intern)))
;;      erg))))

(defun ar-up ()
  "Go to the beginning of current syntactic form in buffer.

If in string or comment, reach the beginning.
Respective if inside a list, statement, block etc.

If already at the beginning of a block, move these form upward."
  (interactive)
  (let ((pps (parse-partial-sexp (point-min) (point)))
        last)
    (cond
     ((nth 8 pps)
      (while (nth 8 pps)
        (goto-char (nth 8 pps))
        (setq last (point))
        (when ar-debug-p (message "last: %s" (point)))
        (skip-chars-backward " \t\r\n\f")
        (setq pps (parse-partial-sexp (point-min) (point))))
      (when last (goto-char last))
      (when ar-debug-p (message "last-pos-reached: %s" (point)))
      )
     ((nth 1 pps)
      (goto-char (nth 1 pps)))
     (t (ar-backward-statement)))))

(defun ar-nav-last-prompt ()
  "Move to previous prompt."
  (interactive)
  (goto-char (pos-bol))
  (when
      (re-search-backward comint-prompt-regexp nil t 1)
    (comint-skip-prompt)))

(provide (quote ar-move))
;;;  ar-move.el ends here
