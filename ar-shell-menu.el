;; ar-shell-menu.el --- Provide the ar-Shell mode menu -*- lexical-binding: t; -*-

(and (ignore-errors (require (quote easymenu)) t)
     ;; (easy-menu-define ar-menu map "SOME Tools"
     ;;           `("PyTools"
     (easy-menu-define
       ar-shell-menu ar-shell-mode-map "ar-Shell Mode menu"
       `("ar-Shell"
         ("Edit"
          ("Shift"
           ("Shift right"
            ["Shift block right" ar-shift-block-right
             :help " ‘ar-shift-block-right’
Indent block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift block or clause right" ar-shift-block-or-clause-right
             :help " ‘ar-shift-block-or-clause-right’
Indent block-or-clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift class right" ar-shift-class-right
             :help " ‘ar-shift-class-right’
Indent class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift clause right" ar-shift-clause-right
             :help " ‘ar-shift-clause-right’
Indent clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift comment right" ar-shift-comment-right
             :help " ‘ar-shift-comment-right’"]

            ["Shift def right" ar-shift-def-right
             :help " ‘ar-shift-def-right’
Indent def by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift def or class right" ar-shift-def-or-class-right
             :help " ‘ar-shift-def-or-class-right’
Indent def-or-class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift minor block right" ar-shift-minor-block-right
             :help " ‘ar-shift-minor-block-right’
Indent minor-block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached.
A minor block is started by a ‘for’, ‘if’, ‘try’ or ‘with’."]

            ["Shift paragraph right" ar-shift-paragraph-right
             :help " ‘ar-shift-paragraph-right’
Indent paragraph by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift region right" ar-shift-region-right
             :help " ‘ar-shift-region-right’
Indent region according to ‘ar-indent-offset’ by COUNT times.

If no region is active, current line is indented.
Returns indentation reached."]

            ["Shift statement right" ar-shift-statement-right
             :help " ‘ar-shift-statement-right’
Indent statement by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift top level right" ar-shift-top-level-right
             :help " ‘ar-shift-top-level-right’"]
            )
           ("Shift left"
            ["Shift block left" ar-shift-block-left
             :help " ‘ar-shift-block-left’
Dedent block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift block or clause left" ar-shift-block-or-clause-left
             :help " ‘ar-shift-block-or-clause-left’
Dedent block-or-clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift class left" ar-shift-class-left
             :help " ‘ar-shift-class-left’
Dedent class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift clause left" ar-shift-clause-left
             :help " ‘ar-shift-clause-left’
Dedent clause by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift comment left" ar-shift-comment-left
             :help " ‘ar-shift-comment-left’"]

            ["Shift def left" ar-shift-def-left
             :help " ‘ar-shift-def-left’
Dedent def by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift def or class left" ar-shift-def-or-class-left
             :help " ‘ar-shift-def-or-class-left’
Dedent def-or-class by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift minor block left" ar-shift-minor-block-left
             :help " ‘ar-shift-minor-block-left’
Dedent minor-block by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached.
A minor block is started by a ‘for’, ‘if’, ‘try’ or ‘with’."]

            ["Shift paragraph left" ar-shift-paragraph-left
             :help " ‘ar-shift-paragraph-left’
Dedent paragraph by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]

            ["Shift region left" ar-shift-region-left
             :help " ‘ar-shift-region-left’
Dedent region according to ‘ar-indent-offset’ by COUNT times.

If no region is active, current line is dedented.
Returns indentation reached."]

            ["Shift statement left" ar-shift-statement-left
             :help " ‘ar-shift-statement-left’
Dedent statement by COUNT spaces.

COUNT defaults to ‘ar-indent-offset’,
use [universal-argument] to specify a different value.

Returns outmost indentation reached."]
            ))
          ("Mark"
           ["Mark block" ar-mark-block
            :help " ‘ar-mark-block’
Mark block at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark block or clause" ar-mark-block-or-clause
            :help " ‘ar-mark-block-or-clause’
Mark block-or-clause at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark class" ar-mark-class
            :help " ‘ar-mark-class’
Mark class at point.

With C-u or ‘ar-mark-decorators’ set to ‘t’, decorators are marked too.
Returns beginning and end positions of marked area, a cons."]

           ["Mark clause" ar-mark-clause
            :help " ‘ar-mark-clause’
Mark clause at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark comment" ar-mark-comment
            :help " ‘ar-mark-comment’
Mark comment at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark def" ar-mark-def
            :help " ‘ar-mark-def’
Mark def at point.

With C-u or ‘ar-mark-decorators’ set to ‘t’, decorators are marked too.
Returns beginning and end positions of marked area, a cons."]

           ["Mark def or class" ar-mark-def-or-class
            :help " ‘ar-mark-def-or-class’
Mark def-or-class at point.

With C-u or ‘ar-mark-decorators’ set to ‘t’, decorators are marked too.
Returns beginning and end positions of marked area, a cons."]

           ["Mark expression" ar-mark-expression
            :help " ‘ar-mark-expression’
Mark expression at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark line" ar-mark-line
            :help " ‘ar-mark-line’
Mark line at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark minor block" ar-mark-minor-block
            :help " ‘ar-mark-minor-block’
Mark minor-block at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark paragraph" ar-mark-paragraph
            :help " ‘ar-mark-paragraph’
Mark paragraph at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark partial expression" ar-mark-partial-expression
            :help " ‘ar-mark-partial-expression’
Mark partial-expression at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark statement" ar-mark-statement
            :help " ‘ar-mark-statement’
Mark statement at point.

Returns beginning and end positions of marked area, a cons."]

           ["Mark top level" ar-mark-top-level
            :help " ‘ar-mark-top-level’
Mark top-level at point.

Returns beginning and end positions of marked area, a cons."]
           )
          ("Copy"
           ["Copy block" ar-copy-block
            :help " ‘ar-copy-block’
Copy block at point.

Store data in kill ring, so it might yanked back."]

           ["Copy block or clause" ar-copy-block-or-clause
            :help " ‘ar-copy-block-or-clause’
Copy block-or-clause at point.

Store data in kill ring, so it might yanked back."]

           ["Copy class" ar-copy-class
            :help " ‘ar-copy-class’
Copy class at point.

Store data in kill ring, so it might yanked back."]

           ["Copy clause" ar-copy-clause
            :help " ‘ar-copy-clause’
Copy clause at point.

Store data in kill ring, so it might yanked back."]

           ["Copy comment" ar-copy-comment
            :help " ‘ar-copy-comment’"]

           ["Copy def" ar-copy-def
            :help " ‘ar-copy-def’
Copy def at point.

Store data in kill ring, so it might yanked back."]

           ["Copy def or class" ar-copy-def-or-class
            :help " ‘ar-copy-def-or-class’
Copy def-or-class at point.

Store data in kill ring, so it might yanked back."]

           ["Copy expression" ar-copy-expression
            :help " ‘ar-copy-expression’
Copy expression at point.

Store data in kill ring, so it might yanked back."]

           ["Copy line" ar-copy-line
            :help " ‘ar-copy-line’"]

           ["Copy minor block" ar-copy-minor-block
            :help " ‘ar-copy-minor-block’
Copy minor-block at point.

Store data in kill ring, so it might yanked back."]

           ["Copy paragraph" ar-copy-paragraph
            :help " ‘ar-copy-paragraph’"]

           ["Copy partial expression" ar-copy-partial-expression
            :help " ‘ar-copy-partial-expression’
Copy partial-expression at point.

Store data in kill ring, so it might yanked back."]

           ["Copy statement" ar-copy-statement
            :help " ‘ar-copy-statement’
Copy statement at point.

Store data in kill ring, so it might yanked back."]

           ["Copy top level" ar-copy-top-level
            :help " ‘ar-copy-top-level’
Copy top-level at point.

Store data in kill ring, so it might yanked back."]
           )
          ("Kill"
           ["Kill block" ar-kill-block
            :help " ‘ar-kill-block’
Delete ‘block’ at point.

Stores data in kill ring"]

           ["Kill block or clause" ar-kill-block-or-clause
            :help " ‘ar-kill-block-or-clause’
Delete ‘block-or-clause’ at point.

Stores data in kill ring"]

           ["Kill class" ar-kill-class
            :help " ‘ar-kill-class’
Delete ‘class’ at point.

Stores data in kill ring"]

           ["Kill clause" ar-kill-clause
            :help " ‘ar-kill-clause’
Delete ‘clause’ at point.

Stores data in kill ring"]

           ["Kill comment" ar-kill-comment
            :help " ‘ar-kill-comment’"]

           ["Kill def" ar-kill-def
            :help " ‘ar-kill-def’
Delete ‘def’ at point.

Stores data in kill ring"]

           ["Kill def or class" ar-kill-def-or-class
            :help " ‘ar-kill-def-or-class’
Delete ‘def-or-class’ at point.

Stores data in kill ring"]

           ["Kill expression" ar-kill-expression
            :help " ‘ar-kill-expression’
Delete ‘expression’ at point.

Stores data in kill ring"]

           ["Kill line" ar-kill-line
            :help " ‘ar-kill-line’"]

           ["Kill minor block" ar-kill-minor-block
            :help " ‘ar-kill-minor-block’
Delete ‘minor-block’ at point.

Stores data in kill ring"]

           ["Kill paragraph" ar-kill-paragraph
            :help " ‘ar-kill-paragraph’"]

           ["Kill partial expression" ar-kill-partial-expression
            :help " ‘ar-kill-partial-expression’
Delete ‘partial-expression’ at point.

Stores data in kill ring"]

           ["Kill statement" ar-kill-statement
            :help " ‘ar-kill-statement’
Delete ‘statement’ at point.

Stores data in kill ring"]

           ["Kill top level" ar-kill-top-level
            :help " ‘ar-kill-top-level’
Delete ‘top-level’ at point.

Stores data in kill ring"]
           )
          ("Delete"
           ["Delete block" ar-delete-block
            :help " ‘ar-delete-block’
Delete BLOCK at point.

Do not store data in kill ring."]

           ["Delete block or clause" ar-delete-block-or-clause
            :help " ‘ar-delete-block-or-clause’
Delete BLOCK-OR-CLAUSE at point.

Do not store data in kill ring."]

           ["Delete class" ar-delete-class
            :help " ‘ar-delete-class’
Delete CLASS at point.

Do not store data in kill ring.
With C-u or ‘ar-mark-decorators’ set to ‘t’, ‘decorators’ are included."]

           ["Delete clause" ar-delete-clause
            :help " ‘ar-delete-clause’
Delete CLAUSE at point.

Do not store data in kill ring."]

           ["Delete comment" ar-delete-comment
            :help " ‘ar-delete-comment’"]

           ["Delete def" ar-delete-def
            :help " ‘ar-delete-def’
Delete DEF at point.

Do not store data in kill ring.
With C-u or ‘ar-mark-decorators’ set to ‘t’, ‘decorators’ are included."]

           ["Delete def or class" ar-delete-def-or-class
            :help " ‘ar-delete-def-or-class’
Delete DEF-OR-CLASS at point.

Do not store data in kill ring.
With C-u or ‘ar-mark-decorators’ set to ‘t’, ‘decorators’ are included."]

           ["Delete expression" ar-delete-expression
            :help " ‘ar-delete-expression’
Delete EXPRESSION at point.

Do not store data in kill ring."]

           ["Delete line" ar-delete-line
            :help " ‘ar-delete-line’"]

           ["Delete minor block" ar-delete-minor-block
            :help " ‘ar-delete-minor-block’
Delete MINOR-BLOCK at point.

Do not store data in kill ring."]

           ["Delete paragraph" ar-delete-paragraph
            :help " ‘ar-delete-paragraph’"]

           ["Delete partial expression" ar-delete-partial-expression
            :help " ‘ar-delete-partial-expression’
Delete PARTIAL-EXPRESSION at point.

Do not store data in kill ring."]

           ["Delete statement" ar-delete-statement
            :help " ‘ar-delete-statement’
Delete STATEMENT at point.

Do not store data in kill ring."]

           ["Delete top level" ar-delete-top-level
            :help " ‘ar-delete-top-level’
Delete TOP-LEVEL at point.

Do not store data in kill ring."]
           )
          ("Comment"
           ["Comment block" ar-comment-block
            :help " ‘ar-comment-block’
Comments block at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment block or clause" ar-comment-block-or-clause
            :help " ‘ar-comment-block-or-clause’
Comments block-or-clause at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment class" ar-comment-class
            :help " ‘ar-comment-class’
Comments class at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment clause" ar-comment-clause
            :help " ‘ar-comment-clause’
Comments clause at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment def" ar-comment-def
            :help " ‘ar-comment-def’
Comments def at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment def or class" ar-comment-def-or-class
            :help " ‘ar-comment-def-or-class’
Comments def-or-class at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]

           ["Comment statement" ar-comment-statement
            :help " ‘ar-comment-statement’
Comments statement at point.

Uses double hash (‘#’) comment starter when ‘ar-block-comment-prefix-p’ is  ‘t’,
the default"]
           ))
         ("Move"
          ("Backward"
           ["Go backward one prompt" ar-nav-last-prompt
            :help " ‘ar-nav-last-prompt’
Like ‘comint-show-output’ known from in shell-mode"]

           ["Beginning of block" ar-beginning-of-block
            :help " ‘ar-beginning-of-block’
Go to beginning block, skip whitespace at BOL.

Returns beginning of block if successful, nil otherwise"]

           ["Beginning of block or clause" ar-beginning-of-block-or-clause
            :help " ‘ar-beginning-of-block-or-clause’
Go to beginning block-or-clause, skip whitespace at BOL.

Returns beginning of block-or-clause if successful, nil otherwise"]

           ["Beginning of class" ar-beginning-of-class
            :help " ‘ar-beginning-of-class’
Go to beginning class, skip whitespace at BOL.

Returns beginning of class if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

           ["Beginning of clause" ar-beginning-of-clause
            :help " ‘ar-beginning-of-clause’
Go to beginning clause, skip whitespace at BOL.

Returns beginning of clause if successful, nil otherwise"]

           ["Beginning of def" ar-beginning-of-def
            :help " ‘ar-beginning-of-def’
Go to beginning def, skip whitespace at BOL.

Returns beginning of def if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

           ["Beginning of def or class" ar-backward-def-or-class
            :help " ‘ar-backward-def-or-class’
Go to beginning def-or-class, skip whitespace at BOL.

Returns beginning of def-or-class if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

           ["Beginning of elif block" ar-beginning-of-elif-block
            :help " ‘ar-beginning-of-elif-block’
Go to beginning elif-block, skip whitespace at BOL.

Returns beginning of elif-block if successful, nil otherwise"]

           ["Beginning of else block" ar-beginning-of-else-block
            :help " ‘ar-beginning-of-else-block’
Go to beginning else-block, skip whitespace at BOL.

Returns beginning of else-block if successful, nil otherwise"]

           ["Beginning of except block" ar-beginning-of-except-block
            :help " ‘ar-beginning-of-except-block’
Go to beginning except-block, skip whitespace at BOL.

Returns beginning of except-block if successful, nil otherwise"]

           ["Beginning of expression" ar-beginning-of-expression
            :help " ‘ar-beginning-of-expression’
Go to the beginning of a compound SomeMode expression.

With numeric ARG do it that many times.

A a compound SomeMode expression might be concatenated by \".\" operator, thus composed by minor SomeMode expressions.

If already at the beginning or before a expression, go to next expression in buffer upwards

Expression here is conceived as the syntactical component of a statement in SOME. See http://docs.SomeMode.org/reference
Operators however are left aside resp. limit ar-expression designed for edit-purposes."]

           ["Beginning of if block" ar-beginning-of-if-block
            :help " ‘ar-beginning-of-if-block’
Go to beginning if-block, skip whitespace at BOL.

Returns beginning of if-block if successful, nil otherwise"]

           ["Beginning of partial expression" ar-backward-partial-expression
            :help " ‘ar-backward-partial-expression’"]

           ["Beginning of statement" ar-backward-statement
            :help " ‘ar-backward-statement’
Go to the initial line of a simple statement.

For beginning of compound statement use ar-beginning-of-block.
For beginning of clause ar-beginning-of-clause."]

           ["Beginning of top level" ar-backward-top-level
            :help " ‘ar-backward-top-level’
Go up to beginning of statments until level of indentation is null.

Returns position if successful, nil otherwise"]

           ["Beginning of try block" ar-beginning-of-try-block
            :help " ‘ar-beginning-of-try-block’
Go to beginning try-block, skip whitespace at BOL.

Returns beginning of try-block if successful, nil otherwise"]
           )
          ("Forward"
           ["End of block" ar-forward-block
            :help " ‘ar-forward-block’
Go to end of block.

Returns end of block if successful, nil otherwise"]

           ["End of block or clause" ar-forward-block-or-clause
            :help " ‘ar-forward-block-or-clause’
Go to end of block-or-clause.

Returns end of block-or-clause if successful, nil otherwise"]

           ["End of class" ar-forward-class
            :help " ‘ar-forward-class’
Go to end of class.

Returns end of class if successful, nil otherwise"]

           ["End of clause" ar-forward-clause
            :help " ‘ar-forward-clause’
Go to end of clause.

Returns end of clause if successful, nil otherwise"]

           ["End of def" ar-forward-def
            :help " ‘ar-forward-def’
Go to end of def.

Returns end of def if successful, nil otherwise"]

           ["End of def or class" ar-forward-def-or-class
            :help " ‘ar-forward-def-or-class’
Go to end of def-or-class.

Returns end of def-or-class if successful, nil otherwise"]

           ["End of elif block" ar-forward-elif-block
            :help " ‘ar-forward-elif-block’
Go to end of elif-block.

Returns end of elif-block if successful, nil otherwise"]

           ["End of else block" ar-forward-else-block
            :help " ‘ar-forward-else-block’
Go to end of else-block.

Returns end of else-block if successful, nil otherwise"]

           ["End of except block" ar-forward-except-block
            :help " ‘ar-forward-except-block’
Go to end of except-block.

Returns end of except-block if successful, nil otherwise"]

           ["End of expression" ar-forward-expression
            :help " ‘ar-forward-expression’
Go to the end of a compound SomeMode expression.

With numeric ARG do it that many times.

A a compound SomeMode expression might be concatenated by \".\" operator, thus composed by minor SomeMode expressions.

Expression here is conceived as the syntactical component of a statement in SOME. See http://docs.SomeMode.org/reference

Operators however are left aside resp. limit ar-expression designed for edit-purposes."]

           ["End of if block" ar-forward-if-block
            :help " ‘ar-forward-if-block’
Go to end of if-block.

Returns end of if-block if successful, nil otherwise"]

           ["End of partial expression" ar-forward-partial-expression
            :help " ‘ar-forward-partial-expression’"]

           ["End of statement" ar-forward-statement
            :help " ‘ar-forward-statement’
Go to the last char of current statement.

Optional argument REPEAT, the number of loops done already, is checked for ar-max-specpdl-size error. Avoid eternal loops due to missing string delimters etc."]

           ["End of top level" ar-forward-top-level
            :help " ‘ar-forward-top-level’
Go to end of top-level form at point.

Returns position if successful, nil otherwise"]

           ["End of try block" ar-forward-try-block
            :help " ‘ar-forward-try-block’
Go to end of try-block.

Returns end of try-block if successful, nil otherwise"]
           )
          ("BOL-forms"
           ("Backward"
            ["Beginning of block bol" ar-beginning-of-block-bol
             :help " ‘ar-beginning-of-block-bol’
Go to beginning block, go to BOL.

Returns beginning of block if successful, nil otherwise"]

            ["Beginning of block or clause bol" ar-beginning-of-block-or-clause-bol
             :help " ‘ar-beginning-of-block-or-clause-bol’
Go to beginning block-or-clause, go to BOL.

Returns beginning of block-or-clause if successful, nil otherwise"]

            ["Beginning of class bol" ar-beginning-of-class-bol
             :help " ‘ar-beginning-of-class-bol’
Go to beginning class, go to BOL.

Returns beginning of class if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

            ["Beginning of clause bol" ar-beginning-of-clause-bol
             :help " ‘ar-beginning-of-clause-bol’
Go to beginning clause, go to BOL.

Returns beginning of clause if successful, nil otherwise"]

            ["Beginning of def bol" ar-beginning-of-def-bol
             :help " ‘ar-beginning-of-def-bol’
Go to beginning def, go to BOL.

Returns beginning of def if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

            ["Beginning of def or class bol" ar-backward-def-or-class-bol
             :help " ‘ar-backward-def-or-class-bol’
Go to beginning def-or-class, go to BOL.

Returns beginning of def-or-class if successful, nil otherwise

When ‘ar-mark-decorators’ is non-nil, decorators are considered too."]

            ["Beginning of elif block bol" ar-beginning-of-elif-block-bol
             :help " ‘ar-beginning-of-elif-block-bol’
Go to beginning elif-block, go to BOL.

Returns beginning of elif-block if successful, nil otherwise"]

            ["Beginning of else block bol" ar-beginning-of-else-block-bol
             :help " ‘ar-beginning-of-else-block-bol’
Go to beginning else-block, go to BOL.

Returns beginning of else-block if successful, nil otherwise"]

            ["Beginning of except block bol" ar-beginning-of-except-block-bol
             :help " ‘ar-beginning-of-except-block-bol’
Go to beginning except-block, go to BOL.

Returns beginning of except-block if successful, nil otherwise"]

            ["Beginning of expression bol" ar-beginning-of-expression-bol
             :help " ‘ar-beginning-of-expression-bol’"]

            ["Beginning of if block bol" ar-beginning-of-if-block-bol
             :help " ‘ar-beginning-of-if-block-bol’
Go to beginning if-block, go to BOL.

Returns beginning of if-block if successful, nil otherwise"]

            ["Beginning of partial expression bol" ar-backward-partial-expression-bol
             :help " ‘ar-backward-partial-expression-bol’"]

            ["Beginning of statement bol" ar-backward-statement-bol
             :help " ‘ar-backward-statement-bol’
Goto beginning of line where statement starts.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-up-statement’: up from current definition to next beginning of statement above."]

            ["Beginning of try block bol" ar-beginning-of-try-block-bol
             :help " ‘ar-beginning-of-try-block-bol’
Go to beginning try-block, go to BOL.

Returns beginning of try-block if successful, nil otherwise"]
            )
           ("Forward"
            ["End of block bol" ar-forward-block-bol
             :help " ‘ar-forward-block-bol’
Goto beginning of line following end of block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-block’: down from current definition to next beginning of block below."]

            ["End of block or clause bol" ar-forward-block-or-clause-bol
             :help " ‘ar-forward-block-or-clause-bol’
Goto beginning of line following end of block-or-clause.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-block-or-clause’: down from current definition to next beginning of block-or-clause below."]

            ["End of class bol" ar-forward-class-bol
             :help " ‘ar-forward-class-bol’
Goto beginning of line following end of class.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-class’: down from current definition to next beginning of class below."]

            ["End of clause bol" ar-forward-clause-bol
             :help " ‘ar-forward-clause-bol’
Goto beginning of line following end of clause.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-clause’: down from current definition to next beginning of clause below."]

            ["End of def bol" ar-forward-def-bol
             :help " ‘ar-forward-def-bol’
Goto beginning of line following end of def.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-def’: down from current definition to next beginning of def below."]

            ["End of def or class bol" ar-forward-def-or-class-bol
             :help " ‘ar-forward-def-or-class-bol’
Goto beginning of line following end of def-or-class.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-def-or-class’: down from current definition to next beginning of def-or-class below."]

            ["End of elif block bol" ar-forward-elif-block-bol
             :help " ‘ar-forward-elif-block-bol’
Goto beginning of line following end of elif-block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-elif-block’: down from current definition to next beginning of elif-block below."]

            ["End of else block bol" ar-forward-else-block-bol
             :help " ‘ar-forward-else-block-bol’
Goto beginning of line following end of else-block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-else-block’: down from current definition to next beginning of else-block below."]

            ["End of except block bol" ar-forward-except-block-bol
             :help " ‘ar-forward-except-block-bol’
Goto beginning of line following end of except-block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-except-block’: down from current definition to next beginning of except-block below."]

            ["End of expression bol" ar-forward-expression-bol
             :help " ‘ar-forward-expression-bol’"]

            ["End of if block bol" ar-forward-if-block-bol
             :help " ‘ar-forward-if-block-bol’
Goto beginning of line following end of if-block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-if-block’: down from current definition to next beginning of if-block below."]

            ["End of partial expression bol" ar-forward-partial-expression-bol
             :help " ‘ar-forward-partial-expression-bol’"]

            ["End of statement bol" ar-forward-statement-bol
             :help " ‘ar-forward-statement-bol’
Go to the beginning-of-line following current statement."]

            ["End of top level bol" ar-forward-top-level-bol
             :help " ‘ar-forward-top-level-bol’
Go to end of top-level form at point, stop at next beginning-of-line.

Returns position successful, nil otherwise"]

            ["End of try block bol" ar-forward-try-block-bol
             :help " ‘ar-forward-try-block-bol’
Goto beginning of line following end of try-block.
  Returns position reached, if successful, nil otherwise.

See also ‘ar-down-try-block’: down from current definition to next beginning of try-block below."]
            ))
          ("Up/Down"
           ["Up" ar-up
            :help " ‘ar-up’
Go up or to beginning of form if inside.

If inside a delimited form --string or list-- go to its beginning.
If not at beginning of a statement or block, go to its beginning.
If at beginning of a statement or block, go to beginning one level above of compound statement or definition at point."]

           ["Down" ar-down
            :help " ‘ar-down’
Go to beginning one level below of compound statement or definition at point.

If no statement or block below, but a delimited form --string or list-- go to its beginning. Repeated call from there will behave like down-list.

Returns position if successful, nil otherwise"]
           ))
         ("Hide-Show"
          ("Hide"
           ["Hide region" ar-hide-region
            :help " ‘ar-hide-region’
Hide active region."]

           ["Hide statement" ar-hide-statement
            :help " ‘ar-hide-statement’
Hide statement at point."]

           ["Hide block" ar-hide-block
            :help " ‘ar-hide-block’
Hide block at point."]

           ["Hide clause" ar-hide-clause
            :help " ‘ar-hide-clause’
Hide clause at point."]

           ["Hide block or clause" ar-hide-block-or-clause
            :help " ‘ar-hide-block-or-clause’
Hide block-or-clause at point."]

           ["Hide def" ar-hide-def
            :help " ‘ar-hide-def’
Hide def at point."]

           ["Hide class" ar-hide-class
            :help " ‘ar-hide-class’
Hide class at point."]

           ["Hide expression" ar-hide-expression
            :help " ‘ar-hide-expression’
Hide expression at point."]

           ["Hide partial expression" ar-hide-partial-expression
            :help " ‘ar-hide-partial-expression’
Hide partial-expression at point."]

           ["Hide line" ar-hide-line
            :help " ‘ar-hide-line’
Hide line at point."]

           ["Hide top level" ar-hide-top-level
            :help " ‘ar-hide-top-level’
Hide top-level at point."]
           )
          ("Show"
           ["Show" ar-show
            :help " ‘ar-show’
Un-hide at point."]

           ["Show all" ar-show-all
            :help " ‘ar-show-all’
Un-hide all in buffer."]
           ))
         ("Virtualenv"
          ["Virtualenv activate" virtualenv-activate
           :help " ‘virtualenv-activate’
Activate the virtualenv located in DIR"]

          ["Virtualenv deactivate" virtualenv-deactivate
           :help " ‘virtualenv-deactivate’
Deactivate the current virtual enviroment"]

          ["Virtualenv p" virtualenv-p
           :help " ‘virtualenv-p’
Check if a directory is a virtualenv"]

          ["Virtualenv workon" virtualenv-workon
           :help " ‘virtualenv-workon’
Issue a virtualenvwrapper-like virtualenv-workon command"]
          )
         ("Help"
          ["Find definition" ar-find-definition
           :help " ‘ar-find-definition’
Find source of definition of SYMBOL.

Interactively, prompt for SYMBOL."]

          ["Help at point" ar-help-at-point
           :help " ‘ar-help-at-point’
Print help on symbol at point.

If symbol is defined in current buffer, jump to its definition
Optional C-u used for debugging, will prevent deletion of temp file."]

          ["Info lookup symbol" ar-info-lookup-symbol
           :help " ‘ar-info-lookup-symbol’"]

          ["Symbol at point" ar-symbol-at-point
           :help " ‘ar-symbol-at-point’
Return the current SOME symbol."]
          )
         ("Customize"

          ["SOME-mode customize group" (customize-group 'ar-mode)
           :help "Open the customization buffer for SOME mode"]
          ("Switches"
           :help "Toggle useful modes"
           ("Interpreter"

            ["Shell prompt read only"
             (setq ar-shell-prompt-read-only
                   (not ar-shell-prompt-read-only))
             :help "If non-nil, the SomeMode prompt is read only.  Setting this variable will only effect new shells.Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-shell-prompt-read-only]

            ["Remove cwd from path"
             (setq ar-remove-cwd-from-path
                   (not ar-remove-cwd-from-path))
             :help "Whether to allow loading of SOME modules from the current directory.
If this is non-nil, Emacs removes '' from sys.path when starting
a SOME process.  This is the default, for security
reasons, as it is easy for the SOME process to be started
without the user's realization (e.g. to perform completion).Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-remove-cwd-from-path]

            ["Honor ISOMEDIR "
             (setq ar-honor-ISOMEDIR-p
                   (not ar-honor-ISOMEDIR-p))
             :help "When non-nil iSomeMode-history file is constructed by \$ISOMEDIR
followed by "/history". Default is nil.

Otherwise value of ar-iSomeMode-history is used. Use `M-x customize-variable' to set it permanently"
:style toggle :selected ar-honor-ISOMEDIR-p]

            ["Honor PYTHONHISTORY "
             (setq ar-honor-PYTHONHISTORY-p
                   (not ar-honor-PYTHONHISTORY-p))
             :help "When non-nil SomeMode-history file is set by \$PYTHONHISTORY
Default is nil.

Otherwise value of ar-SomeMode-history is used. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-honor-PYTHONHISTORY-p]

            ["Enforce ar-shell-name" force-ar-shell-name-p-on
             :help "Enforce customized default ‘ar-shell-name’ should upon execution. "]

            ["Do not enforce default interpreter" force-ar-shell-name-p-off
             :help "Make execute commands guess interpreter from environment"]

            )

           ("Execute"

            ["Fast process" ar-fast-process-p
             :help " ‘ar-fast-process-p’

Use ‘ar-fast-process’\.

Commands prefixed \"ar-fast-...\" suitable for large output

See: large output makes Emacs freeze, lp:1253907

Output-buffer is not in comint-mode"
             :style toggle :selected ar-fast-process-p]

            ["SOME mode v5 behavior"
             (setq ar-mode-v5-behavior-p
                   (not ar-mode-v5-behavior-p))
             :help "Execute region through ‘shell-command-on-region’ as
v5 did it - lp:990079. This might fail with certain chars - see UnicodeEncodeError lp:550661

Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-mode-v5-behavior-p]

            ["Force shell name "
             (setq ar-force-ar-shell-name-p
                   (not ar-force-ar-shell-name-p))
             :help "When ‘t’, execution with kind of SOME specified in ‘ar-shell-name’ is enforced, possibly shebang does not take precedence. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-force-ar-shell-name-p]

            ["Execute \"if name == main\" blocks p"
             (setq ar-if-name-main-permission-p
                   (not ar-if-name-main-permission-p))
             :help " ‘ar-if-name-main-permission-p’

Allow execution of code inside blocks delimited by
if __name__ == '__main__'

Default is non-nil. "
             :style toggle :selected ar-if-name-main-permission-p]

            ["Ask about save"
             (setq ar-ask-about-save
                   (not ar-ask-about-save))
             :help "If not nil, ask about which buffers to save before executing some code.
Otherwise, all modified buffers are saved without asking.Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-ask-about-save]

            ["Store result"
             (setq ar-store-result-p
                   (not ar-store-result-p))
             :help " ‘ar-store-result-p’

When non-nil, put resulting string of ‘ar-execute-...’ into kill-ring, so it might be yanked. "
             :style toggle :selected ar-store-result-p]

            ["Prompt on changed "
             (setq ar-prompt-on-changed-p
                   (not ar-prompt-on-changed-p))
             :help "When called interactively, ask for save before a changed buffer is sent to interpreter.

Default is ‘t’Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-prompt-on-changed-p]

            ["Dedicated process "
             (setq ar-dedicated-process-p
                   (not ar-dedicated-process-p))
             :help "If commands executing code use a dedicated shell.

Default is nilUse `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-dedicated-process-p]

            ["Execute without temporary file"
             (setq ar-execute-no-temp-p
                   (not ar-execute-no-temp-p))
             :help " ‘ar-execute-no-temp-p’
Seems Emacs-24.3 provided a way executing stuff without temporary files.
In experimental state yet "
             :style toggle :selected ar-execute-no-temp-p]

            ["Warn tmp files left "
             (setq ar--warn-tmp-files-left-p
                   (not ar--warn-tmp-files-left-p))
             :help "Messages a warning, when ‘ar-temp-directory’ contains files susceptible being left by previous SOME-mode sessions. See also lp:987534 Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar--warn-tmp-files-left-p])

           ("Edit"

            ("Completion"

             ["Set Pymacs-based complete keymap "
              (setq ar-set-complete-keymap-p
                    (not ar-set-complete-keymap-p))
              :help "If ‘ar-complete-initialize’, which sets up enviroment for Pymacs based ar-complete, should load its keys into ‘ar-mode-map’

Default is nil.
See also resp. edit ‘ar-complete-set-keymap’ Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-set-complete-keymap-p]

             ["Indent no completion "
              (setq ar-indent-no-completion-p
                    (not ar-indent-no-completion-p))
              :help "If completion function should indent when no completion found. Default is ‘t’

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-indent-no-completion-p]

             ["Company pycomplete "
              (setq ar-company-pycomplete-p
                    (not ar-company-pycomplete-p))
              :help "Load company-pycomplete stuff. Default is nilUse `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-company-pycomplete-p])

            ("Filling"

             ("Docstring styles"
              :help "Switch docstring-style"

              ["Nil" ar-set-nil-docstring-style
               :help " ‘ar-set-nil-docstring-style’

Set ar-docstring-style to nil, format string normally. "]

              ["pep-257-nn" ar-set-pep-257-nn-docstring-style
               :help " ‘ar-set-pep-257-nn-docstring-style’

Set ar-docstring-style to 'pep-257-nn "]

              ["pep-257" ar-set-pep-257-docstring-style
               :help " ‘ar-set-pep-257-docstring-style’

Set ar-docstring-style to 'pep-257 "]

              ["django" ar-set-django-docstring-style
               :help " ‘ar-set-django-docstring-style’

Set ar-docstring-style to 'django "]

              ["onetwo" ar-set-onetwo-docstring-style
               :help " ‘ar-set-onetwo-docstring-style’

Set ar-docstring-style to 'onetwo "]

              ["symmetric" ar-set-symmetric-docstring-style
               :help " ‘ar-set-symmetric-docstring-style’

Set ar-docstring-style to 'symmetric "])

             ["Auto-fill mode"
              (setq ar-auto-fill-mode
                    (not ar-auto-fill-mode))
              :help "Fill according to ‘ar-docstring-fill-column’ and ‘ar-comment-fill-column’

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-auto-fill-mode])

            ["Use current dir when execute"
             (setq ar-use-current-dir-when-execute-p
                   (not ar-use-current-dir-when-execute-p))
             :help " ‘ar-toggle-use-current-dir-when-execute-p’

Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-use-current-dir-when-execute-p]

            ("Indent"
             ("TAB related"

              ["indent-tabs-mode"
               (setq indent-tabs-mode
                     (not indent-tabs-mode))
               :help "Indentation can insert tabs if this is non-nil.

Use `M-x customize-variable' to set it permanently"
               :style toggle :selected indent-tabs-mode]

              ["Tab indent"
               (setq ar-tab-indent
                     (not ar-tab-indent))
               :help "Non-nil means TAB in SOME mode calls ‘ar-indent-line’.Use `M-x customize-variable' to set it permanently"
               :style toggle :selected ar-tab-indent]

              ["Tab shifts region "
               (setq ar-tab-shifts-region-p
                     (not ar-tab-shifts-region-p))
               :help "If ‘t’, TAB will indent/cycle the region, not just the current line.

Default is nil
See also ‘ar-tab-indents-region-p’

Use `M-x customize-variable' to set it permanently"
               :style toggle :selected ar-tab-shifts-region-p]

              ["Tab indents region "
               (setq ar-tab-indents-region-p
                     (not ar-tab-indents-region-p))
               :help "When ‘t’ and first TAB does not shift, indent-region is called.

Default is nil
See also ‘ar-tab-shifts-region-p’

Use `M-x customize-variable' to set it permanently"
               :style toggle :selected ar-tab-indents-region-p])

             ["Close at start column"
              (setq ar-closing-list-dedents-bos
                    (not ar-closing-list-dedents-bos))
              :help "When non-nil, indent list's closing delimiter like start-column.

It will be lined up under the first character of
 the line that starts the multi-line construct, as in:

my_list = \[
    1, 2, 3,
    4, 5, 6,
]

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-closing-list-dedents-bos]

             ["Closing list keeps space"
              (setq ar-closing-list-keeps-space
                    (not ar-closing-list-keeps-space))
              :help "If non-nil, closing parenthesis dedents onto column of opening plus ‘ar-closing-list-space’, default is nil Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-closing-list-keeps-space]

             ["Closing list space"
              (setq ar-closing-list-space
                    (not ar-closing-list-space))
              :help "Number of chars, closing parenthesis outdent from opening, default is 1 Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-closing-list-space]

             ["Tab shifts region "
              (setq ar-tab-shifts-region-p
                    (not ar-tab-shifts-region-p))
              :help "If ‘t’, TAB will indent/cycle the region, not just the current line.

Default is nil
See also ‘ar-tab-indents-region-p’Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-tab-shifts-region-p]

             ["Lhs inbound indent"
              (setq ar-lhs-inbound-indent
                    (not ar-lhs-inbound-indent))
              :help "When line starts a multiline-assignment: How many colums indent should be more than opening bracket, brace or parenthesis. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-lhs-inbound-indent]

             ["Continuation offset"
              (setq ar-continuation-offset
                    (not ar-continuation-offset))
              :help "With numeric ARG different from 1 ar-continuation-offset is set to that value; returns ar-continuation-offset. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-continuation-offset]

             ["Electric colon"
              (setq ar-electric-colon-active-p
                    (not ar-electric-colon-active-p))
              :help " ‘ar-electric-colon-active-p’

‘ar-electric-colon’ feature.  Default is ‘nil’. See lp:837065 for discussions. "
              :style toggle :selected ar-electric-colon-active-p]

             ["Electric colon at beginning of block only"
              (setq ar-electric-colon-bobl-only
                    (not ar-electric-colon-bobl-only))
              :help "When inserting a colon, do not indent lines unless at beginning of block.

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-electric-colon-bobl-only]

             ["Electric yank active "
              (setq ar-electric-yank-active-p
                    (not ar-electric-yank-active-p))
              :help " When non-nil, ‘yank’ will be followed by an ‘indent-according-to-mode’.

Default is nilUse `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-electric-yank-active-p]

             ["Trailing whitespace smart delete "
              (setq ar-trailing-whitespace-smart-delete-p
                    (not ar-trailing-whitespace-smart-delete-p))
              :help "Default is nil. When t, ar-mode calls
    (add-hook 'before-save-hook 'delete-trailing-whitespace nil 'local)

Also commands may delete trailing whitespace by the way.
When editing other peoples code, this may produce a larger diff than expected Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-trailing-whitespace-smart-delete-p]

             ["Newline delete trailing whitespace "
              (setq ar-newline-delete-trailing-whitespace-p
                    (not ar-newline-delete-trailing-whitespace-p))
              :help "Delete trailing whitespace maybe left by ‘ar-newline-and-indent’.

Default is ‘t’. See lp:1100892 Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-newline-delete-trailing-whitespace-p]

             ["Dedent keep relative column"
              (setq ar-dedent-keep-relative-column
                    (not ar-dedent-keep-relative-column))
              :help "If point should follow dedent or kind of electric move to end of line. Default is t - keep relative position. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-dedent-keep-relative-column]

;;           ["Indent paren spanned multilines "
;;            (setq ar-indent-paren-spanned-multilines-p
;;                  (not ar-indent-paren-spanned-multilines-p))
;;            :help "If non-nil, indents elements of list a value of ‘ar-indent-offset’ to first element:

;; def foo():
;;     if (foo &&
;;             baz):
;;         bar()

;; Default lines up with first element:

;; def foo():
;;     if (foo &&
;;         baz):
;;         bar()
;; Use `M-x customize-variable' to set it permanently"
;;            :style toggle :selected ar-indent-paren-spanned-multilines-p]

             ;; ["Indent honors multiline listing"
             ;;  (setq ar-indent-honors-multiline-listing
             ;;             (not ar-indent-honors-multiline-listing))
             ;;  :help "If ‘t’, indents to 1\+ column of opening delimiter. If ‘nil’, indent adds one level to the beginning of statement. Default is ‘nil’. Use `M-x customize-variable' to set it permanently"
             ;;  :style toggle :selected ar-indent-honors-multiline-listing]

             ["Indent comment "
              (setq ar-indent-comments
                    (not ar-indent-comments))
              :help "If comments should be indented like code. Default is ‘nil’.

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-indent-comments]

             ["Uncomment indents "
              (setq ar-uncomment-indents-p
                    (not ar-uncomment-indents-p))
              :help "When non-nil, after uncomment indent lines. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-uncomment-indents-p]

             ["Indent honors inline comment"
              (setq ar-indent-honors-inline-comment
                    (not ar-indent-honors-inline-comment))
              :help "If non-nil, indents to column of inlined comment start.
Default is nil. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-indent-honors-inline-comment]

             ["Kill empty line"
              (setq ar-kill-empty-line
                    (not ar-kill-empty-line))
              :help "If t, ar-indent-forward-line kills empty lines. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-kill-empty-line]

             ("Smart indentation"
              :help "Toggle ar-smart-indentation'

Use `M-x customize-variable' to set it permanently"

              ["Toggle ar-smart-indentation" ar-toggle-smart-indentation
               :help "Toggles ar-smart-indentation

Use `M-x customize-variable' to set it permanently"]

              ["ar-smart-indentation on" ar-smart-indentation-on
               :help "Switches ar-smart-indentation on

Use `M-x customize-variable' to set it permanently"]

              ["ar-smart-indentation off" ar-smart-indentation-off
               :help "Switches ar-smart-indentation off

Use `M-x customize-variable' to set it permanently"])

             ["Beep if tab change"
              (setq ar-beep-if-tab-change
                    (not ar-beep-if-tab-change))
              :help "Ring the bell if ‘tab-width’ is changed.
If a comment of the form

                                # vi:set tabsize=<number>:

is found before the first code line when the file is entered, and the
current value of (the general Emacs variable) ‘tab-width’ does not
equal <number>, ‘tab-width’ is set to <number>, a message saying so is
displayed in the echo area, and if ‘ar-beep-if-tab-change’ is non-nil
the Emacs bell is also rung as a warning.Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-beep-if-tab-change]

             ["Electric comment "
              (setq ar-electric-comment-p
                    (not ar-electric-comment-p))
              :help "If \"#\" should call ‘ar-electric-comment’. Default is ‘nil’.

Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-electric-comment-p]

             ["Electric comment add space "
              (setq ar-electric-comment-add-space-p
                    (not ar-electric-comment-add-space-p))
              :help "If ar-electric-comment should add a space.  Default is ‘nil’. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-electric-comment-add-space-p]

             ["Empty line closes "
              (setq ar-empty-line-closes-p
                    (not ar-empty-line-closes-p))
              :help "When non-nil, dedent after empty line following block

if True:
    print(\"Part of the if-statement\")

print(\"Not part of the if-statement\")

Default is nil

If non-nil, a C-j from empty line dedents.
Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-empty-line-closes-p])
            ["Defun use top level "
             (setq ar-defun-use-top-level-p
                   (not ar-defun-use-top-level-p))
             :help "When non-nil, keys C-M-a, C-M-e address top-level form.

Beginning- end-of-defun forms use
commands ‘ar-backward-top-level’, ‘ar-forward-top-level’

mark-defun marks top-level form at point etc. "
             :style toggle :selected ar-defun-use-top-level-p]

            ["Close provides newline"
             (setq ar-close-provides-newline
                   (not ar-close-provides-newline))
             :help "If a newline is inserted, when line after block is not empty. Default is non-nil. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-close-provides-newline]

            ["Block comment prefix "
             (setq ar-block-comment-prefix-p
                   (not ar-block-comment-prefix-p))
             :help "If ar-comment inserts ar-block-comment-prefix.

Default is tUse `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-block-comment-prefix-p])

           ("Display"

            ("Index"

             ["Imenu create index "
              (setq ar--imenu-create-index-p
                    (not ar--imenu-create-index-p))
              :help "Non-nil means SOME mode creates and displays an index menu of functions and global variables. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar--imenu-create-index-p]

             ["Imenu show method args "
              (setq ar-imenu-show-method-args-p
                    (not ar-imenu-show-method-args-p))
              :help "Controls echoing of arguments of functions & methods in the Imenu buffer.
When non-nil, arguments are printed.Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-imenu-show-method-args-p]
             ["Switch index-function" ar-switch-imenu-index-function
              :help "‘ar-switch-imenu-index-function’
Switch between ‘ar--imenu-create-index’ from 5.1 series and ‘ar--imenu-create-index-new’."])

            ("Fontification"

             ["Mark decorators"
              (setq ar-mark-decorators
                    (not ar-mark-decorators))
              :help "If ar-mark-def-or-class functions should mark decorators too. Default is ‘nil’. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-mark-decorators]

             ["Fontify shell buffer "
              (setq ar-fontify-shell-buffer-p
                    (not ar-fontify-shell-buffer-p))
              :help "If code in SOME shell should be highlighted as in script buffer.

Default is nil.

If ‘t’, related vars like ‘comment-start’ will be set too.
Seems convenient when playing with stuff in ISOME shell
Might not be TRT when a lot of output arrives Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-fontify-shell-buffer-p]

             ["Use font lock doc face "
              (setq ar-use-font-lock-doc-face-p
                    (not ar-use-font-lock-doc-face-p))
              :help "If documention string inside of def or class get ‘font-lock-doc-face’.

‘font-lock-doc-face’ inherits ‘font-lock-string-face’.

Call M-x ‘customize-face’ in order to have a visible effect. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-use-font-lock-doc-face-p])

            ["Switch buffers on execute"
             (setq ar-switch-buffers-on-execute-p
                   (not ar-switch-buffers-on-execute-p))
             :help "When non-nil switch to the SOME output buffer.

Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-switch-buffers-on-execute-p]

            ["Split windows on execute"
             (setq ar-split-window-on-execute
                   (not ar-split-window-on-execute))
             :help "When non-nil split windows.

Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-split-window-on-execute]

            ["Keep windows configuration"
             (setq ar-keep-windows-configuration
                   (not ar-keep-windows-configuration))
             :help "If a windows is splitted displaying results, this is directed by variable ‘ar-split-window-on-execute’\. Also setting ‘ar-switch-buffers-on-execute-p’ affects window-configuration\. While commonly a screen splitted into source and SOME-shell buffer is assumed, user may want to keep a different config\.

Setting ‘ar-keep-windows-configuration’ to ‘t’ will restore windows-config regardless of settings mentioned above\. However, if an error occurs, it is displayed\.

To suppres window-changes due to error-signaling also: M-x customize-variable RET. Set ‘ar-keep-4windows-configuration’ onto 'force

Default is nil Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-keep-windows-configuration]

            ["Which split windows on execute function"
             (progn
               (if (eq 'split-window-vertically ar-split-windows-on-execute-function)
                   (setq ar-split-windows-on-execute-function'split-window-horizontally)
                 (setq ar-split-windows-on-execute-function 'split-window-vertically))
               (message "ar-split-windows-on-execute-function set to: %s" ar-split-windows-on-execute-function))

             :help "If ‘split-window-vertically’ or ‘...-horizontally’. Use `M-x customize-variable' RET ‘ar-split-windows-on-execute-function’ RET to set it permanently"
             :style toggle :selected ar-split-windows-on-execute-function]

            ["Modeline display full path "
             (setq ar-modeline-display-full-path-p
                   (not ar-modeline-display-full-path-p))
             :help "If the full PATH/TO/PYTHON should be displayed in shell modeline.

Default is nil. Note: when ‘ar-shell-name’ is specified with path, it is shown as an acronym in buffer-name already. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-modeline-display-full-path-p]

            ["Modeline acronym display home "
             (setq ar-modeline-acronym-display-home-p
                   (not ar-modeline-acronym-display-home-p))
             :help "If the modeline acronym should contain chars indicating the home-directory.

Default is nil Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-modeline-acronym-display-home-p]

            ["Hide show hide docstrings"
             (setq ar-hide-show-hide-docstrings
                   (not ar-hide-show-hide-docstrings))
             :help "Controls if doc strings can be hidden by hide-showUse `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-hide-show-hide-docstrings]

            ["Hide comments when hiding all"
             (setq ar-hide-comments-when-hiding-all
                   (not ar-hide-comments-when-hiding-all))
             :help "Hide the comments too when you do ‘hs-hide-all’. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-hide-comments-when-hiding-all]

            ["Max help buffer "
             (setq ar-max-help-buffer-p
                   (not ar-max-help-buffer-p))
             :help "If \"\*SOME-Help\*\"-buffer should appear as the only visible.

Default is nil. In help-buffer, \"q\" will close it.  Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-max-help-buffer-p]

            ["Current defun show"
             (setq ar-current-defun-show
                   (not ar-current-defun-show))
             :help "If ‘ar-current-defun’ should jump to the definition, highlight it while waiting PY-WHICH-FUNC-DELAY seconds, before returning to previous position.

Default is ‘t’.Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-current-defun-show]

            ["Match paren mode"
             (setq ar-match-paren-mode
                   (not ar-match-paren-mode))
             :help "Non-nil means, cursor will jump to beginning or end of a block.
This vice versa, to beginning first.
Sets ‘ar-match-paren-key’ in ar-mode-map.
Customize ‘ar-match-paren-key’ which key to use. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-match-paren-mode])

           ("Debug"

            ["ar-debug-p"
             (setq ar-debug-p
                   (not ar-debug-p))
             :help "When non-nil, keep resp\. store information useful for debugging\.

Temporary files are not deleted\. Other functions might implement
some logging etc\. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-debug-p]

            ["Pdbtrack do tracking "
             (setq ar-pdbtrack-do-tracking-p
                   (not ar-pdbtrack-do-tracking-p))
             :help "Controls whether the pdbtrack feature is enabled or not.
When non-nil, pdbtrack is enabled in all comint-based buffers,
e.g. shell buffers and the \*SOME\* buffer.  When using pdb to debug a
SOME program, pdbtrack notices the pdb prompt and displays the
source file and line that the program is stopped at, much the same way
as gud-mode does for debugging C programs with gdb.Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-pdbtrack-do-tracking-p]

            ["Jump on exception"
             (setq ar-jump-on-exception
                   (not ar-jump-on-exception))
             :help "Jump to innermost exception frame in SOME output buffer.
When this variable is non-nil and an exception occurs when running
SOME code synchronously in a subprocess, jump immediately to the
source code of the innermost traceback frame.

Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-jump-on-exception]

            ["Highlight error in source "
             (setq ar-highlight-error-source-p
                   (not ar-highlight-error-source-p))
             :help "Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-highlight-error-source-p])

           ("Other"

            ("Directory"

             ["Guess install directory "
              (setq ar-guess-ar-install-directory-p
                    (not ar-guess-ar-install-directory-p))
              :help "If in cases, ‘ar-install-directory’ is not set,  ‘ar-set-load-path’should guess it from ‘buffer-file-name’. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-guess-ar-install-directory-p]

             ["Use local default"
              (setq ar-use-local-default
                    (not ar-use-local-default))
              :help "If ‘t’, ar-shell will use ‘ar-shell-local-path’ instead
of default SOME.

Making switch between several virtualenv's easier,
                               ‘ar-mode’ should deliver an installer, so named-shells pointing to virtualenv's will be available. Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-use-local-default]

             ["Use current dir when execute "
              (setq ar-use-current-dir-when-execute-p
                    (not ar-use-current-dir-when-execute-p))
              :help "When ‘t’, current directory is used by SOME-shell for output of ‘ar-execute-buffer’ and related commands.

See also ‘ar-execute-directory’Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-use-current-dir-when-execute-p]

             ["Keep shell dir when execute "
              (setq ar-keep-shell-dir-when-execute-p
                    (not ar-keep-shell-dir-when-execute-p))
              :help "Do not change SOME shell's current working directory when sending code.

See also ‘ar-execute-directory’Use `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-keep-shell-dir-when-execute-p]

             ["Fileless buffer use default directory "
              (setq ar-fileless-buffer-use-default-directory-p
                    (not ar-fileless-buffer-use-default-directory-p))
              :help "When ‘ar-use-current-dir-when-execute-p’ is non-nil and no buffer-file exists, value of ‘default-directory’ sets current working directory of SOME output shellUse `M-x customize-variable' to set it permanently"
              :style toggle :selected ar-fileless-buffer-use-default-directory-p])

            ("Underscore word syntax"
             :help "Toggle ‘ar-underscore-word-syntax-p’"

             ["Toggle underscore word syntax" ar-toggle-underscore-word-syntax-p
              :help " ‘ar-toggle-underscore-word-syntax-p’

If ‘ar-underscore-word-syntax-p’ should be on or off.

  Returns value of ‘ar-underscore-word-syntax-p’ switched to. .

Use `M-x customize-variable' to set it permanently"]

             ["Underscore word syntax on" ar-underscore-word-syntax-p-on
              :help " ‘ar-underscore-word-syntax-p-on’

Make sure, ar-underscore-word-syntax-p' is on.

Returns value of ‘ar-underscore-word-syntax-p’. .

Use `M-x customize-variable' to set it permanently"]

             ["Underscore word syntax off" ar-underscore-word-syntax-p-off
              :help " ‘ar-underscore-word-syntax-p-off’

Make sure, ‘ar-underscore-word-syntax-p’ is off.

Returns value of ‘ar-underscore-word-syntax-p’. .

Use `M-x customize-variable' to set it permanently"])

            ["Load pymacs "
             (setq ar-load-pymacs-p
                   (not ar-load-pymacs-p))
             :help "If Pymacs related stuff should be loaded.

Default is nil.

Pymacs has been written by François Pinard and many others.
See original source: http://pymacs.progiciels-bpi.caUse `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-load-pymacs-p]

            ["Verbose "
             (setq ar-verbose-p
                   (not ar-verbose-p))
             :help "If functions should report results.

Default is nil. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-verbose-p]

            ["Empty comment line separates paragraph "
             (setq ar-empty-comment-line-separates-paragraph-p
                   (not ar-empty-comment-line-separates-paragraph-p))
             :help "Consider paragraph start/end lines with nothing inside but comment sign.

Default is non-nilUse `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-empty-comment-line-separates-paragraph-p]

            ["Org cycle "
             (setq ar-org-cycle-p
                   (not ar-org-cycle-p))
             :help "When non-nil, command ‘org-cycle’ is available at shift-TAB, <backtab>

Default is nil. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-org-cycle-p]

            ["Set pager cat"
             (setq ar-set-pager-cat-p
                   (not ar-set-pager-cat-p))
             :help "If the shell environment variable \$PAGER should set to ‘cat’.

If ‘t’, use `C-c C-r' to jump to beginning of output. Then scroll normally.

Avoids lp:783828, \"Terminal not fully functional\", for help('COMMAND') in SomeMode-shell

When non-nil, imports module ‘os’ Use `M-x customize-variable' to
set it permanently"
             :style toggle :selected ar-set-pager-cat-p]

            ["Edit only "
             (setq ar-edit-only-p
                   (not ar-edit-only-p))
             :help "When ‘t’ ‘ar-mode’ will not take resort nor check for installed SOME executables. Default is nil.

See bug report at launchpad, lp:944093. Use `M-x customize-variable' to set it permanently"
             :style toggle :selected ar-edit-only-p])))
         ("Other"
          ["Boolswitch" ar-boolswitch
           :help " ‘ar-boolswitch’
Edit the assignment of a boolean variable, revert them.

I.e. switch it from \"True\" to \"False\" and vice versa"]

          ["Empty out list backward" ar-empty-out-list-backward
           :help " ‘ar-empty-out-list-backward’
Deletes all elements from list before point."]

          ["Kill buffer unconditional" ar-kill-buffer-unconditional
           :help " ‘ar-kill-buffer-unconditional’
Kill buffer unconditional, kill buffer-process if existing."]

          ["Remove overlays at point" ar-remove-overlays-at-point
           :help " ‘ar-remove-overlays-at-point’
Remove overlays as set when ‘ar-highlight-error-source-p’ is non-nil."]
          ("Electric"
           ["Complete electric comma" ar-complete-electric-comma
            :help " ‘ar-complete-electric-comma’"]

           ["Complete electric lparen" ar-complete-electric-lparen
            :help " ‘ar-complete-electric-lparen’"]

           ["Electric backspace" ar-electric-backspace
            :help " ‘ar-electric-backspace’
Delete preceding character or level of indentation.

With ARG do that ARG times.
Returns column reached."]

           ["Electric colon" ar-electric-colon
            :help " ‘ar-electric-colon’
Insert a colon and indent accordingly.

If a numeric argument ARG is provided, that many colons are inserted
non-electrically.

Electric behavior is inhibited inside a string or
comment or by universal prefix C-u.

Switched by ‘ar-electric-colon-active-p’, default is nil
See also ‘ar-electric-colon-greedy-p’"]

           ["Electric comment" ar-electric-comment
            :help " ‘ar-electric-comment’
Insert a comment. If starting a comment, indent accordingly.

If a numeric argument ARG is provided, that many \"#\" are inserted
non-electrically.
With C-u \"#\" electric behavior is inhibited inside a string or comment."]

           ["Electric delete" ar-electric-delete
            :help " ‘ar-electric-delete’
Delete following character or levels of whitespace.

With ARG do that ARG times."]

           ["Electric yank" ar-electric-yank
            :help " ‘ar-electric-yank’
Perform command ‘yank’ followed by an ‘indent-according-to-mode’"]

           ["Hungry delete backwards" ar-hungry-delete-backwards
            :help " ‘ar-hungry-delete-backwards’
Delete the preceding character or all preceding whitespace
back to the previous non-whitespace character.
See also C-c <delete>."]

           ["Hungry delete forward" ar-hungry-delete-forward
            :help " ‘ar-hungry-delete-forward’
Delete the following character or all following whitespace
up to the next non-whitespace character.
See also C-c <C-backspace>."]
            )
          ("Abbrevs"       :help "see also ‘ar-add-abbrev’"
           :filter (lambda (&rest junk)
                     (abbrev-table-menu SomeMode-mode-abbrev-table))            )

          ["Add abbrev" ar-add-abbrev
           :help " ‘ar-add-abbrev’
Defines ar-mode specific abbrev for last expressions before point.
Argument is how many ‘ar-partial-expression’s form the expansion; or zero means the region is the expansion.

Reads the abbreviation in the minibuffer; with numeric arg it displays a proposal for an abbrev.
Proposal is composed from the initial character(s) of the
expansion.

Do not use this function in a Lisp program; use ‘define-abbrev’ instead."]
          ("Completion"
           ["Py indent or complete" ar-indent-or-complete
            :help " ‘ar-indent-or-complete’"]

           ["Py shell complete" ar-shell-complete
            :help " ‘ar-shell-complete’"]

           ["Py complete" ar-complete
            :help " ‘ar-complete’"]
            )))))

(provide 'ar-shell-menu)
;;; ar-shell-menu.el ends here
