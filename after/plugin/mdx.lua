-- Register the mdx filetype
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Configure treesitter to use the markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "mdx",
    callback = function(args)
        -- Since we're piggybacking on the markdown parser, that's the treesitter
        -- language we should start.
        --
        -- When this plugin was first introduced, my config was using
        -- nvim-treesitter on the master branch, which used to run this bit
        -- automatically, but with the rewrite on the main branch that no longer
        -- happens. We're don't need to gate against the legacy API of
        -- nvim-treesitter because the call to the start function is idempotent.

        vim.treesitter.start(args.buf, "markdown")
    end,
})
