;;; ar-electric.el --- SOME-mode electric inserts  -*- lexical-binding: t; -*-
(defun ar-electric-colon (arg)
  "Insert a colon and indent accordingly.

If a numeric argument ARG is provided, that many colons are inserted
non-electrically.

Electric behavior is inhibited inside a string or
comment or by universal prefix \\[universal-argument].

Switched by ‘ar-electric-colon-active-p’, default is nil
See also ‘ar-electric-colon-greedy-p’"
  (interactive "*P")
  (cond
   ((not ar-electric-colon-active-p)
    (self-insert-command (prefix-numeric-value arg)))
   ;;
   ((and ar-electric-colon-bobl-only
         (save-excursion
           (ar-backward-statement)
           (not (ar--beginning-of-block-p))))
    (self-insert-command (prefix-numeric-value arg)))
   ;;
   ((eq 4 (prefix-numeric-value arg))
    (self-insert-command 1))
   ;;
   (t
    (insert ":")
    (unless (ar-in-string-or-comment-p)
      (let ((orig (copy-marker (point)))
            (indent (ar-compute-indentation)))
        (unless (or (eq (current-indentation) indent)
                    (and ar-electric-colon-greedy-p
                         (eq indent
                             (save-excursion
                               (ar-backward-statement)
                               (current-indentation))))
                    (and (looking-at ar-def-or-class-re)
                         (< (current-indentation) indent)))
          (beginning-of-line)
          (delete-horizontal-space)
          (indent-to indent))
        (goto-char orig))
      (when ar-electric-colon-newline-and-indent-p
        (ar-newline-and-indent))))))

;; TODO: PRouleau: I would like to better understand this.
;;                 I do not understand the docstring.
;;                 What was the completion bug this is reacting to?
(defun ar-electric-close (arg)
  "Close completion buffer when no longer needed.

It is its sure, its no longer needed, i.e. when inserting a space.

Works around a bug in ‘choose-completion’."

  (interactive "*P")
  (cond
   ((not ar-electric-close-active-p)
    (self-insert-command (prefix-numeric-value arg)))
   ;;
   ((eq 4 (prefix-numeric-value arg))
    (self-insert-command 1))
   ;;
   (t (if (called-interactively-p 'any)
          (self-insert-command (prefix-numeric-value arg))
        ;; used from dont-indent-code-unnecessarily-lp-1048778-test
        (insert " ")))))

;; TODO: PRouleau: describe the electric behavior of '#'.
;;       This description should be in docstring of the
;;       ‘ar-electric-comment-p’ user option and be referred to here.
;;       I currently do not understand what it should be and prefer not
;;       having to infer it from code.
;;       - From what I saw, the intent is to align the comment being
;;         typed to the one on line above or at the indentation level.
;;         - Is there more to it it than that?
;;         - I would like to see the following added (possibly via options):
;;           - When inserting the '#' follow it with a space, such that
;;             comment text is separated from the leading '#' by one space, as
;;             recommended in PEP-8
;;             URL https://www.SomeMode.org/dev/peps/pep-0008/#inline-comments
(defun ar-electric-comment (arg)
  "Insert a comment.  If starting a comment, indent accordingly.

If a numeric argument ARG is provided, that many \"#\" are inserted
non-electrically.
With \\[universal-argument] \"#\" electric behavior is inhibited inside a
string or comment."
  (interactive "*P")
  (if (and ar-indent-comments ar-electric-comment-p)
      (if (ignore-errors (eq 4 (car-safe arg)))
          (insert "#")
        (when (and (eq last-command (quote ar-electric-comment))
                   (looking-back " " (line-beginning-position)))
          (forward-char -1))
        (if (called-interactively-p 'any)
            (self-insert-command (prefix-numeric-value arg))
          (insert "#"))
        (let ((orig (copy-marker (point)))
              (indent (ar-compute-indentation)))
          (unless (eq (current-indentation) indent)
            (goto-char orig)
            (beginning-of-line)
            (delete-horizontal-space)
            (indent-to indent)
            (goto-char orig))
          (when ar-electric-comment-add-space-p
            (unless (looking-at "[ \t]")
              (insert " "))))
        (setq last-command this-command))
    (self-insert-command (prefix-numeric-value arg))))

;; Electric deletion
(defun ar-empty-out-list-backward ()
  "Deletes all elements from list before point."
  (interactive "*")
  (and (member (char-before) (list ?\) ?\] ?\}))
       (let ((orig (point))
             (thischar (char-before))
             pps cn)
         (forward-char -1)
         (setq pps (parse-partial-sexp (point-min) (point)))
         (if (and (not (nth 8 pps)) (nth 1 pps))
             (progn
               (goto-char (nth 1 pps))
               (forward-char 1))
           (cond ((or (eq thischar 41)(eq thischar ?\)))
                  (setq cn "("))
                 ((or (eq thischar 125) (eq thischar ?\}))
                  (setq cn "{"))
                 ((or (eq thischar 93)(eq thischar ?\]))
                  (setq cn "[")))
           (skip-chars-backward (concat "^" cn)))
         (delete-region (point) orig)
         (insert-char thischar 1)
         (forward-char -1))))

