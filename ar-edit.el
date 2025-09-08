;;; ar-edit.el --- Some more SOME edit utilities  -*- lexical-binding: t; -*-

(defun ar-insert-default-shebang ()
  "Insert in buffer shebang of installed default SOME."
  (interactive "*")
  (let* ((erg (if ar-edit-only-p
                  ar-shell-name
                (executable-find ar-shell-name)))
         (sheb (concat "#! " erg)))
    (insert sheb)))

(defun ar--top-level-form-p ()
  "Return non-nil, if line start with a top level form."
  (save-excursion
    (beginning-of-line)
    (unless
        ;; in string
        (nth 3 (parse-partial-sexp (point-min) (point)))
      (and (eq (current-indentation)  0)
           (looking-at "[[:alpha:]_]+")
           ;; (or (looking-at ar-def-or-class-re)
           ;;     (looking-at ar-block-or-clause-re)
           ;;     (looking-at ar-assignment-re))
           ))))

(defun ar-indent-line-outmost (&optional arg)
  "Indent the current line to the outmost reasonable indent.

With optional \\[universal-argument] ARG, unconditionally insert an indent of
‘ar-indent-offset’ length."
  (interactive "*P")
  (cond
   ((eq 4 (prefix-numeric-value arg))
    (if indent-tabs-mode
        (insert (make-string 1 9))
      (insert (make-string ar-indent-offset 32))))
   ;;
   (t
    (let* ((need (ar-compute-indentation (point)))
           (cui (current-indentation))
           (cuc (current-column)))
      (if (and (eq need cui)
               (not (eq cuc cui)))
          (back-to-indentation)
        (beginning-of-line)
        (delete-horizontal-space)
        (indent-to need))))))

(defun ar--re-indent-line ()
  "Re-indent the current line."
  (beginning-of-line)
  (delete-region (point)
                 (progn (skip-chars-forward " \t\r\n\f")
                        (point)))
  (indent-to (ar-compute-indentation)))

;; TODO: the following function can fall into an infinite loop.
;; See https://github.com/andreas-roehler/emacs-generics/SomeMode-mode/-/issues/99
(defun ar--indent-fix-region-intern (beg end)
  "Used when ‘ar-tab-indents-region-p’ is non-nil.

Requires BEG, END as the boundery of region"
  (save-excursion
    (save-restriction
      (beginning-of-line)
      (narrow-to-region beg end)
      (goto-char beg)
      (let ((end (copy-marker end)))
        (forward-line 1)
        (narrow-to-region (line-beginning-position) end)
        (ar--re-indent-line)
        (while (< (line-end-position) end)
          (forward-line 1)
          (ar--re-indent-line))))))

(defun ar-indent-current-line (need)
  "Indent current line to NEED."
  (beginning-of-line)
  (delete-horizontal-space)
  (indent-to need))

;; TODO: Add docstring.
;; What is the intent of the this utility function?
;; What is the purpose of each argument?
(defun ar--indent-line-intern (need cui indent col &optional beg end region dedent)
  (let (erg)
    (if ar-tab-indent
        (progn
          (and ar-tab-indents-region-p region
               (ar--indent-fix-region-intern beg end))
          (cond
           ((bolp)
            (if (and ar-tab-shifts-region-p region)
                (while (< (current-indentation) need)
                  (ar-shift-region-right 1))
              (beginning-of-line)
              (delete-horizontal-space)
              (indent-to need)))
           ;;
           ((< need cui)
            (if (and ar-tab-shifts-region-p region)
                (progn
                  (when (eq (point) (region-end))
                    (exchange-point-and-mark))
                  (while (< 0 (current-indentation))
                    (ar-shift-region-left 1)))
              (beginning-of-line)
              (delete-horizontal-space)
              (indent-to need)))
           ;;
           ((eq need cui)
            (if (or dedent
                    (eq this-command last-command)
                    (eq this-command (quote ar-indent-line)))
                (if (and ar-tab-shifts-region-p region)
                    (while (and (goto-char beg) (< 0 (current-indentation)))
                      (ar-shift-region-left 1))
                  (beginning-of-line)
                  (delete-horizontal-space)
                  (if (<= (line-beginning-position) (+ (point) (- col cui)))
                      (forward-char (- col cui))
                    (beginning-of-line)))))
           ;;
           ((< cui need)
            (if (and ar-tab-shifts-region-p region)
                (ar-shift-region-right 1)
              (beginning-of-line)
              (delete-horizontal-space)
              ;; indent one indent only if goal < need
              (setq erg (+ (* (/ cui indent) indent) indent))
              (if (< need erg)
                  (indent-to need)
                (indent-to erg))
              (forward-char (- col cui))))
           ;;
           (t
            (if (and ar-tab-shifts-region-p region)
                (while (< (current-indentation) need)
                  (ar-shift-region-right 1))
              (beginning-of-line)
              (delete-horizontal-space)
              (indent-to need)
              (back-to-indentation)
              (if (<= (line-beginning-position) (+ (point) (- col cui)))
                  (forward-char (- col cui))
                (beginning-of-line))))))
      (insert-tab))))

