; extends

; HTML element textobjects for tag selection (at/it)
(element) @tag.outer

; Inner content - match text directly
(element
  (text) @tag.inner)

; Inner content - match nested elements
(element
  (element) @tag.inner)

; Self-closing elements
(self_closing_tag) @tag.outer
