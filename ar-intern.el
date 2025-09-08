;; ar-intern.el --- Part of ar-mode -*- lexical-binding: t; -*-

;;  Keymap

;;  Utility stuff

(defun ar--uncomment-intern (beg end)
  (uncomment-region beg end)
  (when ar-uncomment-indents-p
    (ar-indent-region beg end)))

(defun ar-uncomment (&optional beg)
  "Uncomment commented lines at point.

If region is active, restrict uncommenting at region "
  (interactive "*")
  (save-excursion
    (save-restriction
      (when (use-region-p)
        (narrow-to-region (region-beginning) (region-end)))
      (let* (last
             (beg (or beg (save-excursion
                            (while (and (ar-backward-comment) (setq last (point))(prog1 (forward-line -1)(end-of-line))))
                            last))))
        (and (ar-forward-comment))
        (ar--uncomment-intern beg (point))))))

(defun ar-load-named-shells ()
  (interactive)
  (dolist (ele ar-known-shells)
    (let ((erg (ar-install-named-shells-fix-doc ele)))
      (eval (fset (car (read-from-string ele)) (car
                                                (read-from-string (concat "(lambda (&optional dedicated args) \"Start a `" erg "' interpreter.
Optional DEDICATED: with \\\\[universal-argument] start in a new
dedicated shell.
Optional ARGS overriding `py-" ele "-command-args'.

Calls ‘ar-shell’
\"
  (interactive \"p\") (ar-shell dedicated args nil \""ele"\"))")))))))
  (when (functionp (car (read-from-string (car-safe ar-known-shells))))
    (when ar-verbose-p (message "ar-load-named-shells: %s" "installed named-shells"))))

;; (ar-load-named-shells)

(defun ar-load-file (file-name)
  "Load a SOME file FILE-NAME into the SOME process.

If the file has extension ‘.py’ import or reload it as a module.
Treating it as a module keeps the global namespace clean, provides
function location information for debugging, and supports users of
module-qualified names."
  (interactive "f")
  (ar--execute-file-base file-name (get-buffer-process (get-buffer (ar-shell)))))

;;  Hooks
;;  arrange to kill temp files when Emacs exists

(when ar--warn-tmp-files-left-p
  (add-hook 'ar-mode-hook (quote ar--warn-tmp-files-left)))

(defun ar-guess-pdb-path ()
  "If ar-pdb-path is not set, find location of pdb.py. "
  (interactive)
  (let ((ele (split-string (shell-command-to-string "whereis SomeMode")))
        erg)
    (while (or (not erg)(string= "" erg))
      (when (and (string-match "^/" (car ele)) (not (string-match "/man" (car ele))))
        (setq erg (shell-command-to-string (concat "find " (car ele) " -type f -name \"pdb.py\""))))
      (setq ele (cdr ele)))
    (if erg
        (message "%s" erg)
      (message "%s" "pdb.py not found, please customize ‘ar-pdb-path’"))
    erg))

(if ar-mode-output-map
    nil
  (setq ar-mode-output-map (make-sparse-keymap))
  (define-key ar-mode-output-map [button2]  (quote ar-mouseto-exception))
  (define-key ar-mode-output-map "\C-c\C-c" (quote ar-goto-exception))
  ;; TBD: Disable all self-inserting keys.  This is bogus, we should
  ;; really implement this as *SOME Output* buffer being read-only
  (mapc #' (lambda (key)
             (define-key ar-mode-output-map key
               #'(lambda () (interactive) (beep))))
           (where-is-internal 'self-insert-command)))

(defun ar-toggle-comment-auto-fill (&optional arg)
  "Toggles comment-auto-fill mode"
  (interactive "P")
  (if (or (and arg (< 0 (prefix-numeric-value arg)))
          (and (boundp (quote ar-comment-auto-fill-p))(not ar-comment-auto-fill-p)))
      (progn
        (set (make-local-variable (quote ar-comment-auto-fill-p)) t)
        (setq fill-column ar-comment-fill-column)
        (auto-fill-mode 1))
    (set (make-local-variable (quote ar-comment-auto-fill-p)) nil)
    (auto-fill-mode -1)))

(defun ar-comment-auto-fill-on ()
  (interactive)
  (ar-toggle-comment-auto-fill 1))

(defun ar-comment-auto-fill-off ()
  (interactive)
  (ar-toggle-comment-auto-fill -1))

(defun ar--set-auto-fill-values ()
  "Internal use by ‘ar--run-auto-fill-timer’"
  (let ((pps (parse-partial-sexp (point-min) (point))))
    (cond ((and (nth 4 pps)(numberp ar-comment-fill-column))
           (setq fill-column ar-comment-fill-column))
          ((and (nth 3 pps)(numberp ar-docstring-fill-column))
           (setq fill-column ar-docstring-fill-column))
          (t (setq fill-column ar-fill-column-orig)))))

(defun ar--run-auto-fill-timer ()
  "Set fill-column to values according to environment.

‘ar-docstring-fill-column’ resp. to ‘ar-comment-fill-column’."
  (when ar-auto-fill-mode
    (unless ar-autofill-timer
      (setq ar-autofill-timer
            (run-with-idle-timer
             ar-autofill-timer-delay t
             (quote ar--set-auto-fill-values))))))

;;  unconditional Hooks
;;  (orgstruct-mode 1)
(declare-function ar-complete "pycomplete" ())
(defun ar-complete-auto ()
  "Auto-complete function using ar-complete. "
  ;; disable company
  ;; (when company-mode (company-mode))
  (let ((modified (buffer-chars-modified-tick)))
    ;; do not try completion if buffer was not modified
    (unless (eq modified ar-complete-last-modified)
      (if ar-auto-completion-mode-p
          (if (string= "*SOMECompletions*" (buffer-name (current-buffer)))
              (sit-for 0.1 t)
            (if
                (eq ar-auto-completion-buffer (current-buffer))
                ;; not after whitespace, TAB or newline
                (unless (member (char-before) (list 32 9 10))
                  (ar-complete)
                  (setq ar-complete-last-modified (buffer-chars-modified-tick)))
              (setq ar-auto-completion-mode-p nil
                    ar-auto-completion-buffer nil)
              (cancel-timer ar--auto-complete-timer)))))))

;;  End-of- p

;;  Opens
(defun ar--statement-opens-block-p (&optional regexp)
  "Return position if the current statement opens a block
in stricter or wider sense.

For stricter sense specify regexp. "
  (let* ((regexp (or regexp ar-block-or-clause-re))
         (erg (ar--statement-opens-base regexp)))
    erg))

(defun ar--statement-opens-base (regexp)
  (let ((orig (point))
        erg)
    (save-excursion
      (back-to-indentation)
      (ar-forward-statement)
      (ar-backward-statement)
      (when (and
             (<= (line-beginning-position) orig)(looking-back "^[ \t]*" (line-beginning-position))(looking-at regexp))
        (setq erg (point))))
    erg))

(defun ar--statement-opens-clause-p ()
  "Return position if the current statement opens block or clause. "
  (ar--statement-opens-base ar-clause-re))

(defun ar--statement-opens-block-or-clause-p ()
  "Return position if the current statement opens block or clause. "
  (ar--statement-opens-base ar-block-or-clause-re))

(defun ar--statement-opens-class-p ()
  "If the statement opens a functions or class.

Return ‘t’, nil otherwise. "
  (ar--statement-opens-base ar-class-re))

(defun ar--statement-opens-def-p ()
  "If the statement opens a functions or class.
Return ‘t’, nil otherwise. "
  (ar--statement-opens-base ar-def-re))

(defun ar--statement-opens-def-or-class-p ()
  "If the statement opens a functions or class definition.
Return ‘t’, nil otherwise. "
  (ar--statement-opens-base ar-def-or-class-re))

(defun ar--down-top-level (&optional regexp)
  "Go to the end of a top-level form.

When already at end, go to EOB."
  (end-of-line)
  (while (and (ar--forward-regexp (or regexp "^[[:graph:]]"))
              (save-excursion
                (beginning-of-line)
                (or
                 (looking-at ar-clause-re)
                 (looking-at comment-start)))))
  (beginning-of-line)
  (and (looking-at regexp) (point)))

(defun ar--end-of-paragraph (regexp)
  (let* ((regexp (if (symbolp regexp) (symbol-value regexp)
                   regexp)))
    (while (and (not (eobp)) (re-search-forward regexp nil 'move 1) (nth 8 (parse-partial-sexp (point-min) (point)))))))

(defun ar--look-downward-for-beginning (regexp)
  "When above any beginning of FORM, search downward. "
  (let* ((orig (point))
         (erg orig)
         pps)
    (while (and (not (eobp)) (re-search-forward regexp nil t 1) (setq erg (match-beginning 0)) (setq pps (parse-partial-sexp (point-min) (point)))
                (or (nth 8 pps) (nth 1 pps))))
    (cond ((not (or (nth 8 pps) (nth 1 pps) (or (looking-at comment-start))))
           (when (ignore-errors (< orig erg))
             erg)))))

(defun ar-look-downward-for-clause (&optional ind orig regexp)
  "If beginning of other clause exists downward in current block.

If succesful return position. "
  (interactive)
  (unless (eobp)
    (let ((ind (or ind
                   (save-excursion
                     (ar-backward-statement)
                     (if (ar--statement-opens-block-p)
                         (current-indentation)
                       (- (current-indentation) ar-indent-offset)))))
          (orig (or orig (point)))
          (regexp (or regexp ar-extended-block-or-clause-re))
          erg)
      (end-of-line)
      (when (re-search-forward regexp nil t 1)
        (when (nth 8 (parse-partial-sexp (point-min) (point)))
          (while (and (re-search-forward regexp nil t 1)
                      (nth 8 (parse-partial-sexp (point-min) (point))))))
        ;; (setq last (point))
        (back-to-indentation)
        (unless (and (looking-at ar-clause-re)
                     (not (nth 8 (parse-partial-sexp (point-min) (point)))) (eq (current-indentation) ind))
          (progn (setq ind (current-indentation))
                 (while (and (ar-forward-statement-bol)(not (looking-at ar-clause-re))(<= ind (current-indentation)))))
          (if (and (looking-at ar-clause-re)
                   (not (nth 8 (parse-partial-sexp (point-min) (point))))
                   (< orig (point)))
              (setq erg (point))
            (goto-char orig))))
      erg)))

(defun ar-current-defun ()
  "Go to the outermost method or class definition in current scope.

SOME value for ‘add-log-current-defun-function’.
This tells add-log.el how to find the current function/method/variable.
Returns name of class or methods definition, if found, nil otherwise.

See customizable variables ‘ar-current-defun-show’ and ‘ar-current-defun-delay’."
  (interactive)
  (save-restriction
    (widen)
    (save-excursion
      (let ((erg (when (ar-backward-def-or-class)
                   (forward-word 1)
                   (skip-chars-forward " \t")
                   (prin1-to-string (symbol-at-point)))))
        (when (and erg ar-current-defun-show)
          (push-mark (point) t t) (skip-chars-forward "^ (")
          (exchange-point-and-mark)
          (sit-for ar-current-defun-delay t))
        erg))))

(defun ar--join-words-wrapping (words separator prefix line-length)
  (let ((lines ())
        (current-line prefix))
    (while words
      (let* ((word (car words))
             (maybe-line (concat current-line word separator)))
        (if (> (length maybe-line) line-length)
            (setq lines (cons (substring current-line 0 -1) lines)
                  current-line (concat prefix word separator " "))
          (setq current-line (concat maybe-line " "))))
      (setq words (cdr words)))
    (setq lines (cons (substring current-line 0 (- 0 (length separator) 1)) lines))
    (mapconcat 'identity (nreverse lines) "\n")))

(defun ar-sort-imports ()
  "Sort multiline imports.

Put point inside the parentheses of a multiline import and hit
\\[py-sort-imports] to sort the imports lexicographically"
  (interactive)
  (save-excursion
    (let ((open-paren (ignore-errors (save-excursion (progn (up-list -1) (point)))))
          (close-paren (ignore-errors (save-excursion (progn (up-list 1) (point)))))
          sorted-imports)
      (when (and open-paren close-paren)
        (goto-char (1+ open-paren))
        (skip-chars-forward " \n\t")
        (setq sorted-imports
              (sort
               (delete-dups
                (split-string (buffer-substring
                               (point)
                               (save-excursion (goto-char (1- close-paren))
                                               (skip-chars-backward " \n\t")
                                               (point)))
                              ", *\\(\n *\\)?"))
               ;; XXX Should this sort case insensitively?
               'string-lessp))
        ;; Remove empty strings.
        (delete-region open-paren close-paren)
        (goto-char open-paren)
        (insert "(\n")
        (insert (ar--join-words-wrapping (remove "" sorted-imports) "," "    " 78))
        (insert ")")))))

(defun ar--in-literal (&optional lim)
  "Return non-nil if point is in a SOME literal (a comment or string).
Optional argument LIM indicates the beginning of the containing form,
i.e. the limit on how far back to scan."
  (let* ((lim (or lim (point-min)))
         (state (parse-partial-sexp lim (point))))
    (cond
     ((nth 3 state) 'string)
     ((nth 4 state) 'comment))))

(defconst ar-help-address "SomeMode-mode@SomeMode.org"
  "List dealing with usage and developing SomeMode-mode.

Also accepts submission of bug reports, whilst a ticket at
‘https://github.com/andreas-roehler/emacs-generics/SomeMode-mode/-/issues’
is preferable for that. ")

;;  Utilities

(defun ar-install-local-shells (&optional local)
  "Builds SOME-shell commands from executable found in LOCAL.

If LOCAL is empty, shell-command ‘find’ searches beneath current directory.
Eval resulting buffer to install it, see customizable ‘ar-extensions’. "
  (interactive)
  (let* ((local-dir (if local
                        (expand-file-name local)
                      (read-from-minibuffer "Virtualenv directory: " default-directory)))
         (path-separator (if (string-match "/" local-dir)
                             "/"
                           "\\" t))
         (shells (split-string (shell-command-to-string (concat "find " local-dir " -maxdepth 9 -type f -executable -name \"*SomeMode\""))))
         prefix end orig curexe aktpath)
    (set-buffer (get-buffer-create ar-extensions))
    (erase-buffer)
    (dolist (elt shells)
      (setq prefix "")
      (setq curexe (substring elt (1+ (string-match "/[^/]+$" elt))))
      (setq aktpath (substring elt 0 (1+ (string-match "/[^/]+$" elt))))
      (dolist (prf (split-string aktpath (regexp-quote path-separator)))
        (unless (string= "" prf)
          (setq prefix (concat prefix (substring prf 0 1)))))
      (setq orig (point))
      (insert ar-shell-template)
      (setq end (point))
      (goto-char orig)
      (when (re-search-forward "\\<NAME\\>" end t 1)
        (replace-match (concat prefix "-" (substring elt (1+ (save-match-data (string-match "/[^/]+$" elt)))))t))
      (goto-char orig)
      (while (search-forward "DOCNAME" end t 1)
        (replace-match (if (string= "iSomeMode" curexe)
                           "ISOME"
                         (capitalize curexe)) t))
      (goto-char orig)
      (when (search-forward "FULLNAME" end t 1)
        (replace-match elt t))
      (goto-char (point-max)))
    (emacs-lisp-mode)
    (if (file-readable-p (concat ar-install-directory "/" ar-extensions))
        (find-file (concat ar-install-directory "/" ar-extensions)))))

(defun ar--until-found (search-string liste)
  "Search liste for search-string until found. "
  (let ((liste liste) element)
    (while liste
      (if (member search-string (car liste))
          (setq element (car liste) liste nil))
      (setq liste (cdr liste)))
    (when element
      (while (and element (not (numberp element)))
        (if (member search-string (car element))
            (setq element (car element))
          (setq element (cdr element))))
      element)))

(defun ar--report-end-marker (process)
  ;; (message "ar--report-end-marker in %s" (current-buffer))
  (if (derived-mode-p 'comint-mode)
      (if (bound-and-true-p comint-last-prompt)
          (car-safe comint-last-prompt)
        (dotimes (_ 3) (when (not (bound-and-true-p comint-last-prompt))(sit-for 1 t)))
        (and (bound-and-true-p comint-last-prompt)
             (car-safe comint-last-prompt)))
    (if (markerp (process-mark process))
        (process-mark process)
      (progn
        (dotimes (_ 3) (when (not (markerp (process-mark process)))(sit-for 1 t)))
        (process-mark process)))))

(defun ar-which-def-or-class (&optional orig)
  "Returns concatenated ‘def’ and ‘class’ names.

In hierarchical order, if cursor is inside.

Returns \"???\" otherwise
Used by variable ‘which-func-functions’ "
  (interactive)
  (let* ((orig (or orig (point)))
         (backindent 99999)
         (re ar-def-or-class-re
          ;; (concat ar-def-or-class-re "\\([[:alnum:]_]+\\)")
          )
         erg forward indent backward limit)
    (if
        (and (looking-at re)
             (not (nth 8 (parse-partial-sexp (point-min) (point)))))
        (progn
          (setq erg (list (match-string-no-properties 2)))
          (setq backindent (current-indentation)))
      ;; maybe inside a definition's symbol
      (or (eolp) (and (looking-at "[[:alnum:]]")(forward-word 1))))
    (if
        (and (not (and erg (eq 0 (current-indentation))))
             (setq limit (ar-backward-top-level))
             (looking-at re))
        (progn
          (push (match-string-no-properties 2)  erg)
          (setq indent (current-indentation)))
      (goto-char orig)
      (while (and
              (re-search-backward ar-def-or-class-re limit t 1)
              (< (current-indentation) backindent)
              (setq backindent (current-indentation))
              (setq backward (point))
              (or (< 0 (current-indentation))
                  (nth 8 (parse-partial-sexp (point-min) (point))))))
      (when (and backward
                 (goto-char backward)
                 (looking-at re))
        (push (match-string-no-properties 2)  erg)
        (setq indent (current-indentation))))
    ;; (goto-char orig))
    (if erg
        (progn
          (end-of-line)
          (while (and (re-search-forward ar-def-or-class-re nil t 1)
                      (<= (point) orig)
                      (< indent (current-indentation))
                      (or
                       (nth 8 (parse-partial-sexp (point-min) (point)))
                       (setq forward (point)))))
          (if forward
              (progn
                (goto-char forward)
                (save-excursion
                  (back-to-indentation)
                  (and (looking-at re)
                       (setq erg (list (car erg) (match-string-no-properties 2)))
                       ;; (< (ar-forward-def-or-class) orig)
                       ;; if match was beyond definition, nil
                       ;; (setq erg nil)
)))
            (goto-char orig))))
    (if erg
        (if (< 1 (length erg))
            (setq erg (mapconcat 'identity erg "."))
          (setq erg (car erg)))
      (setq erg "???"))
    (goto-char orig)
    erg))

(defun ar--fetch-first-SomeMode-buffer ()
  "Returns first (I)SOME-buffer found in ‘buffer-list’"
  (let ((buli (buffer-list))
        erg)
    (while (and buli (not erg))
      (if (string-match "SOME" (prin1-to-string (car buli)))
          (setq erg (car buli))
        (setq buli (cdr buli))))
    erg))

(defun ar-unload-SomeMode-el ()
  "Unloads SomeMode-mode delivered by shipped SomeMode.el

Removes SomeMode-skeleton forms from abbrevs.
These would interfere when inserting forms heading a block"
  (interactive)
  (let (done)
    (when (featurep 'SomeMode) (unload-feature 'SomeMode t))
    (when (file-readable-p abbrev-file-name)
      (find-file abbrev-file-name)
      (goto-char (point-min))
      (while (re-search-forward "^.+SomeMode-skeleton.+$" nil t 1)
        (setq done t)
        (delete-region (match-beginning 0) (1+ (match-end 0))))
      (when done (write-file abbrev-file-name)
            ;; now reload
            (read-abbrev-file abbrev-file-name))
      (kill-buffer (file-name-nondirectory abbrev-file-name)))))

;; (defmacro ar-kill-buffer-unconditional (buffer)
;;   "Kill buffer unconditional, kill buffer-process if existing. "
;;   `(let ((proc (get-buffer-process ,buffer))
;;          kill-buffer-query-functions)
;;      (ignore-errors
;;        (and proc (kill-process proc))
;;        (set-buffer ,buffer)
;;        (set-buffer-modified-p 'nil)
;;        (kill-buffer (current-buffer)))))

(defun ar-down-top-level ()
  "Go to beginning of next top-level form downward.

Returns position if successful, nil otherwise"
  (interactive)
  (let ((orig (point))
        erg)
    (while (and (not (eobp))
                (progn (end-of-line)
                       (re-search-forward "^[[:alpha:]_'\"]" nil 'move 1))
                (nth 8 (parse-partial-sexp (point-min) (point)))))
    (when (and (not (eobp)) (< orig (point)))
      (goto-char (match-beginning 0))
        (setq erg (point)))
    erg))

(defun ar-forward-top-level-bol ()
  "Go to end of top-level form at point, stop at next beginning-of-line.

Returns position successful, nil otherwise"
  (interactive)
  (let (erg)
    (ar-forward-top-level)
    (unless (or (eobp) (bolp))
      (forward-line 1)
      (beginning-of-line)
      (setq erg (point)))
    erg))

(defun ar-down ()
  "Go to beginning one level below.

Of compound statement or definition at point.

When inside a string, list or comment, jump to its end.
Repeated call from there will behave like down-list.

Returns position if successful, nil otherwise"
  (interactive)
  (let ((orig (point))
        (pps (parse-partial-sexp (point-min) (point))))
    (cond ((eq (syntax-class (syntax-after (point))) 4)
           (forward-sexp))
          ((nth 4 pps)
           (ar-forward-comment))
          ((nth 3 pps)
           (goto-char (nth 8 pps))
           (forward-sexp))
          ((nth 1 pps)
           (goto-char (nth 1 pps))
           (forward-sexp))
          ((or (eq (car (syntax-after orig)) 15)
               (eq (car (syntax-after orig)) 4))
           (forward-sexp))
          ((not (ar--beginning-of-statement-p))
           (ar-backward-statement)
           (cond ((ar--beginning-of-class-p)
                  (ar-forward-class))
                 ((ar--beginning-of-def-p)
                  (ar-forward-def))
                 ((ar--beginning-of-block-p)
                  (ar-forward-block))
                 ((ar--beginning-of-clause-p)
                  (ar-forward-clause))))
          ((ar--beginning-of-class-p)
           (ar-forward-class))
          ((ar--beginning-of-def-p)
           (ar-forward-def))
          ((ar--beginning-of-block-p)
           (ar-forward-block))
          ((ar--beginning-of-clause-p)
           (ar-forward-clause))
          (t
           (ar-forward-statement)))
    (if (< orig (point))
        (point)
      (goto-char orig)
      (end-of-line)
      (skip-chars-forward " \t\r\n\f")
      (if (or (and comment-start (looking-at comment-start)) (and comment-start-skip (looking-at comment-start-skip)))
          (progn
            (goto-char (match-end 0))
            (ar-forward-comment)
            (skip-chars-forward " \t\r\n\f"))
        (ar-down)))))

(defun ar--thing-at-point (form &optional mark-decorators)
  "Returns buffer-substring of string-argument FORM as cons.

Text properties are stripped.
If PY-MARK-DECORATORS, ‘def’- and ‘class’-forms include decorators
If BOL is t, from beginning-of-line"
  (interactive)
  (let* ((begform (intern-soft (concat "ar-backward-" form)))
         (endform (intern-soft (concat "ar-forward-" form)))
         (begcheckform (intern-soft (concat "ar--beginning-of-" form "-p")))
         (orig (point))
         beg end erg)
    (setq beg (if
                  (setq beg (funcall begcheckform))
                  beg
                (funcall begform)))
    (and mark-decorators
         (and (setq erg (ar-backward-decorator))
              (setq beg erg)))
    (setq end (funcall endform))
    (unless end (when (< beg (point))
                  (setq end (point))))
    (if (and beg end (<= beg orig) (<= orig end))
        (buffer-substring-no-properties beg end)
      nil)))

(defun ar--thing-at-point-bol (form &optional mark-decorators)
  (let* ((begform (intern-soft (concat "ar-backward-" form "-bol")))
         (endform (intern-soft (concat "ar-forward-" form "-bol")))
         (begcheckform (intern-soft (concat "ar--beginning-of-" form "-bol-p")))
         beg end erg)
    (setq beg (if
                  (setq beg (funcall begcheckform))
                  beg
                (funcall begform)))
    (when mark-decorators
      (save-excursion
        (when (setq erg (ar-backward-decorator))
          (setq beg erg))))
    (setq end (funcall endform))
    (unless end (when (< beg (point))
                  (setq end (point))))
    (cons beg end)))

(defun ar--mark-base (form &optional mark-decorators)
  "Returns boundaries of FORM, a cons.

If PY-MARK-DECORATORS, ‘def’- and ‘class’-forms include decorators
If BOL is t, mark from beginning-of-line"
  (let* ((begform (intern-soft (concat "ar-backward-" form)))
         (endform (intern-soft (concat "ar-forward-" form)))
         (begcheckform (intern-soft (concat "ar--beginning-of-" form "-p")))
         (orig (point))
         beg end erg)
    (setq beg (if
                  (setq beg (funcall begcheckform))
                  beg
                (funcall begform)))
    (and mark-decorators
         (and (setq erg (ar-backward-decorator))
              (setq beg erg)))
    (push-mark)
    (setq end (funcall endform))
    (unless end (when (< beg (point))
                  (setq end (point))))
    (if (and beg end (<= beg orig) (<= orig end))
        (progn
          (cons beg end)
          (exchange-point-and-mark))
      nil)))

(defun ar--mark-base-bol (form &optional mark-decorators)
  (let* ((begform (intern-soft (concat "ar-backward-" form "-bol")))
         (endform (intern-soft (concat "ar-forward-" form "-bol")))
         (begcheckform (intern-soft (concat "ar--beginning-of-" form "-bol-p")))
         beg end erg)
    (if (functionp begcheckform)
        (or (setq beg (funcall begcheckform))
            (if (functionp begform)
                (setq beg (funcall begform))
              (error (concat "ar--mark-base-bol: " begform " do not exist!" ))))
      (error (concat "ar--mark-base-bol: " begcheckform " do not exist!" )))
    (when mark-decorators
      (save-excursion
        (when (setq erg (ar-backward-decorator))
          (setq beg erg))))
    (if (functionp endform)
        (setq end (funcall endform))
      (error (concat "ar--mark-base-bol: " endform " do not exist!" )))
    (push-mark beg t t)
    (unless end (when (< beg (point))
                  (setq end (point))))
    (cons beg end)))

(defun ar-mark-base (form &optional mark-decorators)
  "Calls ar--mark-base, returns bounds of form, a cons. "
  (let* ((bounds (ar--mark-base form mark-decorators))
         (beg (car bounds)))
    (push-mark beg t t)
    bounds))

(defun ar-backward-same-level-intern (indent)
  (while (and
          (ar-backward-statement)
          (< indent (current-indentation) ))))

(defun ar-backward-same-level ()
  "Go form backward keeping indent level if possible.

If inside a delimited form --string or list-- go to its beginning.
If not at beginning of a statement or block, go to its beginning.
If at beginning of a statement or block,
go to previous beginning of at point.
If no further element at same level, go one level up."
  (interactive)
  (let* ((pps (parse-partial-sexp (point-min) (point)))
         (erg (cond ((nth 8 pps) (goto-char (nth 8 pps)))
                    ((nth 1 pps) (goto-char (nth 1 pps)))
                    (t (if (eq (current-column) (current-indentation))
                           (ar-backward-same-level-intern (current-indentation))
                         (back-to-indentation)
                         (ar-backward-same-level))))))
    erg))

;; (defun ar-forward-same-level ()
;;   "Go form forward keeping indent level if possible.

;; If inside a delimited form --string or list-- go to its beginning.
;; If not at beginning of a statement or block, go to its beginning.
;; If at beginning of a statement or block, go to previous beginning.
;; If no further element at same level, go one level up."
;;   (interactive)
;;   (let (erg)
;;     (unless (ar--beginning-of-statement-p)
;;       (ar-backward-statement))
;;     (setq erg (ar-down (current-indentation)))
;;     erg))

(defun ar--end-of-buffer-p ()
  "Returns position, if cursor is at the end of buffer, nil otherwise. "
  (when (eobp)(point)))

(defun ar-sectionize-region (&optional beg end)
  "Markup code in region as section.

Use current region unless optional args BEG END are delivered."
  (interactive "*")
  (let ((beg (or beg (region-beginning)))
        (end (or (and end (copy-marker end)) (copy-marker (region-end)))))
    (save-excursion
      (goto-char beg)
      (unless (ar-empty-line-p) (split-line))
      ;; (beginning-of-line)
      (insert ar-section-start)
      (goto-char end)
      (unless (ar-empty-line-p) (newline 1))
      (indent-according-to-mode)
      (insert ar-section-end))))

(defun ar-execute-section-prepare (&optional shell)
  "Execute section at point. "
  (save-excursion
    (let ((start (when (or (ar--beginning-of-section-p)
                           (ar-backward-section))
                   (forward-line 1)
                   (beginning-of-line)
                   (point))))
      (if (and start (ar-forward-section))
          (progn
            (beginning-of-line)
            (skip-chars-backward " \t\r\n\f")
            (if shell
                (funcall (car (read-from-string (concat "ar-execute-region-" shell))) start (point))
              (ar-execute-region start (point))))
        (error "Can not see ‘ar-section-start’ resp. ‘ar-section-end’")))))

(defun ar--narrow-prepare (name)
  "Used internally. "
  (save-excursion
    (let ((start (cond ((string= name "statement")
                        (if (ar--beginning-of-statement-p)
                            (point)
                          (ar-backward-statement-bol)))
                       ((funcall (car (read-from-string (concat "ar--statement-opens-" name "-p")))))
                       (t (funcall (car (read-from-string (concat "ar-backward-" name))))))))
      (funcall (car (read-from-string (concat "ar-forward-" name))))
      ;; (sit-for 1)
      (narrow-to-region (point) start))))

(defun ar--forms-report-result (erg &optional iact)
  (let ((res (ignore-errors (buffer-substring-no-properties (car-safe erg) (cdr-safe erg)))))
    (when (and res iact)
      (goto-char (car-safe erg))
      (set-mark (point))
      (goto-char (cdr-safe erg)))
    res))

(defun ar-toggle-shell-fontification (msg)
  "Toggles value of ‘ar-shell-fontify-p’. "
  (interactive "p")

  (if (setq ar-shell-fontify-p (not ar-shell-fontify-p))
      (progn
        (ar-shell-font-lock-turn-on))
    (ar-shell-font-lock-turn-off))
    (when msg (message "ar-shell-fontify-p set to: %s" ar-shell-fontify-p)))

(defun ar-toggle-execute-use-temp-file ()
  (interactive)
  (setq ar--execute-use-temp-file-p (not ar--execute-use-temp-file-p)))

(defun ar--close-intern (regexp)
  "Core function, internal used only. "
  (let ((cui (and
              (or (and (looking-at (symbol-value regexp))
                       (not (nth 8 (parse-partial-sexp (point-min) (point)))))
                       (ar--go-to-keyword regexp)
                       (current-indentation))
              (current-indentation))))
    (when ar-verbose-p (message "%s" cui))
    (ar--end-base regexp (point))
    (forward-line 1)
    (if ar-close-provides-newline
        (unless (ar-empty-line-p) (split-line))
      (fixup-whitespace))
    (indent-to-column cui)))

(defun ar--backward-regexp-fast (regexp)
  "Search backward next regexp not in string or comment.

Return and move to match-beginning if successful"
  (save-match-data
    (let (last)
      (while (and
              (re-search-backward regexp nil 'move 1)
              (setq last (match-beginning 0))
              (nth 8 (parse-partial-sexp (point-min) (point)))))
      (unless (nth 8 (parse-partial-sexp (point-min) (point)))
        last))))

(defun ar-indent-and-forward (&optional indent)
  "Indent current line according to mode, move one line forward.

If optional INDENT is given, use it"
  (interactive "*")
  (beginning-of-line)
  (when (member (char-after) (list 32 9 10 12 13)) (delete-region (point) (progn (skip-chars-forward " \t\r\n\f")(point))))
  (indent-to (or indent (ar-compute-indentation)))
  (if (eobp)
      (newline-and-indent)
    (forward-line 1))
  (back-to-indentation))

(defun ar--indent-line-by-line (beg end)
  "Indent every line until end to max reasonable extend.

Starts from second line of region specified
BEG END deliver the boundaries of region to work within"
  (goto-char beg)
  (ar-indent-and-forward)
  ;; (forward-line 1)
  (while (< (line-end-position) end)
    (if (ar-empty-line-p)
        (forward-line 1)
      (ar-indent-and-forward)))
  (unless (ar-empty-line-p) (ar-indent-and-forward)))

(defun ar-indent-region (&optional beg end no-check)
  "Reindent a region delimited by BEG END.

In case first line accepts an indent, keep the remaining
lines relative.
Otherwise lines in region get outmost indent,
same with optional argument

In order to shift a chunk of code, start with second line.

Optional BEG: used by tests
Optional END: used by tests
Optional NO-CHECK: used by tests
"
  (interactive "*")

  (let ((end
         ;; work around a bug in Emacs' ‘end-of-defun’, which fiddles
         ;; after ‘end-of-defun-function’ is called
         ;; See ‘ar-ert-borks-all-lp-1294820-sIKMyz’ test
         (if (and (and end (save-excursion (goto-char end) (looking-at ar-block-or-clause-re))))
             (copy-marker (- end 1))
           (copy-marker (or end (region-end) (line-end-position)))))
        (beg (or beg (region-beginning) (line-beginning-position))))
    (goto-char beg)
    (ar--indent-line-by-line beg end)))

(defun ar-find-imports ()
  "Find top-level imports.

Returns imports"
  (interactive)
  (let (imports erg)
    (save-excursion
      (if (eq major-mode 'comint-mode)
          (progn
            (re-search-backward comint-prompt-regexp nil t 1)
            (goto-char (match-end 0))
            (while (re-search-forward
                    "import *[A-Za-z_][A-Za-z_0-9].*\\|^from +[A-Za-z_][A-Za-z_0-9.]+ +import .*" nil t)
              (setq imports
                    (concat
                     imports
                     (replace-regexp-in-string
                      "[\\]\r?\n?\s*" ""
                      (buffer-substring-no-properties (match-beginning 0) (point))) ";")))
            (when (ignore-errors (string-match ";" imports))
              (setq imports (split-string imports ";" t))
              (dolist (ele imports)
                (and (string-match "import" ele)
                     (if erg
                         (setq erg (concat erg ";" ele))
                       (setq erg ele)))
                (setq imports erg))))
        (goto-char (point-min))
        (while (re-search-forward
                "^import *[A-Za-z_][A-Za-z_0-9].*\\|^from +[A-Za-z_][A-Za-z_0-9.]+ +import .*" nil t)
          (unless (ar--end-of-statement-p)
            (ar-forward-statement))
          (setq imports
                (concat
                 imports
                 (replace-regexp-in-string
                  "[\\]\r*\n*\s*" ""
                  (buffer-substring-no-properties (match-beginning 0) (point))) ";")))))
    ;; (and imports
    ;; (setq imports (replace-regexp-in-string ";$" "" imports)))
    (when (and ar-verbose-p (called-interactively-p 'any)) (message "%s" imports))
    imports))

(provide 'ar-intern)
 ;;;  ar-intern.el ends here
