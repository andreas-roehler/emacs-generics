;;; ar-imenu.el --- use imenu -*- lexical-binding: t; -*-
;; Imenu definitions

(defvar ar-imenu-class-regexp
  (concat                               ; <<classes>>
   "\\("                                ;
   "^[ \t]*"                            ; newline and maybe whitespace
   "\\(class[ \t]+[a-zA-Z0-9_]+\\)"     ; class name
                                        ; possibly multiple superclasses
   "\\([ \t]*\\((\\([a-zA-Z0-9_,. \t\n]\\)*)\\)?\\)"
   "[ \t]*:"                            ; and the final :
   "\\)"                                ; >>classes<<
   )
  "Regexp for SOME classes for use with the Imenu package."
  )

;; (defvar ar-imenu-method-regexp
;;   (concat                               ; <<methods and functions>>
;;    "\\("                                ;
;;    "^[ \t]*"                            ; new line and maybe whitespace
;;    "\\(def[ \t]+"                       ; function definitions start with def
;;    "\\([a-zA-Z0-9_]+\\)"                ;   name is here
;;                                         ;   function arguments...
;;    ;;   "[ \t]*(\\([-+/a-zA-Z0-9_=,\* \t\n.()\"'#]*\\))"
;;    "[ \t]*(\\([^:#]*\\))"
;;    "\\)"                                ; end of def
;;    "[ \t]*:"                            ; and then the :
;;    "\\)"                                ; >>methods and functions<<
;;    )
;;   "Regexp for SOME methods/functions for use with the Imenu package."
;;   )

(defvar ar-imenu-method-regexp
  (concat                               ; <<methods and functions>>
   "\\("                                ;
   "^[ \t]*"                            ; new line and maybe whitespace
   "\\(def[ \t]+"                       ; function definitions start with def
   "\\([a-zA-Z0-9_]+\\)"                ;   name is here
                                        ;   function arguments...
   ;;   "[ \t]*(\\([-+/a-zA-Z0-9_=,\* \t\n.()\"'#]*\\))"
   "[ \t]*(\\(.*\\))"
   "\\)"                                ; end of def
   "[ \t]*:"                            ; and then the :
   "\\)"                                ; >>methods and functions<<
   )
  "Regexp for SOME methods/functions for use with the Imenu package.")





