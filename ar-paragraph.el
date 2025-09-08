;;; ar-paragraph.el --- filling -*- lexical-binding: t; -*-

(defun ar-set-nil-docstring-style ()
  "Set ar-docstring-style to \\='nil"
  (interactive)
  (setq ar-docstring-style 'nil)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar-set-pep-257-nn-docstring-style ()
  "Set ar-docstring-style to \\='pep-257-nn"
  (interactive)
  (setq ar-docstring-style 'pep-257-nn)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar-set-pep-257-docstring-style ()
  "Set ar-docstring-style to \\='pep-257"
  (interactive)
  (setq ar-docstring-style 'pep-257)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar-set-django-docstring-style ()
  "Set ar-docstring-style to \\='django"
  (interactive)
  (setq ar-docstring-style 'django)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar-set-symmetric-docstring-style ()
  "Set ar-docstring-style to \\='symmetric"
  (interactive)
  (setq ar-docstring-style 'symmetric)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar-set-onetwo-docstring-style ()
  "Set ar-docstring-style to \\='onetwo"
  (interactive)
  (setq ar-docstring-style 'onetwo)
  (when (and (called-interactively-p 'any) ar-verbose-p)
    (message "docstring-style set to:  %s" ar-docstring-style)))

(defun ar--continue-lines-region (beg end)
  (save-excursion
    (goto-char beg)
    (while (< (line-end-position) end)
      (end-of-line)
      (unless (ar-escaped-p) (insert-and-inherit 32) (insert-and-inherit 92))
      (ignore-errors (forward-line 1)))))

(defun ar-fill-comment (&optional justify)
  "Fill the comment paragraph at point"
  (interactive "*P")
  (let (;; Non-nil if the current line contains a comment.
        has-comment

        ;; If has-comment, the appropriate fill-prefix (format "%s" r the comment.
        comment-fill-prefix)

    ;; Figure out what kind of comment we are looking at.
    (save-excursion
      (beginning-of-line)
      (cond
       ;; A line with nothing but a comment on it?
       ((looking-at "[ \t]*#[# \t]*")
        (setq has-comment t
              comment-fill-prefix (buffer-substring (match-beginning 0)
                                                    (match-end 0))))

       ;; A line with some code, followed by a comment? Remember that the hash
       ;; which starts the comment should not be part of a string or character.
       ((progn
          (while (not (looking-at "#\\|$"))
            (skip-chars-forward "^#\n\"'\\")
            (cond
             ((eq (char-after (point)) ?\\) (forward-char 2))
             ((memq (char-after (point)) '(?\" ?')) (forward-sexp 1))))
          (looking-at "#+[\t ]*"))
        (setq has-comment t)
        (setq comment-fill-prefix
              (concat (make-string (current-column) ? )
                      (buffer-substring (match-beginning 0) (match-end 0)))))))

    (if (not has-comment)
        (fill-paragraph justify)

      ;; Narrow to include only the comment, and then fill the region.
      (save-restriction
        (narrow-to-region

         ;; Find the first line we should include in the region to fill.
         (save-excursion
           (while (and (zerop (forward-line -1))
                       (looking-at "^[ \t]*#")))

           ;; We may have gone to far.  Go forward again.
           (or (looking-at "^[ \t]*#")
               (forward-line 1))
           (point))

         ;; Find the beginning of the first line past the region to fill.
         (save-excursion
           (while (progn (forward-line 1)
                         (looking-at "^[ \t]*#")))
           (point)))

        ;; Lines with only hashes on them can be paragraph boundaries.
        (let ((paragraph-start (concat paragraph-start "\\|[ \t#]*$"))
              (paragraph-separate (concat paragraph-separate "\\|[ \t#]*$"))
              (fill-prefix comment-fill-prefix))
          (fill-paragraph justify))))
    t))

(defun ar--in-or-behind-or-before-a-docstring (pps)
  "Return start/end position of a docstring, if inside.

Nil otherwise"
  (interactive "*")
  (save-excursion
    (ar--docstring-p
     (ignore-errors
       (or (and (nth 3 pps) (nth 8 pps))
                        (and
                         (equal (string-to-syntax "|")
                                (syntax-after (point)))
                         (< 0 (skip-chars-forward "\"'"))
                         (nth 3 (parse-partial-sexp (point-min) (point)))))))))

(defun ar--string-fence-delete-spaces (&optional start)
  "Delete spaces following or preceding delimiters of string at point. "
  (interactive "*")
  (let ((beg (or start (nth 8 (parse-partial-sexp (point-min) (point))))))
    (save-excursion
      (goto-char beg)
      (skip-chars-forward "\"'rRuU")
      (delete-region (point) (progn (skip-chars-forward " \t\r\n\f")(point)))
      (goto-char beg)
      (forward-char 1)
      (skip-syntax-forward "^|")
      (skip-chars-backward "\"'rRuU")
      ;; (delete-region (point) (progn (skip-chars-backward " \t\r\n\f")(point)))
)))

(defun ar--skip-raw-string-front-fence ()
  "Skip forward chars u, U, r, R followed by string-delimiters. "
  (when (member (char-after) (list ?u ?U ?r ?R))
    (forward-char 1))
  (skip-chars-forward "\'\""))

(defun ar--fill-fix-end (thisend orig delimiters-style)
  ;; Add the number of newlines indicated by the selected style
  ;; at the end.
  ;; (widen)
  (goto-char thisend)
  (skip-chars-backward "\"'\n ")
  (delete-region (point) (progn (skip-chars-forward " \t\r\n\f") (point)))
  (unless (eq (char-after) 10)
    (and
     (cdr delimiters-style)
     (or (newline (cdr delimiters-style)) t)))
  (ar-indent-line nil t)
  (goto-char orig))

(defun ar-fill-labelled-string (beg end orig)
  "Fill string or paragraph containing lines starting with label

See lp:1066489 "
  (interactive "r*")
  (goto-char orig)
  (let ((fill-prefix fill-prefix)
        thisbeg thisend)
    (if (and
         (ignore-errors (< orig (setq thisend (copy-marker (or (save-excursion (end-of-line) (and (re-search-forward ar-labelled-re nil t 1)(line-beginning-position))) end)))))
         (ignore-errors (<=  (setq thisbeg (copy-marker (or (and (looking-at ar-labelled-re)(match-beginning 0)) (save-excursion (and (re-search-backward ar-labelled-re nil 'move 1) (match-beginning 0))) beg))) orig)))
        (save-excursion
          (goto-char thisbeg)
          (cond ((looking-at ar-colon-labelled-re)
                 (setq fill-prefix (make-string (+ (current-indentation) ar-indent-offset) 32)))
                ((looking-at ar-star-labelled-re)
                 (setq fill-prefix (make-string (+ (current-indentation) 2) 32))))
          (save-restriction
            (narrow-to-region thisbeg thisend)
            (fill-region thisbeg thisend))))))

(defun ar-fill-string (&optional justify docstring pps)
  "String fill function.
JUSTIFY should be used (if applicable) as in ‘fill-paragraph’.

Fill according to ‘ar-docstring-style’ "
  (interactive "*")
  (let* ((justify (or justify (if current-prefix-arg 'full t)))
         ;; (style (or style ar-docstring-style))
         (pps (or pps (parse-partial-sexp (point-min) (point))))
         (orig (copy-marker (point)))
         ;; (docstring (or docstring (ar--in-or-behind-or-before-a-docstring pps)))
         (docstring (cond (docstring
                           (if (not (number-or-marker-p docstring))
                               (ar--in-or-behind-or-before-a-docstring pps))
                           docstring)
                          (t (and (nth 3 pps) (nth 8 pps) (ar--in-or-behind-or-before-a-docstring pps)))))
         (beg (and (nth 3 pps) (nth 8 pps)))
         (tqs (progn (and beg (goto-char beg) (looking-at "\"\"\"\\|'''"))))
         (end (copy-marker (if tqs
                               (or
                                (progn (ignore-errors (forward-sexp))(and (< orig (point)) (point)))
                                (goto-char orig)
                                (line-end-position))
                             (or (progn (goto-char beg) (ignore-errors (forward-sexp))(and (< orig (point)) (point)))
                                 (goto-char orig)
                                 (line-end-position))))))
    (save-restriction
      ;; do not go backward beyond beginning of string
      (narrow-to-region beg (point-max))
      (goto-char orig)
      (when beg
        (if docstring
            (ar--fill-docstring beg end fill-prefix fill-column)
          (if (not tqs)
              (if (ar-preceding-line-backslashed-p)
                  (progn
                    (setq end (copy-marker (line-end-position)))
                    (narrow-to-region (line-beginning-position) end)
                    (fill-region (line-beginning-position) end justify t)
                    (when (< 1 (ar-count-lines))
                      (ar--continue-lines-region (point-min) end)))
                (narrow-to-region beg end)
                (fill-region beg end justify t)
                (when
                    ;; counting in narrowed buffer
                    (< 1 (ar-count-lines))
                  (ar--continue-lines-region beg end)))
            (fill-region beg end justify)))))))

(defun ar--fill-docstring (beg end fill-prefix fill-column)
  "Fills paragraph in docstring below or at cursor position."
  (let ((fill-prefix fill-prefix)
        (orig (point)))
    ;; do not go backward beyond beginning of string
    (let* (;; Paragraph starts with beginning of string, skip the fence-chars
           (innerbeg (copy-marker
                      (progn (goto-char beg)
                             (ar--skip-raw-string-front-fence)
                             (point))))
           (innerend (copy-marker (progn (goto-char end) (skip-chars-backward "\\'\"") (skip-chars-backward " \t\r\n\f") (point))))
           (multi-line-p (string-match "\n" (buffer-substring-no-properties innerbeg innerend))))
      (save-excursion
        (goto-char innerbeg)
        (pcase ar-docstring-style
          (`django
           (if (eolp)
               (forward-line 1)
             (newline 1)))
          (`onetwo
           (delete-horizontal-space)
           (cond ((and multi-line-p (eolp))
                  (forward-line 1))
                 (multi-line-p
                  (newline 1))))
          (`pep-257
           (delete-horizontal-space))
          (`pep-257-nn
           (delete-horizontal-space))
          (`symmetric
           (cond ((and multi-line-p (eolp))
                  (forward-line 1))
                 (multi-line-p
                  (newline 1))
                 (t (delete-horizontal-space))))))
      (cond
       ((string-match ar-star-labelled-re (buffer-substring-no-properties innerbeg innerend))
        (ar-fill-labelled-string innerbeg innerend orig))
       ((string-match ar-colon-labelled-re (buffer-substring-no-properties innerbeg innerend))
        (ar-fill-labelled-string innerbeg innerend orig)
        ;; (save-excursion (goto-char (match-beginning 0))(forward-line 1)(back-to-indentation) (make-string (current-column) 32))
        orig)

       (t (fill-region innerbeg innerend)))
      (goto-char innerend)
      ;; (goto-char paraend)
      (when (or (eq ar-docstring-style 'onetwo)(and multi-line-p (eq ar-docstring-style 'pep-257)))
        (forward-line 1)
        (unless (ar-empty-line-p)
          (newline 1))))))


(defun ar-fill-paragraph (&optional pps beg end tqs)
  "Fill the paragraph at point."
  (interactive "*")
  (window-configuration-to-register ar--windows-config-register)
  (let* ((pps (or pps (parse-partial-sexp (point-min) (point))))
         (docstring (unless (not ar-docstring-style) (and (nth 3 pps) (nth 8 pps) (ar--in-or-behind-or-before-a-docstring pps))))
         (fill-column ar-comment-fill-column)
         (in-string (nth 3 pps))
         (beg (or beg (save-excursion
                        (if (looking-at paragraph-start)
                            (point)
                          (backward-paragraph)
                          (when (looking-at paragraph-start)
                            (point))))
                  (and (nth 3 pps) (nth 8 pps))))
         (end (or end
                  (when beg
                    (save-excursion
                      (or
                       (and in-string
                            (progn
                              (goto-char (nth 8 pps))
                              (setq tqs (looking-at "\"\"\"\\|'''"))
                              (forward-sexp) (point)))
                       (progn
                         (forward-paragraph)
                         (when (looking-at paragraph-separate)
                           (point))))))))
         (fill-prefix (if beg
                          (save-excursion
                            (goto-char beg)
                            (make-string (current-indentation) 32))
                        fill-prefix))
         (fill-column
          (if beg
              (save-excursion
                (goto-char beg) (- ar-docstring-fill-column (current-indentation)))
            ar-docstring-fill-column)))
    (cond ((or (nth 4 pps)
               (and (bolp) (looking-at "[ \t]*#[# \t]*")))
           (ar-fill-comment))
          (docstring
           ;; (setq fill-column ar-docstring-fill-colum;; n)
           (ar--fill-docstring beg end fill-prefix fill-column))
          (t
           (and beg end (fill-region beg end))
           (when (and in-string (not tqs))
             (ar--continue-lines-region beg end)))))
  (jump-to-register ar--windows-config-register))

(defun ar-fill-string-or-comment ()
  "Serve auto-fill-mode"
  (unless (< (current-column) fill-column)
  (let ((pps (parse-partial-sexp (point-min) (point))))
    (if (nth 3 pps)
        (ar-fill-string nil nil pps)
      ;; (ar-fill-comment pps)
      (do-auto-fill)
      ))))

(defun ar-fill-string-django (&optional justify)
  "Fill docstring according to Django's coding standards style.

    \"\"\"
    Process foo, return bar.
    \"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\"

See available styles at ‘ar-fill-paragraph’ or var ‘ar-docstring-style’
"
  (interactive "*P")
  (ar-fill-string justify 'django t))

(defun ar-fill-string-onetwo (&optional justify)
  "One newline and start and Two at end style.

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.

    \"\"\"

See available styles at ‘ar-fill-paragraph’ or var ‘ar-docstring-style’
"
  (interactive "*P")
  (ar-fill-string justify 'onetwo t))

(defun ar-fill-string-pep-257 (&optional justify)
  "PEP-257 with 2 newlines at end of string.

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"Process foo, return bar.

    If processing fails throw ProcessingError.

    \"\"\"

See available styles at ‘ar-fill-paragraph’ or var ‘ar-docstring-style’
"
  (interactive "*P")
  (ar-fill-string justify 'pep-257 t))

(defun ar-fill-string-pep-257-nn (&optional justify)
  "PEP-257 with 1 newline at end of string.

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\"

See available styles at ‘ar-fill-paragraph’ or var ‘ar-docstring-style’
"
  (interactive "*P")
  (ar-fill-string justify 'pep-257-nn t))

(defun ar-fill-string-symmetric (&optional justify)
  "Symmetric style.

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\"

See available styles at ‘ar-fill-paragraph’ or var ‘ar-docstring-style’
"
  (interactive "*P")
  (ar-fill-string justify 'symmetric t))

(provide 'ar-paragraph)
;;; ar-paragraph.el ends here
