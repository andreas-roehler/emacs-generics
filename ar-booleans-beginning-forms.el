;;; ar-booleans-beginning-forms.el --- booleans-beginning forms -*- lexical-binding: t; -*-

(defun ar--beginning-of-comment-p (&optional pps)
  "If cursor is at the beginning of a ‘comment’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-comment-re))
         (point))))

(defun ar--beginning-of-expression-p (&optional pps)
  "If cursor is at the beginning of a ‘expression’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-expression-re))
         (point))))

(defun ar--beginning-of-line-p (&optional pps)
  "If cursor is at the beginning of a ‘line’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-line-re))
         (point))))

(defun ar--beginning-of-paragraph-p (&optional pps)
  "If cursor is at the beginning of a ‘paragraph’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-paragraph-re))
         (point))))

(defun ar--beginning-of-partial-expression-p (&optional pps)
  "If cursor is at the beginning of a ‘partial-expression’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-partial-expression-re))
         (point))))

(defun ar--beginning-of-section-p (&optional pps)
  "If cursor is at the beginning of a ‘section’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-section-re))
         (point))))

(defun ar--beginning-of-top-level-p (&optional pps)
  "If cursor is at the beginning of a ‘top-level’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at (concat "\\b" ar-top-level-re))
         (point))))

(defun ar--beginning-of-assignment-p (&optional pps)
  "If cursor is at the beginning of a ‘assignment’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-assignment-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-block-p (&optional pps)
  "If cursor is at the beginning of a ‘block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-block-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-block-or-clause-p (&optional pps)
  "If cursor is at the beginning of a ‘block-or-clause’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-block-or-clause-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-class-p (&optional pps)
  "If cursor is at the beginning of a ‘class’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-class-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-clause-p (&optional pps)
  "If cursor is at the beginning of a ‘clause’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-clause-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-def-p (&optional pps)
  "If cursor is at the beginning of a ‘def’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-def-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-def-or-class-p (&optional pps)
  "If cursor is at the beginning of a ‘def-or-class’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-def-or-class-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-elif-block-p (&optional pps)
  "If cursor is at the beginning of a ‘elif-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-elif-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-else-block-p (&optional pps)
  "If cursor is at the beginning of a ‘else-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-else-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-except-block-p (&optional pps)
  "If cursor is at the beginning of a ‘except-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-except-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-for-block-p (&optional pps)
  "If cursor is at the beginning of a ‘for-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-for-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-if-block-p (&optional pps)
  "If cursor is at the beginning of a ‘if-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-if-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-indent-p (&optional pps)
  "If cursor is at the beginning of a ‘indent’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-indent-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-minor-block-p (&optional pps)
  "If cursor is at the beginning of a ‘minor-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-minor-block-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-try-block-p (&optional pps)
  "If cursor is at the beginning of a ‘try-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-try-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (eq (current-column)(current-indentation))
         (point))))

(defun ar--beginning-of-assignment-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘assignment’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-assignment-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-block-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-block-or-clause-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘block-or-clause’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-block-or-clause-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-class-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘class’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-class-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-clause-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘clause’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-clause-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-def-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘def’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-def-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-def-or-class-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘def-or-class’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-def-or-class-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-elif-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘elif-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-elif-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-else-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘else-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-else-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-except-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘except-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-except-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-for-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘for-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-for-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-if-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘if-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-if-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-indent-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘indent’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-indent-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-minor-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘minor-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-minor-block-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(defun ar--beginning-of-try-block-bol-p (&optional pps)
  "If cursor is at the beginning of a ‘try-block’.
Return position, nil otherwise."
  (let ((pps (or pps (parse-partial-sexp (point-min) (point)))))
    (and (bolp)
         (not (or (nth 8 pps)(nth 1 pps)))
         (looking-at ar-try-re)
         (looking-back "[^ \t]*" (line-beginning-position))
         (point))))

(provide (quote ar-booleans-beginning-forms))
;; ar-booleans-beginning-forms.el ends here
