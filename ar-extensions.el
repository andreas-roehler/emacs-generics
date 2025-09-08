;;; ar-extensions.el --- more editing utilities -*- lexical-binding: t; -*-

(defun ar-indent-forward-line (&optional arg)
  "Indent and move line forward to next indentation.
Returns column of line reached.

If ‘ar-kill-empty-line’ is non-nil, delete an empty line.

With \\[universal argument] just indent.
"
  (interactive "*P")
  (let ((orig (point))
        erg)
    (unless (eobp)
      (if (and (ar--in-comment-p)(not ar-indent-comments))
          (forward-line 1)
        (ar-indent-line-outmost)
        (unless (eq 4 (prefix-numeric-value arg))
          (if (eobp) (newline)
            (progn (forward-line 1))
            (when (and ar-kill-empty-line (ar-empty-line-p) (not (looking-at "[ \t]*\n[[:alpha:]]")) (not (eobp)))
              (delete-region (line-beginning-position) (line-end-position)))))))
    (back-to-indentation)
    (when (or (eq 4 (prefix-numeric-value arg)) (< orig (point))) (setq erg (current-column)))
    erg))

(defun ar-dedent-forward-line (&optional arg)
  "Dedent line and move one line forward. "
  (interactive "*p")
  (ar-dedent arg)
  (if (eobp)
      (newline 1)
    (forward-line 1))
  (end-of-line))

(defun ar-dedent (&optional arg)
  "Dedent line according to ‘ar-indent-offset’.

With arg, do it that many times.
If point is between indent levels, dedent to next level.
Return indentation reached, if dedent done, nil otherwise.

Affected by ‘ar-dedent-keep-relative-column’. "
  (interactive "*p")
  (or arg (setq arg 1))
  (let ((orig (copy-marker (point)))
        erg)
    (dotimes (_ arg)
      (let* ((cui (current-indentation))
             (remain (% cui ar-indent-offset))
             (indent (* ar-indent-offset (/ cui ar-indent-offset))))
        (beginning-of-line)
        (fixup-whitespace)
        (if (< 0 remain)
            (indent-to-column indent)
          (indent-to-column (- cui ar-indent-offset)))))
    (when (< (point) orig)
      (setq erg (current-column)))
    (when ar-dedent-keep-relative-column (goto-char orig))
    erg))

(defun ar-class-at-point ()
  "Return class definition as string. "
  (interactive)
  (save-excursion
    (let* ((beg (ar-backward-class))
           (end (ar-forward-class))
           (res (when (and (numberp beg)(numberp end)(< beg end)) (buffer-substring-no-properties beg end))))
      res)))

(defun ar-backward-function ()
  "Jump to the beginning of defun.

Returns position. "
  (interactive "p")
  (ar-backward-def-or-class))

(defun ar-forward-function ()
  "Jump to the end of function.

Returns position."
  (interactive "p")
  (ar-forward-def-or-class))

(defun ar-function-at-point ()
  "Return functions definition as string. "
  (interactive)
  (save-excursion
    (let* ((beg (ar-backward-function))
           (end (ar-forward-function)))
      (when (and (numberp beg)(numberp end)(< beg end)) (buffer-substring-no-properties beg end)))))

;; Functions for marking regions

(defun ar-line-at-point ()
  "Return line as string. "
  (interactive)
  (let* ((beg (line-beginning-position))
         (end (line-end-position)))
    (when (and (numberp beg)(numberp end)(< beg end)) (buffer-substring-no-properties beg end))))

(defun ar-match-paren-mode (&optional arg)
  "ar-match-paren-mode nil oder t"
  (interactive "P")
  (if (or arg (not ar-match-paren-mode))
      (progn
        (setq ar-match-paren-mode t)
        (setq ar-match-paren-mode nil))))

(defun ar--match-end-finish (cui)
  (let (skipped)
    (unless (eq (current-column) cui)
      (when (< (current-column) cui)
        (setq skipped (skip-chars-forward " \t" (line-end-position)))
        (setq cui (- cui skipped))
        ;; may current-column greater as needed indent?
        (if (< 0 cui)
            (progn
              (unless (ar-empty-line-p) (split-line))
              (indent-to cui))
          (forward-char cui))
        (unless (eq (char-before) 32)(insert 32)(forward-char -1))))))

(defun ar--match-paren-forward ()
  (setq ar--match-paren-forward-p t)
  (let ((cui (current-indentation)))
    (cond
     ((ar--beginning-of-top-level-p)
      (ar-forward-top-level-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-class-p)
      (ar-forward-class-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-def-p)
      (ar-forward-def-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-if-block-p)
      (ar-forward-if-block-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-try-block-p)
      (ar-forward-try-block-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-for-block-p)
      (ar-forward-for-block-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-block-p)
      (ar-forward-block-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-clause-p)
      (ar-forward-clause-bol)
      (ar--match-end-finish cui))
     ((ar--beginning-of-statement-p)
      (ar-forward-statement-bol)
      (ar--match-end-finish cui))
     (t (ar-forward-statement)
        (ar--match-end-finish cui)))))

(defun ar--match-paren-backward ()
  (setq ar--match-paren-forward-p nil)
  (let* ((cui (current-indentation))
         (cuc (current-column))
         (cui (min cuc cui)))
    (if (eq 0 cui)
        (ar-backward-top-level)
      (when (ar-empty-line-p) (delete-region (line-beginning-position) (point)))
      (ar-backward-statement)
      (unless (< (current-column) cuc)
      (while (and (not (bobp))
                  (< cui (current-column))
                  (ar-backward-statement)))))))

