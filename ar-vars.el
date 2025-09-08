;;; ar-vars.el --- Edit, debug, develop and run programs. -*- lexical-binding: t; -*-

(require 'ansi-color)
(ignore-errors (require 'subr-x))
(require 'cc-cmds)
(require 'comint)
(require 'compile)
(require 'custom)
(require 'ert)
(require 'flymake)
(require 'hippie-exp)
(require 'hideshow)
(require 'json)
(require 'shell)
(require 'thingatpt)
(require 'which-func)
(require 'tramp)
(require 'tramp-sh)
(require 'org-loaddefs)
(unless (functionp 'mapcan)
  (require 'cl-extra)
  ;; mapcan does not exist in Emacs 25
  (defalias 'mapcan 'cl-mapcan)
  )

(define-minor-mode ar-electric-backspace-mode
  "When on, <backspace> key will delete all whitespace chars before point.

Default is nil"
  :group 'ar-mode
  :lighter " eb"
  (if ar-electric-backspace-mode
      (if (ignore-errors (functionp 'keymap-local-set))
          (keymap-local-set "<backspace>" 'ar-electric-backspace)
        (local-set-key "<backspace>" 'ar-electric-backspace))
    (if (ignore-errors (functionp 'keymap-local-unset))
        (keymap-local-unset "<backspace>")
      (local-unset-key "<backspace>"))))

(defvar ar-comment-start-re           "[ \t]*#"
  "Beginning of a comment")

(defvar ar-comment-end-re "\n"
  "Regexp to match the end of a comment.")

(defvar ar-comment-start-skip-re      "#+ *"
"Regexp to match the start of a comment plus everything up to its body.")

(defvar comint-mime-setup-script-dir nil
  "Avoid compiler warning")

(defvar comint-mime-enabled-types nil
  "Avoid compiler warning")

(defvar comint-mime-setup-function-alist nil
  "Avoid compiler warning")

(defvar comint-mime-setup-function-alist nil
  "Avoid compiler warning")

(defgroup ar-mode nil
  "Support for the programming language" ;; generic mark
  :group 'languages
  :prefix "ar-")

(defconst ar-version "6.3.1")

(defvar ar-install-directory nil
  "Make sure it exists.")

(defcustom ar-install-directory nil
  "Directory where SomeMode-mode.el and its subdirectories should be installed.

Needed for completion and other environment stuff only."

  :type 'string
  :tag "ar-install-directory"
  :group 'ar-mode)

(defcustom ar-font-lock-defaults-p t
  "If fontification is not required, avoiding it might speed up things."

  :type 'boolean
  :tag "ar-font-lock-defaults-p"
  :group 'ar-mode
  :safe 'booleanp)

(defcustom ar-register-shell-buffer-p nil
  "If non-nil, register new ar-shell according to ar-register-char as REGISTER.

Default is nil.
See ‘window-configuration-to-register’"

  :type 'boolean
  :tag "ar-register-shell-buffer-p"
  :group 'ar-mode
  :safe 'booleanp)

(defcustom ar-register-char ?y
  "Char used by ar-register-shell-buffer-p

Default is ‘y’.
See also ‘window-configuration-to-register’"

  :type 'char
  :tag "ar-register-char"
  :group 'ar-mode
  :safe 'characterp)

(defcustom ar-SomeModepath ""
  "Define $PYTHONPATH here, if needed.

Emacs does not read .bashrc"

  :type 'string
  :tag "ar-SomeModepath"
  :group 'ar-mode)

(defcustom SomeMode-mode-modeline-display "Py"
  "String to display in Emacs modeline."

  :type 'string
  :tag "SomeMode-mode-modeline-display"
  :group 'ar-mode)

(defcustom ar-SomeMode2-modeline-display "Py2"
  "String to display in Emacs modeline."

  :type 'string
  :tag "SomeMode2-mode-modeline-display"
  :group 'ar-mode)

(defcustom ar-SomeMode3-modeline-display "Py3"
  "String to display in Emacs modeline."

  :type 'string
  :tag "SomeMode3-mode-modeline-display"
  :group 'ar-mode)

(defcustom ar-iSomeMode-modeline-display "IPy"
  "String to display in Emacs modeline."

  :type 'string
  :tag "iSomeMode-modeline-display"
  :group 'ar-mode)

(defcustom ar-jython-modeline-display "Jy"
  "String to display in Emacs modeline."

  :type 'string
  :tag "jython-modeline-display"
  :group 'ar-mode)

(defcustom ar-extensions "ar-extensions.el"
  "File where extensions to SomeMode-mode.el should be installed.

Used by virtualenv support."

  :type 'string
  :tag "ar-extensions"
  :group 'ar-mode)

(defcustom info-lookup-mode "SomeMode"
  "Which SOME documentation should be queried.

Make sure it is accessible from Emacs by \\<emacs-lisp-mode-map> \\[info] ...
See INSTALL-INFO-FILES for help."

  :type 'string
  :tag "info-lookup-mode"
  :group 'ar-mode)

(defcustom ar-fast-process-p nil
  "Use ‘ar-fast-process’.

Commands prefixed \"ar-fast-...\" suitable for large output

See: large output makes Emacs freeze, lp:1253907

Results arrive in output buffer, which is not in comint-mode"

  :type 'boolean
  :tag "ar-fast-process-p"
  :group 'ar-mode
  :safe 'booleanp)

;; credits to SomeMode.el
(defcustom ar-shell-compilation-regexp-alist
  `((,(rx line-start (1+ (any " \t")) "File \""
          (group (1+ (not (any "\"<")))) ; avoid ‘<stdin>’ &c
          "\", line " (group (1+ digit)))
     1 2)
    (,(rx " in file " (group (1+ not-newline)) " on line "
          (group (1+ digit)))
     1 2)
    (,(rx line-start "> " (group (1+ (not (any "(\"<"))))
          "(" (group (1+ digit)) ")" (1+ (not (any "("))) "()")
     1 2))
  "‘compilation-error-regexp-alist’ for ‘ar-shell’."
  :type '(alist string)
  :tag "ar-shell-compilation-regexp-alist"
  :group 'ar-mode)

(defcustom ar-shift-require-transient-mark-mode-p t
  "If ar-shift commands require variable ‘transient-mark-mode’ set to t.

Default is t"

  :type 'boolean
  :tag "ar-shift-require-transient-mark-mode-p"
  :group 'ar-mode
  :safe 'booleanp)

(defvar ar-fast-output-buffer "*SOME Fast*"
  "Internally used. ‘buffer-name’ for fast-processes.")

(defvar ar-this-result nil
  "Internally used, store return-value.")

(defconst ar-coding-re
  "\\(# *coding[ \t]*=\\|#[ \t]*\-*\-[ \t]*coding:\\|#[ \t]*encoding:\\)[ \t]*\\([[:graph:]+]\\)"
 "Fetch the coding cookie maybe.")

(defcustom ar-comment-auto-fill-p nil
  "When non-nil, fill comments.

Defaut is nil"

  :type 'boolean
  :tag "ar-comment-auto-fill-p"
  :group 'ar-mode
  :safe 'booleanp)

(defcustom ar-sexp-use-expression-p nil
  "If non-nil, ‘forward-sexp’ will call ‘ar-forward-expression’.

Respective ‘backward-sexp’ will call ‘ar-backward-expression’
Default is t"
  :type 'boolean
  :tag "ar-sexp-use-expression-p"
  :group 'ar-mode
  :safe 'booleanp)

(defcustom ar-session-p t
  "If commands would use an existing process.

Default is t"

  :type 'boolean
  :tag "ar-session-p"
  :group 'ar-mode
  :safe 'booleanp)

(defvar ar-chars-before " \t\n\r\f"
  "Used by ‘ar--string-strip’.")

(defvar ar-chars-after " \t\n\r\f"
    "Used by ‘ar--string-strip’.")

(defcustom ar-max-help-buffer-p nil
  "If \"\*SOME-Help\*\"-buffer should appear as the only visible.

Default is nil.  In ‘help-buffer’, \"q\" will close it."

  :type 'boolean
  :tag "ar-max-help-buffer-p"
  :group 'ar-mode
  :safe 'booleanp)

(defcustom ar-highlight-error-source-p nil
  "Respective code in source-buffer will be highlighted.

Default is nil.

\\<ar-mode-map> ‘ar-remove-overlays-at-point’ removes that highlighting."
  :type 'boolean
  :tag "ar-highlight-error-source-p"
  :group 'ar-mode)

(defcustom ar-set-pager-cat-p nil
  "If the shell environment variable $PAGER should set to ‘cat’.

Avoids lp:783828,
 \"Terminal not fully functional\", for help('COMMAND') in SomeMode-shell

When non-nil, imports module ‘os’"

  :type 'boolean
  :tag "ar-set-pager-cat-p"
  :group 'ar-mode)

(defcustom ar-empty-line-closes-p nil
  "When non-nil, dedent after empty line following block.

if True:
    print(\"Part of the if-statement\")

print(\"Not part of the if-statement\")

Default is nil"

  :type 'boolean
  :tag "ar-empty-line-closes-p"
  :group 'ar-mode)

(defcustom ar-prompt-on-changed-p t
  "Ask for save before a changed buffer is sent to interpreter.

Default is t"

  :type 'boolean
  :tag "ar-prompt-on-changed-p"
  :group 'ar-mode)

(defcustom ar-dedicated-process-p nil
  "If commands executing code use a dedicated shell.

Default is nil

When non-nil and ‘ar-session-p’, an existing
dedicated process is re-used instead of default
 - which allows executing stuff in parallel."
  :type 'boolean
  :tag "ar-dedicated-process-p"
  :group 'ar-mode)

(defcustom ar-store-result-p nil
  "Put resulting string of ‘ar-execute-...’ into ‘kill-ring’.

Default is nil"

  :type 'boolean
  :tag "ar-dedicated-process-p"
  :group 'ar-mode)

(defvar ar-shell--font-lock-buffer "*PSFLB*"
  "May contain the ‘ar-buffer-name’ currently fontified." )

(defvar ar-return-result-p nil
  "Internally used.

When non-nil, return resulting string of ‘ar-execute-...’.
Imports will use it with nil.
Default is nil")

(defcustom ar--execute-use-temp-file-p nil
 "Assume execution at a remote machine.

 where write-access is not given."

 :type 'boolean
 :tag "ar--execute-use-temp-file-p"
 :group 'ar-mode)

(defvar ar--match-paren-forward-p nil
  "Internally used by ‘ar-match-paren’.")

(defvar ar-new-session-p t
  "Internally used.  See lp:1393882.

Restart ‘ar-shell’ once with new Emacs/‘ar-mode’.")

(defcustom ar-electric-close-active-p nil
  "Close completion buffer if no longer needed.

Works around a bug in ‘choose-completion’.
Default is nil"
  :type 'boolean
  :tag "ar-electric-close-active-p"
  :group 'ar-mode)

(defcustom ar-hide-show-minor-mode-p nil
  "If hide-show minor-mode should be on, default is nil."

  :type 'boolean
  :tag "ar-hide-show-minor-mode-p"
  :group 'ar-mode)

(defcustom ar-do-completion-p t
  "Permits disabling all SomeMode-mode native completion.

Default is ‘t’.
See #144, how to disable process spawn for autocompletion"

  :type 'boolean
  :tag "ar-do-completion-p"
  :group 'ar-mode)

(defcustom ar-load-skeletons-p nil
  "If skeleton definitions should be loaded, default is nil.

If non-nil and variable ‘abbrev-mode’ on, block-skeletons will inserted.
Pressing \"if<SPACE>\" for example will prompt for the if-condition."

  :type 'boolean
  :tag "ar-load-skeletons-p"
  :group 'ar-mode)

(defcustom ar-if-name-main-permission-p t
  "Allow execution of code inside blocks started.

by \"if __name__== '__main__':\".
Default is non-nil"

  :type 'boolean
  :tag "ar-if-name-main-permission-p"
  :group 'ar-mode)

(defcustom ar-use-font-lock-doc-face-p nil
  "If documention string inside of def or class get ‘font-lock-doc-face’.

‘font-lock-doc-face’ inherits ‘font-lock-string-face’.
Call \\<emacs-lisp-mode-map> \\[customize-face] in order to have a effect."

  :type 'boolean
  :tag "ar-use-font-lock-doc-face-p"
  :group 'ar-mode)

(defcustom ar-empty-comment-line-separates-paragraph-p t
  "Consider paragraph start/end lines with nothing inside but comment sign.

Default is  non-nil"
  :type 'boolean
  :tag "ar-empty-comment-line-separates-paragraph-p"
  :group 'ar-mode)

(defcustom ar-indent-honors-inline-comment nil
  "If non-nil, indents to column of inlined comment start.
Default is nil."
  :type 'boolean
  :tag "ar-indent-honors-inline-comment"
  :group 'ar-mode)

(defcustom ar-auto-fill-mode nil
  "If ‘ar-mode’ should set ‘fill-column’.

according to values
in ‘ar-comment-fill-column’ and ‘ar-docstring-fill-column’.
Default is  nil"

  :type 'boolean
  :tag "ar-auto-fill-mode"
  :group 'ar-mode)

(defcustom ar-error-markup-delay 4
  "Seconds error's are highlighted in exception buffer."

  :type 'integer
  :tag "ar-error-markup-delay"
  :group 'ar-mode)

(defcustom ar-fast-completion-delay 0.1
  "Used by ‘ar-fast-send-string’."

  :type 'float
  :tag "ar-fast-completion-delay"
  :group 'ar-mode)

(defcustom ar-new-shell-delay
    (if (eq system-type 'windows-nt)
      2.0
    1.0)

  "If a new comint buffer is connected to SOME.
Commands like completion might need some delay."

  :type 'float
  :tag "ar-new-shell-delay"
  :group 'ar-mode)

(defcustom ar-autofill-timer-delay 1
  "Delay when idle."
  :type 'integer
  :tag "ar-autofill-timer-delay"
  :group 'ar-mode)

(defcustom ar-docstring-fill-column 72
  "Value of ‘fill-column’ to use when filling a docstring.
Any non-integer value means do not use a different value of
‘fill-column’ when filling docstrings."
  :type '(choice (integer)
                 (const :tag "Use the current ‘fill-column’" t))
  :tag "ar-docstring-fill-column"
  :group 'ar-mode)

(defcustom ar-comment-fill-column 79
  "Value of ‘fill-column’ to use when filling a comment.
Any non-integer value means do not use a different value of
‘fill-column’ when filling docstrings."
  :type '(choice (integer)
                 (const :tag "Use the current ‘fill-column’" t))
  :tag "ar-comment-fill-column"
  :group 'ar-mode)

(defcustom ar-fontify-shell-buffer-p nil
  "If code in SOME shell should be highlighted as in script buffer.

Default is nil.

If t, related vars like ‘comment-start’ will be set too.
Seems convenient when playing with stuff in ISOME shell
Might not be TRT when a lot of output arrives"

  :type 'boolean
  :tag "ar-fontify-shell-buffer-p"
  :group 'ar-mode)

(defvar ar-modeline-display ""
  "Internally used.")

(defcustom ar-modeline-display-full-path-p nil
  "If the full PATH/TO/PYTHON be in modeline.

Default is nil. Note: when ‘ar-SomeMode-command’ is
specified with path, it is shown as an acronym in
‘buffer-name’ already."

  :type 'boolean
  :tag "ar-modeline-display-full-path-p"
  :group 'ar-mode)

(defcustom ar-modeline-acronym-display-home-p nil
  "If the modeline acronym should contain chars indicating the home-directory.

Default is nil"
  :type 'boolean
  :tag "ar-modeline-acronym-display-home-p"
  :group 'ar-mode)

(defvar highlight-indent-active nil)
;; (defvar autopair-mode nil)

(defvar-local ar--editbeg nil
  "Internally used by ‘ar-edit-docstring’ and others")

(defvar-local ar--editend nil
  "Internally used by ‘ar-edit-docstring’ and others")

(defvar ar--oldbuf nil
  "Internally used by ‘ar-edit-docstring’.")

(defvar ar-edit-buffer "Edit docstring"
  "Name of the temporary buffer to use when editing.")

(defvar ar--edit-register nil)

(defvar ar-result nil
  "Internally used.  May store result from SOME process.

See var ‘ar-return-result-p’ and command ‘ar-toggle-ar-return-result-p’")

(defvar ar-error nil
  "Takes the error-messages from SOME process.")

(defvar ar-SomeMode-completions "*SOME Completions*"
  "Buffer name for SOME-shell completions, internally used.")

(defvar ar-iSomeMode-completions "*ISOME Completions*"
  "Buffer name for ISOME-shell completions, internally used.")

(defcustom ar-timer-close-completions-p t
  "If ‘ar-timer-close-completion-buffer’ should run, default is non-nil."

  :type 'boolean
  :tag "ar-timer-close-completions-p"
  :group 'ar-mode)

;; (defcustom ar-autopair-mode nil
;;   "If ‘ar-mode’ calls (autopair-mode-on)

;; Default is nil
;; Load ‘autopair-mode’ written by Joao Tavora <joaotavora [at] gmail.com>
;; URL: http://autopair.googlecode.com"
;;   :type 'boolean
;;   :tag "ar-autopair-mode"
;;   :group 'ar-mode)

(defcustom ar-indent-no-completion-p nil
  "If completion function should insert a TAB when no completion found.

Default is nil"
  :type 'boolean
  :tag "ar-indent-no-completion-p"
  :group 'ar-mode)

(defcustom ar-company-pycomplete-p nil
  "Load company-pycomplete stuff.  Default is  nil."

  :type 'boolean
  :tag "ar-company-pycomplete-p"
  :group 'ar-mode)

(defvar ar-last-position nil
    "Used by ‘ar-help-at-point’.

Avoid repeated call at identic pos.")

(defvar ar-auto-completion-mode-p nil
  "Internally used by ‘ar-auto-completion-mode’.")

(defvar ar-complete-last-modified nil
  "Internally used by ‘ar-auto-completion-mode’.")

(defvar ar--auto-complete-timer nil
  "Internally used by ‘ar-auto-completion-mode’.")

(defvar ar-auto-completion-buffer nil
  "Internally used by ‘ar-auto-completion-mode’.")

(defvar ar--auto-complete-timer-delay 1
  "Seconds Emacs must be idle to trigger auto-completion.

See ‘ar-auto-completion-mode’")

(defcustom ar-auto-complete-p nil
  "Run SomeMode-mode's built-in auto-completion via ‘ar-complete-function’.

Default is  nil."

  :type 'boolean
  :tag "ar-auto-complete-p"
  :group 'ar-mode)

(defcustom ar-tab-shifts-region-p nil
  "If t, TAB will indent/cycle the region, not just the current line.

Default is  nil
See also ‘ar-tab-indents-region-p’"

  :type 'boolean
  :tag "ar-tab-shifts-region-p"
  :group 'ar-mode)

(defcustom ar-tab-indents-region-p nil
  "When t and first TAB does not shift, ‘indent-region’ is called.

Default is  nil
See also ‘ar-tab-shifts-region-p’"

  :type 'boolean
  :tag "ar-tab-indents-region-p"
  :group 'ar-mode)

(defcustom ar-block-comment-prefix-p t
  "If ar-comment inserts ‘ar-block-comment-prefix’.

Default is t"

  :type 'boolean
  :tag "ar-block-comment-prefix-p"
  :group 'ar-mode)

(defcustom ar-org-cycle-p nil
  "When non-nil, command ‘org-cycle’ is available at shift-TAB, <backtab>.

Default is nil."
  :type 'boolean
  :tag "ar-org-cycle-p"
  :group 'ar-mode)

(defcustom ar-set-complete-keymap-p  nil
  "If ‘ar-complete-initialize’.

Sets up enviroment for Pymacs based ar-complete.
 Should load its keys into ‘ar-mode-map’
Default is nil.
See also resp. edit ‘ar-complete-set-keymap’"

  :type 'boolean
  :tag "ar-set-complete-keymap-p"
  :group 'ar-mode)

(defcustom ar-outline-minor-mode-p t
  "If outline minor-mode should be on, default is t."
  :type 'boolean
  :tag "ar-outline-minor-mode-p"
  :group 'ar-mode)

(defvar ar-guess-ar-install-directory-p nil
  "If in cases, ‘ar-install-directory’ is not set,  ‘ar-set-load-path’ guess it.")

(defcustom ar-guess-ar-install-directory-p nil
  "If in cases, ‘ar-install-directory’ is not set, ‘ar-set-load-path’ guesses it."
  :type 'boolean
  :tag "ar-guess-ar-install-directory-p"
  :group 'ar-mode)

(defcustom ar-load-pymacs-p nil
  "If Pymacs related stuff should be loaded. Default is nil.

Pymacs has been written by François Pinard and many others.
See original source: http://pymacs.progiciels-bpi.ca"
  :type 'boolean
  :tag "ar-load-pymacs-p"
  :group 'ar-mode)

(defcustom ar-verbose-p nil
  "If functions should report results.

Default is nil."
  :type 'boolean
  :tag "ar-verbose-p"
  :group 'ar-mode)

(defcustom ar-sexp-function nil
  "Called instead of ‘forward-sexp’, ‘backward-sexp’.

Default is nil."

  :type '(choice

          (const :tag "default" nil)
          (const :tag "ar-forward-partial-expression" ar-forward-partial-expression)
          (const :tag "ar-forward-expression" ar-forward-expression))
  :tag "ar-sexp-function"
  :group 'ar-mode)

(defcustom ar-close-provides-newline t
  "If a newline is inserted, when line after block is not empty.

Default is non-nil.
When non-nil, ‘ar-forward-def’ and related will work faster"
  :type 'boolean
  :tag "ar-close-provides-newline"
  :group 'ar-mode)

(defcustom ar-dedent-keep-relative-column t
  "If point should follow dedent or kind of electric move to end of line.

Default is t - keep relative position."
  :type 'boolean
  :tag "ar-dedent-keep-relative-column"
  :group 'ar-mode)

(defcustom ar-indent-list-style 'line-up-with-first-element
  "Sets the basic indentation style of lists.

The term ‘list’ here is seen from Emacs Lisp editing purpose.
A list symbolic expression means everything delimited by
brackets, parentheses or braces.

Setting here might be ignored in case of canonical indent.

‘line-up-with-first-element’ indents to 1+ column
of opening delimiter

def foo (a,
         b):

but ‘one-level-to-beginning-of-statement’ in case of EOL at list-start

def foo (
    a,
    b):

‘one-level-to-beginning-of-statement’ adds
‘ar-indent-offset’ to beginning

def long_function_name(
    var_one, var_two, var_three,
    var_four):
    print(var_one)

‘one-level-from-first-element’ adds ‘ar-indent-offset’ from first element
def foo():
    if (foo &&
            baz):
        bar()"
  :type '(choice
          (const :tag "line-up-with-first-element" line-up-with-first-element)
          (const :tag "one-level-to-beginning-of-statement" one-level-to-beginning-of-statement)
          (const :tag "one-level-from-first-element" one-level-from-first-element)
          )
  :tag "ar-indent-list-style"
  :group 'ar-mode)
(make-variable-buffer-local 'ar-indent-list-style)

(defcustom ar-closing-list-dedents-bos nil
  "When non-nil, indent lists closing delimiter like start-column.

It will be lined up under the first character of
 the line that starts the multi-line construct, as in:

my_list = [
    1, 2, 3,
    4, 5, 6
]

result = some_function_that_takes_arguments(
    \\='a\\=', \\='b\\=', \\='c\\=',
    \\='d\\=', \\='e\\=', \\='f\\='
)

Default is nil, i.e.

my_list = [
    1, 2, 3,
    4, 5, 6
    ]

result = some_function_that_takes_arguments(
    \\='a\\=', \\='b\\=', \\='c\\=',
    \\='d\\=', \\='e\\=', \\='f\\='
    )

Examples from PEP8
URL: https://www.SomeMode.org/dev/peps/pep-0008/#indentation"
  :type 'boolean
  :tag "ar-closing-list-dedents-bos"
  :group 'ar-mode)

(defvar ar-imenu-max-items 99)
(defcustom ar-imenu-max-items 99
 "SOME-mode specific ‘imenu-max-items’."
 :type 'number
 :tag "ar-imenu-max-items"
 :group 'ar-mode)

(defcustom ar-closing-list-space 1
  "Number of chars, closing parenthesis outdent from opening, default is 1."
  :type 'number
  :tag "ar-closing-list-space"
  :group 'ar-mode)

(defcustom ar-max-specpdl-size 99
  "Heuristic exit.
e
Limiting number of recursive calls by ‘ar-forward-statement’ and related.
Default is ‘max-specpdl-size’.

This threshold is just an approximation.  It might set far higher maybe.

See lp:1235375. In case code is not to navigate due to errors,
command ‘which-function-mode’ and others might make Emacs hang.

Rather exit than."

  :type 'number
  :tag "ar-max-specpdl-size"
  :group 'ar-mode)

(defcustom ar-closing-list-keeps-space nil
  "If non-nil, closing parenthesis dedents onto column of opening.
Adds ‘ar-closing-list-space’.
Default is nil."
  :type 'boolean
  :tag "ar-closing-list-keeps-space"
  :group 'ar-mode)

(defcustom ar-electric-colon-active-p nil
  "‘ar-electric-colon’ feature.

Default is nil.  See lp:837065 for discussions.
See also ‘ar-electric-colon-bobl-only’"
  :type 'boolean
  :tag "ar-electric-colon-active-p"
  :group 'ar-mode)

(defcustom ar-electric-colon-bobl-only t

  "When inserting a colon, do not indent lines unless at beginning of block.

See lp:1207405 resp. ‘ar-electric-colon-active-p’"

  :type 'boolean
  :tag "ar-electric-colon-bobl-only"
  :group 'ar-mode)

(defcustom ar-electric-yank-active-p nil
  "When non-nil, ‘yank’ will be followed by an ‘indent-according-to-mode’.

Default is nil"
  :type 'boolean
  :tag "ar-electric-yank-active-p"
  :group 'ar-mode)

(defcustom ar-electric-colon-greedy-p nil
  "If ‘ar-electric-colon’ should indent to the outmost reasonable level.

If nil, default, it will not move from at any reasonable level."
  :type 'boolean
  :tag "ar-electric-colon-greedy-p"
  :group 'ar-mode)

(defcustom ar-electric-colon-newline-and-indent-p nil
  "If non-nil, ‘ar-electric-colon’ will call ‘newline-and-indent’.

Default is nil."
  :type 'boolean
  :tag "ar-electric-colon-newline-and-indent-p"
  :group 'ar-mode)

(defcustom ar-electric-comment-p nil
  "If \"#\" should call ‘ar-electric-comment’. Default is nil."
  :type 'boolean
  :tag "ar-electric-comment-p"
  :group 'ar-mode)

(defcustom ar-electric-comment-add-space-p nil
  "If ‘ar-electric-comment’ should add a space.  Default is nil."
  :type 'boolean
  :tag "ar-electric-comment-add-space-p"
  :group 'ar-mode)

(defcustom ar-defun-use-top-level-p nil
 "If ‘beginning-of-defun’, ‘end-of-defun’ calls function ‘top-level’ form.

Default is nil.

beginning-of defun, ‘end-of-defun’ forms use
commands ‘ar-backward-top-level’, ‘ar-forward-top-level’

‘mark-defun’ marks function ‘top-level’ form at point etc."

 :type 'boolean
  :tag "ar-defun-use-top-level-p"
 :group 'ar-mode)

(defcustom ar-tab-indent t
  "Non-nil means TAB in SOME mode calls ‘ar-indent-line’."
  :type 'boolean
  :tag "ar-tab-indent"
  :group 'ar-mode)

(defcustom ar-return-key 'ar-newline-and-indent
  "Which command <return> should call."
  :type '(choice

          (const :tag "default" ar-newline-and-indent)
          (const :tag "newline" newline)
          (const :tag "ar-newline-and-dedent" ar-newline-and-dedent)
          )
  :tag "ar-return-key"
  :group 'ar-mode)

(defcustom ar-complete-function 'ar-fast-complete
  "When set, enforces function todo completion, default is ‘ar-fast-complete’.

Might not affect ISOME, as ‘ar-shell-complete’ is the only known working here.
Normally ‘ar-mode’ knows best which function to use."
  :type '(choice

          (const :tag "default" nil)
          (const :tag "Pymacs and company based ar-complete" ar-complete)
          (const :tag "ar-shell-complete" ar-shell-complete)
          (const :tag "ar-indent-or-complete" ar-indent-or-complete)
          (const :tag "ar-fast-complete" ar-fast-complete)
          )
  :tag "ar-complete-function"
  :group 'ar-mode)

(defcustom ar-encoding-string " # -*- coding: utf-8 -*-"
  "Default string specifying encoding of a SOME file."
  :type 'string
  :tag "ar-encoding-string"
  :group 'ar-mode)

(defcustom ar-shebang-startstring "#! /bin/env"
  "Detecting the shell in head of file."
  :type 'string
  :tag "ar-shebang-startstring"
  :group 'ar-mode)

(defcustom ar-flake8-command ""
  "Which command to call flake8.

If empty, ‘ar-mode’ will guess some"
  :type 'string
  :tag "ar-flake8-command"
  :group 'ar-mode)

(defcustom ar-flake8-command-args ""
  "Arguments used by flake8.

Default is the empty string."
  :type 'string
  :tag "ar-flake8-command-args"
  :group 'ar-mode)

(defvar ar-flake8-history nil
  "Used by flake8, resp. ‘ar-flake8-command’.

Default is nil.")

(defcustom ar-message-executing-temporary-file t
  "If execute functions using a temporary file should message it.

Default is t.
Messaging increments the prompt counter of ISOME shell."
  :type 'boolean
  :tag "ar-message-executing-temporary-file"
  :group 'ar-mode)

(defcustom ar-execute-no-temp-p nil
  "Seems Emacs-24.3 provided a way executing stuff without temporary files."
  :type 'boolean
  :tag "ar-execute-no-temp-p"
  :group 'ar-mode)

(defcustom ar-lhs-inbound-indent 1
  "When line starts a multiline-assignment.

How many colums indent more than opening bracket, brace or parenthesis."
  :type 'integer
  :tag "ar-lhs-inbound-indent"
  :group 'ar-mode)

(defcustom ar-continuation-offset 2
  "Additional amount of offset to give for some continuation lines.
Continuation lines are those that immediately follow a backslash
terminated line."
  :type 'integer
  :tag "ar-continuation-offset"
  :group 'ar-mode)

(defcustom ar-indent-tabs-mode nil
  "SOME-mode starts ‘indent-tabs-mode’ with the value specified here.

Default is nil."
  :type 'boolean
  :tag "ar-indent-tabs-mode"
  :group 'ar-mode)

(defcustom ar-smart-indentation nil
  "Guess ‘ar-indent-offset’.  Default is nil.

Setting it to t seems useful only in cases where customizing
‘ar-indent-offset’ is no option - for example because the
indentation step is unknown or differs inside the code.

When this variable is non-nil, ‘ar-indent-offset’ is guessed from existing code.

Which might slow down the proceeding."

  :type 'boolean
  :tag "ar-smart-indentation"
  :group 'ar-mode)

(defcustom ar-block-comment-prefix "##"
  "String used by \\[comment-region] to comment out a block of code.
This should follow the convention for non-indenting comment lines so
that the indentation commands will not get confused (i.e., the string
should be of the form ‘#x...’ where ‘x’ is not a blank or a tab, and
 ‘...’ is arbitrary).  However, this string should not end in whitespace."
  :type 'string
  :tag "ar-block-comment-prefix"
  :group 'ar-mode)

(defcustom ar-indent-offset 4
  "Amount of offset per level of indentation.
‘\\[py-guess-indent-offset]’ can usually guess a good value when
you're editing someone else's SOME code."
  :type 'integer
  :tag "ar-indent-offset"
  :group 'ar-mode)
(make-variable-buffer-local 'ar-indent-offset)
(put 'ar-indent-offset 'safe-local-variable 'integerp)

(defcustom ar-backslashed-lines-indent-offset 5
  "Amount of offset per level of indentation of backslashed.
No semantic indent,  which diff to ‘ar-indent-offset’ indicates"
  :type 'integer
  :tag "ar-backslashed-lines-indent-offset"
  :group 'ar-mode)

(defcustom ar-shell-completion-native-output-timeout 5.0
  "Time in seconds to wait for completion output before giving up."
  :version "25.1"
  :type 'float
  :tag "ar-shell-completion-native-output-timeout"
  :group 'ar-mode)

(defcustom ar-shell-completion-native-try-output-timeout 1.0
  "Time in seconds to wait for *trying* native completion output."
  :version "25.1"
  :type 'float
  :tag "ar-shell-completion-native-try-output-timeout"
  :group 'ar-mode)

(defvar ar-shell--first-prompt-received-output-buffer nil)
(defvar ar-shell--first-prompt-received nil)

(defcustom ar-shell-first-prompt-hook nil
  "Hook run upon first (non-pdb) shell prompt detection.
This is the place for shell setup functions that need to wait for
output.  Since the first prompt is ensured, this helps the
current process to not hang while waiting.  This is useful to
safely attach setup code for long-running processes that
eventually provide a shell."
  :version "25.1"
  :type 'hook
  :tag "ar-shell-first-prompt-hook"
  :group 'ar-mode)

(defvar ar-shell--parent-buffer nil)

(defvar ar-shell--package-depth 10)

(defcustom ar-indent-comments t
  "When t, comment lines are indented."
  :type 'boolean
  :tag "ar-indent-comments"
  :group 'ar-mode)

(defcustom ar-uncomment-indents-p nil
  "When non-nil, after uncomment indent lines."
  :type 'boolean
  :tag "ar-uncomment-indents-p"
  :group 'ar-mode)

(defcustom ar-separator-char "/"
  "The character, which separates the system file-path components.

Precedes guessing when not empty, returned by function ‘ar-separator-char’."
  :type 'string
  :tag "ar-separator-char"
  :group 'ar-mode)

(defvar ar-separator-char "/"
  "Values set by defcustom only will not be seen in batch-mode.")

(and
 ;; used as a string finally
 ;; kept a character not to break existing customizations
 (characterp ar-separator-char)(setq ar-separator-char (char-to-string ar-separator-char)))

(defcustom ar-custom-temp-directory ""
  "If set, will take precedence over guessed values from ‘ar-temp-directory’.

Default is the empty string."
  :type 'string
  :tag "ar-custom-temp-directory"
  :group 'ar-mode)

(defcustom ar-beep-if-tab-change t
  "Ring the bell if ‘tab-width’ is changed.
If a comment of the form

                           \t# vi:set tabsize=<number>:

is found before the first code line when the file is entered, and the
current value of (the general Emacs variable) ‘tab-width’ does not
equal <number>, ‘tab-width’ is set to <number>, a message saying so is
displayed in the echo area, and if ‘ar-beep-if-tab-change’ is non-nil
the Emacs bell is also rung as a warning."
  :type 'boolean
  :tag "ar-beep-if-tab-change"
  :group 'ar-mode)

(defcustom ar-jump-on-exception t
  "Jump to innermost exception frame in SOME output buffer.
When this variable is non-nil and an exception occurs when running
SOME code synchronously in a subprocess, jump immediately to the
source code of the innermost traceback frame."
  :type 'boolean
  :tag "ar-jump-on-exception"
  :group 'ar-mode)

(defcustom ar-ask-about-save t
  "If not nil, ask about which buffers to save before executing some code.
Otherwise, all modified buffers are saved without asking."
  :type 'boolean
  :tag "ar-ask-about-save"
  :group 'ar-mode)

(defcustom ar-delete-function 'delete-char
  "Function called by ‘ar-electric-delete’ when deleting forwards."
  :type 'function
  :tag "ar-delete-function"
  :group 'ar-mode)

(defcustom ar-import-check-point-max
  20000
  "Max number of characters to search Java-ish import statement.

When ‘ar-mode’ tries to calculate the shell
-- either a CSOME or a Jython shell --
it looks at the so-called ‘shebang’.
If that's not available, it looks at some of the
file heading imports to see if they look Java-like."
  :type 'integer
  :tag "ar-import-check-point-max
"
  :group 'ar-mode)

(defcustom ar-known-shells
  (list
   "iSomeMode"
   "iSomeMode2.7"
   "iSomeMode3"
   "jython"
   "SomeMode"
   "SomeMode2"
   "SomeMode3"
   "pypy"
   )
  "A list of available shells instrumented for commands.
Expects its executables installed

Edit for your needs."
  :type '(repeat string)
  :tag "ar-shells"
  :group 'ar-mode)

(defcustom ar-known-shells-extended-commands
  (list "iSomeMode"
        "SomeMode"
        "SomeMode3"
        "pypy"
        )
  "A list of shells for finer grained commands.
like ‘ar-execute-statement-iSomeMode’
Expects its executables installed

Edit for your needs."
  :type '(repeat string)
  :tag "ar-shells"
  :group 'ar-mode)

(defcustom ar-jython-packages
  '("java" "javax")
  "Imported packages that imply ‘jython-mode’."
  :type '(repeat string)
  :tag "ar-jython-packages
"
  :group 'ar-mode)

(defcustom ar-current-defun-show t
  "If ‘ar-current-defun’ should jump to the definition.

Highlights it while waiting PY-WHICH-FUNC-DELAY seconds.
Afterwards returning to previous position.

Default is t."

  :type 'boolean
  :tag "ar-current-defun-show"
  :group 'ar-mode)

(defcustom ar-current-defun-delay 2
  "‘ar-current-defun’ waits PY-WHICH-FUNC-DELAY seconds.

Before returning to previous position."

  :type 'number
  :tag "ar-current-defun-delay"
  :group 'ar-mode)

(defcustom ar-SomeMode-send-delay 1
  "Seconds to wait for output, used by ‘ar--send-...’ functions.

See also ‘ar-iSomeMode-send-delay’"

  :type 'number
  :tag "ar-SomeMode-send-delay"
  :group 'ar-mode)

(defcustom ar-SomeMode3-send-delay 1
  "Seconds to wait for output, used by ‘ar--send-...’ functions.

See also ‘ar-iSomeMode-send-delay’"

  :type 'number
  :tag "ar-SomeMode3-send-delay"
  :group 'ar-mode)

(defcustom ar-iSomeMode-send-delay 1
  "Seconds to wait for output, used by ‘ar--send-...’ functions.

See also ‘ar-SomeMode-send-delay’"

  :type 'number
  :tag "ar-iSomeMode-send-delay"
  :group 'ar-mode)

(defcustom ar-master-file nil
  "Execute the named master file instead of the buffer's file.

Default is nil.
With relative path variable ‘default-directory’ is prepended.

Beside you may set this variable in the file's local
variable section, e.g.:

                           # Local Variables:
                           # ar-master-file: \"master.py\"
                           # End:"
  :type 'string
  :tag "ar-master-file"
  :group 'ar-mode)
(make-variable-buffer-local 'ar-master-file)

(defcustom ar-pychecker-command "pychecker"
  "Shell command used to run Pychecker."
  :type 'string
  :tag "ar-pychecker-command"
  :group 'ar-mode)

(defcustom ar-pychecker-command-args "--stdlib"
  "String arguments to be passed to pychecker."
  :type 'string
  :tag "ar-pychecker-command-args"
  :group 'ar-mode)

(defcustom ar-pyflakes3-command "pyflakes3"
  "Shell command used to run Pyflakes3."
  :type 'string
  :tag "ar-pyflakes3-command"
  :group 'ar-mode)

(defcustom ar-pyflakes3-command-args ""
  "String arguments to be passed to pyflakes3.

Default is \"\""
  :type 'string
  :tag "ar-pyflakes3-command-args"
  :group 'ar-mode)

(defcustom ar-pep8-command "pep8"
  "Shell command used to run pep8."
  :type 'string
  :tag "ar-pep8-command"
  :group 'ar-mode)

(defcustom ar-pep8-command-args ""
  "String arguments to be passed to pylint.

Default is \"\""
  :type 'string
  :tag "ar-pep8-command-args"
  :group 'ar-mode)

(defcustom ar-pyflakespep8-command (concat ar-install-directory "/pyflakespep8.py")
  "Shell command used to run ‘pyflakespep8’."
  :type 'string
  :tag "ar-pyflakespep8-command"
  :group 'ar-mode)

(defcustom ar-pyflakespep8-command-args ""
  "String arguments to be passed to pyflakespep8.

Default is \"\""
  :type 'string
  :tag "ar-pyflakespep8-command-args"
  :group 'ar-mode)

(defcustom ar-pylint-command "pylint"
  "Shell command used to run Pylint."
  :type 'string
  :tag "ar-pylint-command"
  :group 'ar-mode)

(defcustom ar-pylint-command-args '("--errors-only")
  "String arguments to be passed to pylint.

Default is \"--errors-only\""
  :type '(repeat string)
  :tag "ar-pylint-command-args"
  :group 'ar-mode)

(defvar ar-pdbtrack-input-prompt "^[(<]*[Ii]?[Pp]y?db[>)]+ *"
  "Recognize the prompt.")
(setq ar-pdbtrack-input-prompt "^[(<]*[Ii]?[Pp]y?db[>)]+ *")

(defcustom ar-shell-input-prompt-1-regexp ">>> "
  "A regular expression to match the input prompt of the shell."
  :type 'regexp
  :tag "ar-shell-input-prompt-1-regexp"
  :group 'ar-mode)

(defcustom ar-shell-input-prompt-2-regexp "[.][.][.]:? "
  "A regular expression to match the input prompt.

Applies to the shell after the first line of input."
  :type 'string
  :tag "ar-shell-input-prompt-2-regexp"
  :group 'ar-mode)

(defvar ar-shell-iSomeMode-input-prompt-1-regexp "In \\[[0-9]+\\]: "
  "Regular Expression matching input prompt of SomeMode shell.
It should not contain a caret (^) at the beginning.")

(defvar ar-shell-iSomeMode-input-prompt-2-regexp "   \\.\\.\\.: "
  "Regular Expression matching second level input prompt of SomeMode shell.
It should not contain a caret (^) at the beginning.")

(defcustom ar-shell-input-prompt-2-regexps
  '(">>> " "\\.\\.\\. "                 ; SOME
    "In \\[[0-9]+\\]: "                 ; ISOME
    "   \\.\\.\\.: "                    ; ISOME
    ;; Using ipdb outside ISOME may fail to cleanup and leave static
    ;; ISOME prompts activated, this adds some safeguard for that.
    "In : " "\\.\\.\\.: ")
  "List of regular expressions matching input prompts."
  :type '(repeat string)
  :version "24.4"
  :tag "ar-shell-input-prompt-2-regexps"
  :group 'ar-mode)

(defcustom ar-shell-input-prompt-regexps
  '(">>> " "\\.\\.\\. "                 ; SOME
    "In \\[[0-9]+\\]: "                 ; ISOME
    "   \\.\\.\\.: "                    ; ISOME
    ;; Using ipdb outside ISOME may fail to cleanup and leave static
    ;; ISOME prompts activated, this adds some safeguard for that.
    "In : " "\\.\\.\\.: ")
  "List of regular expressions matching input prompts."
  :type '(repeat regexp)
  :version "24.4"
  :tag "ar-shell-input-prompt-regexps"
  :group 'ar-mode)

(defvar ar-iSomeMode-output-prompt-re "^Out\\[[0-9]+\\]: "
  "A regular expression to match the output prompt of ISOME.")

(defcustom ar-shell-output-prompt-regexps
  '(""                                  ; SOME
    "Out\\[[0-9]+\\]: "                 ; ISOME
    "Out :")                            ; ipdb safeguard
  "List of regular expressions matching output prompts."
  :type '(repeat string)
  :version "24.4"
  :tag "ar-shell-output-prompt-regexps"
  :group 'ar-mode)

(defvar ar-pydbtrack-input-prompt "^[(]*ipydb[>)]+ "
  "Recognize the pydb-prompt.")
;; (setq ar-pdbtrack-input-prompt "^[(< \t]*[Ii]?[Pp]y?db[>)]*.*")

(defvar ar-iSomeMode-input-prompt-re "In \\[?[0-9 ]*\\]?: *\\|^[ ]\\{3\\}[.]\\{3,\\}: *"
  "A regular expression to match the ISOME input prompt.")

(defvar ar-shell-prompt-regexp
  (concat "\\("
          (mapconcat 'identity
                     (delq nil
                           (list
                            ar-shell-input-prompt-1-regexp
                            ar-shell-input-prompt-2-regexp
                            ar-iSomeMode-input-prompt-re
                            ar-iSomeMode-output-prompt-re
                            ar-pdbtrack-input-prompt
                            ar-pydbtrack-input-prompt
                            "[.]\\{3,\\}:? *"
                            ))
                     "\\|")
          "\\)")
  "Internally used by ‘ar-fast-filter’.
‘ansi-color-filter-apply’ might return
Result: \"\\nIn [10]:    ....:    ....:    ....: 1\\n\\nIn [11]: \"")

(defvar ar-fast-filter-re
  (concat "\\("
          (mapconcat 'identity
                     (delq nil
                           (list
                            ar-shell-input-prompt-1-regexp
                            ar-shell-input-prompt-2-regexp
                            ar-iSomeMode-input-prompt-re
                            ar-iSomeMode-output-prompt-re
                            ar-pdbtrack-input-prompt
                            ar-pydbtrack-input-prompt
                            "[.]\\{3,\\}:? *"
                            ))
                     "\\|")
          "\\)")
  "Internally used by ‘ar-fast-filter’.
‘ansi-color-filter-apply’ might return
Result: \"\\nIn [10]:    ....:    ....:    ....: 1\\n\\nIn [11]: \"")

(defcustom ar-shell-prompt-detect-p nil
  "Non-nil enables autodetection of interpreter prompts."
  :type 'boolean
  :safe 'booleanp
  :version "24.4"
  :tag "ar-shell-prompt-detect-p"
  :group 'ar-mode)

(defcustom ar-shell-prompt-read-only t
  "If non-nil, the SomeMode prompt is read only.

Setting this variable will only effect new shells."
  :type 'boolean
  :tag "ar-shell-prompt-read-only"
  :group 'ar-mode)

(setq ar-fast-filter-re
  (concat "\\("
          (mapconcat 'identity
                     (delq nil
                           (list
                            ar-shell-input-prompt-1-regexp
                            ar-shell-input-prompt-2-regexp
                            ar-iSomeMode-input-prompt-re
                            ar-iSomeMode-output-prompt-re
                            ar-pdbtrack-input-prompt
                            ar-pydbtrack-input-prompt
                            "[.]\\{3,\\}:? *"
                            ))
                     "\\|")
          "\\)"))

(defcustom ar-honor-ISOMEDIR-p nil
  "When non-nil iSomeMode-history file is constructed by $ISOMEDIR.

Default is nil.
Otherwise value of ‘ar-iSomeMode-history’ is used."
  :type 'boolean
  :tag "ar-honor-ISOMEDIR-p"
  :group 'ar-mode)

(defcustom ar-iSomeMode-history "~/.iSomeMode/history"
  "ISomeMode-history default file.

Used when ‘ar-honor-ISOMEDIR-p’ is nil - th default"

  :type 'string
  :tag "ar-iSomeMode-history"
  :group 'ar-mode)

(defcustom ar-honor-PYTHONHISTORY-p nil
  "When non-nil SomeMode-history file is set by $PYTHONHISTORY.

Default is nil.
Otherwise value of ‘ar-SomeMode-history’ is used."
  :type 'boolean
  :tag "ar-honor-PYTHONHISTORY-p"
  :group 'ar-mode)

(defcustom ar-SomeMode-history "~/.SomeMode_history"
  "SOME-history default file.

Used when ‘ar-honor-PYTHONHISTORY-p’ is nil (default)."

  :type 'string
  :tag "ar-SomeMode-history"
  :group 'ar-mode)

(defcustom ar-switch-buffers-on-execute-p nil
  "When non-nil switch to the SOME output buffer.

If ‘ar-keep-windows-configuration’ is t, this will take precedence
over setting here."

  :type 'boolean
  :tag "ar-switch-buffers-on-execute-p"
  :group 'ar-mode)
;; made buffer-local as pdb might need t in all circumstances
(make-variable-buffer-local 'ar-switch-buffers-on-execute-p)

(defcustom ar-split-window-on-execute 'just-two
  "When non-nil split windows.

Default is just-two - when code is send to interpreter.
Splits screen into source-code buffer and current ‘ar-shell’ result.
Other buffer will be hidden that way.

When set to t, ‘ar-mode’ tries to reuse existing windows
and will split only if needed.

With \\='always, results will displayed in a new window.

Both t and ‘always’ is experimental still.

For the moment: If a multitude of ar-shells/buffers should be
visible, open them manually and set ‘ar-keep-windows-configuration’ to t.

See also ‘ar-keep-windows-configuration’"
  :type `(choice
          (const :tag "default" just-two)
          (const :tag "reuse" t)
          (const :tag "no split" nil)
          (const :tag "always" always))
  :tag "ar-split-window-on-execute"
  :group 'ar-mode)

(defcustom ar-split-window-on-execute-threshold 3
  "Maximal number of displayed windows.

Honored, when ‘ar-split-window-on-execute’ is t, i.e. \"reuse\".
Do not split when max number of displayed windows is reached."
  :type 'number
  :tag "ar-split-window-on-execute-threshold"
  :group 'ar-mode)

(defcustom ar-split-windows-on-execute-function 'split-window-vertically
  "How window should get splitted to display results of ar-execute-... functions."
  :type '(choice (const :tag "split-window-vertically" split-window-vertically)
                 (const :tag "split-window-horizontally" split-window-horizontally)
                 )
  :tag "ar-split-windows-on-execute-function"
  :group 'ar-mode)

(defcustom ar-shell-fontify-p 'input
  "Fontify current input in SOME shell. Default is input.

INPUT will leave output unfontified.

At any case only current input gets fontified."
  :type '(choice (const :tag "Default" all)
                 (const :tag "Input" input)
                 (const :tag "Nil" nil)
                 )
  :tag "ar-shell-fontify-p"
  :group 'ar-mode)

(defcustom ar-hide-show-keywords
  '("class"    "def"    "elif"    "else"    "except"
    "for"      "if"     "while"   "finally" "try"
    "with"     "match"  "case")
  "Keywords composing visible heads."
  :type '(repeat string)
  :tag "ar-hide-show-keywords
"
  :group 'ar-mode)

(defcustom ar-hide-show-hide-docstrings t
  "Controls if doc strings can be hidden by hide-show."
  :type 'boolean
  :tag "ar-hide-show-hide-docstrings"
  :group 'ar-mode)

(defcustom ar-hide-comments-when-hiding-all t
  "Hide the comments too when you do an ‘hs-hide-all’."
  :type 'boolean
  :tag "ar-hide-comments-when-hiding-all"
  :group 'ar-mode)

(defcustom ar-outline-mode-keywords
  '("class"    "def"    "elif"    "else"    "except"
    "for"      "if"     "while"   "finally" "try"
    "with"     "match"  "case")
  "Keywords composing visible heads."
  :type '(repeat string)
  :tag "ar-outline-mode-keywords
"
  :group 'ar-mode)

(defcustom ar-mode-hook nil
  "Hook run when entering SOME mode."

  :type 'hook
  :tag "ar-mode-hook"
  :group 'ar-mode
  )

;; (defcustom ar-shell-name
;;   (if (eq system-type 'windows-nt)
;;       "C:/SOME27/SomeMode"
;;     "SomeMode")

;;   "A PATH/TO/EXECUTABLE or default value ‘ar-shell’ may look for.

;; If no shell is specified by command.

;; On Windows default is C:/SOME27/SomeMode
;; --there is no garantee it exists, please check your system--

;; Else SomeMode"
;;   :type 'string
;;   :tag "ar-shell-name
;; "
;;   :group 'ar-mode)

(defcustom ar-SomeMode-command
  (if (eq system-type 'windows-nt)
      ;; "C:\\SOME27\\SomeMode.exe"
      "SomeMode"
   ;; "C:/SOME33/Lib/site-packages/ISOME"
    "SomeMode")

  "Make sure directory in in the PATH-variable.

Windows: edit in \"Advanced System Settings/Environment Variables\"
Commonly \"C:\\\\SOME27\\\\SomeMode.exe\"
With Anaconda for example the following works here:
\"C:\\\\Users\\\\My-User-Name\\\\Anaconda\\\\Scripts\\\\SomeMode.exe\"

Else /usr/bin/SomeMode"

  :type 'string
  :tag "ar-SomeMode-command
"
  :group 'ar-mode)

(defvar ar-shell-name ar-SomeMode-command)
;; (defvaralias 'ar-shell-name 'ar-SomeMode-command)

(defcustom ar-SomeMode-command-args '("-i")
  "String arguments to be used when starting a SOME shell."
  :type '(repeat string)
  :tag "ar-SomeMode-command-args"
  :group 'ar-mode)

(defcustom ar-SomeMode2-command
  (if (eq system-type 'windows-nt)
      "C:\\SOME27\\SomeMode"
    ;; "SomeMode2"
    "SomeMode2")

  "Make sure, the directory where SomeMode.exe resides in in the PATH-variable.

Windows: If needed, edit in
\"Advanced System Settings/Environment Variables\"
Commonly
\"C:\\\\SOME27\\\\SomeMode.exe\"
With Anaconda for example the following works here:
\"C:\\\\Users\\\\My-User-Name\\\\Anaconda\\\\Scripts\\\\SomeMode.exe\"

Else /usr/bin/SomeMode"

  :type 'string
  :tag "ar-SomeMode2-command
"
  :group 'ar-mode)

(defcustom ar-SomeMode2-command-args '("-i")
  "String arguments to be used when starting a SOME shell."
  :type '(repeat string)
  :tag "ar-SomeMode2-command-args"
  :group 'ar-mode)

;; "/usr/bin/SomeMode3"
(defcustom ar-SomeMode3-command
  (if (eq system-type 'windows-nt)
    "C:/SOME33/SomeMode"
    "SomeMode3")

  "A PATH/TO/EXECUTABLE or default value ‘ar-shell’ may look for.

Unless shell is specified by command.

On Windows see C:/SOME3/SomeMode.exe
--there is no garantee it exists, please check your system--

At GNU systems see /usr/bin/SomeMode3"

  :type 'string
  :tag "ar-SomeMode3-command
"
  :group 'ar-mode)

(defcustom ar-SomeMode3-command-args '("-i")
  "String arguments to be used when starting a SOME3 shell."
  :type '(repeat string)
  :tag "ar-SomeMode3-command-args"
  :group 'ar-mode)

(defcustom ar-iSomeMode-command
  (if (eq system-type 'windows-nt)
    "C:\\SOME27\\SomeMode"
    ;; "C:/SOME33/Lib/site-packages/ISOME"
    ;; "/usr/bin/iSomeMode"
    "iSomeMode")

  "A PATH/TO/EXECUTABLE or default value.

`M-x ISOME RET' may look for,
Unless ISOME-shell is specified by command.

On Windows default is \"C:\\\\SOME27\\\\SomeMode.exe\"
While with Anaconda for example the following works here:
\"C:\\\\Users\\\\My-User-Name\\\\Anaconda\\\\Scripts\\\\iSomeMode.exe\"

Else /usr/bin/iSomeMode"

  :type 'string
  :tag "ar-iSomeMode-command
"
  :group 'ar-mode)

(defcustom ar-iSomeMode-command-args
  (if (eq system-type 'windows-nt)
      '("-i" "C:\\SOME27\\Scripts\\iSomeMode-script.py")
    ;; --simple-prompt seems to exist from ISOME 5.
    (if (string-match "^[0-4]" (ignore-errors (shell-command-to-string (concat "iSomeMode" " -V"))))
        '("--pylab" "--automagic")
      '("--pylab" "--automagic" "--simple-prompt")))
  "String arguments to be used when starting a ISOME shell.

At Windows make sure iSomeMode-script.py is PATH.
Also setting PATH/TO/SCRIPT here should work, for example;
C:\\SOME27\\Scripts\\iSomeMode-script.py
With Anaconda the following is known to work:
\"C:\\\\Users\\\\My-User-Name\\\\Anaconda\\\\Scripts\\\\iSomeMode-script-py\""
  :type '(repeat string)
  :tag "ar-iSomeMode-command-args"
  :group 'ar-mode)

(defcustom ar-jython-command
  (if (eq system-type 'windows-nt)
      '("jython")
    '("/usr/bin/jython"))

  "A PATH/TO/EXECUTABLE or default value.
`M-x Jython RET' may look for, if no Jython-shell is specified by command.

Not known to work at windows
Default /usr/bin/jython"

  :type '(repeat string)
  :tag "ar-jython-command
"
  :group 'ar-mode)

(defcustom ar-jython-command-args '("-i")
  "String arguments to be used when starting a Jython shell."
  :type '(repeat string)
  :tag "ar-jython-command-args"
  :group 'ar-mode)

(defcustom ar-shell-toggle-1 ar-SomeMode2-command
  "A PATH/TO/EXECUTABLE or default value used by ‘ar-toggle-shell’."
  :type 'string
  :tag "ar-shell-toggle-1"
  :group 'ar-mode)

(defcustom ar-shell-toggle-2 ar-SomeMode3-command
  "A PATH/TO/EXECUTABLE or default value used by ‘ar-toggle-shell’."
  :type 'string
  :tag "ar-shell-toggle-2"
  :group 'ar-mode)

(defcustom ar--imenu-create-index-p nil
  "Non-nil means SOME mode creates and displays an index menu.

Of functions and global variables."
  :type 'boolean
  :tag "ar--imenu-create-index-p"
  :group 'ar-mode)

(defvar ar-history-filter-regexp "\\‘\\s-*\\S-?\\S-?\\s-*\\'\\|''’/tmp/"
  "Input matching this regexp is not saved on the history list.
Default ignores all inputs of 0, 1, or 2 non-blank characters.")

(defcustom ar-match-paren-mode nil
  "Non-nil means, cursor will jump to beginning or end of a block.
This vice versa, to beginning first.
Sets ‘ar-match-paren-key’ in ‘ar-mode-map’.
Customize ‘ar-match-paren-key’ which key to use."
  :type 'boolean
  :tag "ar-match-paren-mode"
  :group 'ar-mode)

(defcustom ar-match-paren-key "%"
  "String used by \\[comment-region] to comment out a block of code.
This should follow the convention for non-indenting comment lines so
that the indentation commands will not get confused (i.e., the string
should be of the form ‘#x...’ where ‘x’ is not a blank or a tab, and
                               ‘...’ is arbitrary).
However, this string should not end in whitespace."
  :type 'string
  :tag "ar-match-paren-key"
  :group 'ar-mode)

(defcustom ar-kill-empty-line t
  "If t, ‘ar-indent-forward-line’ kills empty lines."
  :type 'boolean
  :tag "ar-kill-empty-line"
  :group 'ar-mode)

(defcustom ar-imenu-show-method-args-p nil
  "Controls echoing of arguments of functions & methods in the Imenu buffer.
When non-nil, arguments are printed."
  :type 'boolean
  :tag "ar-imenu-show-method-args-p"
  :group 'ar-mode)

(defcustom ar-use-local-default nil
  "If t, ‘ar-shell’ will use ‘ar-shell-local-path’.

Alternative to default SOME.

Making switch between several virtualenv's easier,‘ar-mode’ should
deliver an installer, named-shells pointing to virtualenv's will be available."
  :type 'boolean
  :tag "ar-use-local-default"
  :group 'ar-mode)

(defcustom ar-edit-only-p nil
  "Do not check for installed SOME executables.

Default is nil.

See bug report at launchpad, lp:944093."
  :type 'boolean
  :tag "ar-edit-only-p"
  :group 'ar-mode)

(defcustom ar-force-ar-shell-name-p nil
  "When t, execution specified in ‘ar-shell-name’ is enforced.

Possibly shebang does not take precedence."

  :type 'boolean
  :tag "ar-force-ar-shell-name-p"
  :group 'ar-mode)

(defcustom ar-mode-v5-behavior-p nil
  "Execute region through ‘shell-command-on-region’.

As v5 did it - lp:990079.
This might fail with certain chars - see UnicodeEncodeError lp:550661"

  :type 'boolean
  :tag "ar-mode-v5-behavior-p"
  :group 'ar-mode)

(defcustom ar-trailing-whitespace-smart-delete-p nil
  "Default is nil.

When t, ‘ar-mode’ calls
\(add-hook \\='before-save-hook \\='delete-trailing-whitespace nil \\='local)

Also commands may delete trailing whitespace by the way.
When editing other peoples code, this may produce a larger diff than expected"
  :type 'boolean
  :tag "ar-trailing-whitespace-smart-delete-p"
  :group 'ar-mode)

(defcustom ar-newline-delete-trailing-whitespace-p t
  "Delete trailing whitespace maybe left by ‘ar-newline-and-indent’.

Default is t. See lp:1100892"
  :type 'boolean
  :tag "ar-newline-delete-trailing-whitespace-p"
  :group 'ar-mode)

(defcustom ar--warn-tmp-files-left-p nil
  "Warn, when ‘ar-temp-directory’ contains files susceptible being left.

WRT previous SOME-mode sessions. See also lp:987534."
  :type 'boolean
  :tag "ar--warn-tmp-files-left-p"
  :group 'ar-mode)

(defcustom ar-complete-ac-sources '(ac-source-pycomplete)
  "List of ‘auto-complete’ sources assigned to ‘ac-sources’.

In ‘ar-complete-initialize’.

Default is known to work an Ubuntu 14.10 - having SomeMode-
mode, pymacs and auto-complete-el, with the following minimal
Emacs initialization:

\(require \\='pymacs)
\(require \\='auto-complete-config)
\(ac-config-default)"
  :type 'hook
  :tag "ar-complete-ac-sources"
  :options '(ac-source-pycomplete ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers)
  :group 'ar-mode)

(defcustom ar-remove-cwd-from-path t
  "Whether to allow loading of SOME modules from the current directory.
If this is non-nil, Emacs removes '' from sys.path when starting
a SOME process.  This is the default, for security
reasons, as it is easy for the SOME process to be started
without the user's realization (e.g. to perform completion)."
  :type 'boolean
  :tag "ar-remove-cwd-from-path"
  :group 'ar-mode)

(defcustom ar-shell-local-path ""
  "‘ar-shell’ will use EXECUTABLE indicated here incl. path.

If ‘ar-use-local-default’ is non-nil."

  :type 'string
  :tag "ar-shell-local-path"
  :group 'ar-mode)

(defcustom ar-SomeMode-edit-version "SomeMode3"
  "Default is \"SomeMode3\".

When empty, version is guessed via ‘ar-choose-shell’."

  :type 'string
  :tag "ar-SomeMode-edit-version"
  :group 'ar-mode)

(defcustom ar-iSomeMode-execute-delay 0.3
  "Delay needed by execute functions when no ISOME shell is running."
  :type 'float
  :tag "ar-iSomeMode-execute-delay"
  :group 'ar-mode)

(defvar ar-shell-completion-setup-code
  "try:
    import readline
except ImportError:
    def __COMPLETER_all_completions(text): []
else:
    import rlcompleter
    readline.set_completer(rlcompleter.Completer().complete)
    def __COMPLETER_all_completions(text):
        import sys
        completions = []
        try:
            i = 0
            while True:
                res = readline.get_completer()(text, i)
                if not res: break
                i += 1
                completions.append(res)
        except NameError:
            pass
        return completions"
  "Code used to setup completion in SOME processes.")

(defvar ar-shell-module-completion-code "';'.join(__COMPLETER_all_completions('''%s'''))"
  "SOME code used to get completions separated by semicolons for imports.")

(defvar ar-iSomeMode-module-completion-code
  "import ISOME
version = ISOME.__version__
if \'0.10\' < version:
    from ISOME.core.completerlib import module_completion
"
  "For ISOME v0.11 or greater.
Use the following as the value of this variable:

';'.join(module_completion('''%s'''))")

(defvar ar-iSomeMode-module-completion-string
  "';'.join(module_completion('''%s'''))"
  "See also ‘ar-iSomeMode-module-completion-code’.")

(defcustom ar--imenu-create-index-function 'ar--imenu-index
  "Switch between ‘ar--imenu-create-index-new’  and series 5. index-machine."
  :type '(choice
          (const :tag "'ar--imenu-create-index-new, also lists modules variables " ar--imenu-create-index-new)

          (const :tag "ar--imenu-create-index, series 5. index-machine" ar--imenu-create-index)
          (const :tag "ar--imenu-index, honor type annotations" ar--imenu-index)

          )
  :tag "ar--imenu-create-index-function"
  :group 'ar-mode)

(defvar ar-line-re "^"
  "Used by generated functions." )

(defvar ar-input-filter-re "\\‘\\s-*\\S-?\\S-?\\s-*\\’"
  "Input matching this regexp is not saved on the history list.
Default ignores all inputs of 0, 1, or 2 non-blank characters.")

(defvar strip-chars-before  "\\`[ \t\r\n]*"
  "Regexp indicating which chars shall be stripped before STRING.

See also ‘string-chars-preserve’")

(defvar strip-chars-after  "[ \t\r\n]*\\'"
  "Regexp indicating which chars shall be stripped after STRING.

See also ‘string-chars-preserve’")

(defcustom ar-docstring-style 'pep-257-nn
  "Implemented styles:

 are DJANGO, ONETWO, PEP-257, PEP-257-NN,SYMMETRIC, and NIL.

A value of NIL wo not care about quotes
position and will treat docstrings a normal string, any other
value may result in one of the following docstring styles:

DJANGO:

    \"\"\"
    Process foo, return bar.
    \"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\"

ONETWO:

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.

    \"\"\"

PEP-257:

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"Process foo, return bar.

    If processing fails throw ProcessingError.

    \"\"\"

PEP-257-NN:

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\"

SYMMETRIC:

    \"\"\"Process foo, return bar.\"\"\"

    \"\"\"
    Process foo, return bar.

    If processing fails throw ProcessingError.
    \"\"\""
  :type '(choice

          (const :tag "Do not format docstrings" nil)
          (const :tag "Django's coding standards style." django)
          (const :tag "One newline and start and Two at end style." onetwo)
          (const :tag "PEP-257 with 2 newlines at end of string." pep-257)
          (const :tag "PEP-257-nn with 1 newline at end of string." pep-257-nn)
          (const :tag "Symmetric style." symmetric))
  :tag "ar-docstring-style"
  :group 'ar-mode)

(defcustom ar-execute-directory nil
  "Stores the file's default directory-name ar-execute-... functions act upon.

Used by SOME-shell for output of ‘ar-execute-buffer’ and related commands.
See also ‘ar-use-current-dir-when-execute-p’"
  :type 'string
  :tag "ar-execute-directory"
  :group 'ar-mode)

(defcustom ar-use-current-dir-when-execute-p t
  "Current directory used for output.

See also ‘ar-execute-directory’"
  :type 'boolean
  :tag "ar-use-current-dir-when-execute-p"
  :group 'ar-mode)

(defcustom ar-keep-shell-dir-when-execute-p nil
  "Do not change SOME shell's current working directory when sending code.

See also ‘ar-execute-directory’"
  :type 'boolean
  :tag "ar-keep-shell-dir-when-execute-p"
  :group 'ar-mode)

(defcustom ar-fileless-buffer-use-default-directory-p t
  "‘default-directory’ sets current working directory of SOME output shell.

When ‘ar-use-current-dir-when-execute-p’ is non-nil and no buffer-file exists."
  :type 'boolean
  :tag "ar-fileless-buffer-use-default-directory-p"
  :group 'ar-mode)

(defcustom ar-check-command "pychecker --stdlib"
  "Command used to check a SOME file."
  :type 'string
  :tag "ar-check-command"
  :group 'ar-mode)

;; (defvar ar-this-abbrevs-changed nil
;;   "Internally used by ‘ar-mode-hook’.")

(defvar ar-buffer-name nil
  "Internal use.

The buffer last output was sent to.")

(defvar ar-orig-buffer-or-file nil
  "Internal use.")

(defcustom ar-keep-windows-configuration nil
  "Takes precedence over:

 ‘ar-split-window-on-execute’ and ‘ar-switch-buffers-on-execute-p’.
See lp:1239498

To suppres window-changes due to error-signaling also.
Set ‘ar-keep-windows-configuration’ onto \\'force

Default is nil"

  :type '(choice
          (const :tag "nil" nil)
          (const :tag "t" t)
          (const :tag "force" force))
  :tag "ar-keep-windows-configuration"
  :group 'ar-mode)

(defvar ar-output-buffer ""
      "Used if ‘ar-mode-v5-behavior-p’ is t.

Otherwise output buffer is created dynamically according to version process.")

(defcustom ar-force-default-output-buffer-p nil
  "Enforce sending output to the default output ‘buffer-name’.

Set by defvar ‘ar-output-buffer’
Bug #31 - wrong fontification caused by string-delimiters in output"

  :type 'boolean
  :tag "ar-force-default-output-buffer-p"
  :group 'ar-mode)

(defcustom ar-shell-unbuffered t
  "Should shell output be unbuffered?.
When non-nil, this may prevent delayed and missing output in the
SOME shell.  See commentary for details."
  :type 'boolean
  :safe 'booleanp
  :tag "ar-shell-unbuffered"
  :group 'ar-mode)

(defcustom ar-shell-process-environment nil
  "List of overridden environment variables for subprocesses to inherit.
Each element should be a string of the form ENVVARNAME=VALUE.
When this variable is non-nil, values are exported into the
process environment before starting it.  Any variables already
present in the current environment are superseded by variables
set here."
  :type '(repeat string)
  :tag "ar-shell-process-environment"
  :group 'ar-mode)

(defcustom ar-shell-extra-SomeModepaths nil
  "List of extra SomeModepaths for SOME shell.
When this variable is non-nil, values added at the beginning of
the PYTHONPATH before starting processes.  Any values present
here that already exists in PYTHONPATH are moved to the beginning
of the list so that they are prioritized when looking for
modules."
  :type '(repeat string)
  :tag "ar-shell-extra-SomeModepaths"
  :group 'ar-mode)

(defcustom ar-shell-exec-path nil
  "List of paths for searching executables.
When this variable is non-nil, values added at the beginning of
the PATH before starting processes.  Any values present here that
already exists in PATH are moved to the beginning of the list so
that they are prioritized when looking for executables."
  :type '(repeat string)
  :tag "ar-shell-exec-path"
  :group 'ar-mode)

(defcustom ar-shell-remote-exec-path nil
  "List of paths to be ensured remotely for searching executables.
When this variable is non-nil, values are exported into remote
hosts PATH before starting processes.  Values defined in
‘ar-shell-exec-path’ will take precedence to paths defined
here.  Normally you wont use this variable directly unless you
plan to ensure a particular set of paths to all SOME shell
executed through tramp connections."
  :version "25.1"
  :type '(repeat string)
  :tag "ar-shell-remote-exec-path"
  :group 'ar-mode)

(defcustom ar-shell-virtualenv-root nil
  "Path to virtualenv root.
This variable, when set to a string, makes the environment to be
modified such that shells are started within the specified
virtualenv."
  :type '(choice (const nil) string)
  :tag "ar-shell-virtualenv-root"
  :group 'ar-mode)

(defcustom ar-start-in-virtualenv-p nil
  "When ‘ar-shell-virtualenv-root’ is set, Emacs should start there."
  :type 'boolean
  :tag "ar-start-in-virtualenv-p"
  :group 'ar-mode)

(defvar ar-shell-completion-native-redirect-buffer
  " *Py completions redirect*"
  "Buffer to be used to redirect output of readline commands.")

(defvar ar-shell--block-prompt nil
  "Input block prompt for inferior SomeMode shell.
Do not set this variable directly, instead use
‘ar-shell-prompt-set-calculated-regexps’.")

(defvar ar-shell-output-filter-in-progress nil)
(defvar ar-shell-output-filter-buffer nil)

(defvar ar-shell--prompt-calculated-input-regexp nil
  "Calculated input prompt regexp for inferior SomeMode shell.
Do not set this variable directly.

Iff ‘ar-shell--prompt-calculated-input-regexp’
or ‘ar-shell--prompt-calculated-output-regexp’ are set
‘ar-shell-prompt-set-calculated-regexps’ is not run.")

(defvar ar-shell--prompt-calculated-output-regexp nil
  "Calculated output prompt regexp for inferior SomeMode shell.

‘ar-shell-prompt-set-calculated-regexps’
Do not set this variable directly.

Iff ‘ar-shell--prompt-calculated-input-regexp’
or ‘ar-shell--prompt-calculated-output-regexp’ are set
‘ar-shell-prompt-set-calculated-regexps’ is not run.")

(defvar ar-shell-prompt-output-regexp ""
  "See ‘ar-shell-prompt-output-regexps’.")

(defvar ar-shell-prompt-output-regexps
  '(""                                  ; SOME
    "Out\\[[0-9]+\\]: "                 ; ISOME
    "Out :")                            ; ipdb safeguard
  "List of regular expressions matching output prompts.")

(defvar ar-underscore-word-syntax-p t
  "This is set later by defcustom, only initial value here.

If underscore chars should be of ‘syntax-class’ ‘word’, not of ‘symbol’.
Underscores in word-class makes ‘forward-word’.
Travels the indentifiers. Default is t.
See also command ‘ar-toggle-underscore-word-syntax-p’")

(defvar ar-autofill-timer nil)
(defvar ar-fill-column-orig fill-column
  "Used to reset fill-column")

;; defvared value is not updated maybe
(defvar ar-mode-message-string
  (if (or (string= "SomeMode-mode.el" (buffer-name))
          (ignore-errors (string-match "SomeMode-mode.el" (ar--buffer-filename-remote-maybe))))
      "SomeMode-mode.el"
    "ar-mode") ;; generic mark
  "Internally used. Reports the ‘ar-mode’ branch.")

;; defvared value is not updated maybe
(setq ar-mode-message-string
  (if (or (string= "SomeMode-mode.el" (buffer-name))
          (ignore-errors (string-match "SomeMode-mode.el" (ar--buffer-filename-remote-maybe))))
      "SomeMode-mode.el"
    "ar-mode")) ;; generic mark

(defvar ar-mode-syntax-table nil
  "Give punctuation syntax to ASCII that normally has symbol.

Syntax or has word syntax and is not a letter.")

(setq ar-mode-syntax-table
      (let ((table (make-syntax-table)))
        ;; Give punctuation syntax to ASCII that normally has symbol
        ;; syntax or has word syntax and is not a letter.
        (let ((symbol (string-to-syntax "_"))
              (sst (standard-syntax-table)))
          (dotimes (i 128)
            (unless (= i ?_)
              (if (equal symbol (aref sst i))
                  (modify-syntax-entry i "." table)))))
        (modify-syntax-entry ?$ "." table)
        (modify-syntax-entry ?% "." table)
        ;; exceptions
        (modify-syntax-entry ?# "<" table)
        (modify-syntax-entry ?\n ">" table)
        (modify-syntax-entry ?' "\"" table)
        (modify-syntax-entry ?` "$" table)
        (if ar-underscore-word-syntax-p
            (modify-syntax-entry ?\_ "w" table)
          (modify-syntax-entry ?\_ "_" table))
        table))

(defvar ar-shell-mode-syntax-table nil
  "Set from ar-shell")

(defvar ar-iSomeMode-completion-command-string nil
  "Select command according to ISOME version.

Either ‘ar-iSomeMode0.10-completion-command-string’
or ‘ar-iSomeMode0.11-completion-command-string’.

‘ar-iSomeMode0.11-completion-command-string’ also covers version 0.12")

(defvar ar-iSomeMode0.10-completion-command-string
  "print(';'.join(__IP.Completer.all_completions('%s'))) #PYTHON-MODE SILENT\n"
  "The string send to iSomeMode to query for all possible completions.")

(defvar ar-iSomeMode0.11-completion-command-string
  "print(';'.join(get_iSomeMode().Completer.all_completions('%s'))) #PYTHON-MODE SILENT\n"
  "The string send to iSomeMode to query for all possible completions.")

(defvar ar-encoding-string-re "^[ \t]*#[ \t]*-\\*-[ \t]*coding:.+-\\*-"
  "Matches encoding string of a SOME file.")

(defvar ar-shebang-regexp "#![ \t]?\\([^ \t\n]+\\)[ \t]*\\([biptj]+ython[^ \t\n]*\\)"
  "Detecting the shell in head of file.")

(defvar ar-temp-directory
  (let ((ok #'(lambda (x)
               (and x
                    (setq x (expand-file-name x)) ; always true
                    (file-directory-p x)
                    (file-writable-p x)
                    x)))
        erg)
    (or
     (and (not (string= "" ar-custom-temp-directory))
          (if (funcall ok ar-custom-temp-directory)
              (setq erg (expand-file-name ar-custom-temp-directory))
            (if (file-directory-p (expand-file-name ar-custom-temp-directory))
                (error "ar-custom-temp-directory set but not writable")
              (error "ar-custom-temp-directory not an existing directory"))))
     (and (funcall ok (getenv "TMPDIR"))
          (setq erg (getenv "TMPDIR")))
     (and (funcall ok (getenv "TEMP/TMP"))
          (setq erg (getenv "TEMP/TMP")))
     (and (funcall ok "/usr/tmp")
          (setq erg "/usr/tmp"))
     (and (funcall ok "/tmp")
          (setq erg "/tmp"))
     (and (funcall ok "/var/tmp")
          (setq erg "/var/tmp"))
     (and (eq system-type 'darwin)
          (funcall ok "/var/folders")
          (setq erg "/var/folders"))
     (and (or (eq system-type 'ms-dos)(eq system-type 'windows-nt))
          (funcall ok (concat "c:" ar-separator-char "Users"))
          (setq erg (concat "c:" ar-separator-char "Users")))
     ;; (funcall ok ".")
     (error
      "Could not find a usable temp directory -- set ‘ar-temp-directory’"))
    (when erg (setq ar-temp-directory erg)))
  "Directory used for temporary files created by a *SOME* process.
By default, guesses the first directory from this list that exists and that you
can write into: the value (if any) of the environment variable TMPDIR,
/usr/tmp, /tmp, /var/tmp, or the current directory.

 ‘ar-custom-temp-directory’ will take precedence when setq")

(defvar ar-exec-command nil
  "Internally used.")

(defvar ar-which-bufname "SOME")

(defvar ar-pychecker-history nil)

(defvar ar-pyflakes3-history nil)

(defvar ar-pep8-history nil)

(defvar ar-pyflakespep8-history nil)

(defvar ar-pylint-history nil)

(defvar ar-mode-output-map nil
  "Keymap used in *SOME Output* buffers.")

(defvar hs-hide-comments-when-hiding-all t
  "Defined in hideshow.el, silence compiler warnings here.")

(defvar ar-shell-complete-debug nil
  "For interal use when debugging, stores completions." )

(defvar ar-debug-p nil
  "Activate extra code for analysis and test purpose when non-nil.

Temporary files are not deleted. Other functions might implement
some logging, etc.
For normal operation, leave it set to nil, its default.
Defined with a defvar form to allow testing the loading of new versions.")

(defcustom ar-shell-complete-p nil
  "Enable native completion."

  :type 'boolean
  :tag "ar-shell-complete-p"
  :group 'ar-mode)
(make-variable-buffer-local 'ar-shell-complete-p)

(defcustom ar-section-start "# {{"
  "Delimit arbitrary chunks of code."
  :type 'string
  :tag "ar-section-start"
  :group 'ar-mode)

(defcustom ar-section-end "# }}"
  "Delimit arbitrary chunks of code."
  :type 'string
  :tag "ar-section-end"
  :group 'ar-mode)

(defvar ar-section-re ar-section-start)

(defvar ar-last-window-configuration nil
  "Internal use.

Restore ‘ar-restore-window-configuration’.")

(defvar ar-exception-buffer nil
  "Will be set internally.

Remember source buffer where error might occur.")

(defvar ar-string-delim-re "\\(\"\"\"\\|'''\\|\"\\|'\\)"
  "When looking at beginning of string.")

(defvar ar-star-labelled-re "[ \\t]*[\\*-] +[[:graph:]]"
  "When looking at a star label.")

(defvar ar-colon-labelled-re "[ \\t]*[[:graph:]]* * :  *[[:graph:]]+"
  "When looking at a colon label.")
;; (setq ar-colon-labelled-re "[ \\t]*[[:graph:]]* *: *[[:graph:]]+\\|[ \\t]*[\\*-] +[[:graph:]]")

(defvar ar-labelled-re (concat ar-colon-labelled-re "\\|" ar-star-labelled-re)
  "When looking at label.")

;; "[ \t]+\\c.+"
(defvar ar-symbol-re "[ \t]*\\c.+[ \t]*$"
  "Matching lines only containing symbols.")
(setq ar-symbol-re "[ \t]*\\c.+[ \t]*")

(defvar ar-expression-skip-regexp "[^ (=:#\t\r\n\f]"
  "Expression possibly composing a ‘ar-expression’.")

(defvar ar-expression-skip-chars "^ (=#\t\r\n\f"
  "Chars composing a ‘ar-expression’.")

(setq ar-expression-skip-chars "^ [{(=#\t\r\n\f")

(defvar ar-expression-re "[^ =#\t\r\n\f]+"
  "Expression possibly composing a ‘ar-expression’.")

(defcustom ar-paragraph-re paragraph-start
  "Allow SOME specific ‘paragraph-start’ var."
  :type 'string
  :tag "ar-paragraph-re"
  :group 'ar-mode)

(defvar ar-not-expression-regexp "[ .=#\t\r\n\f)]+"
  "Regexp indicated probably will not compose a ‘ar-expression’.")

(defvar ar-not-expression-chars " #\t\r\n\f"
  "Chars indicated probably will not compose a ‘ar-expression’.")

;; (defvar ar-partial-expression-stop-backward-chars "^] .=,\"'()[{}:#\t\r\n\f"
(defvar ar-partial-expression-stop-backward-chars "^] .=,\"'()[{}:#\t\r\n\f"
    "Chars indicated which not possibly compose a ‘ar-partial-expression’,
stop at it.")
;; (setq ar-partial-expression-stop-backward-chars "^] .=,\"'()[{}:#\t\r\n\f")

(defvar ar-partial-expression-forward-chars "^ .\"')}]:#\t\r\n\f")
;; (setq ar-partial-expression-forward-chars "^ .\"')}]:#\t\r\n\f")

(defvar ar-partial-expression-re (concat "[" ar-partial-expression-stop-backward-chars (substring ar-partial-expression-forward-chars 1) "]+"))
(setq ar-partial-expression-re (concat "[" ar-partial-expression-stop-backward-chars "]+"))

;; (defvar ar-statement-re ar-partial-expression-re)
(defvar ar-statement-re "[^] .=,\"'()[{}:#
]+" "Match beginning of a statement")

(defvar ar-indent-re ".+"
  "This var is introduced for regularity only.")
(setq ar-indent-re ".+")

(defvar ar-operator-re "[ \t]*\\(\\.\\|+\\|-\\|*\\|//\\|//\\|&\\|%\\||\\|\\^\\|>>\\|<<\\|<\\|<=\\|>\\|>=\\|==\\|!=\\|=\\)[ \t]*"
  "Matches most of SOME syntactical meaningful characters.

See also ‘ar-assignment-re’")

;; (setq ar-operator-re "[ \t]*\\(\\.\\|+\\|-\\|*\\|//\\|//\\|&\\|%\\||\\|\\^\\|>>\\|<<\\|<\\|<=\\|>\\|>=\\|==\\|!=\\|=\\)[ \t]*")

(defvar ar-delimiter-re "\\(\\.[[:alnum:]]\\|,\\|;\\|:\\)[ \t\n]"
  "Delimiting elements of lists or other programming constructs.")

(defvar ar-line-number-offset 0
  "When an exception occurs as a result of ‘ar-execute-region’.

A subsequent ‘ar-up-exception’ needs the line number where the region
started, in order to jump to the correct file line.
This variable is set in ‘ar-execute-region’ and used in ‘ar--jump-to-exception’.")

(defvar ar-match-paren-no-use-syntax-pps nil)

(defvar ar-traceback-line-re
  "[ \t]+File \"\\([^\"]+\\)\", line \\([0-9]+\\)"
  "Regular expression that describes tracebacks.")

(defvar ar-XXX-tag-face 'ar-XXX-tag-face)

(defvar ar-pseudo-keyword-face 'ar-pseudo-keyword-face)

(defface ar-variable-name-face
  '((t (:inherit font-lock-variable-name-face)))
  "Face method decorators."
  :tag "ar-variable-name-face"
  :group 'ar-mode)

(defvar ar-variable-name-face 'ar-variable-name-face)
(setq ar-variable-name-face 'ar-variable-name-face)

(defvar ar-number-face 'ar-number-face)

(defvar ar-decorators-face 'ar-decorators-face)

(defvar ar-object-reference-face 'ar-object-reference-face)

(defvar ar-builtins-face 'ar-builtins-face)

(defvar ar-class-name-face 'ar-class-name-face)

(defvar ar-def-face 'ar-def-face)

(defvar ar-exception-name-face 'ar-exception-name-face)

(defvar ar-import-from-face 'ar-import-from-face)

(defvar ar-def-class-face 'ar-def-class-face)

(defvar ar-try-if-face 'ar-try-if-face)

(defvar ar-file-queue nil
  "Queue of SOME temp files awaiting execution.
Currently-active file is at the head of the list.")

(defvar jython-mode-hook nil
  "Hook called by ‘jython-mode’.
‘jython-mode’ also calls ‘ar-mode-hook’.")

(defvar ar-shell-hook nil
  "Hook called by ‘ar-shell’.")

;; (defvar ar-font-lock-keywords nil)

(defvar ar-dotted-expression-syntax-table
  (let ((table (make-syntax-table ar-mode-syntax-table)))
    (modify-syntax-entry ?_ "_" table)
    (modify-syntax-entry ?."_" table)
    table)
  "Syntax table used to identify SOME dotted expressions.")

(defvar ar-default-template "if"
  "Default template to expand by ‘SomeMode-expand-template’.
Updated on each expansion.")

(defvar-local ar-already-guessed-indent-offset nil
  "Internal use by ‘ar-indent-line’.

When ‘this-command’ is ‘eq’ to ‘last-command’, use the guess already computed.")

(defvar ar-shell-template "
\(defun NAME (&optional argprompt)
  \"Start an DOCNAME interpreter in another window.

With optional \\\\[universal-argument] user is prompted
for options to pass to the DOCNAME interpreter. \"
  (interactive \"P\")
  (let\* ((ar-shell-name \"FULLNAME\"))
    (ar-shell argprompt)
    (when (called-interactively-p 'interactive)
      (switch-to-buffer (current-buffer))
      (goto-char (point-max)))))
")

;; Constants
(defconst ar-block-closing-keywords-re
  "[ \t]*\\_<\\(return\\|raise\\|break\\|continue\\|pass\\)\\_>[ \n\t]*"
  "Matches the beginning of a class, method or compound statement.")

(setq ar-block-closing-keywords-re
  "[ \t]*\\_<\\(return\\|raise\\|break\\|continue\\|pass\\)\\_>[ \n\t]*")

(defconst ar-finally-re
  "[ \t]*\\_<finally:"
  "Regular expression matching keyword which closes a try-block.")

(defconst ar-except-re "[ \t]*\\_<except\\_>"
  "Matches the beginning of a ‘except’ block.")

;; (defconst ar-except-re
;;   "[ \t]*\\_<except\\_>[:( \n\t]*"
;;   "Regular expression matching keyword which composes a try-block.")

(defconst ar-return-re
  ".*:?[ \t]*\\_<\\(return\\)\\_>[ \n\t]*"
  "Regular expression matching keyword which typically closes a function.")

(defconst ar-decorator-re
  "[ \t]*@[^ ]+\\_>[ \n\t]*"
  "Regular expression matching keyword which typically closes a function.")

(defcustom ar-outdent-re-raw
  (regexp-opt (list
               "case"
               "elif"
               "else"
               "except"
               "finally"
               )
              'symbols)
  "Used by ‘ar-outdent-re’."
  :type '(repeat string)
  :tag "ar-outdent-re-raw"
  :group 'ar-mode)

(defconst ar-outdent-re
  (concat "\\(" (mapconcat 'identity
                           '(
	                     "case"
                             "else:"
                             "except\\(\\s +.*\\)?:"
                             "finally:"
                             "elif\\s +.*:")
                           "\\|")
          "\\)")
  "Regular expression matching statements to be dedented one level.")

(defconst ar-no-outdent-re
  (concat
   "\\("
   (mapconcat 'identity
              (list "try:"
                    "except\\(\\s +.*\\)?:"
                    "while\\s +.*:"
                    "for\\s +.*:"
                    "if\\s +.*:"
                    "elif\\s +.*:"
                    (concat ar-block-closing-keywords-re "[ \t\n]")
                    )
              "\\|")
          "\\)")
  "Regular expression matching lines not to dedent after.")

;; (defcustom ar-no-outdent-re-raw
;;   (regexp-opt (list
;;                "break"
;;                "continue"
;;                "import"
;;                "pass"
;;                "raise"
;;                "return")
;;               'symbols)
;;   "Uused by ‘ar-no-outdent-re’."
;;   :type '(repeat string)
;;   :tag "ar-no-outdent-re-raw"
;;   :group 'ar-mode)

;; (defconst ar-no-outdent-re
;;   (concat
;;    "[ \t]*"
;;    ar-no-outdent-re-raw
;;    "[)\t]*$")
;; "Regular expression matching lines not to augment indent after.

;; See ‘ar-no-outdent-re-raw’ for better readable content")

(defconst ar-assignment-re "\\(\\_<\\w+\\_>[[:alnum:]:, \t]*[ \t]*\\)\\(=\\|+=\\|*=\\|%=\\|&=\\|^=\\|<<=\\|-=\\|/=\\|**=\\||=\\|>>=\\|//=\\)\\(.*\\)"
  "If looking at the beginning of an assignment.")

;; 'name':
(defconst ar-dict-re "'\\_<\\w+\\_>':")

(defcustom ar-block-re-raw
  (regexp-opt (list
               "async def"
               "async for"
               "async with"
               "class"
               "def"
               "for"
               "if"
               "match"
               "try"
               "while"
               "with"
               )
              'symbols)
  "Matches the beginning of a compound statement but not its clause."
  :type '(repeat string)
  :tag "ar-block-re-raw"
  :group 'ar-mode)

(defconst ar-block-re (concat
                       ;; def main():
                       ;; |   if len(sys.argv) == 1:
                       ;;         usage()
                       ;;         # sys.exit()

                       ;;     class asdf(object):
                       ar-block-re-raw
                       ".*[:( \n\t]"
                       )
  "Matches the beginning of a compound statement.")

(defconst ar-minor-block-re-raw (regexp-opt
                                 (list
                                      "async for"
                                      "async with"
                                      "case"
                                      "except"
                                      "for"
                                      "if"
                                      "match"
                                      "try"
                                      "with"
                                      )
                                 'symbols)
  "Matches the beginning of an case ‘for’, ‘if’, ‘try’, ‘except’ or ‘with’ block.")

(defconst ar-minor-block-re
  (concat
   ar-minor-block-re-raw
   "[:( \n\t]")

  "Regular expression matching lines not to augment indent after.

See ‘ar-minor-block-re-raw’ for better readable content")

(defconst ar-try-re-raw (regexp-opt (list "try") 'symbols)
  "Matches the beginning of a ‘try’ block.")

(defconst ar-try-re (concat ar-try-re-raw "[: \n\t]")
  "Matches the beginning of a ‘try’ block.")

(defconst ar-case-re "[ \t]*\\_<case\\_>[: \t][^:]*:"
  "Matches a ‘case’ clause.")

(defconst ar-match-case-re "[ \t]*\\_<match\\|case\\_>[: \t][^:]*:"
  "Matches a ‘match case’ clause.")

(defconst ar-for-re "[ \t]*\\_<\\(async for\\|for\\)\\_> +[[:alpha:]_][[:alnum:]_]* +in +[[:alpha:]_][[:alnum:]_()]* *[: \n\t]"
  "Matches the beginning of a ‘try’ block.")

(defconst ar-if-re "[ \t]*\\_<if\\_>[ (]+"
  "Matches the beginning of an ‘if’ block.")

(defconst ar-else-re "[ \t]*\\_<else:"
  "Matches the beginning of an ‘else’ block.")

(setq ar-else-re "else")

(defconst ar-elif-re "[ \t]*\\_<\\elif\\_>[( \n\t]"
  "Matches the beginning of a compound if-statement's clause exclusively.")

;; (defconst ar-elif-block-re "[ \t]*\\_<elif\\_> +[[:alpha:]_][[:alnum:]_]* *[: \n\t]"
;;   "Matches the beginning of an ‘elif’ block.")

(defconst ar-class-re-raw  (regexp-opt (list "class") 'symbol)
  "Matches the beginning of a class definition.")

(defconst ar-class-re (concat ar-class-re-raw "[ \n\t]")
  "Matches the beginning of a class definition.")

(defconst ar-def-or-class-re-raw (regexp-opt
                                  (list
                                  "async def"
                                  "class"
                                  "def")
  'symbol)
"Matches the beginning of a class- or functions definition.")

;; (defconst ar-def-or-class-re (concat ar-def-or-class-re-raw
(defconst ar-def-or-class-re (concat ar-def-or-class-re-raw
                                     "[ \n\t]+\\([[:alnum:]_]*\\)")
  "Matches the beginning of a class- or functions definition.

Second group grabs the name")

;; (setq ar-def-or-class-re "[ \t]*\\_<\\(async def\\|class\\|def\\)\\_>[ \n\t]")

;; (defconst ar-def-re "[ \t]*\\_<\\(async def\\|def\\)\\_>[ \n\t]"

(defvar ar-def-re-raw (regexp-opt (list
                                   "def"
                                   "async def"
                                   )
                                  'symbol)
  "Matches the beginning of a functions definition.")

(defconst ar-def-re (concat ar-def-re-raw "[ \n\t]")
  "Matches the beginning of a functions definition.")

(defcustom ar-block-or-clause-re-raw
  (regexp-opt (list
               "async for"
               "async with"
               "async def"
               "async class"
               "class"
               "def"
               "elif"
               "else"
               "except"
               "finally"
               "for"
               "if"
               "try"
               "while"
               "with"
               "match"
               "case"
               )
              'symbols)
  "Matches the beginning of a compound statement or its clause."
  :type '(repeat string)
  :tag "ar-block-or-clause-re-raw"
  :group 'ar-mode)

(defvar ar-block-or-clause-re
  (concat
   ar-block-or-clause-re-raw
   "[( \t]*.*:?")
  "See ‘ar-block-or-clause-re-raw’, which it reads.")

(defcustom ar-extended-block-or-clause-re-raw
  (list
   "async def"
   "async for"
   "async with"
   "class"
   "def"
   "elif"
   "else"
   "except"
   "finally"
   "for"
   "if"
   "try"
   "while"
   "with"
   "match"
   "case"
   )
  "Matches the beginning of a compound statement or its clause."
  :type '(repeat string)
  :tag "ar-extended-block-or-clause-re-raw"
  :group 'ar-mode)

(defconst ar-extended-block-or-clause-re
  (concat
   (regexp-opt  ar-extended-block-or-clause-re-raw 'symbols)
   "[( \t:]+")
  "See ‘ar-block-or-clause-re-raw’, which it reads.")

(defconst ar-clause-re ar-extended-block-or-clause-re
  "See also ar-minor-clause re.")

(defcustom ar-minor-clause-re-raw
  (list
   "case"
   "elif"
   "else"
   "except"
   "finally"
   )
  "Matches the beginning of a clause."
    :type '(repeat string)
    :tag "ar-minor-clause-re-raw"
    :group 'ar-mode)

(defconst ar-minor-clause-re
  (concat
   (regexp-opt  ar-minor-clause-re-raw 'symbols)
   "[( \t]*.*:")
  "See ‘ar-minor-clause-re-raw’, which it reads.")

(defcustom ar-top-level-re
  (concat
   "^[a-zA-Z_]"
   (regexp-opt  ar-extended-block-or-clause-re-raw)
   "[( \t]*.*:?")
  "A form which starts at zero indent level, but is not a comment."
  :type '(regexp)
  :tag "ar-top-level-re"
  :group 'ar-mode
  )

(defvar ar-comment-re "#[ \t]*"
  "Needed for normalized processing.")

(defcustom ar-block-re-raw
  (regexp-opt (list
               "async for"
               "async with"
               "async def"
               "async class"
               "class"
               "def"
               "for"
               "if"
               "try"
               "while"
               "with"
               "match"
               )
              'symbols)
  "Matches the beginning of a compound statement or its clause."
  :type '(repeat string)
  :tag "ar-block-or-clause-re-raw"
  :group 'ar-mode)

(defconst ar-block-keywords
  (concat "[ \t]*"
          ar-block-or-clause-re-raw
          "[( \t]*.*:")
  "Matches known keywords opening a block.

Customizing ‘ar-block-re-raw’  will change values here")

(defconst ar-try-clause-re
  (concat
   "[ \t]*\\_<\\("
   (mapconcat 'identity
              (list
               "else"
               "except"
               "finally")
              "\\|")
   "\\)\\_>[( \t]*.*:")
  "Matches the beginning of a compound try-statement's clause.")

(defcustom ar-compilation-regexp-alist
  `((,(rx line-start (1+ (any " \t")) "File \""
          (group (1+ (not (any "\"<")))) ; avoid ‘<stdin>’ &c
          "\", line " (group (1+ digit)))
     1 2)
    (,(rx " in file " (group (1+ not-newline)) " on line "
          (group (1+ digit)))
     1 2)
    (,(rx line-start "> " (group (1+ (not (any "(\"<"))))
          "(" (group (1+ digit)) ")" (1+ (not (any "("))) "()")
     1 2))
  "Fetch errors from ar-shell.
hooked into ‘compilation-error-regexp-alist’"
  :type '(alist string)
  :tag "ar-compilation-regexp-alist"
  :group 'ar-mode)

(defconst ar-font-lock-syntactic-keywords
  ;; Make outer chars of matching triple-quote sequences into generic
  ;; string delimiters.  Fixme: Is there a better way?
  ;; First avoid a sequence preceded by an odd number of backslashes.
  `((,(concat "\\(?:^\\|[^\\]\\(?:\\\\.\\)*\\)" ;Prefix.
              "\\(?1:\"\\)\\(?2:\"\\)\\(?3:\"\\)\\(?4:\"\\)\\(?5:\"\\)\\(?6:\"\\)\\|\\(?1:\"\\)\\(?2:\"\\)\\(?3:\"\\)\\|\\(?1:'\\)\\(?2:'\\)\\(?3:'\\)\\(?4:'\\)\\(?5:'\\)\\(?6:'\\)\\|\\(?1:'\\)\\(?2:'\\)\\(?3:'\\)\\(?4:'\\)\\(?5:'\\)\\(?6:'\\)\\|\\(?1:'\\)\\(?2:'\\)\\(?3:'\\)")
     (1 (ar--quote-syntax 1) t t)
     (2 (ar--quote-syntax 2) t t)
     (3 (ar--quote-syntax 3) t t)
     (6 (ar--quote-syntax 1) t t))))

(defconst ar--windows-config-register 313465889
  "Internal used by ‘window-configuration-to-register’.")

;; (setq ar--windows-config-register 313;; 465889)

;; testing
(defvar ar-ert-test-default-executables
  (list "SomeMode" "SomeMode3" "iSomeMode")
  "Serialize tests employing dolist.")

(defcustom ar-shell-unfontify-p t
  "Run ‘ar--run-unfontify-timer’ unfontifying the shell banner-text.

Default is nil"

  :type 'boolean
  :tag "ar-shell-unfontify-p"
  :group 'ar-mode)

;; Pdb
;; #62, pdb-track in a shell buffer
(defcustom pdb-track-stack-from-shell-p t
  "If t, track source from shell-buffer.

Default is t.
Add hook \\='comint-output-filter-functions \\='ar--pdbtrack-track-stack-file"

  :type 'boolean
  :tag "pdb-track-stack-from-shell-p"
  :group 'ar-mode)

(defvar gud-pdb-history ""
  "Silence compiler warning.")

(defcustom ar-update-gud-pdb-history-p t
  "If pdb should provide suggestions WRT file to check and ‘ar-pdb-path’.

Default is t
See lp:963253"
  :type 'boolean
  :tag "ar-update-gud-pdb-history-p"
  :group 'ar-mode)

(defcustom ar-pdb-executable nil
  "Indicate PATH/TO/pdb.

Default is nil
See lp:963253"
  :type 'string
  :tag "ar-pdb-executable"
  :group 'ar-mode)

(defcustom ar-pdb-path
  (if (or (eq system-type 'ms-dos)(eq system-type 'windows-nt))
      (quote c:/SomeMode27/SomeMode\ -i\ c:/SomeMode27/Lib/pdb.py)
    '/usr/lib/SomeMode2.7/pdb.py)
  "Where to find pdb.py.  Edit this according to your system.
For example \"/usr/lib/SomeMode3.4\" might be an option too.

If you ignore the location `M-x ar-guess-pdb-path' might display it."
  :type 'variable
  :tag "ar-pdb-path"
  :group 'ar-mode)

(defvar ar-SomeMode-ms-pdb-command ""
  "MS-systems might use that.")

(defcustom ar-shell-prompt-pdb-regexp "[(<]*[Ii]?[Pp]db[>)]+ "
  "Regular expression matching pdb input prompt of SOME shell.
It should not contain a caret (^) at the beginning."
  :type 'string
  :tag "ar-shell-prompt-pdb-regexp"
  :group 'ar-mode)

(defcustom ar-pdbtrack-stacktrace-info-regexp
  "> \\([^\"(<]+\\)(\\([0-9]+\\))\\([?a-zA-Z0-9_<>]+\\)()"
  "Regular expression matching stacktrace information.
Used to extract the current line and module being inspected."
  :type 'string
  :safe 'stringp
  :tag "ar-pdbtrack-stacktrace-info-regexp"
  :group 'ar-mode)

(defvar ar-pdbtrack-tracked-buffer nil
  "Variable containing the value of the current tracked buffer.
Never set this variable directly, use
‘ar-pdbtrack-set-tracked-buffer’ instead.")

(defvar ar-pdbtrack-buffers-to-kill nil
  "List of buffers to be deleted after tracking finishes.")

(defcustom ar-pdbtrack-do-tracking-p t
  "Controls whether the pdbtrack feature is enabled or not.
When non-nil, pdbtrack is enabled in all comint-based buffers,
e.g. shell buffers and the *SOME* buffer.  When using pdb to debug a
SOME program, pdbtrack notices the pdb prompt and displays the
source file and line that the program is stopped at, much the same way
as ‘gud-mode’ does for debugging C programs with gdb."
  :type 'boolean
  :tag "ar-pdbtrack-do-tracking-p"
  :group 'ar-mode)
(make-variable-buffer-local 'ar-pdbtrack-do-tracking-p)

(defcustom ar-pdbtrack-filename-mapping nil
  "Supports mapping file paths when opening file buffers in pdbtrack.
When non-nil this is an alist mapping paths in the SOME interpreter
to paths in Emacs."
  :type 'alist
  :tag "ar-pdbtrack-filename-mapping"
  :group 'ar-mode)

(defcustom ar-pdbtrack-minor-mode-string " PDB"
  "String to use in the minor mode list when pdbtrack is enabled."
  :type 'string
  :tag "ar-pdbtrack-minor-mode-string"
  :group 'ar-mode)

(defconst ar-pdbtrack-stack-entry-regexp
   (concat ".*\\("ar-shell-input-prompt-1-regexp">\\|"ar-iSomeMode-input-prompt-re">\\|>\\) *\\(.*\\)(\\([0-9]+\\))\\([?a-zA-Z0-9_<>()]+\\)()")
  "Regular expression pdbtrack uses to find a stack trace entry.")

(defconst ar-pdbtrack-marker-regexp-file-group 2
  "Group position in gud-pydb-marker-regexp that matches the file name.")

(defconst ar-pdbtrack-marker-regexp-line-group 3
  "Group position in gud-pydb-marker-regexp that matches the line number.")

(defconst ar-pdbtrack-marker-regexp-funcname-group 4
  "Group position in gud-pydb-marker-regexp that matches the function name.")

(defconst ar-pdbtrack-track-range 10000
  "Max number of characters from end of buffer to search for stack entry.")

(defvar ar-pdbtrack-is-tracking-p nil)

(defvar ar--docbeg nil
  "Internally used by ‘ar--write-edit’.")

(defvar ar--docend nil
  "Internally used by ‘ar--write-edit’.")

(defvar ar-completion-setup-code  "def __PYTHON_EL_get_completions(text):
    completions = []
    completer = None

    try:
        import readline

        try:
            import __builtin__
        except ImportError:
            # SOME 3
            import builtins as __builtin__
        builtins = dir(__builtin__)

        is_iSomeMode = ('__ISOME__' in builtins or
                      '__ISOME__active' in builtins)
        splits = text.split()
        is_module = splits and splits[0] in ('from', 'import')

        if is_iSomeMode and is_module:
            from ISOME.core.completerlib import module_completion
            completions = module_completion(text.strip())
        elif is_iSomeMode and '__IP' in builtins:
            completions = __IP.complete(text)
        elif is_iSomeMode and 'get_iSomeMode' in builtins:
            completions = get_iSomeMode().Completer.all_completions(text)
        else:
            # Try to reuse current completer.
            completer = readline.get_completer()
            if not completer:
                # importing rlcompleter sets the completer, use it as a
                # last resort to avoid breaking customizations.
                import rlcompleter
                completer = readline.get_completer()
            if getattr(completer, 'PYTHON_EL_WRAPPED', False):
                completer.print_mode = False
            i = 0
            while True:
                completion = completer(text, i)
                if not completion:
                    break
                i += 1
                completions.append(completion)
    except:
        pass
    finally:
        if getattr(completer, 'PYTHON_EL_WRAPPED', False):
            completer.print_mode = True
    return completions"
  "Code used to setup completion in inferior SOME processes.")

(defcustom ar-completion-setup-code
  "
def __PYTHON_EL_get_completions(text):
    completions = []
    completer = None

    try:
        import readline

        try:
            import __builtin__
        except ImportError:
            # SOME 3
            import builtins as __builtin__
        builtins = dir(__builtin__)

        is_iSomeMode = ('__ISOME__' in builtins or
                      '__ISOME__active' in builtins)
        splits = text.split()
        is_module = splits and splits[0] in ('from', 'import')

        if is_iSomeMode and is_module:
            from ISOME.core.completerlib import module_completion
            completions = module_completion(text.strip())
        elif is_iSomeMode and '__IP' in builtins:
            completions = __IP.complete(text)
        elif is_iSomeMode and 'get_iSomeMode' in builtins:
            completions = get_iSomeMode().Completer.all_completions(text)
        else:
            # Try to reuse current completer.
            completer = readline.get_completer()
            if not completer:
                # importing rlcompleter sets the completer, use it as a
                # last resort to avoid breaking customizations.
                import rlcompleter
                completer = readline.get_completer()
            if getattr(completer, 'PYTHON_EL_WRAPPED', False):
                completer.print_mode = False
            i = 0
            while True:
                completion = completer(text, i)
                if not completion:
                    break
                i += 1
                completions.append(completion)
    except:
        pass
    finally:
        if getattr(completer, 'PYTHON_EL_WRAPPED', False):
            completer.print_mode = True
    return completions"
  "Code used to setup completion in inferior SOME processes."
  :type 'string
  :tag "ar-completion-setup-code"
  :group 'ar-mode)

(defcustom ar-shell-completion-string-code
  "';'.join(__PYTHON_EL_get_completions('''%s'''))"
  "SOME code used to get a string of completions separated by semicolons.
The string passed to the function is the current SomeMode name or
the full statement in the case of imports."
  :type 'string
  :tag "ar-shell-completion-string-code"
  :group 'ar-mode)

(defface ar-XXX-tag-face
  '((t (:inherit font-lock-string-face)))
  "XXX\\|TODO\\|FIXME "
  :tag "ar-XXX-tag-face"
  :group 'ar-mode)

(defface ar-pseudo-keyword-face
  '((t (:inherit font-lock-keyword-face)))
  "Face for pseudo keywords in SOME mode, like self, True, False,
  Ellipsis.

See also ‘ar-object-reference-face’"
  :tag "ar-pseudo-keyword-face"
  :group 'ar-mode)

(defface ar-object-reference-face
  '((t (:inherit ar-pseudo-keyword-face)))
  "Face when referencing object members from its class resp. method.,
commonly \"cls\" and \"self\""
  :tag "ar-object-reference-face"
  :group 'ar-mode)

(defface ar-number-face
 '((t (:inherit nil)))
  "Highlight numbers."
  :tag "ar-number-face"
  :group 'ar-mode)

(defface ar-try-if-face
  '((t (:inherit font-lock-keyword-face)))
  "Highlight keywords."
  :tag "ar-try-if-face"
  :group 'ar-mode)

(defface ar-import-from-face
  '((t (:inherit font-lock-keyword-face)))
  "Highlight keywords."
  :tag "ar-import-from-face"
  :group 'ar-mode)

(defface ar-def-class-face
  '((t (:inherit font-lock-keyword-face)))
  "Highlight keywords."
  :tag "ar-def-class-face"
  :group 'ar-mode)

 ;; PEP 318 decorators
(defface ar-decorators-face
  '((t (:inherit font-lock-keyword-face)))
  "Face method decorators."
  :tag "ar-decorators-face"
  :group 'ar-mode)

(defface ar-builtins-face
  '((t (:inherit font-lock-builtin-face)))
  "Face for builtins like TypeError, object, open, and exec."
  :tag "ar-builtins-face"
  :group 'ar-mode)

(defface ar-class-name-face
  '((t (:inherit font-lock-type-face)))
  "Face for classes."
  :tag "ar-class-name-face"
  :group 'ar-mode)

(defface ar-def-face
  '((t (:inherit font-lock-function-name-face)))
  "Face for definitions."
  :tag "ar-def-face"
  :group 'ar-mode)

(defface ar-exception-name-face
  '((t (:inherit font-lock-builtin-face)))
  "Face for SOME exceptions."
  :tag "ar-exception-name-face"
  :group 'ar-mode)

;; subr-x.el might not exist yet
;; #73, Byte compilation on Emacs 25.3 fails on different trim-right signature

(defsubst ar--string-trim-left (strg &optional regexp)
  "Trim STRING of leading string matching REGEXP.

REGEXP defaults to \"[ \\t\\n\\r]+\"."
  (if (string-match (concat "\\`\\(?:" (or regexp "[ \t\n\r]+") "\\)") strg)
      (replace-match "" t t strg)
    strg))

(defsubst ar--string-trim-right (strg &optional regexp)
  "Trim STRING of trailing string matching REGEXP.

REGEXP defaults to \"[ \\t\\n\\r]+\"."
  (if (string-match (concat "\\(?:" (or regexp "[ \t\n\r]+") "\\)\\'") strg)
      (replace-match "" t t strg)
    strg))

(defsubst ar--string-trim (strg &optional trim-left trim-right)
  "Trim STRING of leading and trailing strings matching TRIM-LEFT and TRIM-RIGHT.

TRIM-LEFT and TRIM-RIGHT default to \"[ \\t\\n\\r]+\"."
  (ar--string-trim-left (ar--string-trim-right strg trim-right) trim-left))

(defcustom ar-empty-line-p-chars "^[ \t\r]*$"
  "Empty-line-p-chars."
  :type 'regexp
  :tag "ar-empty-line-p-chars"
  :group 'ar-mode)

(defcustom ar-default-working-directory ""
  "If not empty used by ‘ar-set-current-working-directory’."
  :type 'string
  :tag "ar-default-working-directory"
  :group 'ar-mode)

(defcustom ar-SomeMode-ffap-setup-code
  "
def __FFAP_get_module_path(objstr):
    try:
        import inspect
        import os.path
        # NameError exceptions are delayed until this point.
        obj = eval(objstr)
        module = inspect.getmodule(obj)
        filename = module.__file__
        ext = os.path.splitext(filename)[1]
        if ext in ('.pyc', '.pyo'):
            # Point to the source file.
            filename = filename[:-1]
        if os.path.exists(filename):
            return filename
        return ''
    except:
        return ''"
  "SOME code to get a module path."
  :type 'string
  :tag "ar-SomeMode-ffap-setup-code"
  :group 'ar-mode)

;; (defvar ar-ffap-string-code
;;   "__FFAP_get_module_path('''%s''')\n"
;;   "SOME code used to get a string with the path of a module.")

(defcustom ar-ffap-string-code
  "__FFAP_get_module_path('''%s''')"
  "SOME code used to get a string with the path of a module."
  :type 'string
  :tag "ar-SomeMode-ffap-string-code"
  :group 'ar-mode)

(defvar ar-mode-map nil)

(defvar ar-debug-p nil
  "Used for development purposes.")

;; This and other stuff from SomeMode.el

(defvar ar-last-exeption-buffer nil
  "Internal use only - when ‘ar-up-exception’ is called.

In source-buffer, this will deliver the exception-buffer again.")

(defcustom ar-electric-backspace-p nil
  "When ‘t’, <backspace> key will delete all whitespace chars before point.

Default nil"

  :type 'boolean
  :tag "ar-electric-backspace-p"
  :group 'ar-mode
  :safe 'booleanp
  :set (lambda (symbol value)
         (set-default symbol value)
         (ar-electric-backspace-mode (if value 1 0))))

(defcustom ar-mark-decorators nil
  "If decorators should be marked too.

Default is nil.

Also used by navigation"
  :type 'boolean
  :tag "ar-mark-decorators")

(provide 'ar-vars)
;;; ar-vars.el ends here