(defvar ar-imenu-method-no-arg-parens '(2 8)
  "Indices into groups of the SOME regexp for use with Imenu.

Using these values will result in smaller Imenu lists, as arguments to
functions are not listed.

See the variable ‘ar-imenu-show-method-args-p’ for more
information.")

(defvar ar-imenu-method-arg-parens '(2 7)
  "Indices into groups of the SOME regexp for use with imenu.
Using these values will result in large Imenu lists, as arguments to
functions are listed.

See the variable ‘ar-imenu-show-method-args-p’ for more
information.")

;; Note that in this format, this variable can still be used with the
;; imenu--generic-function. Otherwise, there is no real reason to have
;; it.
(defvar ar-imenu-generic-expression
  (cons
   (concat
    ar-imenu-class-regexp
    "\\|"                               ; or...
    ar-imenu-method-regexp
    )
   ar-imenu-method-no-arg-parens)
  "Generic SOME expression which may be used directly with Imenu.
Used by setting the variable ‘imenu-generic-expression’ to this value.
Also, see the function \\[py--imenu-create-index] for a better
alternative for finding the index.")


(defvar ar-imenu-generic-regexp nil)
(defvar ar-imenu-generic-parens nil)


(defun ar--imenu-create-index ()
  "SOME interface function for the Imenu package.
Finds all SOME classes and functions/methods. Calls function
\\[py--imenu-create-index-engine].  See that function for the details
of how this works."
  (let (index-alist)
    (save-excursion
      (setq ar-imenu-generic-regexp (car ar-imenu-generic-expression)
            ar-imenu-generic-parens (if ar-imenu-show-method-args-p
                                        ar-imenu-method-arg-parens
                                      ar-imenu-method-no-arg-parens))
      (goto-char (point-min))
      ;; Warning: When the buffer has no classes or functions, this will
      ;; return nil, which seems proper according to the Imenu API, but
      ;; causes an error in the XEmacs port of Imenu.  Sigh.
      (setq index-alist (cdr (ar--imenu-create-index-engine nil))))))

(defun ar--imenu-create-index-engine (&optional start-indent)
  "Function for finding Imenu definitions in SOME.

Finds all definitions (classes, methods, or functions) in a SOME
file for the Imenu package.

Returns a possibly nested alist of the form

        (INDEX-NAME . INDEX-POSITION)

The second element of the alist may be an alist, producing a nested
list as in

        (INDEX-NAME . INDEX-ALIST)

This function should not be called directly, as it calls itself
recursively and requires some setup.  Rather this is the engine for
the function \\[py--imenu-create-index-function].

It works recursively by looking for all definitions at the current
indention level.  When it finds one, it adds it to the alist.  If it
finds a definition at a greater indentation level, it removes the
previous definition from the alist. In its place it adds all
definitions found at the next indentation level.  When it finds a
definition that is less indented then the current level, it returns
the alist it has created thus far.

The optional argument START-INDENT indicates the starting indentation
at which to continue looking for SOME classes, methods, or
functions.  If this is not supplied, the function uses the indentation
of the first definition found."
  (let (index-alist
        sub-method-alist
        looking-p
        def-name prev-name
        cur-indent def-pos
        (class-paren (car ar-imenu-generic-parens))
        (def-paren (cadr ar-imenu-generic-parens)))
    ;; (switch-to-buffer (current-buffer))
    (setq looking-p
          (re-search-forward ar-imenu-generic-regexp (point-max) t))
    (while looking-p
      (save-excursion
        ;; used to set def-name to this value but generic-extract-name
        ;; is new to imenu-1.14. this way it still works with
        ;; imenu-1.11
        ;;(imenu--generic-extract-name ar-imenu-generic-parens))
        (let ((cur-paren (if (match-beginning class-paren)
                             class-paren def-paren)))
          (setq def-name
                (buffer-substring-no-properties (match-beginning cur-paren)
                                                (match-end cur-paren))))
        (save-match-data
          (ar-backward-def-or-class))
        (beginning-of-line)
        (setq cur-indent (current-indentation)))
      ;; HACK: want to go to the next correct definition location.  We
      ;; explicitly list them here but it would be better to have them
      ;; in a list.
      (setq def-pos
            (or (match-beginning class-paren)
                (match-beginning def-paren)))
      ;; if we do not have a starting indent level, take this one
      (or start-indent
          (setq start-indent cur-indent))
      ;; if we do not have class name yet, take this one
      (or prev-name
          (setq prev-name def-name))
      ;; what level is the next definition on?  must be same, deeper
      ;; or shallower indentation
      (cond
       ;; Skip code in comments and strings
       ((ar--in-literal))
       ;; at the same indent level, add it to the list...
       ((= start-indent cur-indent)
        (push (cons def-name def-pos) index-alist))
       ;; deeper indented expression, recurse
       ((< start-indent cur-indent)
        ;; the point is currently on the expression we're supposed to
        ;; start on, so go back to the last expression. The recursive
        ;; call will find this place again and add it to the correct
        ;; list
        (re-search-backward ar-imenu-generic-regexp (point-min) (quote move))
        (setq sub-method-alist (ar--imenu-create-index-engine cur-indent))
        (if sub-method-alist
            ;; we put the last element on the index-alist on the start
            ;; of the submethod alist so the user can still get to it.
            (let* ((save-elmt (pop index-alist))
                   (classname (and (string-match "^class " (car save-elmt))(replace-regexp-in-string "^class " "" (car save-elmt)))))
              (if (and classname (not (string-match "^class " (caar sub-method-alist))))
                  (setcar (car sub-method-alist) (concat classname "." (caar sub-method-alist))))
              (push (cons prev-name
                          (cons save-elmt sub-method-alist))
                    index-alist))))
       (t
        (setq looking-p nil)
        (re-search-backward ar-imenu-generic-regexp (point-min) t)))
      ;; end-cond
      (setq prev-name def-name)
      (and looking-p
           (setq looking-p
                 (re-search-forward ar-imenu-generic-regexp
                                    (point-max) (quote move)))))
    (nreverse index-alist)))

(defun ar--imenu-create-index-new (&optional beg end)
  "‘imenu-create-index-function’ for SOME. "
  (interactive)
  (set (make-local-variable (quote imenu-max-items)) ar-imenu-max-items)
  (let ((orig (point))
        (beg (or beg (point-min)))
        (end (or end (point-max)))
        index-alist vars thisend sublist classname pos name)
    (goto-char beg)
    (while (and (re-search-forward "^[ \t]*\\(def\\|class\\)[ \t]+\\(\\sw+\\)" end t 1)(not (nth 8 (parse-partial-sexp (point-min) (point)))))
      (if (save-match-data (string= "class" (match-string-no-properties 1)))
          (progn
            (setq pos (match-beginning 0)
                  name (match-string-no-properties 2)
                  classname (concat "class " name)
                  thisend (save-match-data (ar--end-of-def-or-class-position))
                  sublist (quote ()))
            (while (and (re-search-forward "^[ \t]*\\(def\\|class\\)[ \t]+\\(\\sw+\\)" (or thisend end) t 1)(not (nth 8 (parse-partial-sexp (point-min) (point)))))
              (let* ((pos (match-beginning 0))
                     (name (match-string-no-properties 2)))
                (push (cons (concat " " name) pos) sublist)))
            (if classname
                (progn
                  (setq sublist (nreverse sublist))
                  (push (cons classname pos) sublist)
                  (push (cons classname sublist) index-alist))
              (push sublist index-alist)))

        (let ((pos (match-beginning 0))
              (name (match-string-no-properties 2)))
          (push (cons name pos) index-alist))))
    ;; Look for module variables.
    (goto-char (point-min))
    (while (re-search-forward "^\\(\\sw+\\)[ \t]*=" end t)
      (unless (nth 8 (parse-partial-sexp (point-min) (point)))
        (let ((pos (match-beginning 1))
              (name (match-string-no-properties 1)))
          (push (cons name pos) vars))))
    (setq index-alist (nreverse index-alist))
    (when vars
      (push (cons "Module variables"
                  (nreverse vars))
            index-alist))
    (goto-char orig)
    index-alist))

;; A modified slice from SomeMode.el
(defvar ar-imenu-format-item-label-function
  (quote ar-imenu-format-item-label)
  "Imenu function used to format an item label.
It must be a function with two arguments: TYPE and NAME.")

(defvar ar-imenu-format-parent-item-label-function
  (quote ar-imenu-format-parent-item-label)
  "Imenu function used to format a parent item label.
It must be a function with two arguments: TYPE and NAME.")

(defvar ar-imenu-format-parent-item-jump-label-function
  (quote ar-imenu-format-parent-item-jump-label)
  "Imenu function used to format a parent jump item label.
It must be a function with two arguments: TYPE and NAME.")

(defun ar-imenu-format-item-label (type name)
  "Return Imenu label for single node using TYPE and NAME."
  (format "%s (%s)" name type))

(defun ar-imenu-format-parent-item-label (type name)
  "Return Imenu label for parent node using TYPE and NAME."
  (format "%s..." (ar-imenu-format-item-label type name)))

;; overengineering?
(defun ar-imenu-format-parent-item-jump-label (type _name)
  "Return Imenu label for parent node jump using TYPE and NAME."
  (if (string= type "class")
      "*class definition*"
    "*function definition*"))

(defun ar-imenu--put-parent (type name pos tree)
  "Add the parent with TYPE, NAME and POS to TREE."
  (let* ((label
         (funcall ar-imenu-format-item-label-function type name))
        ;; (jump-label
        ;; (funcall ar-imenu-format-parent-item-jump-label-function type name))
        (jump-label label
         ;; (funcall ar-imenu-format-parent-item-jump-label-function type name)
         )
        )
    (if (not tree)
        (cons label pos)
      (cons label (cons (cons jump-label pos) tree)))))

(defun ar-imenu--build-tree (&optional min-indent prev-indent tree)
  "Recursively build the tree of nested definitions of a node.
Arguments MIN-INDENT, PREV-INDENT and TREE are internal and should
not be passed explicitly unless you know what you are doing."
  (setq min-indent (or min-indent 0)
        prev-indent (or prev-indent ar-indent-offset))
  (save-restriction
    (narrow-to-region (point-min) (point))
    (let* ((pos
            (progn
              ;; finds a top-level class
              (ar-backward-def-or-class)
              ;; stops behind the indented form at EOL
              (ar-forward-def-or-class)
              ;; may find an inner def-or-class
              (ar-backward-def-or-class)))
           type
           (name (when (and pos (looking-at ar-def-or-class-re))
                   (let ((split (split-string (match-string-no-properties 0))))
                     (setq type (car split))
                     (cadr split))))
           (label (when name
                    (funcall ar-imenu-format-item-label-function type name)))
           (indent (current-indentation))
           (children-indent-limit (+ ar-indent-offset min-indent)))
      (cond ((not pos)
             ;; Nothing found, probably near to bobp.
             nil)
            ((<= indent min-indent)
             ;; The current indentation points that this is a parent
             ;; node, add it to the tree and stop recursing.
             (ar-imenu--put-parent type name pos tree))
            (t
             (ar-imenu--build-tree
              min-indent
              indent
              (if (<= indent children-indent-limit)
                  (cons (cons label pos) tree)
                (cons
                 (ar-imenu--build-tree
                  prev-indent indent (list (cons label pos)))
                 tree))))))))

(defun ar--imenu-index ()
  "Return tree Imenu alist for the current SOME buffer. "
  (save-excursion
    (goto-char (point-max))
    (let ((index)
          (tree))
      (while (setq tree (ar-imenu--build-tree))
        (setq index (cons tree index)))
      index)))

(provide (quote ar-imenu))
;;; ar-imenu.el ends here
