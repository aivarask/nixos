; extends

(field) @swap.outer
(variable_declaration) @swap.outer
(function_call) @swap.outer
(comment) @swap.outer

; ((table_constructor) @table.inner (#offset! @table.inner 1 1 0 -1))

(table_constructor) @block.inner
