; locals.scm - Local variable tracking for Emacs Lisp

; Function definitions create scope
(function_definition) @local.scope
(macro_definition) @local.scope

; Parameters are definitions
(function_definition
  parameters: (list (symbol) @local.definition))
(macro_definition
  parameters: (list (symbol) @local.definition))

; Let bindings
((list
   fn: (symbol) @_let
   (list (symbol) @local.definition))
  (#any-of? @_let "let" "let*" "cl-let" "cl-let*"))

; References
(symbol) @local.reference