(defun ar--indent-line-or-region-base (beg end region cui need arg this-indent-offset col &optional dedent)
  (cond ((eq 4 (prefix-numeric-value arg))
         (if (and (eq cui (current-indentation))
                  (<= need cui))
             (if indent-tabs-mode (insert "\t")(insert (make-string ar-indent-offset 32)))
           (beginning-of-line)
           (delete-horizontal-space)
           (indent-to (+ need ar-indent-offset))))
        ((not (eq 1 (prefix-numeric-value arg)))
         (ar-smart-indentation-off)
         (ar--indent-line-intern need cui this-indent-offset col beg end region dedent))
        (t (ar--indent-line-intern need cui this-indent-offset col beg end region dedent))))

(defun ar--calculate-indent-backwards (cui indent-offset)
  "Return the next reasonable indent lower than current indentation.

Requires current indent as CUI
Requires current indent-offset as INDENT-OFFSET"
  (if (< 0 (% cui ar-indent-offset))
      ;; not correctly indented at all
      (/ cui indent-offset)
    (- cui indent-offset)))

(defun ar-indent-line (&optional arg dedent)
  "Indent the current line according ARG.

When called interactivly with \\[universal-argument],
ignore dedenting rules for block closing statements
\(e.g. return, raise, break, continue, pass)

An optional \\[universal-argument] followed by a numeric argument
neither 1 nor 4 will switch off ‘ar-smart-indentation’ for this execution.
This permits to correct allowed but unwanted indents. Similar to
‘ar-toggle-smart-indentation’ resp. ‘ar-smart-indentation-off’ followed by TAB.

OUTMOST-ONLY stops circling possible indent.

When ‘ar-tab-shifts-region-p’ is t, not just the current line,
but the region is shiftet that way.

If ‘ar-tab-indents-region-p’ is t and first TAB does not shift
--as indent is at outmost reasonable--, ‘indent-region’ is called.

Optional arg DEDENT: force dedent.

\\[quoted-insert] TAB inserts a literal TAB-character."
  (interactive "P")
  (unless (eq this-command last-command)
    (setq ar-already-guessed-indent-offset nil))
  (let ((orig (copy-marker (point)))
        ;; TAB-leaves-point-in-the-wrong-lp-1178453-test
        (region (use-region-p))
        cui
        outmost
        col
        beg
        end
        need
        this-indent-offset)
    (and region
         (setq beg (region-beginning))
         (setq end (region-end))
         (goto-char beg))
    (setq cui (current-indentation))
    (setq col (current-column))
    (setq this-indent-offset
          (cond ((and ar-smart-indentation (not (eq this-command last-command)))
                 (ar-guess-indent-offset))
                ((and ar-smart-indentation (eq this-command last-command) ar-already-guessed-indent-offset)
                 ar-already-guessed-indent-offset)
                (t ar-indent-offset)))
    (setq outmost (ar-compute-indentation nil nil nil nil nil nil nil this-indent-offset))
    ;; now choose the indent
    (unless (and (not dedent)(not (eq this-command last-command))(eq outmost (current-indentation)))
      (setq need
            (cond ((eq this-command last-command)
                   (if (bolp)
                       ;; jump forward to max indent
                       outmost
                     (ar--calculate-indent-backwards cui this-indent-offset)))
                  ;; (ar--calculate-indent-backwards cui this-indent-offset)))))
                  (t
                   outmost
                   )))
      (ar--indent-line-or-region-base beg end region cui need arg this-indent-offset col dedent)
      (and region (or ar-tab-shifts-region-p
                      ar-tab-indents-region-p)
           (not (eq (point) orig))
           (exchange-point-and-mark))
      (current-indentation))))