(defun ar--match-paren-blocks ()
  (cond
   ((and (looking-back "^[ \t]*" (line-beginning-position))(if (eq last-command (quote ar-match-paren))(not ar--match-paren-forward-p)t)
         ;; (looking-at ar-extended-block-or-clause-re)
         (looking-at "[[:alpha:]_]"))
    ;; from beginning of top-level, block, clause, statement
    (ar--match-paren-forward))
   (t
    (ar--match-paren-backward))))

(defun ar-match-paren (&optional arg)
  "If at a beginning, jump to end and vice versa.

When called from within, go to the start.
Matches lists, but also block, statement, string and comment. "
  (interactive "*P")
  (if (eq 4 (prefix-numeric-value arg))
      (insert "%")
    (let ((pps (parse-partial-sexp (point-min) (point))))
      (cond
       ;; if inside string, go to beginning
       ((nth 3 pps)
        (goto-char (nth 8 pps)))
       ;; if inside comment, go to beginning
       ((nth 4 pps)
        (ar-backward-comment))
       ;; at comment start, go to end of commented section
       ((and
         ;; unless comment starts where jumped to some end
         (not ar--match-paren-forward-p)
         (eq 11 (car-safe (syntax-after (point)))))
        (ar-forward-comment))
       ;; at string start, go to end
       ((or (eq 15 (car-safe (syntax-after (point))))
            (eq 7 (car (syntax-after (point)))))
        (goto-char (scan-sexps (point) 1))
        (forward-char -1))
       ;; open paren
       ((eq 4 (car (syntax-after (point))))
        (goto-char (scan-sexps (point) 1))
        (forward-char -1))
       ((eq 5 (car (syntax-after (point))))
        (goto-char (scan-sexps (1+ (point)) -1)))
       ((nth 1 pps)
        (goto-char (nth 1 pps)))
       (t
        ;; SOME specific blocks
        (ar--match-paren-blocks))))))

(unless (functionp (quote in-string-p))
  (defun in-string-p (&optional pos)
    (interactive)
    (let ((orig (or pos (point))))
      (save-excursion
        (save-restriction
          (widen)
          (beginning-of-defun)
          (numberp
           (progn
             (if (featurep (quote xemacs))
                 (nth 3 (parse-partial-sexp (point) orig)
                      (nth 3 (parse-partial-sexp (point-min) (point))))))))))))

(defun ar-documentation (w)
  "Launch PyDOC on the Word at Point"
  (interactive
   (list (let* ((word (ar-symbol-at-point))
                (input (read-string
                        (format "pydoc entry%s: "
                                (if (not word) "" (format " (default %s)" word))))))
           (if (string= input "")
               (if (not word) (error "No pydoc args given")
                 word) ;sinon word
             input)))) ;sinon input
  (shell-command (concat ar-shell-name " -c \"from pydoc import help;help('" w "')\"") "*PYDOCS*")
  (view-buffer-other-window "*PYDOCS*" t 'kill-buffer-and-window))

(defun pst-here ()
  "Kill previous \"pdb.set_trace()\" and insert it at point. "
  (interactive "*")
  (let ((orig (copy-marker (point))))
    (search-backward "pdb.set_trace()")
    (replace-match "")
    (when (ar-empty-line-p)
      (delete-region (line-beginning-position) (line-end-position)))
    (goto-char orig)
    (insert "pdb.set_trace()")))

(defun ar-printform-insert (&optional arg strg)
  "Inserts a print statement from `(car kill-ring)'.

With optional \\[universal-argument] print as string"
  (interactive "*P")
  (let* ((name (ar--string-strip (or strg (car kill-ring))))
         ;; guess if doublequotes or parentheses are needed
         (numbered (not (eq 4 (prefix-numeric-value arg))))
         (form (if numbered
                   (concat "print(\"" name ": %s \" % (" name "))")
                 (concat "print(\"" name ": %s \" % \"" name "\")"))))
    (insert form)))

(defun ar-print-formatform-insert (&optional strg)
  "Inserts a print statement out of current `(car kill-ring)' by default.

print(\"\\nfoo: {}\"\.format(foo))"
  (interactive "*")
  (let ((name (ar--string-strip (or strg (car kill-ring)))))
    (insert (concat "print(\"" name ": {}\\n\".format(" name "))"))))

(defun ar-line-to-printform-SomeMode2 ()
  "Transforms the item on current in a print statement. "
  (interactive "*")
  (let* ((name (ar-symbol-at-point))
         (form (concat "print(\"" name ": %s \" % " name ")")))
    (delete-region (line-beginning-position) (line-end-position))
    (insert form))
  (forward-line 1)
  (back-to-indentation))

(defun ar-boolswitch ()
  "Edit the assignment of a boolean variable, revert them.

I.e. switch it from \"True\" to \"False\" and vice versa"
  (interactive "*")
  (save-excursion
    (unless (ar--end-of-statement-p)
      (ar-forward-statement))
    (backward-word)
    (cond ((looking-at "True")
           (replace-match "False"))
          ((looking-at "False")
           (replace-match "True"))
          (t (message "%s" "Can not see \"True or False\" here")))))

(provide 'ar-extensions)
;;; ar-extensions.el ends here
