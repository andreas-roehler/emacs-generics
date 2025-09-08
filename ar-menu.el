;; ar-menu.el --- Provide the SomeMode-mode menu -*- lexical-binding: t; -*-
(defun ar-define-menu (map)
  (easy-menu-define ar-menu map "Py"
    `("SOME"
      ("Interpreter"
       ["ISomeMode" iSomeMode
        :help " ‘iSomeMode’
Start an ISOME interpreter."]

       ["ISomeMode2\.7" iSomeMode2\.7
        :help " ‘iSomeMode2\.7’"]

       ["ISomeMode3" iSomeMode3
        :help " ‘iSomeMode3’
Start an ISOME3 interpreter."]

       ["Jython" jython
        :help " ‘jython’
Start an Jython interpreter."]

       ["SOME" SomeMode
        :help " ‘SomeMode’
Start an SOME interpreter."]

       ["SOME2" SomeMode2
        :help " ‘SomeMode2’
Start an SOME2 interpreter."]

       ["SOME3" SomeMode3
        :help " ‘SomeMode3’
Start an SOME3 interpreter."]
       ["SymPy" isympy3
        :help " ‘isympy3’
Start an SymPy interpreter."])

      ("Edit"
       ("Shift"
        ("Shift right"
         ["Shift block right" ar-shift-block-right
          :help " ‘ar-shift-block-right’
Indent block by COUNT spaces."]

         ["Shift block or clause right" ar-shift-block-or-clause-right
          :help " ‘ar-shift-block-or-clause-right’
Indent block-or-clause by COUNT spaces."]

         ["Shift class right" ar-shift-class-right
          :help " ‘ar-shift-class-right’
Indent class by COUNT spaces."]

         ["Shift clause right" ar-shift-clause-right
          :help " ‘ar-shift-clause-right’
Indent clause by COUNT spaces."]

         ["Shift comment right" ar-shift-comment-right
          :help " ‘ar-shift-comment-right’
Indent comment by COUNT spaces."]

         ["Shift def right" ar-shift-def-right
          :help " ‘ar-shift-def-right’
Indent def by COUNT spaces."]

         ["Shift def or class right" ar-shift-def-or-class-right
          :help " ‘ar-shift-def-or-class-right’
Indent def-or-class by COUNT spaces."]

         ["Shift indent right" ar-shift-indent-right
          :help " ‘ar-shift-indent-right’
Indent indent by COUNT spaces."]

         ["Shift minor block right" ar-shift-minor-block-right
          :help " ‘ar-shift-minor-block-right’
Indent minor-block by COUNT spaces."]

         ["Shift paragraph right" ar-shift-paragraph-right
          :help " ‘ar-shift-paragraph-right’
Indent paragraph by COUNT spaces."]

         ["Shift region right" ar-shift-region-right
          :help " ‘ar-shift-region-right’
Indent region by COUNT spaces."]

         ["Shift statement right" ar-shift-statement-right
          :help " ‘ar-shift-statement-right’
Indent statement by COUNT spaces."]

         ["Shift top level right" ar-shift-top-level-right
          :help " ‘ar-shift-top-level-right’
Indent top-level by COUNT spaces."])
        ("Shift left"
         ["Shift block left" ar-shift-block-left
          :help " ‘ar-shift-block-left’
Dedent block by COUNT spaces."]

         ["Shift block or clause left" ar-shift-block-or-clause-left
          :help " ‘ar-shift-block-or-clause-left’
Dedent block-or-clause by COUNT spaces."]

         ["Shift class left" ar-shift-class-left
          :help " ‘ar-shift-class-left’
Dedent class by COUNT spaces."]

         ["Shift clause left" ar-shift-clause-left
          :help " ‘ar-shift-clause-left’
Dedent clause by COUNT spaces."]

         ["Shift comment left" ar-shift-comment-left
          :help " ‘ar-shift-comment-left’
Dedent comment by COUNT spaces."]

         ["Shift def left" ar-shift-def-left
          :help " ‘ar-shift-def-left’
Dedent def by COUNT spaces."]

         ["Shift def or class left" ar-shift-def-or-class-left
          :help " ‘ar-shift-def-or-class-left’
Dedent def-or-class by COUNT spaces."]

         ["Shift indent left" ar-shift-indent-left
          :help " ‘ar-shift-indent-left’
Dedent indent by COUNT spaces."]

         ["Shift minor block left" ar-shift-minor-block-left
          :help " ‘ar-shift-minor-block-left’
Dedent minor-block by COUNT spaces."]

         ["Shift paragraph left" ar-shift-paragraph-left
          :help " ‘ar-shift-paragraph-left’
Dedent paragraph by COUNT spaces."]

         ["Shift region left" ar-shift-region-left
          :help " ‘ar-shift-region-left’
Dedent region by COUNT spaces."]

         ["Shift statement left" ar-shift-statement-left
          :help " ‘ar-shift-statement-left’
Dedent statement by COUNT spaces."]))
       ("Mark"
        ["Mark block" ar-mark-block
         :help " ‘ar-mark-block’
Mark block, take beginning of line positions."]

        ["Mark block or clause" ar-mark-block-or-clause
         :help " ‘ar-mark-block-or-clause’
Mark block-or-clause, take beginning of line positions."]

        ["Mark class" ar-mark-class
         :help " ‘ar-mark-class’
Mark class, take beginning of line positions."]

        ["Mark clause" ar-mark-clause
         :help " ‘ar-mark-clause’
Mark clause, take beginning of line positions."]

        ["Mark comment" ar-mark-comment
         :help " ‘ar-mark-comment’
Mark comment at point."]

        ["Mark def" ar-mark-def
         :help " ‘ar-mark-def’
Mark def, take beginning of line positions."]

        ["Mark def or class" ar-mark-def-or-class
         :help " ‘ar-mark-def-or-class’
Mark def-or-class, take beginning of line positions."]

        ["Mark expression" ar-mark-expression
         :help " ‘ar-mark-expression’
Mark expression at point."]

        ["Mark except block" ar-mark-except-block
         :help " ‘ar-mark-except-block’
Mark except-block, take beginning of line positions."]

        ["Mark if block" ar-mark-if-block
         :help " ‘ar-mark-if-block’
Mark if-block, take beginning of line positions."]

        ["Mark indent" ar-mark-indent
         :help " ‘ar-mark-indent’
Mark indent, take beginning of line positions."]

        ["Mark line" ar-mark-line
         :help " ‘ar-mark-line’
Mark line at point."]

        ["Mark minor block" ar-mark-minor-block
         :help " ‘ar-mark-minor-block’
Mark minor-block, take beginning of line positions."]

        ["Mark partial expression" ar-mark-partial-expression
         :help " ‘ar-mark-partial-expression’
Mark partial-expression at point."]

        ["Mark paragraph" ar-mark-paragraph
         :help " ‘ar-mark-paragraph’
Mark paragraph at point."]

        ["Mark section" ar-mark-section
         :help " ‘ar-mark-section’
Mark section at point."]

        ["Mark statement" ar-mark-statement
         :help " ‘ar-mark-statement’
Mark statement, take beginning of line positions."]

        ["Mark top level" ar-mark-top-level
         :help " ‘ar-mark-top-level’
Mark top-level, take beginning of line positions."]

        ["Mark try block" ar-mark-try-block
         :help " ‘ar-mark-try-block’
Mark try-block, take beginning of line positions."])
       ("Copy"
        ["Copy block" ar-copy-block
         :help " ‘ar-copy-block’
Copy block at point."]

        ["Copy block or clause" ar-copy-block-or-clause
         :help " ‘ar-copy-block-or-clause’
Copy block-or-clause at point."]

        ["Copy class" ar-copy-class
         :help " ‘ar-copy-class’
Copy class at point."]

        ["Copy clause" ar-copy-clause
         :help " ‘ar-copy-clause’
Copy clause at point."]

        ["Copy comment" ar-copy-comment
         :help " ‘ar-copy-comment’"]

        ["Copy def" ar-copy-def
         :help " ‘ar-copy-def’
Copy def at point."]

        ["Copy def or class" ar-copy-def-or-class
         :help " ‘ar-copy-def-or-class’
Copy def-or-class at point."]

        ["Copy expression" ar-copy-expression
         :help " ‘ar-copy-expression’
Copy expression at point."]

        ["Copy except block" ar-copy-except-block
         :help " ‘ar-copy-except-block’"]

        ["Copy if block" ar-copy-if-block
         :help " ‘ar-copy-if-block’"]

        ["Copy indent" ar-copy-indent
         :help " ‘ar-copy-indent’
Copy indent at point."]

        ["Copy line" ar-copy-line
         :help " ‘ar-copy-line’
Copy line at point."]

        ["Copy minor block" ar-copy-minor-block
         :help " ‘ar-copy-minor-block’
Copy minor-block at point."]

        ["Copy partial expression" ar-copy-partial-expression
         :help " ‘ar-copy-partial-expression’
Copy partial-expression at point."]

        ["Copy paragraph" ar-copy-paragraph
         :help " ‘ar-copy-paragraph’
Copy paragraph at point."]

        ["Copy section" ar-copy-section
         :help " ‘ar-copy-section’"]

        ["Copy statement" ar-copy-statement
         :help " ‘ar-copy-statement’
Copy statement at point."]

        ["Copy top level" ar-copy-top-level
         :help " ‘ar-copy-top-level’
Copy top-level at point."])
       ("Kill"
        ["Kill block" ar-kill-block
         :help " ‘ar-kill-block’
Delete block at point."]

        ["Kill block or clause" ar-kill-block-or-clause
         :help " ‘ar-kill-block-or-clause’
Delete block-or-clause at point."]

        ["Kill class" ar-kill-class
         :help " ‘ar-kill-class’
Delete class at point."]

        ["Kill clause" ar-kill-clause
         :help " ‘ar-kill-clause’
Delete clause at point."]

        ["Kill comment" ar-kill-comment
         :help " ‘ar-kill-comment’
Delete comment at point."]

        ["Kill def" ar-kill-def
         :help " ‘ar-kill-def’
Delete def at point."]

        ["Kill def or class" ar-kill-def-or-class
         :help " ‘ar-kill-def-or-class’
Delete def-or-class at point."]

        ["Kill expression" ar-kill-expression
         :help " ‘ar-kill-expression’
Delete expression at point."]

        ["Kill except block" ar-kill-except-block
         :help " ‘ar-kill-except-block’
Delete except-block at point."]

        ["Kill if block" ar-kill-if-block
         :help " ‘ar-kill-if-block’
Delete if-block at point."]

        ["Kill indent" ar-kill-indent
         :help " ‘ar-kill-indent’
Delete indent at point."]

        ["Kill line" ar-kill-line
         :help " ‘ar-kill-line’
Delete line at point."]

        ["Kill minor block" ar-kill-minor-block
         :help " ‘ar-kill-minor-block’
Delete minor-block at point."]

        ["Kill partial expression" ar-kill-partial-expression
         :help " ‘ar-kill-partial-expression’
Delete partial-expression at point."]

        ["Kill paragraph" ar-kill-paragraph
         :help " ‘ar-kill-paragraph’
Delete paragraph at point."]

        ["Kill section" ar-kill-section
         :help " ‘ar-kill-section’
Delete section at point."]

        ["Kill statement" ar-kill-statement
         :help " ‘ar-kill-statement’
Delete statement at point."]

        ["Kill top level" ar-kill-top-level
         :help " ‘ar-kill-top-level’
Delete top-level at point."]

        ["Kill try block" ar-kill-try-block
         :help " ‘ar-kill-try-block’
Delete try-block at point."])
       ("Delete"
        ["Delete block" ar-delete-block
         :help " ‘ar-delete-block’
Delete BLOCK at point until beginning-of-line."]

        ["Delete block or clause" ar-delete-block-or-clause
         :help " ‘ar-delete-block-or-clause’
Delete BLOCK-OR-CLAUSE at point until beginning-of-line."]

        ["Delete class" ar-delete-class
         :help " ‘ar-delete-class’
Delete CLASS at point until beginning-of-line."]

        ["Delete clause" ar-delete-clause
         :help " ‘ar-delete-clause’
Delete CLAUSE at point until beginning-of-line."]

        ["Delete comment" ar-delete-comment
         :help " ‘ar-delete-comment’
Delete COMMENT at point."]

        ["Delete def" ar-delete-def
         :help " ‘ar-delete-def’
Delete DEF at point until beginning-of-line."]

        ["Delete def or class" ar-delete-def-or-class
         :help " ‘ar-delete-def-or-class’
Delete DEF-OR-CLASS at point until beginning-of-line."]

        ["Delete expression" ar-delete-expression
         :help " ‘ar-delete-expression’
Delete EXPRESSION at point."]

        ["Delete except block" ar-delete-except-block
         :help " ‘ar-delete-except-block’
Delete EXCEPT-BLOCK at point until beginning-of-line."]

        ["Delete if block" ar-delete-if-block
         :help " ‘ar-delete-if-block’
Delete IF-BLOCK at point until beginning-of-line."]

        ["Delete indent" ar-delete-indent
         :help " ‘ar-delete-indent’
Delete INDENT at point until beginning-of-line."]

        ["Delete line" ar-delete-line
         :help " ‘ar-delete-line’
Delete LINE at point."]

        ["Delete minor block" ar-delete-minor-block
         :help " ‘ar-delete-minor-block’
Delete MINOR-BLOCK at point until beginning-of-line."]

        ["Delete partial expression" ar-delete-partial-expression
         :help " ‘ar-delete-partial-expression’
Delete PARTIAL-EXPRESSION at point."]

        ["Delete paragraph" ar-delete-paragraph
         :help " ‘ar-delete-paragraph’
Delete PARAGRAPH at point."]

        ["Delete section" ar-delete-section
         :help " ‘ar-delete-section’
Delete SECTION at point."]

        ["Delete statement" ar-delete-statement
         :help " ‘ar-delete-statement’
Delete STATEMENT at point until beginning-of-line."]

        ["Delete top level" ar-delete-top-level
         :help " ‘ar-delete-top-level’
Delete TOP-LEVEL at point."]

        ["Delete try block" ar-delete-try-block
         :help " ‘ar-delete-try-block’
Delete TRY-BLOCK at point until beginning-of-line."])
       ("Comment"
        ["Comment block" ar-comment-block
         :help " ‘ar-comment-block’
Comments block at point."]

        ["Comment block or clause" ar-comment-block-or-clause
         :help " ‘ar-comment-block-or-clause’
Comments block-or-clause at point."]

        ["Comment class" ar-comment-class
         :help " ‘ar-comment-class’
Comments class at point."]

        ["Comment clause" ar-comment-clause
         :help " ‘ar-comment-clause’
Comments clause at point."]

        ["Comment def" ar-comment-def
         :help " ‘ar-comment-def’
Comments def at point."]

        ["Comment def or class" ar-comment-def-or-class
         :help " ‘ar-comment-def-or-class’
Comments def-or-class at point."]

        ["Comment indent" ar-comment-indent
         :help " ‘ar-comment-indent’
Comments indent at point."]

        ["Comment minor block" ar-comment-minor-block
         :help " ‘ar-comment-minor-block’
Comments minor-block at point."]

        ["Comment section" ar-comment-section
         :help " ‘ar-comment-section’
Comments section at point."]

        ["Comment statement" ar-comment-statement
         :help " ‘ar-comment-statement’
Comments statement at point."]

        ["Comment top level" ar-comment-top-level
         :help " ‘ar-comment-top-level’
Comments top-level at point."]))
      ("Move"
       ("Backward"

        ["Backward def or class" ar-backward-def-or-class
         :help " ‘ar-backward-def-or-class’
Go to beginning of def-or-class."]

        ["Backward class" ar-backward-class
         :help " ‘ar-backward-class’
Go to beginning of class."]

        ["Backward def" ar-backward-def
         :help " ‘ar-backward-def’
Go to beginning of def."]

        ["Backward block" ar-backward-block
         :help " ‘ar-backward-block’
Go to beginning of ‘block’."]

        ["Backward statement" ar-backward-statement
         :help " ‘ar-backward-statement’
Go to the initial line of a simple statement."]

        ["Backward indent" ar-backward-indent
         :help " ‘ar-backward-indent’
Go to the beginning of a section of equal indent."]

        ["Backward top level" ar-backward-top-level
         :help " ‘ar-backward-top-level’
Go up to beginning of statments until level of indentation is null."]

        ("Other"
         ["Backward section" ar-backward-section
          :help " ‘ar-backward-section’
Go to next section start upward in buffer."]

         ["Backward expression" ar-backward-expression
          :help " ‘ar-backward-expression’"]

         ["Backward partial expression" ar-backward-partial-expression
          :help " ‘ar-backward-partial-expression’"]

         ["Backward assignment" ar-backward-assignment
          :help " ‘ar-backward-assignment’"]

         ["Backward block or clause" ar-backward-block-or-clause
          :help " ‘ar-backward-block-or-clause’
Go to beginning of ‘block-or-clause’."]

         ["Backward clause" ar-backward-clause
          :help " ‘ar-backward-clause’
Go to beginning of ‘clause’."]

         ["Backward elif block" ar-backward-elif-block
          :help " ‘ar-backward-elif-block’
Go to beginning of ‘elif-block’."]

         ["Backward else block" ar-backward-else-block
          :help " ‘ar-backward-else-block’
Go to beginning of ‘else-block’."]

         ["Backward except block" ar-backward-except-block
          :help " ‘ar-backward-except-block’
Go to beginning of ‘except-block’."]

         ["Backward if block" ar-backward-if-block
          :help " ‘ar-backward-if-block’
Go to beginning of ‘if-block’."]

         ["Backward minor block" ar-backward-minor-block
          :help " ‘ar-backward-minor-block’
Go to beginning of ‘minor-block’."]

         ["Backward try block" ar-backward-try-block
          :help " ‘ar-backward-try-block’
Go to beginning of ‘try-block’."]))
       ("Forward"
        ["Forward def or class" ar-forward-def-or-class
         :help " ‘ar-forward-def-or-class’
Go to end of def-or-class."]

        ["Forward class" ar-forward-class
         :help " ‘ar-forward-class’
Go to end of class."]

        ["Forward def" ar-forward-def
         :help " ‘ar-forward-def’
Go to end of def."]

        ["Forward block" ar-forward-block
         :help " ‘ar-forward-block’
Go to end of block."]

        ["Forward statement" ar-forward-statement
         :help " ‘ar-forward-statement’
Go to the last char of current statement."]

        ["Forward indent" ar-forward-indent
         :help " ‘ar-forward-indent’
Go to the end of a section of equal indentation."]

        ["Forward top level" ar-forward-top-level
         :help " ‘ar-forward-top-level’
Go to end of top-level form at point."]

        ("Other"
         ["Forward section" ar-forward-section
          :help " ‘ar-forward-section’
Go to next section end downward in buffer."]

         ["Forward expression" ar-forward-expression
          :help " ‘ar-forward-expression’"]

         ["Forward partial expression" ar-forward-partial-expression
          :help " ‘ar-forward-partial-expression’"]

         ["Forward assignment" ar-forward-assignment
          :help " ‘ar-forward-assignment’"]

         ["Forward block or clause" ar-forward-block-or-clause
          :help " ‘ar-forward-block-or-clause’
Go to end of block-or-clause."]

         ["Forward clause" ar-forward-clause
          :help " ‘ar-forward-clause’
Go to end of clause."]

         ["Forward for block" ar-forward-for-block
         :help " ‘ar-forward-for-block’
Go to end of for-block."]

         ["Forward elif block" ar-forward-elif-block
          :help " ‘ar-forward-elif-block’
Go to end of elif-block."]

         ["Forward else block" ar-forward-else-block
          :help " ‘ar-forward-else-block’
Go to end of else-block."]

         ["Forward except block" ar-forward-except-block
          :help " ‘ar-forward-except-block’
Go to end of except-block."]

         ["Forward if block" ar-forward-if-block
          :help " ‘ar-forward-if-block’
Go to end of if-block."]

         ["Forward minor block" ar-forward-minor-block
          :help " ‘ar-forward-minor-block’
Go to end of minor-block."]
         ["Forward try block" ar-forward-try-block
          :help " ‘ar-forward-try-block’
Go to end of try-block."]))
       ("BOL-forms"
        ("Backward"
         ["Backward block bol" ar-backward-block-bol
          :help " ‘ar-backward-block-bol’
Go to beginning of ‘block’, go to BOL."]

         ["Backward block or clause bol" ar-backward-block-or-clause-bol
          :help " ‘ar-backward-block-or-clause-bol’
Go to beginning of ‘block-or-clause’, go to BOL."]

         ["Backward class bol" ar-backward-class-bol
          :help " ‘ar-backward-class-bol’
Go to beginning of class, go to BOL."]

         ["Backward clause bol" ar-backward-clause-bol
          :help " ‘ar-backward-clause-bol’
Go to beginning of ‘clause’, go to BOL."]

         ["Backward def bol" ar-backward-def-bol
          :help " ‘ar-backward-def-bol’
Go to beginning of def, go to BOL."]

         ["Backward def or class bol" ar-backward-def-or-class-bol
          :help " ‘ar-backward-def-or-class-bol’
Go to beginning of def-or-class, go to BOL."]

         ["Backward elif block bol" ar-backward-elif-block-bol
          :help " ‘ar-backward-elif-block-bol’
Go to beginning of ‘elif-block’, go to BOL."]

         ["Backward else block bol" ar-backward-else-block-bol
          :help " ‘ar-backward-else-block-bol’
Go to beginning of ‘else-block’, go to BOL."]

         ["Backward except block bol" ar-backward-except-block-bol
          :help " ‘ar-backward-except-block-bol’
Go to beginning of ‘except-block’, go to BOL."]

         ["Backward expression bol" ar-backward-expression-bol
          :help " ‘ar-backward-expression-bol’"]

         ["Backward for block bol" ar-backward-for-block-bol
          :help " ‘ar-backward-for-block-bol’
Go to beginning of ‘for-block’, go to BOL."]

         ["Backward if block bol" ar-backward-if-block-bol
          :help " ‘ar-backward-if-block-bol’
Go to beginning of ‘if-block’, go to BOL."]

         ["Backward indent bol" ar-backward-indent-bol
          :help " ‘ar-backward-indent-bol’
Go to the beginning of line of a section of equal indent."]

         ["Backward minor block bol" ar-backward-minor-block-bol
          :help " ‘ar-backward-minor-block-bol’
Go to beginning of ‘minor-block’, go to BOL."]

         ["Backward partial expression bol" ar-backward-partial-expression-bol
          :help " ‘ar-backward-partial-expression-bol’"]

         ["Backward section bol" ar-backward-section-bol
          :help " ‘ar-backward-section-bol’"]

         ["Backward statement bol" ar-backward-statement-bol
          :help " ‘ar-backward-statement-bol’
Goto beginning of line where statement starts."]

         ["Backward try block bol" ar-backward-try-block-bol
          :help " ‘ar-backward-try-block-bol’
Go to beginning of ‘try-block’, go to BOL."])
        ("Forward"
         ["Forward block bol" ar-forward-block-bol
          :help " ‘ar-forward-block-bol’
Goto beginning of line following end of block."]

         ["Forward block or clause bol" ar-forward-block-or-clause-bol
          :help " ‘ar-forward-block-or-clause-bol’
Goto beginning of line following end of block-or-clause."]

         ["Forward class bol" ar-forward-class-bol
          :help " ‘ar-forward-class-bol’
Goto beginning of line following end of class."]

         ["Forward clause bol" ar-forward-clause-bol
          :help " ‘ar-forward-clause-bol’
Goto beginning of line following end of clause."]

         ["Forward def bol" ar-forward-def-bol
          :help " ‘ar-forward-def-bol’
Goto beginning of line following end of def."]

         ["Forward def or class bol" ar-forward-def-or-class-bol
          :help " ‘ar-forward-def-or-class-bol’
Goto beginning of line following end of def-or-class."]

         ["Forward elif block bol" ar-forward-elif-block-bol
          :help " ‘ar-forward-elif-block-bol’
Goto beginning of line following end of elif-block."]

         ["Forward else block bol" ar-forward-else-block-bol
          :help " ‘ar-forward-else-block-bol’
Goto beginning of line following end of else-block."]

         ["Forward except block bol" ar-forward-except-block-bol
          :help " ‘ar-forward-except-block-bol’
Goto beginning of line following end of except-block."]

         ["Forward expression bol" ar-forward-expression-bol
          :help " ‘ar-forward-expression-bol’"]

         ["Forward for block bol" ar-forward-for-block-bol
          :help " ‘ar-forward-for-block-bol’
Goto beginning of line following end of for-block."]

         ["Forward if block bol" ar-forward-if-block-bol
          :help " ‘ar-forward-if-block-bol’
Goto beginning of line following end of if-block."]

         ["Forward indent bol" ar-forward-indent-bol
          :help " ‘ar-forward-indent-bol’
Go to beginning of line following of a section of equal indentation."]

         ["Forward minor block bol" ar-forward-minor-block-bol
          :help " ‘ar-forward-minor-block-bol’
Goto beginning of line following end of minor-block."]

         ["Forward partial expression bol" ar-forward-partial-expression-bol
          :help " ‘ar-forward-partial-expression-bol’"]

         ["Forward section bol" ar-forward-section-bol
          :help " ‘ar-forward-section-bol’"]

         ["Forward statement bol" ar-forward-statement-bol
          :help " ‘ar-forward-statement-bol’
Go to the beginning-of-line following current statement."]

         ["Forward top level bol" ar-forward-top-level-bol
          :help " ‘ar-forward-top-level-bol’
Go to end of top-level form at point, stop at next beginning-of-line."]

         ["Forward try block bol" ar-forward-try-block-bol
          :help " ‘ar-forward-try-block-bol’
Goto beginning of line following end of try-block."]))
       ("Up/Down"
        ["Up" ar-up
         :help " ‘ar-up’
Go up or to beginning of form if inside."]

        ["Down" ar-down
         :help " ‘ar-down’
Go to beginning one level below of compound statement or definition at point."]))
      ("Send"
       ["Execute block" ar-execute-block
        :help " ‘ar-execute-block’
Send block at point to interpreter."]

       ["Execute block or clause" ar-execute-block-or-clause
        :help " ‘ar-execute-block-or-clause’
Send block-or-clause at point to interpreter."]

       ["Execute buffer" ar-execute-buffer
        :help " ‘ar-execute-buffer’
:around advice: ‘ad-Advice-ar-execute-buffer’"]

       ["Execute class" ar-execute-class
        :help " ‘ar-execute-class’
Send class at point to interpreter."]

       ["Execute clause" ar-execute-clause
        :help " ‘ar-execute-clause’
Send clause at point to interpreter."]

       ["Execute def" ar-execute-def
        :help " ‘ar-execute-def’
Send def at point to interpreter."]

       ["Execute def or class" ar-execute-def-or-class
        :help " ‘ar-execute-def-or-class’
Send def-or-class at point to interpreter."]

       ["Execute expression" ar-execute-expression
        :help " ‘ar-execute-expression’
Send expression at point to interpreter."]

       ["Execute indent" ar-execute-indent
        :help " ‘ar-execute-indent’
Send indent at point to interpreter."]

       ["Execute line" ar-execute-line
        :help " ‘ar-execute-line’
Send line at point to interpreter."]

       ["Execute minor block" ar-execute-minor-block
        :help " ‘ar-execute-minor-block’
Send minor-block at point to interpreter."]

       ["Execute paragraph" ar-execute-paragraph
        :help " ‘ar-execute-paragraph’
Send paragraph at point to interpreter."]

       ["Execute partial expression" ar-execute-partial-expression
        :help " ‘ar-execute-partial-expression’
Send partial-expression at point to interpreter."]

       ["Execute region" ar-execute-region
        :help " ‘ar-execute-region’
Send region at point to interpreter."]

       ["Execute statement" ar-execute-statement
        :help " ‘ar-execute-statement’
Send statement at point to interpreter."]

       ["Execute top level" ar-execute-top-level
        :help " ‘ar-execute-top-level’
Send top-level at point to interpreter."]
       ("Other"
        ("ISOME"
         ["Execute block iSomeMode" ar-execute-block-iSomeMode
          :help " ‘ar-execute-block-iSomeMode’
Send block at point to ISOME interpreter."]

         ["Execute block or clause iSomeMode" ar-execute-block-or-clause-iSomeMode
          :help " ‘ar-execute-block-or-clause-iSomeMode’
Send block-or-clause at point to ISOME interpreter."]

         ["Execute buffer iSomeMode" ar-execute-buffer-iSomeMode
          :help " ‘ar-execute-buffer-iSomeMode’
Send buffer at point to ISOME interpreter."]

         ["Execute class iSomeMode" ar-execute-class-iSomeMode
          :help " ‘ar-execute-class-iSomeMode’
Send class at point to ISOME interpreter."]

         ["Execute clause iSomeMode" ar-execute-clause-iSomeMode
          :help " ‘ar-execute-clause-iSomeMode’
Send clause at point to ISOME interpreter."]

         ["Execute def iSomeMode" ar-execute-def-iSomeMode
          :help " ‘ar-execute-def-iSomeMode’
Send def at point to ISOME interpreter."]

         ["Execute def or class iSomeMode" ar-execute-def-or-class-iSomeMode
          :help " ‘ar-execute-def-or-class-iSomeMode’
Send def-or-class at point to ISOME interpreter."]

         ["Execute expression iSomeMode" ar-execute-expression-iSomeMode
          :help " ‘ar-execute-expression-iSomeMode’
Send expression at point to ISOME interpreter."]

         ["Execute indent iSomeMode" ar-execute-indent-iSomeMode
          :help " ‘ar-execute-indent-iSomeMode’
Send indent at point to ISOME interpreter."]

         ["Execute line iSomeMode" ar-execute-line-iSomeMode
          :help " ‘ar-execute-line-iSomeMode’
Send line at point to ISOME interpreter."]

         ["Execute minor block iSomeMode" ar-execute-minor-block-iSomeMode
          :help " ‘ar-execute-minor-block-iSomeMode’
Send minor-block at point to ISOME interpreter."]

         ["Execute paragraph iSomeMode" ar-execute-paragraph-iSomeMode
          :help " ‘ar-execute-paragraph-iSomeMode’
Send paragraph at point to ISOME interpreter."]

         ["Execute partial expression iSomeMode" ar-execute-partial-expression-iSomeMode
          :help " ‘ar-execute-partial-expression-iSomeMode’
Send partial-expression at point to ISOME interpreter."]

         ["Execute region iSomeMode" ar-execute-region-iSomeMode
          :help " ‘ar-execute-region-iSomeMode’
Send region at point to ISOME interpreter."]

         ["Execute statement iSomeMode" ar-execute-statement-iSomeMode
          :help " ‘ar-execute-statement-iSomeMode’
Send statement at point to ISOME interpreter."]

         ["Execute top level iSomeMode" ar-execute-top-level-iSomeMode
          :help " ‘ar-execute-top-level-iSomeMode’
Send top-level at point to ISOME interpreter."])
        ("ISOME2"
         ["Execute block iSomeMode2" ar-execute-block-iSomeMode2
          :help " ‘ar-execute-block-iSomeMode2’"]

         ["Execute block or clause iSomeMode2" ar-execute-block-or-clause-iSomeMode2
          :help " ‘ar-execute-block-or-clause-iSomeMode2’"]

         ["Execute buffer iSomeMode2" ar-execute-buffer-iSomeMode2
          :help " ‘ar-execute-buffer-iSomeMode2’"]

         ["Execute class iSomeMode2" ar-execute-class-iSomeMode2
          :help " ‘ar-execute-class-iSomeMode2’"]

         ["Execute clause iSomeMode2" ar-execute-clause-iSomeMode2
          :help " ‘ar-execute-clause-iSomeMode2’"]

         ["Execute def iSomeMode2" ar-execute-def-iSomeMode2
          :help " ‘ar-execute-def-iSomeMode2’"]

         ["Execute def or class iSomeMode2" ar-execute-def-or-class-iSomeMode2
          :help " ‘ar-execute-def-or-class-iSomeMode2’"]

         ["Execute expression iSomeMode2" ar-execute-expression-iSomeMode2
          :help " ‘ar-execute-expression-iSomeMode2’"]

         ["Execute indent iSomeMode2" ar-execute-indent-iSomeMode2
          :help " ‘ar-execute-indent-iSomeMode2’"]

         ["Execute line iSomeMode2" ar-execute-line-iSomeMode2
          :help " ‘ar-execute-line-iSomeMode2’"]

         ["Execute minor block iSomeMode2" ar-execute-minor-block-iSomeMode2
          :help " ‘ar-execute-minor-block-iSomeMode2’"]

         ["Execute paragraph iSomeMode2" ar-execute-paragraph-iSomeMode2
          :help " ‘ar-execute-paragraph-iSomeMode2’"]

         ["Execute partial expression iSomeMode2" ar-execute-partial-expression-iSomeMode2
          :help " ‘ar-execute-partial-expression-iSomeMode2’"]

         ["Execute region iSomeMode2" ar-execute-region-iSomeMode2
          :help " ‘ar-execute-region-iSomeMode2’"]

         ["Execute statement iSomeMode2" ar-execute-statement-iSomeMode2
          :help " ‘ar-execute-statement-iSomeMode2’"]

         ["Execute top level iSomeMode2" ar-execute-top-level-iSomeMode2
          :help " ‘ar-execute-top-level-iSomeMode2’"])
        ("ISOME3"
         ["Execute block iSomeMode3" ar-execute-block-iSomeMode3
          :help " ‘ar-execute-block-iSomeMode3’
Send block at point to ISOME interpreter."]

         ["Execute block or clause iSomeMode3" ar-execute-block-or-clause-iSomeMode3
          :help " ‘ar-execute-block-or-clause-iSomeMode3’
Send block-or-clause at point to ISOME interpreter."]

         ["Execute buffer iSomeMode3" ar-execute-buffer-iSomeMode3
          :help " ‘ar-execute-buffer-iSomeMode3’
Send buffer at point to ISOME interpreter."]

         ["Execute class iSomeMode3" ar-execute-class-iSomeMode3
          :help " ‘ar-execute-class-iSomeMode3’
Send class at point to ISOME interpreter."]

         ["Execute clause iSomeMode3" ar-execute-clause-iSomeMode3
          :help " ‘ar-execute-clause-iSomeMode3’
Send clause at point to ISOME interpreter."]

         ["Execute def iSomeMode3" ar-execute-def-iSomeMode3
          :help " ‘ar-execute-def-iSomeMode3’
Send def at point to ISOME interpreter."]

         ["Execute def or class iSomeMode3" ar-execute-def-or-class-iSomeMode3
          :help " ‘ar-execute-def-or-class-iSomeMode3’
Send def-or-class at point to ISOME interpreter."]

         ["Execute expression iSomeMode3" ar-execute-expression-iSomeMode3
          :help " ‘ar-execute-expression-iSomeMode3’
Send expression at point to ISOME interpreter."]

         ["Execute indent iSomeMode3" ar-execute-indent-iSomeMode3
          :help " ‘ar-execute-indent-iSomeMode3’
Send indent at point to ISOME interpreter."]

         ["Execute line iSomeMode3" ar-execute-line-iSomeMode3
          :help " ‘ar-execute-line-iSomeMode3’
Send line at point to ISOME interpreter."]

         ["Execute minor block iSomeMode3" ar-execute-minor-block-iSomeMode3
          :help " ‘ar-execute-minor-block-iSomeMode3’
Send minor-block at point to ISOME interpreter."]

         ["Execute paragraph iSomeMode3" ar-execute-paragraph-iSomeMode3
          :help " ‘ar-execute-paragraph-iSomeMode3’
Send paragraph at point to ISOME interpreter."]

         ["Execute partial expression iSomeMode3" ar-execute-partial-expression-iSomeMode3
          :help " ‘ar-execute-partial-expression-iSomeMode3’
Send partial-expression at point to ISOME interpreter."]

         ["Execute region iSomeMode3" ar-execute-region-iSomeMode3
          :help " ‘ar-execute-region-iSomeMode3’
Send region at point to ISOME interpreter."]

         ["Execute statement iSomeMode3" ar-execute-statement-iSomeMode3
          :help " ‘ar-execute-statement-iSomeMode3’
Send statement at point to ISOME interpreter."]

         ["Execute top level iSomeMode3" ar-execute-top-level-iSomeMode3
          :help " ‘ar-execute-top-level-iSomeMode3’
Send top-level at point to ISOME interpreter."])
        ("Jython"
         ["Execute block jython" ar-execute-block-jython
          :help " ‘ar-execute-block-jython’
Send block at point to Jython interpreter."]

         ["Execute block or clause jython" ar-execute-block-or-clause-jython
          :help " ‘ar-execute-block-or-clause-jython’
Send block-or-clause at point to Jython interpreter."]

         ["Execute buffer jython" ar-execute-buffer-jython
          :help " ‘ar-execute-buffer-jython’
Send buffer at point to Jython interpreter."]

         ["Execute class jython" ar-execute-class-jython
          :help " ‘ar-execute-class-jython’
Send class at point to Jython interpreter."]

         ["Execute clause jython" ar-execute-clause-jython
          :help " ‘ar-execute-clause-jython’
Send clause at point to Jython interpreter."]

         ["Execute def jython" ar-execute-def-jython
          :help " ‘ar-execute-def-jython’
Send def at point to Jython interpreter."]

         ["Execute def or class jython" ar-execute-def-or-class-jython
          :help " ‘ar-execute-def-or-class-jython’
Send def-or-class at point to Jython interpreter."]

         ["Execute expression jython" ar-execute-expression-jython
          :help " ‘ar-execute-expression-jython’
Send expression at point to Jython interpreter."]

         ["Execute indent jython" ar-execute-indent-jython
          :help " ‘ar-execute-indent-jython’
Send indent at point to Jython interpreter."]

         ["Execute line jython" ar-execute-line-jython
          :help " ‘ar-execute-line-jython’
Send line at point to Jython interpreter."]

         ["Execute minor block jython" ar-execute-minor-block-jython
          :help " ‘ar-execute-minor-block-jython’
Send minor-block at point to Jython interpreter."]

         ["Execute paragraph jython" ar-execute-paragraph-jython
          :help " ‘ar-execute-paragraph-jython’
Send paragraph at point to Jython interpreter."]

         ["Execute partial expression jython" ar-execute-partial-expression-jython
          :help " ‘ar-execute-partial-expression-jython’
Send partial-expression at point to Jython interpreter."]

         ["Execute region jython" ar-execute-region-jython
          :help " ‘ar-execute-region-jython’
Send region at point to Jython interpreter."]

         ["Execute statement jython" ar-execute-statement-jython
          :help " ‘ar-execute-statement-jython’
Send statement at point to Jython interpreter."]

         ["Execute top level jython" ar-execute-top-level-jython
          :help " ‘ar-execute-top-level-jython’
Send top-level at point to Jython interpreter."])
        ("SOME"
         ["Execute block SomeMode" ar-execute-block-SomeMode
          :help " ‘ar-execute-block-SomeMode’
Send block at point to default interpreter."]

         ["Execute block or clause SomeMode" ar-execute-block-or-clause-SomeMode
          :help " ‘ar-execute-block-or-clause-SomeMode’
Send block-or-clause at point to default interpreter."]

         ["Execute buffer SomeMode" ar-execute-buffer-SomeMode
          :help " ‘ar-execute-buffer-SomeMode’
Send buffer at point to default interpreter."]

         ["Execute class SomeMode" ar-execute-class-SomeMode
          :help " ‘ar-execute-class-SomeMode’
Send class at point to default interpreter."]

         ["Execute clause SomeMode" ar-execute-clause-SomeMode
          :help " ‘ar-execute-clause-SomeMode’
Send clause at point to default interpreter."]

         ["Execute def SomeMode" ar-execute-def-SomeMode
          :help " ‘ar-execute-def-SomeMode’
Send def at point to default interpreter."]

         ["Execute def or class SomeMode" ar-execute-def-or-class-SomeMode
          :help " ‘ar-execute-def-or-class-SomeMode’
Send def-or-class at point to default interpreter."]

         ["Execute expression SomeMode" ar-execute-expression-SomeMode
          :help " ‘ar-execute-expression-SomeMode’
Send expression at point to default interpreter."]

         ["Execute indent SomeMode" ar-execute-indent-SomeMode
          :help " ‘ar-execute-indent-SomeMode’
Send indent at point to default interpreter."]

         ["Execute line SomeMode" ar-execute-line-SomeMode
          :help " ‘ar-execute-line-SomeMode’
Send line at point to default interpreter."]

         ["Execute minor block SomeMode" ar-execute-minor-block-SomeMode
          :help " ‘ar-execute-minor-block-SomeMode’
Send minor-block at point to default interpreter."]

         ["Execute paragraph SomeMode" ar-execute-paragraph-SomeMode
          :help " ‘ar-execute-paragraph-SomeMode’
Send paragraph at point to default interpreter."]

         ["Execute partial expression SomeMode" ar-execute-partial-expression-SomeMode
          :help " ‘ar-execute-partial-expression-SomeMode’
Send partial-expression at point to default interpreter."]

         ["Execute region SomeMode" ar-execute-region-SomeMode
          :help " ‘ar-execute-region-SomeMode’
Send region at point to default interpreter."]

         ["Execute statement SomeMode" ar-execute-statement-SomeMode
          :help " ‘ar-execute-statement-SomeMode’
Send statement at point to default interpreter."]

         ["Execute top level SomeMode" ar-execute-top-level-SomeMode
          :help " ‘ar-execute-top-level-SomeMode’
Send top-level at point to default interpreter."])
        ("SOME2"
         ["Execute block SomeMode2" ar-execute-block-SomeMode2
          :help " ‘ar-execute-block-SomeMode2’
Send block at point to SOME2 interpreter."]

         ["Execute block or clause SomeMode2" ar-execute-block-or-clause-SomeMode2
          :help " ‘ar-execute-block-or-clause-SomeMode2’
Send block-or-clause at point to SOME2 interpreter."]

         ["Execute buffer SomeMode2" ar-execute-buffer-SomeMode2
          :help " ‘ar-execute-buffer-SomeMode2’
Send buffer at point to SOME2 interpreter."]

         ["Execute class SomeMode2" ar-execute-class-SomeMode2
          :help " ‘ar-execute-class-SomeMode2’
Send class at point to SOME2 interpreter."]

         ["Execute clause SomeMode2" ar-execute-clause-SomeMode2
          :help " ‘ar-execute-clause-SomeMode2’
Send clause at point to SOME2 interpreter."]

         ["Execute def SomeMode2" ar-execute-def-SomeMode2
          :help " ‘ar-execute-def-SomeMode2’
Send def at point to SOME2 interpreter."]

         ["Execute def or class SomeMode2" ar-execute-def-or-class-SomeMode2
          :help " ‘ar-execute-def-or-class-SomeMode2’
Send def-or-class at point to SOME2 interpreter."]

         ["Execute expression SomeMode2" ar-execute-expression-SomeMode2
          :help " ‘ar-execute-expression-SomeMode2’
Send expression at point to SOME2 interpreter."]

         ["Execute indent SomeMode2" ar-execute-indent-SomeMode2
          :help " ‘ar-execute-indent-SomeMode2’
Send indent at point to SOME2 interpreter."]

         ["Execute line SomeMode2" ar-execute-line-SomeMode2
          :help " ‘ar-execute-line-SomeMode2’
Send line at point to SOME2 interpreter."]

         ["Execute minor block SomeMode2" ar-execute-minor-block-SomeMode2
          :help " ‘ar-execute-minor-block-SomeMode2’
Send minor-block at point to SOME2 interpreter."]

         ["Execute paragraph SomeMode2" ar-execute-paragraph-SomeMode2
          :help " ‘ar-execute-paragraph-SomeMode2’
Send paragraph at point to SOME2 interpreter."]

         ["Execute partial expression SomeMode2" ar-execute-partial-expression-SomeMode2
          :help " ‘ar-execute-partial-expression-SomeMode2’
Send partial-expression at point to SOME2 interpreter."]

         ["Execute region SomeMode2" ar-execute-region-SomeMode2
          :help " ‘ar-execute-region-SomeMode2’
Send region at point to SOME2 interpreter."]

         ["Execute statement SomeMode2" ar-execute-statement-SomeMode2
          :help " ‘ar-execute-statement-SomeMode2’
Send statement at point to SOME2 interpreter."]

         ["Execute top level SomeMode2" ar-execute-top-level-SomeMode2
          :help " ‘ar-execute-top-level-SomeMode2’
Send top-level at point to SOME2 interpreter."])
        ("SOME3"
         ["Execute block SomeMode3" ar-execute-block-SomeMode3
          :help " ‘ar-execute-block-SomeMode3’
Send block at point to SOME3 interpreter."]

         ["Execute block or clause SomeMode3" ar-execute-block-or-clause-SomeMode3
          :help " ‘ar-execute-block-or-clause-SomeMode3’
Send block-or-clause at point to SOME3 interpreter."]

         ["Execute buffer SomeMode3" ar-execute-buffer-SomeMode3
          :help " ‘ar-execute-buffer-SomeMode3’
Send buffer at point to SOME3 interpreter."]

         ["Execute class SomeMode3" ar-execute-class-SomeMode3
          :help " ‘ar-execute-class-SomeMode3’
Send class at point to SOME3 interpreter."]

         ["Execute clause SomeMode3" ar-execute-clause-SomeMode3
          :help " ‘ar-execute-clause-SomeMode3’
Send clause at point to SOME3 interpreter."]

         ["Execute def SomeMode3" ar-execute-def-SomeMode3
          :help " ‘ar-execute-def-SomeMode3’
Send def at point to SOME3 interpreter."]

         ["Execute def or class SomeMode3" ar-execute-def-or-class-SomeMode3
          :help " ‘ar-execute-def-or-class-SomeMode3’
Send def-or-class at point to SOME3 interpreter."]

         ["Execute expression SomeMode3" ar-execute-expression-SomeMode3
          :help " ‘ar-execute-expression-SomeMode3’
Send expression at point to SOME3 interpreter."]

         ["Execute indent SomeMode3" ar-execute-indent-SomeMode3
          :help " ‘ar-execute-indent-SomeMode3’
Send indent at point to SOME3 interpreter."]

         ["Execute line SomeMode3" ar-execute-line-SomeMode3
          :help " ‘ar-execute-line-SomeMode3’
Send line at point to SOME3 interpreter."]

         ["Execute minor block SomeMode3" ar-execute-minor-block-SomeMode3
          :help " ‘ar-execute-minor-block-SomeMode3’
Send minor-block at point to SOME3 interpreter."]

         ["Execute paragraph SomeMode3" ar-execute-paragraph-SomeMode3
          :help " ‘ar-execute-paragraph-SomeMode3’
Send paragraph at point to SOME3 interpreter."]

         ["Execute partial expression SomeMode3" ar-execute-partial-expression-SomeMode3
          :help " ‘ar-execute-partial-expression-SomeMode3’
Send partial-expression at point to SOME3 interpreter."]

         ["Execute region SomeMode3" ar-execute-region-SomeMode3
          :help " ‘ar-execute-region-SomeMode3’
Send region at point to SOME3 interpreter."]

         ["Execute statement SomeMode3" ar-execute-statement-SomeMode3
          :help " ‘ar-execute-statement-SomeMode3’
Send statement at point to SOME3 interpreter."]

         ["Execute top level SomeMode3" ar-execute-top-level-SomeMode3
          :help " ‘ar-execute-top-level-SomeMode3’
Send top-level at point to SOME3 interpreter."])
        ("Ignoring defaults "
         :help "`M-x ar-execute-statement- TAB' for example list commands ignoring defaults

 of ‘ar-switch-buffers-on-execute-p’ and ‘ar-split-window-on-execute’")))
      ("Hide-Show"
       ("Hide"
        ["Hide block" ar-hide-block
         :help " ‘ar-hide-block’
Hide block at point."]

        ["Hide top level" ar-hide-top-level
         :help " ‘ar-hide-top-level’
Hide top-level at point."]

        ["Hide def" ar-hide-def
         :help " ‘ar-hide-def’
Hide def at point."]

        ["Hide def or class" ar-hide-def-or-class
         :help " ‘ar-hide-def-or-class’
Hide def-or-class at point."]

        ["Hide statement" ar-hide-statement
         :help " ‘ar-hide-statement’
Hide statement at point."]

        ["Hide class" ar-hide-class
         :help " ‘ar-hide-class’
Hide class at point."]

        ["Hide clause" ar-hide-clause
         :help " ‘ar-hide-clause’
Hide clause at point."]

        ["Hide block or clause" ar-hide-block-or-clause
         :help " ‘ar-hide-block-or-clause’
Hide block-or-clause at point."]

        ["Hide comment" ar-hide-comment
         :help " ‘ar-hide-comment’
Hide comment at point."]

        ["Hide indent" ar-hide-indent
         :help " ‘ar-hide-indent’
Hide indent at point."]

        ["Hide expression" ar-hide-expression
         :help " ‘ar-hide-expression’
Hide expression at point."]

        ["Hide line" ar-hide-line
         :help " ‘ar-hide-line’
Hide line at point."]

        ["Hide for-block" ar-hide-for-block
         :help " ‘ar-hide-for-block’
Hide for-block at point."]

        ["Hide if-block" ar-hide-if-block
         :help " ‘ar-hide-if-block’
Hide if-block at point."]

        ["Hide elif-block" ar-hide-elif-block
         :help " ‘ar-hide-elif-block’
Hide elif-block at point."]

        ["Hide else-block" ar-hide-else-block
         :help " ‘ar-hide-else-block’
Hide else-block at point."]

        ["Hide except-block" ar-hide-except-block
         :help " ‘ar-hide-except-block’
Hide except-block at point."]

        ["Hide minor-block" ar-hide-minor-block
         :help " ‘ar-hide-minor-block’
Hide minor-block at point."]

        ["Hide paragraph" ar-hide-paragraph
         :help " ‘ar-hide-paragraph’
Hide paragraph at point."]

        ["Hide partial expression" ar-hide-partial-expression
         :help " ‘ar-hide-partial-expression’
Hide partial-expression at point."]

        ["Hide section" ar-hide-section
         :help " ‘ar-hide-section’
Hide section at point."])
       ("Show"
        ["Show all" ar-show-all
         :help " ‘ar-show-all’
Show all in buffer."]

        ["Show" ar-show
         :help " ‘ar-show’
Show hidden code at point."]))
      ("Fast process"
       ["Execute block fast" ar-execute-block-fast
        :help " ‘ar-execute-block-fast’
Process block at point by a SOME interpreter."]

       ["Execute block or clause fast" ar-execute-block-or-clause-fast
        :help " ‘ar-execute-block-or-clause-fast’
Process block-or-clause at point by a SOME interpreter."]

       ["Execute class fast" ar-execute-class-fast
        :help " ‘ar-execute-class-fast’
Process class at point by a SOME interpreter."]

       ["Execute clause fast" ar-execute-clause-fast
        :help " ‘ar-execute-clause-fast’
Process clause at point by a SOME interpreter."]

       ["Execute def fast" ar-execute-def-fast
        :help " ‘ar-execute-def-fast’
Process def at point by a SOME interpreter."]

       ["Execute def or class fast" ar-execute-def-or-class-fast
        :help " ‘ar-execute-def-or-class-fast’
Process def-or-class at point by a SOME interpreter."]

       ["Execute expression fast" ar-execute-expression-fast
        :help " ‘ar-execute-expression-fast’
Process expression at point by a SOME interpreter."]

       ["Execute partial expression fast" ar-execute-partial-expression-fast
        :help " ‘ar-execute-partial-expression-fast’
Process partial-expression at point by a SOME interpreter."]

       ["Execute region fast" ar-execute-region-fast
        :help " ‘ar-execute-region-fast’"]

       ["Execute statement fast" ar-execute-statement-fast
        :help " ‘ar-execute-statement-fast’
Process statement at point by a SOME interpreter."]

       ["Execute string fast" ar-execute-string-fast
        :help " ‘ar-execute-string-fast’"]

       ["Execute top level fast" ar-execute-top-level-fast
        :help " ‘ar-execute-top-level-fast’
Process top-level at point by a SOME interpreter."])
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
Issue a virtualenvwrapper-like virtualenv-workon command"])

      ["Execute import or reload" ar-execute-import-or-reload
       :help " ‘ar-execute-import-or-reload’
Import the current buffer’s file in a SOME interpreter."]
      ("Help"
       ["Find definition" ar-find-definition
        :help " ‘ar-find-definition’
Find source of definition of SYMBOL."]

       ["Help at point" ar-help-at-point
        :help " ‘ar-help-at-point’
Print help on symbol at point."]

       ["Info lookup symbol" ar-info-lookup-symbol
        :help " ‘ar-info-lookup-symbol’"]

       ["Symbol at point" ar-symbol-at-point
        :help " ‘ar-symbol-at-point’
Return the current SOME symbol."])
      ("Debugger"
       ["Execute statement pdb" ar-execute-statement-pdb
        :help " ‘ar-execute-statement-pdb’
Execute statement running pdb."]

       ["Pdb" pdb
        :help " ‘pdb’
Run pdb on program FILE in buffer ‘*gud-FILE*’."])
      ("Checks"
       ("Pylint"
        ["Pylint run" ar-pylint-run
         :help " ‘ar-pylint-run’
*Run pylint (default on the file currently visited)."]

        ["Pylint help" ar-pylint-help
         :help " ‘ar-pylint-help’
Display Pylint command line help messages."]

        ["Pylint flymake mode" pylint-flymake-mode
         :help " ‘pylint-flymake-mode’
Toggle ‘pylint’ ‘flymake-mode’."])
       ("Pep8"
        ["Pep8 run" ar-pep8-run
         :help " ‘ar-pep8-run’
*Run pep8, check formatting - default on the file currently visited."]

        ["Pep8 help" ar-pep8-help
         :help " ‘ar-pep8-help’
Display pep8 command line help messages."]

        ["Pep8 flymake mode" pep8-flymake-mode
         :help " ‘pep8-flymake-mode’
Toggle `pep8’ ‘flymake-mode’."])
       ("Pyflakes3"
        ["Pyflakes3 run" ar-pyflakes3-run
         :help " ‘ar-pyflakes3-run’
*Run pyflakes (default on the file currently visited)."]

        ["Pyflakes3 help" ar-pyflakes3-help
         :help " ‘ar-pyflakes3-help’
Display Pyflakes3 command line help messages."]

        ["Pyflakes3 flymake mode" pyflakes-flymake-mode
         :help " ‘pyflakes-flymake-mode’
Toggle ‘pyflakes’ ‘flymake-mode’."])
       ("Flake8"
        ["Flake8 run" ar-flake8-run
         :help " ‘ar-flake8-run’
Flake8 is a wrapper around these tools:"]

        ["Flake8 help" ar-flake8-help
         :help " ‘ar-flake8-help’
Display flake8 command line help messages."]
        ("Pyflakes-pep8"
         ["Pyflakes pep8 run" ar-pyflakes3-pep8-run
          :help " ‘ar-pyflakes-pep8-run’"]

         ["Pyflakes pep8 help" ar-pyflakes-pep8-help
          :help " ‘ar-pyflakes-pep8-help’"]

         ["Pyflakes pep8 flymake mode" pyflakes-pep8-flymake-mode
          :help " ‘pyflakes-pep8-flymake-mode’"])
        ))
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
    4, 5, 6,]

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
         ["ar-electric-backspace-mode" ar-electric-backspace-mode
          :help " ‘ar-electric-backspace-mode’
If <backspace> key deletes one or more of whitespace chars left from point .
Default is nil."
          :style toggle :selected ar-electric-backspace-mode]
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

         ["Register shell buffer"
          (setq ar-register-shell-buffer-p
                (not ar-register-shell-buffer-p))
          :help "If ar-shell buffer should be registerd at start.

Default is nil."
          :style toggle :selected ar-register-shell-buffer-p]

         ["Verbose "
          (setq ar-verbose-p
                (not ar-verbose-p))
          :help "If functions should report results.

Default is nil. Use `M-x customize-variable' to set it permanently"
          :style toggle :selected ar-verbose-p]
         ;; ["No session mode "
         ;;       (setq ar-no-session-p
         ;;             (not ar-no-session-p))
         ;;       :help "If shell should be in session-mode.

         ;; Default is nil. Use `M-x customize-variable' to set it permanently"
         ;;       :style toggle :selected ar-no-session-p]

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
       ["ar-electric-backspace-mode" ar-electric-backspace-mode
        :help " ‘ar-electric-backspace-mode’
If <backspace> key deletes one or more of whitespace chars left from point ."]
       ["Boolswitch" ar-boolswitch
        :help " ‘ar-boolswitch’
Edit the assignment of a boolean variable, revert them."]

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
Delete preceding character or level of indentation."]

        ["Electric colon" ar-electric-colon
         :help " ‘ar-electric-colon’
Insert a colon and indent accordingly."]

        ["Electric comment" ar-electric-comment
         :help " ‘ar-electric-comment’
Insert a comment. If starting a comment, indent accordingly."]

        ["Electric delete" ar-electric-delete
         :help " ‘ar-electric-delete’
Delete following character or levels of whitespace."]

        ["Electric yank" ar-electric-yank
         :help " ‘ar-electric-yank’
Perform command ‘yank’ followed by an ‘indent-according-to-mode’"]

        ["Hungry delete backwards" ar-hungry-delete-backwards
         :help " ‘ar-hungry-delete-backwards’
Delete the preceding character or all preceding whitespace"]

        ["Hungry delete forward" ar-hungry-delete-forward
         :help " ‘ar-hungry-delete-forward’
Delete the following character or all following whitespace"])
       ("Filling"
        ["Py docstring style" ar-docstring-style
         :help " ‘ar-docstring-style’"]

        ["Py fill comment" ar-fill-comment
         :help " ‘ar-fill-comment’"]

        ["Py fill paragraph" ar-fill-paragraph
         :help " ‘ar-fill-paragraph’"]

        ["Py fill string" ar-fill-string
         :help " ‘ar-fill-string’"]

        ["Py fill string django" ar-fill-string-django
         :help " ‘ar-fill-string-django’"]

        ["Py fill string onetwo" ar-fill-string-onetwo
         :help " ‘ar-fill-string-onetwo’"]

        ["Py fill string pep 257" ar-fill-string-pep-257
         :help " ‘ar-fill-string-pep-257’"]

        ["Py fill string pep 257 nn" ar-fill-string-pep-257-nn
         :help " ‘ar-fill-string-pep-257-nn’"]

        ["Py fill string symmetric" ar-fill-string-symmetric
         :help " ‘ar-fill-string-symmetric’"])
       ("Abbrevs"          :help "see also ‘ar-add-abbrev’"
        :filter (lambda (&rest junk)
                  (abbrev-table-menu SomeMode-mode-abbrev-table)))

       ["Add abbrev" ar-add-abbrev
        :help " ‘ar-add-abbrev’
Defines ar-mode specific abbrev for last expressions before point."]
       ("Completion"
        ["Py indent or complete" ar-indent-or-complete
         :help " ‘ar-indent-or-complete’"]

        ["Py shell complete" ar-shell-complete
         :help " ‘ar-shell-complete’"]

        ["Py complete" ar-complete
         :help " ‘ar-complete’"])

       ["Find function" ar-find-function
        :help " ‘ar-find-function’
Find source of definition of SYMBOL."])))
  map)

(provide 'ar-menu)
;;; ar-menu.el ends here