(defun ar--delete-trailing-whitespace (orig)
  "Delete trailing whitespace.

Either ‘ar-newline-delete-trailing-whitespace-p’
or `
py-trailing-whitespace-smart-delete-p' must be t.

Start from position ORIG"
  (when (or ar-newline-delete-trailing-whitespace-p ar-trailing-whitespace-smart-delete-p)
    (let ((pos (copy-marker (point))))
      (save-excursion
        (goto-char orig)
        (if (ar-empty-line-p)
            (if (ar---emacs-version-greater-23)
                (delete-trailing-whitespace (line-beginning-position) pos)
              (save-restriction
                (narrow-to-region (line-beginning-position) pos)
                (delete-trailing-whitespace)))
          (skip-chars-backward " \t")
          (if (ar---emacs-version-greater-23)
              (delete-trailing-whitespace (line-beginning-position) pos)
            (save-restriction
              (narrow-to-region (point) pos)
              (delete-trailing-whitespace))))))))

(defun ar-newline-and-indent ()
  "Add a newline and indent to outmost reasonable indent.
When indent is set back manually, this is honoured in following lines."
  (interactive "*")
  (let* ((orig (point))
         ;; lp:1280982, deliberatly dedented by user
         (this-dedent
          (when
              ;; (and (or (eq 10 (char-after))(eobp))(looking-back "^[ \t]*" (line-beginning-position)))
              (looking-back "^[ \t]+" (line-beginning-position))
            (current-column)))
         erg)
    (newline 1)
    (ar--delete-trailing-whitespace orig)
    (setq erg
          (cond (this-dedent
                 (indent-to-column this-dedent))
                ((and ar-empty-line-closes-p (or (eq this-command last-command)(ar--after-empty-line)))
                 (indent-to-column (save-excursion (ar-backward-statement)(- (current-indentation) ar-indent-offset))))
                (t
                 (fixup-whitespace)
                 (indent-to-column (ar-compute-indentation)))))
    erg))

(defun ar-newline-and-dedent ()
  "Add a newline and indent to one level below current.
Returns column."
  (interactive "*")
  (let ((cui (current-indentation)))
    (newline 1)
    (when (< 0 cui)
      (indent-to (- (ar-compute-indentation) ar-indent-offset)))))

(defun ar-toggle-indent-tabs-mode ()
  "Toggle ‘indent-tabs-mode’.

Returns value of ‘indent-tabs-mode’ switched to."
  (interactive)
  (when
      (setq indent-tabs-mode (not indent-tabs-mode))
    (setq tab-width ar-indent-offset))
  (when (and ar-verbose-p (called-interactively-p 'any)) (message "indent-tabs-mode %s  ar-indent-offset %s" indent-tabs-mode ar-indent-offset))
  indent-tabs-mode)

(defun ar-indent-tabs-mode (arg)
  "With positive ARG switch ‘indent-tabs-mode’ on.

With negative ARG switch ‘indent-tabs-mode’ off.
Returns value of ‘indent-tabs-mode’ switched to.

If IACT is provided, message result"
  (interactive "p")
  (if (< 0 arg)
      (progn
        (setq indent-tabs-mode t)
        (setq tab-width ar-indent-offset))
    (setq indent-tabs-mode nil))
  (when (and ar-verbose-p (called-interactively-p 'any)) (message "indent-tabs-mode %s   ar-indent-offset %s" indent-tabs-mode ar-indent-offset))
  indent-tabs-mode)

(defun ar-indent-tabs-mode-on (arg)
  "Switch ‘indent-tabs-mode’ according to ARG."
  (interactive "p")
  (ar-indent-tabs-mode (abs arg)))

(defun ar-indent-tabs-mode-off (arg)
  "Switch ‘indent-tabs-mode’ according to ARG."
  (interactive "p")
  (ar-indent-tabs-mode (- (abs arg))))

;;  Guess indent offset

;; (defun ar--comment-indent-function ()
;;   "SOME version of ‘comment-indent-function’."
;;   ;; This is required when filladapt is turned off.  Without it, when
;;   ;; filladapt is not used, comments which start in column zero
;;   ;; cascade one character to the right
;;   (save-excursion
;;     (beginning-of-line)
;;     (let ((eol (line-end-position)))
;;       (and comment-start-skip
;;            (re-search-forward comment-start-skip eol t)
;;            (setq eol (match-beginning 0)))
;;       (goto-char eol)
;;       (skip-chars-backward " \t")
;;       (max comment-column (+ (current-column) (if (bolp) 0 1))))))

;; ;

;;  Declarations start
(defun ar--bounds-of-declarations ()
  "Bounds of consecutive multitude of assigments resp. statements around point.

Indented same level, which do not open blocks.
Typically declarations resp. initialisations of variables following
a class or function definition.
See also ‘ar--bounds-of-statements’"
  (let* ((orig-indent (progn
                        (back-to-indentation)
                        (unless (ar--beginning-of-statement-p)
                          (ar-backward-statement))
                        (unless (ar--beginning-of-block-p)
                          (current-indentation))))
         (orig (point))
         last beg end)
    (when orig-indent
      (setq beg (line-beginning-position))
      ;; look upward first
      (while (and
              (or 
                (ar--beginning-of-statement-p)
                  (ar-backward-statement))
              (ar-backward-statement)
              (not (ar--beginning-of-block-p))
              (eq (current-indentation) orig-indent))
        (setq beg (line-beginning-position)))
      (goto-char orig)
      (while (and (setq last (line-end-position))
                  (setq end (ar-down-statement))
                  (not (ar--beginning-of-block-p))
                  (eq (ar-indentation-of-statement) orig-indent)))
      (setq end last)
      (goto-char beg)
      (if (and beg end)
          (progn
            (cons beg end))
        nil))))

(defun ar-backward-declarations ()
  "Got to the beginning of assigments resp. statements.

Move in current level which do not open blocks."
  (interactive)
  (let* ((bounds (ar--bounds-of-declarations))
         (erg (car bounds)))
    (when erg (goto-char erg))
    erg))

(defun ar-forward-declarations ()
  "Got to the end of assigments resp. statements.

Move in current level which do not open blocks."
  (interactive)
  (let* ((bounds (ar--bounds-of-declarations))
         (erg (cdr bounds)))
    (when erg (goto-char erg))
    erg))

(defun ar-declarations ()
  "Forms in current level.

Forms do not open blocks or start with a keyword.

See also ‘ar-statements’."
  (interactive)
  (let* ((bounds (ar--bounds-of-declarations))
         (beg (car bounds))
         (end (cdr bounds)))
    (when (and beg end)
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (kill-new (buffer-substring-no-properties beg end))
      (exchange-point-and-mark))))

(defun ar-kill-declarations ()
  "Delete variables declared in current level.

Store deleted variables in ‘kill-ring’"
  (interactive "*")
  (let* ((bounds (ar--bounds-of-declarations))
         (beg (car bounds))
         (end (cdr bounds)))
    (when (and beg end)
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (kill-new (buffer-substring-no-properties beg end))
      (delete-region beg end))))
;;  Declarations end

;;  Statements start
(defun ar--bounds-of-statements ()
  "Bounds of consecutive multitude of statements around point.

Indented same level, which do not open blocks."
  (interactive)
  (let* ((orig-indent (progn
                        (back-to-indentation)
                        (unless (ar--beginning-of-statement-p)
                          (ar-backward-statement))
                        (unless (ar--beginning-of-block-p)
                          (current-indentation))))
         (orig (point))
         last beg end)
    (when orig-indent
      (setq beg (point))
      (while (and (setq last beg)
                  (setq beg
                        (when (ar-backward-statement)
                          (line-beginning-position)))
                  ;; backward-statement should not stop in string
                  ;; (not (ar-in-string-p))
                  (not (ar--beginning-of-block-p))
                  (eq (current-indentation) orig-indent)))
      (setq beg last)
      (goto-char orig)
      (setq end (line-end-position))
      (while (and (setq last (ar--end-of-statement-position))
                  (setq end (ar-down-statement))
                  (not (ar--beginning-of-block-p))
                  ;; (not (looking-at ar-keywords))
                  ;; (not (looking-at "pdb\."))
                  ;; (not (ar-in-string-p))
                  (eq (ar-indentation-of-statement) orig-indent)))
      (setq end last)
      (goto-char orig)
      (if (and beg end)
          (progn
            (when (called-interactively-p 'any) (message "%s %s" beg end))
            (cons beg end))
        nil))))

(defun ar-backward-statements ()
  "Got to the beginning of statements in current level which do not open blocks."
  (interactive)
  (let* ((bounds (ar--bounds-of-statements))
         (erg (car bounds)))
    (when erg (goto-char erg))
    erg))

(defun ar-forward-statements ()
  "Got to the end of statements in current level which do not open blocks."
  (interactive)
  (let* ((bounds (ar--bounds-of-statements))
         (erg (cdr bounds)))
    (when erg (goto-char erg))
    erg))

(defun ar-statements ()
  "Copy and mark simple statements level.

These statements do not open blocks.

More general than ‘ar-declarations’."
  (interactive)
  (let* ((bounds (ar--bounds-of-statements))
         (beg (car bounds))
         (end (cdr bounds)))
    (when (and beg end)
      (goto-char beg)
      (push-mark)
      (goto-char end)
      (kill-new (buffer-substring-no-properties beg end))
      (exchange-point-and-mark))))

(defun ar-kill-statements ()
  "Delete statements declared in current level.

Store deleted statements in ‘kill-ring’"
  (interactive "*")
  (let* ((bounds (ar--bounds-of-statements))
         (beg (car bounds))
         (end (cdr bounds)))
    (when (and beg end)
      (kill-new (buffer-substring-no-properties beg end))
      (delete-region beg end))))

(defun ar-insert-super ()
  "Insert a function \"super()\" from current environment.

As example given in SOME v3.1 documentation » The SOME Standard Library »

class C(B):
    def method(self, arg):
        super().method(arg) # This does the same thing as:
                               # super(C, self).method(arg)

Returns the string inserted."
  (interactive "*")
  (let* ((orig (point))
         (funcname (progn
                     (ar-backward-def)
                     (when (looking-at (concat ar-def-re " *\\([^(]+\\) *(\\(?:[^),]*\\),? *\\([^)]*\\))"))
                       (match-string-no-properties 2))))
         (args (match-string-no-properties 3))
         (ver (ar-which-SomeMode))
         classname erg)
    (if (< ver 3)
        (progn
          (ar-backward-class)
          (when (looking-at (concat ar-class-re " *\\([^( ]+\\)"))
            (setq classname (match-string-no-properties 2)))
          (goto-char orig)
          (setq erg (concat "super(" classname ", self)." funcname "(" args ")"))
          ;; super(C, self).method(arg)"
          (insert erg))
      (goto-char orig)
      (setq erg (concat "super()." funcname "(" args ")"))
      (insert erg))
    erg))

;; Comments
(defun ar-delete-comments-in-def-or-class ()
  "Delete all commented lines in def-or-class at point."
  (interactive "*")
  (save-excursion
    (let ((beg (ar--beginning-of-def-or-class-position))
          (end (ar--end-of-def-or-class-position)))
      (and beg end (ar--delete-comments-intern beg end)))))

(defun ar-delete-comments-in-class ()
  "Delete all commented lines in class at point."
  (interactive "*")
  (save-excursion
    (let ((beg (ar--beginning-of-class-position))
          (end (ar--end-of-class-position)))
      (and beg end (ar--delete-comments-intern beg end)))))

(defun ar-delete-comments-in-block ()
  "Delete all commented lines in block at point."
  (interactive "*")
  (save-excursion
    (let ((beg (ar--beginning-of-block-position))
          (end (ar--end-of-block-position)))
      (and beg end (ar--delete-comments-intern beg end)))))

(defun ar-delete-comments-in-region (beg end)
  "Delete all commented lines in region delimited by BEG END."
  (interactive "r*")
  (save-excursion
    (ar--delete-comments-intern beg end)))

(defun ar--delete-comments-intern (beg end)
  (save-restriction
    (narrow-to-region beg end)
    (goto-char beg)
    (while (and (< (line-end-position) end) (not (eobp)))
      (beginning-of-line)
      (if (looking-at (concat "[ \t]*" comment-start))
          (delete-region (point) (1+ (line-end-position)))
        (forward-line 1)))))

;; Edit docstring
(defun ar--edit-set-vars ()
  (save-excursion
    (let ((ar--editbeg (when (use-region-p) (region-beginning)))
          (ar--editend (when (use-region-p) (region-end)))
          (pps (parse-partial-sexp (point-min) (point))))
      (when (nth 3 pps)
        (setq ar--editbeg (or ar--editbeg (progn (goto-char (nth 8 pps))
                                                 (skip-chars-forward (char-to-string (char-after)))(push-mark) (point))))
        (setq ar--editend (or ar--editend
                              (progn (goto-char (nth 8 pps))
                                     (forward-sexp)
                                     (skip-chars-backward (char-to-string (char-before)))
                                     (point)))))
      (cons (copy-marker ar--editbeg) (copy-marker ar--editend)))))

(defun ar--write-edit ()
  "When edit is finished, write docstring back to orginal buffer."
  (interactive)
  (goto-char (point-min))
  (while (re-search-forward "[\"']" nil t 1)
    (or (ar-escaped-p)
        (replace-match (concat "\\\\" (match-string-no-properties 0)))))
  (jump-to-register ar--edit-register)
  ;; (ar-restore-window-configuration)
  (delete-region ar--docbeg ar--docend)
  (insert-buffer-substring ar-edit-buffer))

(defun ar-edit--intern (buffer-name mode &optional beg end prefix suffix)
  "Edit string or active region in ‘ar-mode’.

arg BUFFER-NAME: a string.
arg MODE: which buffer-mode used in edit-buffer"
  (interactive "*")
  (save-excursion
    (save-restriction
      (window-configuration-to-register ar--edit-register)
      (setq ar--oldbuf (current-buffer))
      (let* ((orig (point))
             (bounds (or (and beg end) (ar--edit-set-vars)))
             relpos editstrg)
        (setq ar--docbeg (or beg (car bounds)))
        (setq ar--docend (or end (cdr bounds)))
        ;; store relative position in editstrg
        (setq relpos (1+ (- orig ar--docbeg)))
        (setq editstrg (buffer-substring ar--docbeg ar--docend))
        (set-buffer (get-buffer-create buffer-name))
        (erase-buffer)
        (switch-to-buffer (current-buffer))
        (when prefix (insert prefix))
        (insert editstrg)
        (when suffix (insert suffix))
        (funcall mode)
        (local-set-key [(control c) (control c)] (quote ar--write-edit))
        (goto-char relpos)
        (message "%s" "Type C-c C-c writes contents back")))))

(defun ar-edit-docstring ()
  "Edit docstring or active region in ‘ar-mode’."
  (interactive "*")
  (ar-edit--intern "Edit docstring" 'ar-mode))

(defun ar-unpretty-assignment ()
  "Revoke prettyprint, write assignment in a shortest way."
  (interactive "*")
  (save-excursion
    (let* ((beg (ar-beginning-of-assignment))
           (end (copy-marker (ar-forward-assignment)))
           last)
      (goto-char beg)
      (while (and (not (eobp))(re-search-forward "^\\([ \t]*\\)\[\]\"'{}]" end t 1) (setq last (copy-marker (point))))
        (save-excursion (goto-char (match-end 1))
                        (when (eq (current-column) (current-indentation)) (delete-region (point) (progn (skip-chars-backward " \t\r\n\f") (point)))))
        (when last (goto-char last))))))

(defun ar--prettyprint-assignment-intern (beg end name buffer)
  (let ((proc (get-buffer-process buffer))
        erg)
    ;; (ar-send-string "import pprint" proc nil t)
    (ar-fast-send-string "import json" proc buffer)
    ;; send the dict/assigment
    (ar-fast-send-string (buffer-substring-no-properties beg end) proc buffer)
    ;; do pretty-print
    ;; print(json.dumps(neudict4, indent=4))
    (setq erg (ar-fast-send-string (concat "print(json.dumps("name", indent=5))") proc buffer t))
    (goto-char beg)
    (skip-chars-forward "^{")
    (delete-region (point) (progn (forward-sexp) (point)))
    (insert erg)))

(defun ar-prettyprint-assignment ()
  "Prettyprint assignment in ‘ar-mode’."
  (interactive "*")
  (window-configuration-to-register ar--windows-config-register)
  (save-excursion
    (let* ((beg (ar-beginning-of-assignment))
           (name (ar-expression))
           (end (ar-forward-assignment))
           (proc-buf (ar-shell nil nil "Fast Intern Utility Re-Use")))
      (ar--prettyprint-assignment-intern beg end name proc-buf)))
  (ar-restore-window-configuration))

(provide 'ar-edit)
;;; ar-edit.el ends here
