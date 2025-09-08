;; ar-compute-indentation.el --- Part of ar-mode -*- lexical-binding: t; -*-

;;  Keymap

;;  Utility stuff

(defun ar--computer-closing-inner-list ()
  "Compute indentation according to ar-closing-list-dedents-bos."
  (if ar-closing-list-dedents-bos
      (+ (current-indentation) ar-indent-offset)
    (1+ (current-column))))

(defun ar-compute-indentation-according-to-list-style-intern()
  (pcase ar-indent-list-style
    (`line-up-with-first-element
     (if (looking-at "\\s([ \\t]*$")
         (cond ((save-excursion
                  (back-to-indentation)
                  (looking-at ar-if-re))
                ;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=42513
                0)
               ((looking-back "^[ \\t]+ " (line-beginning-position))
                ;; line with 'sword', from a single opener
                ;; var5: Sequence[Mapping[str, Sequence[str]]] = [
                ;;     {
                ;;      'red': ['scarlet', 'vermilion', 'ruby'],
                ;;      'green': ['emerald', 'aqua']
                ;;     },
                ;;     {
                ;;                 'sword': ['cutlass', 'rapier']
                ;;     }
                ;; ]
                (+ (current-indentation) 1))
               (t
                (+ (current-indentation) ar-indent-offset)))
       (+ (current-column) 1)))
    (`one-level-to-beginning-of-statement
     (+ (current-indentation) ar-indent-offset))
    (`one-level-from-first-element
     (+ 1 (current-column) ar-indent-offset))))

(defun ar-compute-indentation-according-to-list-style (pps line-beginning-position)
  "See ‘ar-indent-list-style’

Choices are:

\\='line-up-with-first-element (default)
\\='one-level-to-beginning-of-statement
\\='one-level-from-opener

See also ar-closing-list-dedents-bos"
  (let ((orig (point))
        (lines (ar-count-lines))
        (just-at-closer (save-excursion
                          (or (looking-back "^[ \t]*\\s)" (line-beginning-position))
                              (and (looking-at "[ \t]*\\s)")
                                   (looking-back "^[ \t]*" (line-beginning-position))))))
        (lines-from
         (progn (goto-char (nth 1 pps))
                (ar-count-lines))))
    ;; now at start of inner list
    (cond
     ((save-excursion
        ;; from last 'pk': chained lists as special case
        ;; data = {'key': {
        ;;     'objlist': [
        ;;         {'pk': 1,
        ;;          'name': 'first'},
        ;;         {'pk': 2,
        ;;          'name': 'second'}
        ;;     ]
        ;; }}
        (and
         ;; list starts at current line
         (< line-beginning-position (nth 1 pps))
         ;; if previous line contains in another list, indent according to its start
         (progn
           (beginning-of-line)
           (skip-chars-backward " \t\r\n\f")
           (skip-chars-backward "^[[:alnum:]]")
           (eq (nth 0 pps) (nth 0 (parse-partial-sexp (point-min) (point)))))))
      (beginning-of-line)
      (skip-chars-backward " \t\r\n\f")
      (skip-chars-backward "^[[:alnum:]]")
      (goto-char (nth 1 (parse-partial-sexp (point-min) (point))))
      (current-indentation))
     (just-at-closer
      ;; dedents at opener or at openers indentation
      (cond ((or (eq line-beginning-position (line-beginning-position)) ar-closing-list-dedents-bos)
             (current-indentation))
            (t (ar-compute-indentation-according-to-list-style-intern))))
     ((save-excursion
        (and
         (not just-at-closer)
         (< 1 (- lines lines-from))
         (progn
           (goto-char orig)
           (forward-line -1)
           ;; ignore if in higher nesting
           (eq (nth 0 pps) (nth 0 (parse-partial-sexp (point-min) (point)))))))
      (progn
        (goto-char orig)
        (forward-line -1)
        (current-indentation)))
     ((eq line-beginning-position (line-beginning-position))
      ;; (and (eq line-beginning-position (line-beginning-position))  (looking-back [^ \\t]*))
      (current-indentation))
     ((eq (current-column) 0)
      ;; List starts at BOL or indent,
      ;; https://bugs.launchpad.net/SomeMode-mode/+bug/328842
      (+ (current-indentation) ar-indent-offset))
     (t (ar-compute-indentation-according-to-list-style-intern)))))

(defun ar-compute-comment-indentation (pps iact orig origline closing line nesting repeat indent-offset liep)
  (cond ((nth 8 pps)
         (goto-char (nth 8 pps))
         (cond ((and line (eq (current-column) (current-indentation)))
                (current-indentation))
               ((and (eq liep (line-end-position)) ar-indent-honors-inline-comment)
                (current-column))
               ((ar--line-backward-maybe)
                (setq line t)
                (skip-chars-backward " \t")
                (ar-compute-indentation iact orig origline closing line nesting repeat indent-offset liep))
               (t (if ar-indent-comments
                      (progn
                        (ar-backward-comment)
                        (ar-compute-indentation iact orig origline closing line nesting repeat indent-offset liep))
                    0))))
        ((and
          (looking-at (concat "[ \t]*" comment-start))
          (looking-back "^[ \t]*" (line-beginning-position))(not line)
          (eq liep (line-end-position)))
         (if ar-indent-comments
             (progn
               (setq line t)
               (skip-chars-backward " \t\r\n\f")
               ;; as previous comment-line might
               ;; be wrongly unindented, travel
               ;; whole commented section
               (ar-backward-comment)
               (ar-compute-indentation iact orig origline closing line nesting repeat indent-offset liep))
           0))
        ((and
          (looking-at (concat "[ \t]*" comment-start))
          (looking-back "^[ \t]*" (line-beginning-position))
          (not (eq liep (line-end-position))))
         (current-indentation))
        ((and (eq 11 (syntax-after (point))) line ar-indent-honors-inline-comment)
         (current-column))))

(defun ar-compute-indentation--at-closer-maybe (erg)
  (goto-char erg)
  (backward-sexp)
  (if ar-closing-list-dedents-bos
      (current-indentation)
    (+ (current-indentation) ar-indent-offset)))

(defun ar-compute-indentation--at-closer-p ()
  "If on a line on with just on or more chars closing a list."
  ;; (interactive)
  (or
   (and (looking-back "^[ \\t]*[\])}]+[ \\t]*" (line-beginning-position))(match-end 0))
   (and (looking-back "^ *" (line-beginning-position))
        (looking-at "[ \\t]*[\]})]+[ \\t]*$")
        (match-end 0)
        )))

(defun ar--compute-indentation-in-docstring ()
  ""
  (save-excursion
    ;; (goto-char (match-beginning 0))
    (back-to-indentation)
    (if (looking-at "[uUrR]?\"\"\"\\|[uUrR]?'''")
        (progn
          (skip-chars-backward " \t\r\n\f")
          (back-to-indentation)
          (if (looking-at ar-def-or-class-re)
              (+ (current-column) ar-indent-offset)
            (current-indentation)))
      (beginning-of-line) 
      (skip-chars-backward " \t\r\n\f")
      (back-to-indentation)
      (current-indentation))))

(defun ar-compute-indentation (&optional iact orig origline closing line nesting repeat indent-offset liep beg)
  "Compute SOME indentation.

When HONOR-BLOCK-CLOSE-P is non-nil, statements such as ‘return’,
‘raise’, ‘break’, ‘continue’, and ‘pass’ force one level of dedenting.

ORIG keeps original position
ORIGLINE keeps line where compute started
CLOSING is t when started at a char delimiting a list as \"]})\"
LINE indicates being not at origline now
NESTING is currently ignored, if executing from inside a list
REPEAT counter enables checks against ‘ar-max-specpdl-size’
INDENT-OFFSET allows calculation of block-local values
LIEP stores line-end-position at point-of-interest
"
  (interactive "p")
  ;; (and (not line) (< (current-column) (current-indentation)) (back-to-indentation))
  (let ((beg
         (or beg
             (and (comint-check-proc (current-buffer))
                  (re-search-backward (concat ar-shell-prompt-regexp "\\|" ar-iSomeMode-output-prompt-re "\\|" ar-iSomeMode-input-prompt-re) nil t 1))
             (point-min))))
    (save-excursion
      (save-restriction
        ;; (narrow-to-region beg (line-end-position))
        ;; in shell, narrow from previous prompt
        ;; needed by closing
        (let* ((orig (or orig (copy-marker (point))))
               (origline (or origline (ar-count-lines (point-min) (point))))
               ;; closing indicates: when started, looked
               ;; at a single closing parenthesis
               ;; line: moved already a line backward
               (liep (or liep (line-end-position)))
               (line (or line (not (eq origline (ar-count-lines (point-min) (point))))))
               ;; (line line)
               (pps (progn
                      (unless (eq (current-indentation) (current-column))(skip-chars-backward " " (line-beginning-position)))
                      ;; (when (eq 5 (car (syntax-after (1- (point)))))
                      ;;   (forward-char -1))
                      (parse-partial-sexp (point-min) (point))))

               ;; in a recursive call already
               (repeat (or repeat 0))
               ;; nesting: started nesting a list
               (nesting nesting)
               indent this-line)
          (if (< ar-max-specpdl-size repeat)
              (error "‘ar-compute-indentation’ reached loops max.")
            (setq nesting (nth 0 pps))
            (setq indent
                  (cond
                   ((bobp)
                    (cond ((eq liep (line-end-position))
                           0)
                          ;; - ((looking-at ar-outdent-re)
                          ;; - (+ (or indent-offset (and ar-smart-indentation (ar-guess-indent-offset)) ar-indent-offset) (current-indentation)))
                          ((and line (looking-at ar-block-or-clause-re))
                           ar-indent-offset)
                          ((looking-at ar-outdent-re)
                           (+ (or indent-offset (and ar-smart-indentation (ar-guess-indent-offset)) ar-indent-offset) (current-indentation)))
                          (t
                           (current-indentation))))
                   ;; in string
                   ((and (nth 3 pps) (nth 8 pps))
                    (cond
                     ((ar--docstring-p (nth 8 pps))
                      (ar--compute-indentation-in-docstring))
                     ;; string in list
                     ;; ;; data = {'key': {
                     ;;     'objlist': [
                     ;;         {'pk': 1,
                     ;;          'name': 'first'},
                     ;;         {'pk': 2,
                     ;;          'name': 'second'}
                     ;;     ]
                     ;; }}
                     (t (goto-char (nth 8 pps))
                      (if
                          (or line (< (ar-count-lines (point-min) (point)) origline))
                          (current-column)
                        (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg)))))
                   ((and (looking-at "\"\"\"\\|'''") (not (bobp)))
                    (ar-backward-statement)
                    (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))
                   ;; comments
                   ((or
                     (nth 8 pps)
                     (and
                      (looking-at (concat "[ \t]*" comment-start))
                      (looking-back "^[ \t]*" (line-beginning-position))(not line))
                     (and (eq 11 (syntax-after (point))) line ar-indent-honors-inline-comment))
                    (ar-compute-comment-indentation pps iact orig origline closing line nesting (+ repeat 1) indent-offset liep))
                   ;; lists
                   ((and (nth 1 pps)(or (< 1 (nth 0 pps))(eq major-mode (quote SomeMode-mode))))
                    (ar-compute-indentation-according-to-list-style pps (line-beginning-position)))
                   ;; Compute according to ‘ar-indent-list-style’

                   ;; Choices are:

                   ;; \\='line-up-with-first-element (default)
                   ;; \\='one-level-to-beginning-of-statement
                   ;; \\='one-level-from-opener"

                   ;; See also ar-closing-list-dedents-bos
                   ;;   (ar-compute-indentation-in-list pps line closing orig)
                   ;; (back-to-indentation)
                   ;; (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg)))
                   ((and (eq (char-after) (or ?\( ?\{ ?\[)) line)
                    (1+ (current-column)))
                   ((ar-preceding-line-backslashed-p)
                    (progn
                      (ar-backward-statement)
                      (setq this-line (ar-count-lines))
                      (if (< 1 (- origline this-line))
                          (ar--fetch-indent-line-above orig)
                        (if (looking-at "from +\\([^ \t\n]+\\) +import")
                            ar-backslashed-lines-indent-offset
                          (if (< 20 (line-end-position))
                              8
                            (+ (current-indentation) ar-continuation-offset))))))
                   ((and (looking-at ar-block-closing-keywords-re)
                         (eq liep (line-end-position)))
                    (skip-chars-backward "[ \t\r\n\f]")
                    (ar-backward-statement)
                    (cond ((looking-at ar-extended-block-or-clause-re)
                           (+
                            ;; (if ar-smart-indentation (ar-guess-indent-offset) indent-offset)
                            (or indent-offset (and ar-smart-indentation (ar-guess-indent-offset)) ar-indent-offset)
                            (current-indentation)))
                          ((looking-at ar-block-closing-keywords-re)
                           (- (current-indentation) (or indent-offset ar-indent-offset)))
                          (t (current-column))))
                   ((looking-at ar-block-closing-keywords-re)
                    (if (< (line-end-position) orig)
                        ;; #80, Lines after return cannot be correctly indented
                        (if (looking-at "return[ \\t]*$")
                            (current-indentation)
                          (- (current-indentation) (or indent-offset ar-indent-offset)))
                      (ar-backward-block-or-clause)
                      (current-indentation)))
                   ((and (looking-at ar-minor-clause-re) (not line)
                         (eq liep (line-end-position)))
                    (cond
                     ((looking-at ar-case-re)
                      (and (ar--backward-regexp (quote ar-match-case-re) nil (quote >))
                           ;; (+ (current-indentation) ar-indent-offset)
                           (current-indentation)))
                     ((and (ar--backward-regexp (quote ar-block-or-clause-re)
                                                ;; an arbitray large
                                                ;; number, larger than
                                                ;; any real expected
                                                ;; indent
                                                (* 99 ar-indent-offset)
                                                (quote <))
                           (current-indentation)))
                     ((looking-at ar-outdent-re)
                      (and (ar--backward-regexp (quote ar-block-or-clause-re)
                                                ;; an arbitray number, larger than an real expected indent
                                                (* 99 ar-indent-offset)
                                                (quote <))))
                     ((bobp) 0)
                     (t (save-excursion
                          ;; (skip-chars-backward " \t\r\n\f")
                          (if (ar-backward-block)
                              ;; (ar--backward-regexp (quote ar-block-or-clause-re))
                              (+ ar-indent-offset (current-indentation))
                            0)))))
                   ((looking-at ar-extended-block-or-clause-re)
                    (cond ((and (not line)
                                (eq liep (line-end-position)))
                           (when (ar--line-backward-maybe)
                             (ar-compute-indentation iact orig origline closing t nesting (+ repeat 1) indent-offset liep beg)))
                          (t (+
                              (cond (indent-offset)
                                    (ar-smart-indentation
                                     (ar-guess-indent-offset))
                                    (t ar-indent-offset))
                              (current-indentation)))))
                   ((and
                     (< (line-end-position) liep)
                     (eq (current-column) (current-indentation)))
                    ;; from beginning of previous line
                    (cond
                     ((looking-at ar-assignment-re)
                      (goto-char (match-end 0))
                      ;; multiline-assignment
                      (if (and nesting (looking-at " *[[{(]") (not (looking-at ".+[]})][ \t]*$")))
                          (+ (current-indentation) (or indent-offset ar-indent-offset))
                        (current-indentation)))
                     ((looking-at ar-assignment-re)
                      (ar-backward-statement)
                      (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))
                     ((looking-at ar-block-or-clause-re)
                      (+ (current-indentation) ar-indent-offset))
                     (t (current-indentation))))
                   ((and (< (current-indentation) (current-column))(not line))
                    (back-to-indentation)
                    (unless line
                      (setq nesting (nth 0 (parse-partial-sexp (point-min) (point)))))
                    (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))
                   ((and (not (ar--beginning-of-statement-p)) (not (and line (eq 11 (syntax-after (point))))))
                    (if (bobp)
                        (current-column)
                      (if (eq (point) orig)
                          (progn
                            (when (ar--line-backward-maybe) (setq line t))
                            (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))
                        (ar-backward-statement)
                        (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))))
                   ((or (ar--statement-opens-block-p ar-extended-block-or-clause-re) (looking-at "@"))
                    (if (< (ar-count-lines) origline)
                        (+ (or indent-offset (and ar-smart-indentation (ar-guess-indent-offset)) ar-indent-offset) (current-indentation))
                      (skip-chars-backward " \t\r\n\f")
                      (setq line t)
                      (back-to-indentation)
                      (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg)))
                   ((and ar-empty-line-closes-p (ar--after-empty-line))
                    (progn (ar-backward-statement)
                           (- (current-indentation) (or indent-offset ar-indent-offset))))
                   ;; still at original line
                   ((and (eq liep (line-end-position))
                         (save-excursion
                           (and
                            (ar--go-to-keyword (quote ar-extended-block-or-clause-re) nil (* ar-indent-offset 99))
                            (if (looking-at (concat ar-block-re "\\|" ar-outdent-re))
                                (+ (current-indentation)
                                   (if ar-smart-indentation
                                       (or indent-offset (ar-guess-indent-offset))
                                     (or indent-offset ar-indent-offset)))
                              (current-indentation))))))
                   ((and (not line)
                         (eq liep (line-end-position))
                         (ar--beginning-of-statement-p))
                    (ar-backward-statement)
                    (ar-compute-indentation iact orig origline closing line nesting (+ repeat 1) indent-offset liep beg))
                   (t (current-indentation))))
            ;; (when (or (eq 1 (prefix-numeric-value iact)) ar-verbose-p) (message "%s" indent))
            (when (or iact ar-verbose-p) (message "%s" indent))
            indent))))))

(provide (quote ar-compute-indentation))
;;; ar-compute-indentation.el ends here
