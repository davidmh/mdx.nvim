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

  local install_available, install = pcall(require, "nvim-treesitter.install")
  if install_available then
    -- The legacy branch (master) in nvim-treesitter provides the installer through a
    -- dedicated module
    install.ensure_installed { "mdx" }
  else
    -- The default branch (main) exposes an install method from the default module
    local ok, new_api = pcall(require, 'nvim-treesitter')
    if ok then
      new_api.install { "mdx" }
    end
  end
else
  vim.cmd.echom "mdx.nvim depends on nvim-treesitter.vim"
end
