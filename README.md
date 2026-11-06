# nvim-treesitter-elisp

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Neovim](https://img.shields.io/badge/Neovim-0.9+-blueviolet.svg)](https://neovim.io)

Add Tree-sitter support for Emacs Lisp (elisp) to Neovim.

## Why this plugin?

nvim-treesitter doesn't include an elisp parser. This plugin:
- Compiles [tree-sitter-elisp](https://github.com/Wilfred/tree-sitter-elisp) from source
- Provides syntax highlighting, indentation, folding, and local variable tracking
- Works with Neovim 0.9+

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "fork-svg/nvim-treesitter-elisp",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-elisp").setup()
  end,
}
```

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "fork-svg/nvim-treesitter-elisp",
  requires = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesitter-elisp").setup()
  end,
}
```

### Using vim-plug

```vim
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'fork-svg/nvim-treesitter-elisp'
```

Then add to your init.lua:

```lua
require("treesitter-elisp").setup()
```

## Install the Parser

After installing the plugin, run:

```vim
:TSElispInstall
```

This will:
1. Clone the tree-sitter-elisp grammar
2. Compile the parser to `~/.local/share/nvim/treesitter/elisp.so`
3. Register it with Neovim

## Commands

| Command | Description |
|---------|-------------|
| `:TSElispInstall` | Install/compile the elisp parser |
| `:TSElispUninstall` | Remove the elisp parser |

## Configuration

```lua
require("treesitter-elisp").setup({
  -- Custom grammar URL (optional)
  url = "https://github.com/Wilfred/tree-sitter-elisp",

  -- Pin to specific commit (optional)
  revision = nil,

  -- Auto-install when opening elisp file (optional)
  auto_install = false,
})
```

## Requirements

- Neovim 0.9+
- `gcc` or `cc` compiler
- `git`
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## How it Works

1. Plugin registers `elisp` filetype with tree-sitter
2. `:TSElispInstall` compiles `src/parser.c` to `elisp.so`
3. Neovim loads the parser when opening `.el` files
4. Query files provide highlighting, indentation, folding

## License

MIT
