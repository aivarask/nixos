;; extends

(
    (call_expression
        (identifier) @_ident (#eq? @_ident "createTemplate")
        (argument_list
            (string_literal) @twig
        )
    (#offset! @twig 0 1 0 -1)
    )
)
