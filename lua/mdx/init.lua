local M = {}

function M.setup()
    -- Register the mdx filetype
    vim.filetype.add({ extension = { mdx = "mdx" } })

    -- Configure treesitter to use the markdown parser for mdx files
    require("nvim-treesitter.parsers").filetype_to_parsername.mdx = "markdown"
end

return M
