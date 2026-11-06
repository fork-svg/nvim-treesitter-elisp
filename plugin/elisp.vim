" nvim-treesitter-elisp: Add Tree-sitter support for Emacs Lisp
" Maintainer: fork-svg
" License: MIT

if exists('g:loaded_treesitter_elisp')
  finish
endif
let g:loaded_treesitter_elisp = 1

if !has('nvim-0.9.0')
  echohl ErrorMsg
  echomsg 'nvim-treesitter-elisp requires Neovim 0.9.0+'
  echohl None
  finish
endif

" Auto-setup on plugin load
lua require('treesitter-elisp').setup()
