local M = {}

function M.root(root)
    local f = debug.getinfo(1, "S").source:sub(2)
    return vim.fn.fnamemodify(f, ":p:h") .. "/" .. (root or "")
end

function M.setup()
    vim.loader.enable()
    vim.cmd([[set runtimepath=$VIMRUNTIME]])
    vim.opt.runtimepath:append(M.root())
    vim.opt.packpath = { M.root(".local/site") }
    vim.env.XDG_CONFIG_HOME = M.root(".local/config")
    vim.env.XDG_DATA_HOME = M.root(".local/data")
    vim.env.XDG_STATE_HOME = M.root(".local/state")
    vim.env.XDG_CACHE_HOME = M.root(".local/cache")
    local lazypath = vim.env.XDG_DATA_HOME .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    local version = vim.version()
    if version.major >= 0 and version.minor >= 12 then
        vim.cmd.colorscheme("catppuccin")
    end

    require("lazy").setup({
        spec = {
            {
                "nvim-treesitter/nvim-treesitter",
                opts = { build = ":TSUpdate" },
                config = function()
                    local treesitter = require("nvim-treesitter")

                    -- NOTE:
                    -- The only reason I'm using the :wait() call here is to
                    -- allow the script ./setup-minimal-config to wait for the
                    -- parsers to be installed before exiting the headless
                    -- instance.
                    -- You don't need to use the :wait() call in your config.
                    treesitter.install({ "markdown", "tsx", "typescript" }):wait()
                end,
            },
            {
                "davidmh/mdx.nvim",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter",
                },
            },
        },
    })
end

vim.o.swapfile = false
_G.__TEST = true

M.setup()
