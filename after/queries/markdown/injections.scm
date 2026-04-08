; extends

((inline) @injection.content
  (#lua-match? @injection.content "^%s*import")
  (#set! injection.language "typescript"))

((inline) @injection.content
  (#lua-match? @injection.content "^%s*export")
  (#set! injection.language "typescript"))

((inline) @injection.content
  (#lua-match? @injection.content "^<")
  (#set! injection.language "typescriptreact"))

; Multi-line JSX component bodies: when a component spans multiple lines,
; markdown parses the indented body as an indented_code_block. Inject TSX
; so it gets proper syntax highlighting.
((indented_code_block) @injection.content
  (#set! injection.language "typescriptreact")
  (#set! injection.include-children))