;; TODO: PRouleau Question: [...]

;;       - Also, the mapping for [backspace] in ar-mode-map only works in
;;         graphics mode, it does not work when Emacs runs in terminal mode.
;;         It would be nice to have a binding that works in terminal mode too.
;; keep-one handed over form ‘ar-electric-delete’ maybe
(defun ar-electric-backspace (&optional arg)
  "Delete one or more of whitespace chars left from point.
Honor indentation.

If called at whitespace below max indentation,

Delete region when both variable ‘delete-active-region’ and ‘use-region-p’
are non-nil.

With \\[universal-argument], deactivate electric-behavior this time,
delete just one character before point.

At no-whitespace character, delete one before point.

"
  (interactive "*P")
  (unless (bobp)
    (let ((backward-delete-char-untabify-method 'untabify)
          indent
          done)
      (cond
       ;; electric-pair-mode
       ((and electric-pair-mode
             (or
              (and
               (ignore-errors (eq 5 (car (syntax-after (point)))))
               (ignore-errors (eq 4 (car (syntax-after (1- (point)))))))
              (and
               (ignore-errors (eq 7 (car (syntax-after (point)))))
               (ignore-errors (eq 7 (car (syntax-after (1- (point)))))))))
      (delete-char 1)
      (backward-delete-char-untabify 1))
       ((eq 4 (prefix-numeric-value arg))
        (backward-delete-char-untabify 1))
       ((use-region-p)
        ;; Emacs23 does not know that var
        (if (boundp 'delete-active-region)
            (delete-active-region)
          (delete-region (region-beginning) (region-end))))
       ((looking-back "[[:graph:]]" (line-beginning-position))
        (backward-delete-char-untabify 1))
       ;; before code
       ((looking-back "^[ \t]+" (line-beginning-position))
        (setq indent (ar-compute-indentation))
        (cond ((< indent (current-indentation))
               (back-to-indentation)
               (delete-region (line-beginning-position) (point))
               (indent-to indent))
              ((<=  (current-column) ar-indent-offset)
               (delete-region (line-beginning-position) (point)))
              ((eq 0 (% (current-column) ar-indent-offset))
               (delete-region (point) (progn (backward-char ar-indent-offset) (point))))
              (t (delete-region
                  (point)
                  (progn
                    ;; go backward the remainder
                    (backward-char (% (current-column) ar-indent-offset))
                    (point))))))
       ((looking-back "[[:graph:]][ \t]+" (line-beginning-position))
        ;; in the middle fixup-whitespace
        (setq done (line-end-position))
        (fixup-whitespace)
        ;; if just one whitespace at point, delete that one
        (or (< (line-end-position) done) (delete-char 1)))

       ;; (if (< 1 (abs (skip-chars-backward " \t")))
       ;;                (delete-region (point) (progn (skip-chars-forward " \t") (point)))
       ;;              (delete-char 1))

       ((bolp)
        (delete-char -1))
       (t
        (ar-indent-line nil t))))))

(defun ar-electric-delete (&optional arg)
  "Delete one or more of whitespace chars right from point.
Honor indentation.

Delete region when both variable ‘delete-active-region’ and ‘use-region-p’
are non-nil.

With \\[universal-argument], deactivate electric-behavior this time,
delete just one character at point.

At spaces in line of code, call fixup-whitespace.
At no-whitespace char, delete one char at point.
"
  (interactive "P*")
  (unless (eobp)
    (let* (;; ar-ert-deletes-too-much-lp:1300270-dMegYd
           ;; x = {'abc':'def',
           ;;     'ghi':'jkl'}
           (backward-delete-char-untabify-method 'untabify)
           (indent (ar-compute-indentation))
           ;; (delpos (+ (line-beginning-position) indent))
           ;; (line-end-pos (line-end-position))
           ;; (orig (point))
           done)
      (cond
       ((eq 4 (prefix-numeric-value arg))
        (delete-char 1))
       ;; delete active region if one is active
       ((use-region-p)
        ;; Emacs23 does not know that var
        (if (boundp 'delete-active-region)
            (delete-active-region)
          (delete-region (region-beginning) (region-end))))
       ;; ((looking-at "[[:graph:]]")
       ;;  (delete-char 1))
       ((or (eolp) (looking-at "[ \t]+$"))
        (cond
         ((eolp) (delete-char 1))
         ((< (+ indent (line-beginning-position)) (line-end-position))
          (end-of-line)
          (while (and (member (char-before) (list 9 32 ?\r))
                      (< indent (current-column)))
            (backward-delete-char-untabify 1)))))
       (;; before code
        (looking-at "[ \t]+[[:graph:]]")
        ;; before indent
        (if (looking-back "^[ \t]*" (line-beginning-position))
            (cond ((< indent (current-indentation))
                   (back-to-indentation)
                   (delete-region (line-beginning-position) (point))
                   (indent-to indent))
                  ((< 0 (% (current-indentation) ar-indent-offset))
                   (back-to-indentation)
                   (delete-region (point) (progn (backward-char (% (current-indentation) ar-indent-offset)) (point))))
                  ((eq 0 (% (current-indentation) ar-indent-offset))
                   (back-to-indentation)
                   (delete-region (point) (progn (backward-char ar-indent-offset) (point))))
                  (t
                   (skip-chars-forward " \t")
                   (delete-region (line-beginning-position) (point))))
          ;; in the middle fixup-whitespace
          (setq done (line-end-position))
          (fixup-whitespace)
          ;; if just one whitespace at point, delete that one
          (or (< (line-end-position) done) (delete-char 1))))
       (t (delete-char 1))))))

;; TODO: PRouleau: the electric yank mechanism is currently commented out.
;;       Is this a feature to keep?  Was it used?  I can see a benefit for it.
;;       Why is it currently disabled?
(defun ar-electric-yank (&optional arg)
  "Perform command ‘yank’ followed by an ‘indent-according-to-mode’.
Pass ARG to the command ‘yank’."
  (interactive "P")
  (cond
   (ar-electric-yank-active-p
    (yank arg)
    ;; (ar-indent-line)
    )
   (t
    (yank arg))))

(defun ar-toggle-ar-electric-colon-active ()
  "Toggle use of electric colon for SOME code."
  (interactive)
  (setq ar-electric-colon-active-p (not ar-electric-colon-active-p))
  (when (and ar-verbose-p (called-interactively-p 'interactive)) (message "ar-electric-colon-active-p: %s" ar-electric-colon-active-p)))

(defun ar-toggle-ar-electric-backspace-mode ()
  "Toggle ar-electric-backspace-mode."
  (interactive)
  (setq ar-electric-backspace-mode (not ar-electric-backspace-mode))
  (if ar-electric-backspace-mode  (ar-electric-backspace-mode 1) (ar-electric-backspace-mode -1))
  (when (and ar-verbose-p (called-interactively-p 'interactive)) (message "ar-electric-backspace-mode: %s" ar-electric-backspace-mode)))

(put (quote ar-electric-colon) 'delete-selection t) ;delsel
(put (quote ar-electric-colon) 'pending-delete t) ;pending-del
(put (quote ar-electric-backspace) 'delete-selection 'supersede) ;delsel
(put (quote ar-electric-backspace) 'pending-delete 'supersede) ;pending-del
(put (quote ar-electric-delete) 'delete-selection 'supersede) ;delsel
(put (quote ar-electric-delete) 'pending-delete 'supersede) ;pending-del



(provide 'ar-electric)
;;; ar-electric.el ends here
