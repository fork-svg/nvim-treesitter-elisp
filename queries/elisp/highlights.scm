; highlights.scm - Syntax highlighting for Emacs Lisp

; Comments
(comment) @comment

; Strings
(string) @string
(string_text_properties) @string

; Numbers
(integer) @number
(float) @number
(char) @character

; Special forms
(special_form
  name: (symbol) @keyword)

; Function definitions
(function_definition
  name: (symbol) @function)

; Macro definitions
(macro_definition
  name: (symbol) @function.macro)

; Function quotes
(function_quote
  (symbol) @function)

; Symbols
(symbol) @variable
((symbol) @constant.builtin
  (#any-of? @constant.builtin "nil" "t"))
((symbol) @keyword
  (#any-of? @keyword
    "let" "let*" "if" "when" "unless" "cond" "case"
    "progn" "prog1" "prog2" "save-excursion" "save-restriction"
    "save-current-buffer" "unwind-protect" "condition-case"
    "catch" "throw" "while" "dolist" "dotimes" "cl-loop"
    "cl-let" "cl-let*" "cl-flet" "cl-labels" "cl-macrolet"
    "defvar" "defconst" "defcustom" "defvar-local"
    "defun" "defmacro" "defsubst" "defalias" "defadvice"
    "defclass" "defmethod" "defgeneric"
    "require" "provide" "declare-function"
    "interactive" "lambda" "function"))

; Quotes
(quote) @operator
(unquote) @operator
(unquote_splice) @operator

; Lists
(list
  fn: (symbol) @function.call)

; Vectors
(vector) @constructor

; Bytecode
(bytecode) @constant.macro
(byte_compiled_file_name) @string.special

; Hash tables
(hash_table) @constructor

; Punctuation
("(") @punctuation.bracket
(")") @punctuation.bracket
("'") @punctuation.special
("`") @punctuation.special
(",") @punctuation.special
(",@") @punctuation.special
("#'") @punctuation.special
(".") @punctuation.delimiter
