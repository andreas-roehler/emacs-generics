;;; ar-execute-file --- Runs files -*- lexical-binding: t; -*-

(defun ar-execute-file-iSomeMode (filename)
  "Send file to ISOME interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "iSomeMode" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-iSomeMode3 (filename)
  "Send file to ISOME3 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "iSomeMode3" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-jython (filename)
  "Send file to Jython interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "jython" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode (filename)
  "Send file to SOME interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "SomeMode" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode2 (filename)
  "Send file to SOME2 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "SomeMode2" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode3 (filename)
  "Send file to SOME3 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "SomeMode3" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-pypy (filename)
  "Send file to PyPy interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "pypy" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file- (filename)
  "Send file to  interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil nil "" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-iSomeMode-dedicated (filename)
  "Send file to a dedicatedISOME interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "iSomeMode" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-iSomeMode3-dedicated (filename)
  "Send file to a dedicatedISOME3 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "iSomeMode3" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-jython-dedicated (filename)
  "Send file to a dedicatedJython interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "jython" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode-dedicated (filename)
  "Send file to a dedicatedSOME interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "SomeMode" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode2-dedicated (filename)
  "Send file to a dedicatedSOME2 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "SomeMode2" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-SomeMode3-dedicated (filename)
  "Send file to a dedicatedSOME3 interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "SomeMode3" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file-pypy-dedicated (filename)
  "Send file to a dedicatedPyPy interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "pypy" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(defun ar-execute-file--dedicated (filename)
  "Send file to a dedicated interpreter"
  (interactive "fFile: ")
  (let ((buffer (ar-shell nil nil t "" nil t)))
    (ar--execute-file-base filename (get-buffer-process buffer) nil buffer nil t)))

(provide (quote ar-execute-file))
;;; ar-execute-file.el ends here
