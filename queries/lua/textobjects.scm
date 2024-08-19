; extends

(field) @swap.outer
(variable_declaration) @swap.outer
(function_call) @swap.outer
(comment) @swap.outer

; treesitter-directive-offset!
((table_constructor) @list.inner (#offset! @list.inner 1 0 -1 0))
