-- nvim-treesitter-elisp: Register elisp parser with nvim-treesitter
-- Usage in your init.lua:
--   require("treesitter-elisp").setup()
-- Then run :TSInstall elisp

local M = {}

function M.setup()
  -- Register elisp parser via TSUpdate event (nvim-treesitter native way)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
      require('nvim-treesitter.parsers').elisp = {
        install_info = {
          url = "https://github.com/Wilfred/tree-sitter-elisp",
          files = { "src/parser.c" },
          -- tree-sitter-elisp already has pre-generated src/parser.c
          generate = false,
        },
        filetype = { "elisp", "emacs" },
        maintainers = { "@fork-svg" },
      }
    end,
  })
end

return M
