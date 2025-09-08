;;; ar-start-Zf98zM.el -- Searching downwards in buffer -*- lexical-binding: t; -*-

(defun ar-end-of-string ()
  "Go to end of string at point if any, if successful return position. "
  (interactive)
  (let ((pps (parse-partial-sexp (point-min) (point)))
        (sapo (car (syntax-after (point)))))
    (if (and (nth 3 pps)(nth 8 pps))
        (progn (goto-char (nth 8 pps))
               (forward-sexp))
      (if (or (eq sapo 7) (eq sapo 15))
          (and (skip-syntax-forward "|\"")
               (skip-syntax-forward "^|\""))))
    (skip-syntax-forward "|\"")))

(defun ar-escaped-p (&optional pos)
    "Return t if char at POS is preceded by an odd number of backslashes. "
    (save-excursion
      (when pos (goto-char pos))
      (< 0 (% (abs (skip-chars-backward "\\\\")) 2))))

(defmacro ar-current-line-backslashed-p ()
  "Return t if current line is a backslashed continuation line."
  `(save-excursion
     (end-of-line)
     (skip-chars-backward " \t\r\n\f")
     (and (eq (char-before (point)) ?\\ )
          (ar-escaped-p))))

(defun ar--skip-to-comment-or-semicolon ()
  "Returns position if point was moved."
  (let ((orig (point)))
    (cond ((while (and (< 0 (abs (skip-chars-forward "^#;" (line-end-position))))
                       ;; (sit-for 1)
                       (and (nth 8 (parse-partial-sexp (point-min) (point))) (skip-chars-forward "#;" (line-end-position)))))))
    (and (< orig (point))(point))))

(defun ar--end-of-comment-intern (pos)
  (while (and (not (eobp))
              (forward-comment 99999)))
  ;; forward-comment fails sometimes
  (and (eq pos (point)) (prog1 (forward-line 1) (back-to-indentation))
       (while (member (char-after) (list  (string-to-char comment-start) 10))(forward-line 1)(back-to-indentation))))

(defun ar-backward-statement-bol ()
  "Goto beginning of line where statement start.
Returns position reached, if successful, nil otherwise.

See also ‘ar-up-statement’"
  (interactive)
  (let* ((orig (point))
         erg)
    (unless (bobp)
      (cond ((bolp)
             (and (ar-backward-statement orig)
                  (progn (beginning-of-line)
                         (setq erg (point)))))
            (t (setq erg
                     (and
                      (ar-backward-statement)
                      (progn (beginning-of-line) (point)))))))
    erg))

(defun ar-forward-statement-bol ()
  "Go to the ‘beginning-of-line’ following current statement."
  (interactive)
  (ar-forward-statement)
  (ar--beginning-of-line-form))

(defun ar-up-statement ()
  "go to the beginning of next statement upwards in buffer.

Return position if statement found, nil otherwise."
  (interactive)
  (if (ar--beginning-of-statement-p)
      (ar-backward-statement)
    (progn (and (ar-backward-statement) (ar-backward-statement)))))

(defun ar--end-of-statement-p ()
  "Return position, if cursor is at the end of a statement, nil otherwise."
  (let ((orig (point)))
    (save-excursion
      (ar-backward-statement)
      (ar-forward-statement)
      (when (eq orig (point))
        orig))))

(defun ar-down-statement ()
  "Go to the beginning of next statement downwards in buffer.

Corresponds to backward-up-list in Elisp
Return position if statement found, nil otherwise."
  (interactive)
  (let* ((orig (point)))
    (cond ((ar--end-of-statement-p)
           (progn
             (and
              (ar-forward-statement)
              (ar-backward-statement)
              (< orig (point))
              (point))))
          ((ignore-errors (< orig (and (ar-forward-statement) (ar-backward-statement))))
           (point))
          ((ignore-errors (< orig (and (ar-forward-statement) (ar-forward-statement)(ar-backward-statement))))
             (point)))))

(defun ar--fetch-indent-statement-above (orig)
  "Report the preceding indent. "
  (save-excursion
    (goto-char orig)
    (forward-line -1)
    (end-of-line)
    (skip-chars-backward " \t\r\n\f")
    (back-to-indentation)
    (if (or (looking-at comment-start)(ar--beginning-of-statement-p))
        (current-indentation)
      (ar-backward-statement)
      (current-indentation))))

(defun ar--end-base-determine-secondvalue (regexp)
  "Expects being at block-opener.

REGEXP: a symbol"
  (cond
   ((eq regexp (quote ar-minor-block-re))
    (cond ((looking-at ar-else-re)
           nil)
          ((or (looking-at (concat ar-try-re)))
           (concat ar-elif-re "\\|" ar-else-re "\\|" ar-except-re))
          ((or (looking-at (concat ar-except-re "\\|" ar-elif-re "\\|" ar-if-re)))
           (concat ar-elif-re "\\|" ar-else-re))))
   ((member regexp
            (list
             (quote ar-block-re)
             (quote ar-block-or-clause-re)
             (quote ar-clause-re)
             (quote ar-if-re)
             ))
    (cond ((looking-at ar-if-re)
           (concat ar-elif-re "\\|" ar-else-re))
          ((looking-at ar-elif-re)
           (concat ar-elif-re "\\|" ar-else-re))
          ((looking-at ar-else-re))
          ((looking-at ar-try-re)
           (concat ar-except-re "\\|" ar-else-re "\\|" ar-finally-re))
          ((looking-at ar-except-re)
           (concat ar-else-re "\\|" ar-finally-re))
          ((looking-at ar-finally-re)
           nil)))
   ((eq regexp (quote ar-for-re)) nil)
   ((eq regexp (quote ar-try-re))
    (cond
     ;; ((looking-at ar-try-re)
     ;;  (concat ar-except-re "\\|" ar-else-re "\\|" ar-finally-re))
     ((looking-at ar-except-re)
      (concat ar-else-re "\\|" ar-finally-re))
     ((looking-at ar-finally-re))
     (t
      (concat ar-except-re "\\|" ar-else-re "\\|" ar-finally-re))))))

(defun ar--backward-regexp (regexp &optional indent condition orig)
  "Search backward next regexp not in string or comment.

Return position if successful
REGEXP: the expression to search for
SECONDVALUE: travel these expressions
"
  (unless (bobp)
    (save-match-data
      (unless (ar--beginning-of-statement-p) (skip-chars-backward " \t\r\n\f")
              (ar-backward-comment))
      (let* (pps
             (regexpvalue (symbol-value regexp))
             (secondvalue (pcase regexp
                            (ar-def-re ar-block-re)
                            ;; (unless (member regexp (list 'ar-def-re 'ar-class-re))
                            ;; (or secondvalue (symbol-value regexp))))
                            ))
             (indent (or indent (current-indentation)))
             (condition (or condition '<=))
             (orig (or orig (point))))
        (if (eq (current-indentation) (current-column))
            (while (and (not (bobp))
                        ;; def foo():
                        ;;     if True:
                        ;;         def bar():
                        ;;             pass
                        ;;     elif False:
                        ;;         def baz():
                        ;;             pass
                        ;;     else:
                        ;;         try:
                        ;;             1 == 1
                        ;;         except:
                        ;;             pass

                        ;; When looking for beginning-of-def from EOB,
                        ;; make sure, the further indented ‘def
                        ;; baz():’ in the middle isn't matched, but
                        ;; BOB. Therefor the ‘secondvalue’, which may
                        ;; correct the required indent
                        (re-search-backward (concat "^ \\{0,"(format "%s" indent) "\\}\\(" regexpvalue "\\|" secondvalue "\\)") nil 'move 1)
                        (goto-char (match-beginning 1))
                        (not (and (looking-back "async *" (line-beginning-position))
                                  (goto-char (match-beginning 0))))
                        (or (and
                             (setq pps (nth 8 (parse-partial-sexp (point-min) (point))))
                             (goto-char pps))
                            (and (not (eq (current-column) 0))
                                 (not (looking-at regexpvalue))
                                 (looking-at secondvalue)
                                 indent
                                 ))
                        (prog1 t
                          (cond ((< (current-indentation) indent)
                                 (setq indent (current-indentation)))
                                ((and (not (looking-at regexpvalue))
                                      (member regexp (list 'ar-def-re 'ar-class-re 'ar-def-or-class-re)) )
                                 (setq indent (- (current-indentation) ar-indent-offset)))))
                        ))
          (unless (bobp)
            (back-to-indentation)
            (and
             (setq pps (nth 8 (parse-partial-sexp (point-min) (point))))
             (goto-char pps))
            ;; (unless (and (< (point) orig) (not (looking-at regexpvalue)) (looking-at secondvalue))
            (unless (and (< (point) orig) (or (looking-at regexpvalue) (and secondvalue (looking-at secondvalue))))
              (ar--backward-regexp regexp (current-indentation) condition orig))
            (unless (or (eq (point) orig)(bobp)) (back-to-indentation))))
        (and (looking-at regexpvalue) (not (nth 8 (parse-partial-sexp (point-min) (point))))(point))))))

(defun ar--go-to-keyword (regexp &optional condition maxindent ignoreindent)
  "Expects being called from beginning of a statement.

Argument REGEXP: a symbol.

Return position if successful, nil otherwise

Keyword detected from REGEXP
Honor MAXINDENT if provided
Optional IGNOREINDENT: find next keyword at any indentation"
  (unless (bobp)
    ;;    (when (ar-empty-line-p) (skip-chars-backward " \t\r\n\f"))
    (let* ((orig (point))
           (regexp (if (eq regexp (quote ar-clause-re)) (quote ar-extended-block-or-clause-re) regexp))
           (regexpvalue (if (symbolp regexp)(symbol-value regexp) regexp))
           (maxindent
            (if ignoreindent
                ;; just a big value
                9999
              (or maxindent
                  (if (ar-empty-line-p) (current-column) (current-indentation)))))

           ;; (allvalue (symbol-value (quote ar-block-or-clause-re)))
           )
      (unless (ar--beginning-of-statement-p)
        (ar-backward-statement))
      (when (and (not (string= "" ar-block-closing-keywords-re))(looking-at ar-block-closing-keywords-re))
        (setq maxindent (min maxindent (- (current-indentation) ar-indent-offset))))
      (cond
       ((and (looking-at regexpvalue)(< (point) orig))
        (point))
       (t (while
              (not (or (bobp) (and (looking-at regexpvalue)(< (point) orig) (not (nth 8 (parse-partial-sexp (point-min) (point)))))))
            ;; search backward and reduce maxindent, if non-matching forms suggest it
            (ar--backward-regexp regexp maxindent
                                 (or condition '<=)
                                 orig))))
      (and (< (point) orig)(looking-at regexpvalue)(point)))))

(defun ar-up-base (regexp &optional indent)
  "Expects a symbol as REGEXP like `(quote ar-clause-re)'

Return position if successful"
  (unless (ar--beginning-of-statement-p) (ar-backward-statement))
  (unless (looking-at (symbol-value regexp))
    (ar--go-to-keyword regexp '< (or indent (current-indentation))))
  ;; now from beginning-of-block go one indent level upwards
  (when
      (looking-at (symbol-value regexp))
    (ar--go-to-keyword regexp '< (- (or indent (current-indentation)) ar-indent-offset))))

(defun ar-up-base-bol (regexp)
  "Go to the beginning of next form upwards in buffer.

Return position if form found, nil otherwise.
Argument REGEXP determined by form"
  (let* (;;(orig (point))
         erg)
    (if (bobp)
        (setq erg nil)
      (while (and (re-search-backward regexp nil t 1)
                  (nth 8 (parse-partial-sexp (point-min) (point)))))
      (beginning-of-line)
      (when (looking-at regexp) (setq erg (point)))
      ;; (when ar-verbose-p (message "%s" erg))
      erg)))

(defun ar--down-according-to-indent (regexp secondvalue &optional indent use-regexp)
  "Return position if moved, nil otherwise.

Optional ENFORCE-REGEXP: search for regexp only."
  (unless (eobp)
    (let* ((orig (point))
           (indent (or indent 0))
           done
           (regexpvalue (if (member regexp (list (quote ar-def-re) (quote ar-def-or-class-re) (quote ar-class-re)))
                            (concat (symbol-value regexp) "\\|" (symbol-value (quote ar-decorator-re)))
                          (symbol-value regexp)))
           (lastvalue (and secondvalue
                           (pcase regexp
                             (`ar-try-re (concat ar-finally-re "\\|" ar-except-re "\\|" ar-else-re))
                             (`ar-if-re ar-else-re))))
           last)
      (if (eq regexp (quote ar-clause-re))
          (ar-forward-clause-intern indent)
        (while
            (and
             (not done)
             (progn (end-of-line)
                    (pcase indent
                      (0
                       (cond (use-regexp
                              (re-search-forward (concat "^" regexpvalue) nil 'move 1))
                             (t (re-search-forward "^[[:alnum:]_@]+" nil 'move 1))))
                      (_
                       (cond (use-regexp
                              (re-search-forward (concat "^ \\{0,"(format "%s" indent) "\\}"regexpvalue) nil 'move 1))
                             (t (re-search-forward (concat "^ \\{"(format "0,%s" indent) "\\}[[:alnum:]_@]+") nil 'move 1))))))
             (or (nth 8 (parse-partial-sexp (point-min) (point)))
                 (progn (back-to-indentation) (ar--forward-string-maybe (nth 8 (parse-partial-sexp orig (point)))))
                 (and secondvalue (looking-at secondvalue) (setq last (point)))
                 (and lastvalue (looking-at lastvalue)(setq last (point)))
                 (and (looking-at regexpvalue) (setq done t) (setq last (point)))
                 ;; ar-forward-def-or-class-test-3JzvVW
                 ;; (setq done t)
                 ))))
      (when last (goto-char last))
      (and (< orig (point)) (point)))))

(defun ar--end-base (regexp &optional orig bol repeat)
  "Used internal by functions going to the end FORM.

Returns the indentation of FORM-start
Arg REGEXP, a symbol"
  (unless (eobp)
    (let (;; not looking for an assignment
          (use-regexp (member regexp (list (quote ar-def-re) (quote ar-class-re) (quote ar-def-or-class-re))))
          (orig (or orig (point))))
      (unless (eobp)
        (unless (ar--beginning-of-statement-p nil bol)
          (ar-backward-statement))
        (let* (;; when at block-start, be specific
               ;; (regexp (ar--refine-regexp-maybe regexp))
               (regexpvalue (if (symbolp regexp)(symbol-value regexp) regexp))
               ;; (regexp (or regexp (symbol-value (quote ar-extended-block-or-clause-re))))
               (repeat (if repeat (1+ repeat) 0))
               (indent (current-indentation))
               (secondvalue (ar--end-base-determine-secondvalue regexp))
               ;; when at block-start, be specific
               ;; return current-indentation, position and possibly needed clause-regexps (secondvalue)
               (res
                (cond
                 ((and ;; (ar--beginning-of-statement-p)
                       ;; (eq 0 (current-column))
                       (or (looking-at (concat "[ \\ŧ]*" regexpvalue))
                           (and (member regexp (list (quote ar-def-re) (quote ar-def-or-class-re) (quote ar-class-re)))
                                (looking-at ar-decorator-re)
                                (ar-down-def-or-class indent))
                           (and (member regexp (list (quote ar-minor-block-re) (quote ar-if-re) (quote ar-for-re) (quote ar-try-re)))
                                (looking-at ar-minor-clause-re))))
                  (list (current-indentation) (point) secondvalue))
                 ((looking-at regexpvalue)
                  (list (current-indentation) (point) secondvalue))
                 ((eq 0 (current-indentation))
                  (ar--down-according-to-indent regexp nil 0 use-regexp))
                 ;; look upward
                 (t (ar--go-to-keyword regexp (if (member regexp (list (quote ar-def-re) (quote ar-class-re) (quote ar-def-or-class-re))) '< '<=))))))
          (cond
           (res
            (and
             (ar--down-according-to-indent regexp secondvalue (current-indentation))
             (progn
               (when (and secondvalue (looking-at secondvalue))
                 ;; (when (looking-at ar-else-re)
                 (ar--down-according-to-indent regexp secondvalue (current-indentation)))
               (if (>= indent (current-indentation))
                   (ar--down-end-form)
                 (end-of-line)
                 (skip-chars-backward " \t\r\n\f")))
             ;; (ar--end-base regexp orig bol repeat)
             ;; )
             ))
           (t (unless (< 0 repeat) (goto-char orig))
              (ar--forward-regexp (symbol-value regexp))
              (beginning-of-line)
              (and
               (ar--down-according-to-indent regexp secondvalue (current-indentation) t)
               (ar--down-end-form))))
          (cond ((< orig (point))
                 (if bol
                     (ar--beginning-of-line-form)
                   (point)))
                ((eq (point) orig)
                 (unless (eobp)
                   (cond
                    ((and (< repeat 1)
                          (or
                           ;; looking next indent as part of body
                           (ar--down-according-to-indent regexp secondvalue
                                                         indent
                                                         ;; if expected indent is 0,
                                                         ;; search for new start,
                                                         ;; search for regexp only
                                                         (eq 0 indent))
                           (and
                            ;; next block-start downwards, reduce expected indent maybe
                            (setq indent (or (and (< 0 indent) (- indent ar-indent-offset)) indent))
                            (ar--down-according-to-indent regexp secondvalue
                                                          indent t))))
                     (ar--end-base regexp orig bol (1+ repeat))))))
                ((< (point) orig)
                 (goto-char orig)
                 (when (ar--down-according-to-indent regexp secondvalue nil t)
                   (ar--end-base regexp (point) bol (1+ repeat))))))))))

;; ar-start-Zf98zM.el ends here
(provide 'ar-start-Zf98zM)
