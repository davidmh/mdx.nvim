-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Configure treesitter to use the markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")

local ok, parsers = pcall(require, "nvim-treesitter.parsers")

if ok then
  local parser_configs = parsers.get_parser_configs()

  parser_configs.mdx = {
    install_info = {
      url = "https://github.com/srazzak/tree-sitter-mdx",
      files = {"src/parser.c", "src/scanner.c"},
      branch = "main"
    },
    filetype = "mdx"
  }
else
  vim.cmd.echom "mdx.nvim depends on nvim-treesitter.vim"
end
