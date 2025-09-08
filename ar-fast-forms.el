;;; ar-fast-forms.el --- Execute forms at point -*- lexical-binding: t; -*-

;; Process forms fast

(defun ar-execute-buffer-fast (&optional shell dedicated split switch proc)
  "Send accessible part of buffer to a SOME interpreter.

Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SPLIT: split buffers after executing
Optional SWITCH: switch to output buffer after executing
Optional PROC: select an already running process for executing"
  (interactive)
  (ar-execute-buffer shell dedicated t split switch proc))

(defun ar-execute-region-fast (beg end &optional shell dedicated split switch proc)
  "Send region to a SOME interpreter.

Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SPLIT: split buffers after executing
Optional SWITCH: switch to output buffer after executing
Optional PROC: select an already running process for executing"
  (interactive "r")
  (let ((ar-fast-process-p t))
    (ar-execute-region beg end shell dedicated t split switch proc)))

(defun ar-execute-block-fast (&optional shell dedicated switch beg end file)
  "Process block at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote block) shell dedicated switch beg end file t))

(defun ar-execute-block-or-clause-fast (&optional shell dedicated switch beg end file)
  "Process block-or-clause at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote block-or-clause) shell dedicated switch beg end file t))

(defun ar-execute-class-fast (&optional shell dedicated switch beg end file)
  "Process class at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote class) shell dedicated switch beg end file t))

(defun ar-execute-clause-fast (&optional shell dedicated switch beg end file)
  "Process clause at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote clause) shell dedicated switch beg end file t))

(defun ar-execute-def-fast (&optional shell dedicated switch beg end file)
  "Process def at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote def) shell dedicated switch beg end file t))

(defun ar-execute-def-or-class-fast (&optional shell dedicated switch beg end file)
  "Process def-or-class at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote def-or-class) shell dedicated switch beg end file t))

(defun ar-execute-expression-fast (&optional shell dedicated switch beg end file)
  "Process expression at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote expression) shell dedicated switch beg end file t))

(defun ar-execute-partial-expression-fast (&optional shell dedicated switch beg end file)
  "Process partial-expression at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote partial-expression) shell dedicated switch beg end file t))

(defun ar-execute-section-fast (&optional shell dedicated switch beg end file)
  "Process section at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote section) shell dedicated switch beg end file t))

(defun ar-execute-statement-fast (&optional shell dedicated switch beg end file)
  "Process statement at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote statement) shell dedicated switch beg end file t))

(defun ar-execute-top-level-fast (&optional shell dedicated switch beg end file)
  "Process top-level at point by a SOME interpreter.

Output buffer not in comint-mode, displays \"Fast\"  by default
Optional SHELL: Selecte a SOME-shell(VERSION) as ar-shell-name
Optional DEDICATED: run in a dedicated process
Optional SWITCH: switch to output buffer after executing
Optional File: execute through running a temp-file"
  (interactive)
  (ar--execute-prepare (quote top-level) shell dedicated switch beg end file t))

(provide (quote ar-fast-forms))
;;; ar-fast-forms.el ends here
