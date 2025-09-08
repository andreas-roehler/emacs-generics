;;; ar-shift-forms.el --- Move forms left or right -*- lexical-binding: t; -*-

(defun ar-shift-left (&optional count start end)
  "Dedent region according to ‘ar-indent-offset’ by COUNT times.

If no region is active, current line is dedented.
Return indentation reached
Optional COUNT: COUNT times ‘ar-indent-offset’
Optional START: region beginning
Optional END: region end"
  (interactive "p")
  (ar--shift-intern (- count) start end))

(defun ar-shift-right (&optional count beg end)
  "Indent region according to ‘ar-indent-offset’ by COUNT times.

If no region is active, current line is indented.
Return indentation reached
Optional COUNT: COUNT times ‘ar-indent-offset’
Optional BEG: region beginning
Optional END: region end"
  (interactive "p")
  (ar--shift-intern count beg end))

(defun ar--shift-intern (count &optional start end)
  (save-excursion
    (let* (;; obsolete
           ;; (inhibit-point-motion-hooks t)
           deactivate-mark
           (beg (cond (start)
                      ((use-region-p)
                       (save-excursion
                         (goto-char
                          (region-beginning))))
                      (t (line-beginning-position))))
           (end (cond (end)
                      ((use-region-p)
                       (save-excursion
                         (goto-char
                          (region-end))))
                      (t (line-end-position)))))
      (setq beg (copy-marker beg))
      (setq end (copy-marker end))
      (if (< 0 count)
          (indent-rigidly beg end ar-indent-offset)
        (indent-rigidly beg end (- ar-indent-offset)))
      (push-mark beg t)
      (goto-char end)
      (skip-chars-backward " \t\r\n\f"))
    (ar-indentation-of-statement)))

(defun ar--shift-forms-base (form arg &optional beg end)
  (let* ((begform (intern-soft (concat "ar-backward-" form)))
         (endform (intern-soft (concat "ar-forward-" form)))
         (orig (copy-marker (point)))
         (beg (cond (beg)
                    ((use-region-p)
                     (save-excursion
                       (goto-char (region-beginning))
                       (line-beginning-position)))
                    (t (save-excursion
                         (funcall begform)
                         (line-beginning-position)))))
         (end (cond (end)
                    ((use-region-p)
                     (region-end))
                    (t (funcall endform))))
         (erg (ar--shift-intern arg beg end)))
    (goto-char orig)
    erg))

(defun ar-shift-block-right (&optional arg)
  "Indent block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "block" (or arg ar-indent-offset)))

(defun ar-shift-block-left (&optional arg)
  "Dedent block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "block" (- (or arg ar-indent-offset))))

(defun ar-shift-block-or-clause-right (&optional arg)
  "Indent block-or-clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "block-or-clause" (or arg ar-indent-offset)))

(defun ar-shift-block-or-clause-left (&optional arg)
  "Dedent block-or-clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "block-or-clause" (- (or arg ar-indent-offset))))

(defun ar-shift-class-right (&optional arg)
  "Indent class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "class" (or arg ar-indent-offset)))

(defun ar-shift-class-left (&optional arg)
  "Dedent class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "class" (- (or arg ar-indent-offset))))

(defun ar-shift-clause-right (&optional arg)
  "Indent clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "clause" (or arg ar-indent-offset)))

(defun ar-shift-clause-left (&optional arg)
  "Dedent clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "clause" (- (or arg ar-indent-offset))))

(defun ar-shift-comment-right (&optional arg)
  "Indent comment by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "comment" (or arg ar-indent-offset)))

(defun ar-shift-comment-left (&optional arg)
  "Dedent comment by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "comment" (- (or arg ar-indent-offset))))

(defun ar-shift-def-right (&optional arg)
  "Indent def by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "def" (or arg ar-indent-offset)))

(defun ar-shift-def-left (&optional arg)
  "Dedent def by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "def" (- (or arg ar-indent-offset))))

(defun ar-shift-def-or-class-right (&optional arg)
  "Indent def-or-class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "def-or-class" (or arg ar-indent-offset)))

(defun ar-shift-def-or-class-left (&optional arg)
  "Dedent def-or-class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "def-or-class" (- (or arg ar-indent-offset))))

(defun ar-shift-indent-right (&optional arg)
  "Indent indent by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "indent" (or arg ar-indent-offset)))

(defun ar-shift-indent-left (&optional arg)
  "Dedent indent by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "indent" (- (or arg ar-indent-offset))))

(defun ar-shift-minor-block-right (&optional arg)
  "Indent minor-block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "minor-block" (or arg ar-indent-offset)))

(defun ar-shift-minor-block-left (&optional arg)
  "Dedent minor-block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "minor-block" (- (or arg ar-indent-offset))))

(defun ar-shift-paragraph-right (&optional arg)
  "Indent paragraph by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "paragraph" (or arg ar-indent-offset)))

(defun ar-shift-paragraph-left (&optional arg)
  "Dedent paragraph by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "paragraph" (- (or arg ar-indent-offset))))

(defun ar-shift-region-right (&optional arg)
  "Indent region by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "region" (or arg ar-indent-offset)))

(defun ar-shift-region-left (&optional arg)
  "Dedent region by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "region" (- (or arg ar-indent-offset))))

(defun ar-shift-statement-right (&optional arg)
  "Indent statement by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "statement" (or arg ar-indent-offset)))

(defun ar-shift-statement-left (&optional arg)
  "Dedent statement by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "statement" (- (or arg ar-indent-offset))))

(defun ar-shift-top-level-right (&optional arg)
  "Indent top-level by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "top-level" (or arg ar-indent-offset)))

(defun ar-shift-top-level-left (&optional arg)
  "Dedent top-level by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use \\[universal-argument] to specify a different value.

Return outmost indentation reached."
  (interactive "*P")
  (ar--shift-forms-base "top-level" (- (or arg ar-indent-offset))))

(provide (quote ar-shift-forms))
;;; ar-shift-forms.el ends here
