; extends

; JSX element textobjects for tag selection (at/it)
(jsx_element) @tag.outer

; Inner content - match jsx_text directly
(jsx_element
  (jsx_text) @tag.inner)

; Inner content - match nested elements
(jsx_element
  (jsx_element) @tag.inner)

; Self-closing JSX elements (no inner content)
(jsx_self_closing_element) @tag.outer
