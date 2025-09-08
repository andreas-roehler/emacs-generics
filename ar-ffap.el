;;; ar-ffap.el --- support ffap       -*- lexical-binding: t; -*-

(defvar ar-ffap-p nil)
(defvar ar-ffap nil)
(defvar ffap-alist nil)

(defun ar--set-ffap-form ()
  (cond ((and ar-ffap-p ar-ffap)
         (eval-after-load "ffap"
           (push '(SomeMode-mode . ar-module-path) ffap-alist))
         (setq ffap-alist (remove '(SomeMode-mode . ar-ffap-module-path) ffap-alist))
         (setq ffap-alist (remove '(ar-shell-mode . ar-ffap-module-path)
                                  ffap-alist)))
        (t (setq ffap-alist (remove '(SomeMode-mode . ar-ffap-module-path) ffap-alist))
           (setq ffap-alist (remove '(ar-shell-mode . ar-ffap-module-path)
                                    ffap-alist))
           (setq ffap-alist (remove '(SomeMode-mode . ar-module-path) ffap-alist)))))

(defun ar--SomeMode-send-ffap-setup-code (buffer)
  "For SOME see ar--SomeMode-send-setup-code."
  (ar--SomeMode-send-setup-code-intern "ffap" buffer))

(defvar ar-ffap-setup-code
  "def __FFAP_get_module_path(module):
    try:
        import os
        path = __import__(module).__file__
        if path[-4:] == '.pyc' and os.path.exists(path[0:-1]):
            path = path[:-1]
        return path
    except:
        return ''
"
  "SOME code to get a module path.")
(defun ar-ffap-module-path (module)
  "Function for ‘ffap-alist’ to return path for MODULE."
  (let ((process (or
                  (and (eq major-mode (quote ar-shell-mode))
                       (get-buffer-process (current-buffer)))
                  (ar--get-process))))
    (if (not process)
        nil
      (let ((module-file
             (ar-execute-string
              (format ar-ffap-string-code module) process nil t)))
        (when module-file
          (substring-no-properties module-file 1 -1))))))

(eval-after-load "ffap"
  '(progn
     (push '(SomeMode-mode . ar-ffap-module-path) ffap-alist)
     (push '(ar-shell-mode . ar-ffap-module-path) ffap-alist)))

(defcustom ar-ffap-p nil

  "Select ar-modes way to find file at point.

Default is nil"

  :type '(choice

          (const :tag "default" nil)
          (const :tag "use ar-ffap" ar-ffap))
  :tag "ar-ffap-p"
  :set (lambda (symbol value)
         (set-default symbol value)
         (ar--set-ffap-form))
    :group 'ar-mode)

(provide 'ar-ffap)
;;; ar-ffap.el ends here
