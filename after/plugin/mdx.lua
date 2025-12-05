-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Configure treesitter to use the markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")
