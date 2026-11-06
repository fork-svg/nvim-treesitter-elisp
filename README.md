# nvim-treesitter-elisp

Add Tree-sitter support for Emacs Lisp to Neovim.

## Why this plugin?

nvim-treesitter doesn't include an elisp parser. This plugin registers [tree-sitter-elisp](https://github.com/Wilfred/tree-sitter-elisp) (84⭐, used by Emacs 29+ and Difftastic) with nvim-treesitter.

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "fork-svg/nvim-treesitter-elisp",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "fork-svg/nvim-treesitter-elisp",
  requires = { "nvim-treesitter/nvim-treesitter" },
}
```

### Using vim-plug

```vim
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'fork-svg/nvim-treesitter-elisp'
```

## Usage

After installing the plugin, run:

```vim
:TSInstall elisp
```

That's it! The plugin uses nvim-treesitter's native parser registration mechanism.

## How it Works

The plugin uses `vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate', ... })` to register the elisp parser with nvim-treesitter. This is the official way to add custom parsers.

When you run `:TSInstall elisp`, nvim-treesitter:
1. Clones the tree-sitter-elisp grammar from GitHub
2. Compiles `src/parser.c` to `elisp.so`
3. Loads it when you open `.el` files

The plugin provides:
- **Syntax highlighting** via `queries/elisp/highlights.scm`
- **Indentation** via `queries/elisp/indents.scm`
- **Code folding** via `queries/elisp/folds.scm`
- **Local variable tracking** via `queries/elisp/locals.scm`

## Manual Setup

If you prefer to configure manually:

```lua
require('treesitter-elisp').setup()  -- Called automatically on plugin load
```

## Requirements

- Neovim 0.9+
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- `gcc` or `cc` compiler
- `git`

## License

MIT
