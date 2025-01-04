local M = {}

function M.setup()
    -- Register the mdx filetype
    vim.filetype.add({ extension = { mdx = "mdx" } })

    -- Configure treesitter to use the markdown parser for mdx files
    vim.treesitter.language.register("markdown", "mdx")

    -- If the current buffer has the extension mdx, but not the newly create filetype, set it
    if vim.endswith(vim.api.nvim_buf_get_name(0), ".mdx") and vim.o.filetype ~= "mdx" then
        vim.o.filetype = "mdx"
    end
end

return M
