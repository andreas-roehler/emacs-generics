;;; ar-close-forms.el --- close forms -*- lexical-binding: t; -*-


(defun ar-close-block ()
  "Close block at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-block-re)))

(defun ar-close-class ()
  "Close class at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-class-re)))

(defun ar-close-clause ()
  "Close clause at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-clause-re)))

(defun ar-close-block-or-clause ()
  "Close block-or-clause at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-block-or-clause-re)))

(defun ar-close-def ()
  "Close def at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-def-re)))

(defun ar-close-def-or-class ()
  "Close def-or-class at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-def-or-class-re)))

(defun ar-close-minor-block ()
  "Close minor-block at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-minor-block-re)))

(defun ar-close-statement ()
  "Close statement at point.

Set indent level to that of beginning of function definition.

If final line is not empty
and ‘ar-close-block-provides-newline’ non-nil,
insert a newline."
  (interactive "*")
  (ar--close-intern (quote ar-statement-re)))

(provide (quote ar-close-forms))
;;; ar-close-forms.el ends here
