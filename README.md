# mdx.nvim

Good enough syntax highlight for MDX in Neovim using Treesitter.

Highlight support for mdx based in [the post] written by [Phelipe Teles].

## Installation

#### With [lazy.nvim]

```lua
{
  "davidmh/mdx.nvim",
  dependencies = {"nvim-treesitter/nvim-treesitter"}
}
```

## Testing

To test the plugin with a minimal configuration:

```bash
# Run the setup script to install plugins and parsers
./setup-minimal-config

# Open the test file
nvim -u minimal-init.lua test.mdx
```

This will:
1. Install lazy.nvim, nvim-treesitter and mdx.nvim
2. Install treesitter parsers for markdown, tsx, and typescript

The test file `test.mdx` contains example MDX code to verify syntax highlighting works correctly.

#### With [vim-plug]

```vim
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'davidmh/mdx.nvim'
```

#### With [NvChad]

From the NvChad [docs]:

> All NvChad default plugins will have `lazy = true` set. Therefore, if you want
> a plugin to be enabled on startup, change it to `lazy = false`.

Since this plugin only defines a filetype it's safe to let it run on startup.
So setting `lazy = false` is enough.

But if you absolutely need to loaded only when needed, you can use `event = "BufEnter *.mdx"`

[the post]: https://phelipetls.github.io/posts/mdx-syntax-highlight-treesitter-nvim/
[Phelipe Teles]: https://github.com/phelipetls
[lazy.nvim]: https://github.com/folke/lazy.nvim
[vim-plug]: https://github.com/junegunn/vim-plug
[NvChad]: https://github.com/NvChad/NvChad
[docs]: https://nvchad.com/docs/config/plugins
