;; Extended executes --- more execute forms -*- lexical-binding: t; -*-

(defun ar--execute-prepare (form shell &optional dedicated switch beg end filename fast proc wholebuf split)
  "Update some vars."
  (save-excursion
    (let* ((form (prin1-to-string form))
           (origline (ar-count-lines))
           (fast
            (or fast ar-fast-process-p))
           (ar-exception-buffer (current-buffer))
           (beg (unless filename
                  (prog1
                      (or beg
                          (and (bolp) (point))
                          ;; (funcall
                          ;;      (intern-soft (concat "ar--beginning-of-" form "-p")))
                          (funcall (intern-soft (concat "ar-backward-" form)))
                          (push-mark)))))
           (end (unless filename
                  (or end (save-excursion (funcall (intern-soft (concat "ar-forward-" form))))))))
      ;; (setq ar-buffer-name nil)
      (if filename
            (if (file-readable-p filename)
                (ar--execute-file-base (expand-file-name filename) nil nil nil origline)
              (message "%s not readable. %s" filename "Do you have write permissions?"))
        (ar--execute-base beg end shell filename proc wholebuf fast dedicated split switch)))))

(defun ar-execute-block-iSomeMode (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-iSomeMode-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-jython (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-jython-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode2 (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode2-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode3 (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-SomeMode3-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-pypy (&optional dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-pypy-dedicated (&optional fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block (&optional shell dedicated fast split switch proc)
  "Send block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-dedicated (&optional shell fast split switch proc)
  "Send block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-iSomeMode (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-iSomeMode-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-jython (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-jython-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode2 (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode2-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode3 (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-SomeMode3-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-pypy (&optional dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-pypy-dedicated (&optional fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause (&optional shell dedicated fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-block-or-clause-dedicated (&optional shell fast split switch proc)
  "Send block-or-clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote block-or-clause) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-buffer-iSomeMode (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote iSomeMode) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-iSomeMode-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote iSomeMode) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote iSomeMode3) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote iSomeMode3) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-jython (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote jython) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-jython-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote jython) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode2 (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode2) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode2-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode2) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode3 (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode3) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-SomeMode3-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote SomeMode3) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-pypy (&optional dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote pypy) dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-pypy-dedicated (&optional fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) (quote pypy) t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer (&optional shell dedicated fast split switch proc)
  "Send buffer at point to a SomeMode3 interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) shell dedicated switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-buffer-dedicated (&optional shell fast split switch proc)
  "Send buffer at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((ar-master-file (or ar-master-file (ar-fetch-ar-master-file)))
        (wholebuf t)
        filename buffer)
    (when ar-master-file
      (setq filename (expand-file-name ar-master-file)
            buffer (or (get-file-buffer filename)
                       (find-file-noselect filename)))
      (set-buffer buffer))
    (ar--execute-prepare (quote buffer) shell t switch (point-min) (point-max) nil fast proc wholebuf split)))

(defun ar-execute-class-iSomeMode (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-iSomeMode-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-jython (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-jython-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode2 (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode2-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode3 (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-SomeMode3-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-pypy (&optional dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-pypy-dedicated (&optional fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class (&optional shell dedicated fast split switch proc)
  "Send class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-class-dedicated (&optional shell fast split switch proc)
  "Send class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote class) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-iSomeMode (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-iSomeMode-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-jython (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-jython-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode2 (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode2-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode3 (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-SomeMode3-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-pypy (&optional dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-pypy-dedicated (&optional fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause (&optional shell dedicated fast split switch proc)
  "Send clause at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-clause-dedicated (&optional shell fast split switch proc)
  "Send clause at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote clause) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-iSomeMode (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-iSomeMode-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-jython (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-jython-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode2 (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode2-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode3 (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-SomeMode3-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-pypy (&optional dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-pypy-dedicated (&optional fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def (&optional shell dedicated fast split switch proc)
  "Send def at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-dedicated (&optional shell fast split switch proc)
  "Send def at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-iSomeMode (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-iSomeMode-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-jython (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-jython-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode2 (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode2-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode3 (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-SomeMode3-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-pypy (&optional dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-pypy-dedicated (&optional fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class (&optional shell dedicated fast split switch proc)
  "Send def-or-class at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-def-or-class-dedicated (&optional shell fast split switch proc)
  "Send def-or-class at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote def-or-class) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-iSomeMode (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-iSomeMode-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-jython (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-jython-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode2 (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode2-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode3 (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-SomeMode3-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-pypy (&optional dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-pypy-dedicated (&optional fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression (&optional shell dedicated fast split switch proc)
  "Send expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-expression-dedicated (&optional shell fast split switch proc)
  "Send expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote expression) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-iSomeMode (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-iSomeMode-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-jython (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-jython-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode2 (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode2-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode3 (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-SomeMode3-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-pypy (&optional dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-pypy-dedicated (&optional fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent (&optional shell dedicated fast split switch proc)
  "Send indent at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-indent-dedicated (&optional shell fast split switch proc)
  "Send indent at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote indent) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-iSomeMode (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-iSomeMode-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-jython (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-jython-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode2 (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode2-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode3 (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-SomeMode3-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-pypy (&optional dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-pypy-dedicated (&optional fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line (&optional shell dedicated fast split switch proc)
  "Send line at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-line-dedicated (&optional shell fast split switch proc)
  "Send line at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote line) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-iSomeMode (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-iSomeMode-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-jython (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-jython-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode2 (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode2-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode3 (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-SomeMode3-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-pypy (&optional dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-pypy-dedicated (&optional fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block (&optional shell dedicated fast split switch proc)
  "Send minor-block at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-minor-block-dedicated (&optional shell fast split switch proc)
  "Send minor-block at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote minor-block) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-iSomeMode (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-iSomeMode-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-jython (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-jython-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode2 (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode2-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode3 (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-SomeMode3-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-pypy (&optional dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-pypy-dedicated (&optional fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph (&optional shell dedicated fast split switch proc)
  "Send paragraph at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-paragraph-dedicated (&optional shell fast split switch proc)
  "Send paragraph at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote paragraph) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-iSomeMode (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-iSomeMode-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-jython (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-jython-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode2 (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode2-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode3 (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-SomeMode3-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-pypy (&optional dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-pypy-dedicated (&optional fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression (&optional shell dedicated fast split switch proc)
  "Send partial-expression at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-partial-expression-dedicated (&optional shell fast split switch proc)
  "Send partial-expression at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote partial-expression) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-region-iSomeMode (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote iSomeMode) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-iSomeMode-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote iSomeMode) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-iSomeMode3 (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote iSomeMode3) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-iSomeMode3-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote iSomeMode3) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-jython (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote jython) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-jython-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote jython) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode2 (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode2) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode2-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode2) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode3 (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode3) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-SomeMode3-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote SomeMode3) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-pypy (beg end &optional dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote pypy) dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-pypy-dedicated (beg end &optional fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) (quote pypy) t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region (beg end &optional shell dedicated fast split switch proc)
  "Send region at point to a SomeMode3 interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) shell dedicated switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-region-dedicated (beg end &optional shell fast split switch proc)
  "Send region at point to a SomeMode3 unique interpreter."
  (interactive "r")
  (let ((wholebuf nil))
    (ar--execute-prepare (quote region) shell t switch (or beg (region-beginning)) (or end (region-end)) nil fast proc wholebuf split)))

(defun ar-execute-statement-iSomeMode (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-iSomeMode-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-jython (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-jython-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode2 (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode2-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode3 (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-SomeMode3-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-pypy (&optional dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-pypy-dedicated (&optional fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement (&optional shell dedicated fast split switch proc)
  "Send statement at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-statement-dedicated (&optional shell fast split switch proc)
  "Send statement at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote statement) shell t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-iSomeMode (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote iSomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-iSomeMode-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote iSomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-iSomeMode3 (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote iSomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-iSomeMode3-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote iSomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-jython (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote jython) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-jython-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote jython) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter.

For ‘default’ see value of ‘ar-shell-name’"
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode2 (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode2) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode2-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode2) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode3 (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode3) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-SomeMode3-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote SomeMode3) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-pypy (&optional dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote pypy) dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-pypy-dedicated (&optional fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) (quote pypy) t switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level (&optional shell dedicated fast split switch proc)
  "Send top-level at point to a SomeMode3 interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) shell dedicated switch nil nil nil fast proc wholebuf split)))

(defun ar-execute-top-level-dedicated (&optional shell fast split switch proc)
  "Send top-level at point to a SomeMode3 unique interpreter."
  (interactive)
  (let ((wholebuf nil))
    (ar--execute-prepare (quote top-level) shell t switch nil nil nil fast proc wholebuf split)))

(provide (quote ar-extended-executes))
;;; ar-extended-executes.el ends here
