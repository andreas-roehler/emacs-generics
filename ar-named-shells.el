;;; SOME named shells -*- lexical-binding: t; -*- 

(defun iSomeMode (&optional argprompt args buffer fast exception-buffer split)
  "Start an ISOME interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "iSomeMode" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun iSomeMode3 (&optional argprompt args buffer fast exception-buffer split)
  "Start an ISOME3 interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "iSomeMode3" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun jython (&optional argprompt args buffer fast exception-buffer split)
  "Start an Jython interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "jython" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun SomeMode (&optional argprompt args buffer fast exception-buffer split)
  "Start an SOME interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "SomeMode" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun SomeMode2 (&optional argprompt args buffer fast exception-buffer split)
  "Start an SOME2 interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "SomeMode2" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun SomeMode3 (&optional argprompt args buffer fast exception-buffer split)
  "Start an SOME3 interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "SomeMode3" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(defun pypy (&optional argprompt args buffer fast exception-buffer split)
  "Start an Pypy interpreter.

With optional \\[universal-argument] get a new dedicated shell."
  (interactive "p")
  (let ((buffer (ar-shell argprompt args nil "pypy" buffer fast exception-buffer split (unless argprompt (eq 1 (prefix-numeric-value argprompt))))))
    (funcall (lambda nil (window-configuration-to-register 121)))
    (goto-char (point-max)) 
    buffer))

(provide (quote ar-named-shells))
;;; ar-named-shells.el ends here
