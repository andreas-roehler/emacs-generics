;;; ar-section-forms.el --- section forms -*- lexical-binding: t; -*- 

(defun ar-execute-section ()
  "Execute section at point."
  (interactive)
  (ar-execute-section-prepare))

(defun ar-execute-section-SomeMode ()
  "Execute section at point using SomeMode interpreter."
  (interactive)
  (ar-execute-section-prepare "SomeMode"))

(defun ar-execute-section-SomeMode2 ()
  "Execute section at point using SomeMode2 interpreter."
  (interactive)
  (ar-execute-section-prepare "SomeMode2"))

(defun ar-execute-section-SomeMode3 ()
  "Execute section at point using SomeMode3 interpreter."
  (interactive)
  (ar-execute-section-prepare "SomeMode3"))

(defun ar-execute-section-iSomeMode ()
  "Execute section at point using iSomeMode interpreter."
  (interactive)
  (ar-execute-section-prepare "iSomeMode"))

(defun ar-execute-section-iSomeMode2.7 ()
  "Execute section at point using iSomeMode2.7 interpreter."
  (interactive)
  (ar-execute-section-prepare "iSomeMode2.7"))

(defun ar-execute-section-iSomeMode3 ()
  "Execute section at point using iSomeMode3 interpreter."
  (interactive)
  (ar-execute-section-prepare "iSomeMode3"))

(defun ar-execute-section-jython ()
  "Execute section at point using jython interpreter."
  (interactive)
  (ar-execute-section-prepare "jython"))

(provide (quote ar-section-forms))
;;; ar-section-forms.el ends here
