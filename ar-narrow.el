;;; ar-narrow.el --- narrow forms -*- lexical-binding: t; -*- 

(defun ar-narrow-to-block ()
  "Narrow to block at point."
  (interactive)
  (ar--narrow-prepare "block"))

(defun ar-narrow-to-block-or-clause ()
  "Narrow to block-or-clause at point."
  (interactive)
  (ar--narrow-prepare "block-or-clause"))

(defun ar-narrow-to-class ()
  "Narrow to class at point."
  (interactive)
  (ar--narrow-prepare "class"))

(defun ar-narrow-to-clause ()
  "Narrow to clause at point."
  (interactive)
  (ar--narrow-prepare "clause"))

(defun ar-narrow-to-def ()
  "Narrow to def at point."
  (interactive)
  (ar--narrow-prepare "def"))

(defun ar-narrow-to-def-or-class ()
  "Narrow to def-or-class at point."
  (interactive)
  (ar--narrow-prepare "def-or-class"))

(defun ar-narrow-to-statement ()
  "Narrow to statement at point."
  (interactive)
  (ar--narrow-prepare "statement"))

(provide (quote ar-narrow))
;;; ar-narrow.el ends here
