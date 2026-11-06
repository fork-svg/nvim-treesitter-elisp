local M = {}

M.config = {
  url = "https://github.com/Wilfred/tree-sitter-elisp",
  branch = "main",
  revision = nil,
}

local function get_parser_dir()
  local data = vim.fn.stdpath("data")
  return data .. "/treesitter"
end

local function get_parser_path()
  return get_parser_dir() .. "/elisp.so"
end

local function get_src_dir()
  local cache = vim.fn.stdpath("cache")
  return cache .. "/treesitter-elisp"
end

function M.get_parser_path()
  return get_parser_path()
end

function M.is_installed()
  return vim.loop.fs_stat(get_parser_path()) ~= nil
end

local function setup_filetypes()
  vim.treesitter.language.register("elisp", "elisp")
  vim.treesitter.language.register("elisp", "emacs")
  vim.treesitter.language.register("elisp", "fennel")
end

function M.install(opts)
  opts = opts or {}
  local on_exit = opts.on_exit

  local src_dir = get_src_dir()
  local parser_path = get_parser_path()
  local parser_dir = get_parser_dir()

  vim.fn.mkdir(parser_dir, "p")
  vim.fn.mkdir(src_dir, "p")

  local url = M.config.url
  if M.config.revision then
    url = url .. ".git"
  end

  local commands = {
    { "git", "clone", "--depth", "1", url, src_dir },
    { "gcc", "-shared", "-fPIC", "-O2",
      "-I" .. src_dir .. "/src",
      src_dir .. "/src/parser.c",
      "-o", parser_path },
  }

  if M.config.revision then
    table.insert(commands, 2, { "git", "-C", src_dir, "fetch", "--depth", "1", "origin", M.config.revision })
    table.insert(commands, 3, { "git", "-C", src_dir, "checkout", "FETCH_HEAD" })
  end

  local function run_command(idx)
    if idx > #commands then
      vim.schedule(function()
        vim.notify("treesitter-elisp: parser installed at " .. parser_path, vim.log.levels.INFO)
        setup_filetypes()
        if on_exit then on_exit(true) end
      end)
      return
    end

    local cmd = commands[idx]
    local is_clone = cmd[1] == "git" and cmd[2] == "clone"

    if is_clone and vim.loop.fs_stat(src_dir .. "/.git") ~= nil then
      vim.schedule(function()
        vim.notify("treesitter-elisp: updating source...", vim.log.levels.INFO)
      end)
      vim.fn.delete(src_dir, "rf")
    end

    vim.fn.jobstart(cmd, {
      cwd = src_dir,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.schedule(function()
            vim.notify("treesitter-elisp: command failed: " .. table.concat(cmd, " "), vim.log.levels.ERROR)
            if on_exit then on_exit(false) end
          end)
          return
        end
        vim.schedule(function()
          run_command(idx + 1)
        end)
      end,
    })
  end

  vim.schedule(function()
    vim.notify("treesitter-elisp: installing parser...", vim.log.levels.INFO)
  end)
  run_command(1)
end

function M.uninstall()
  local parser_path = get_parser_path()
  local src_dir = get_src_dir()

  if vim.loop.fs_stat(parser_path) then
    vim.loop.fs_unlink(parser_path)
  end
  if vim.loop.fs_stat(src_dir) then
    vim.fn.delete(src_dir, "rf")
  end
  vim.notify("treesitter-elisp: parser removed", vim.log.levels.INFO)
end

function M.setup(opts)
  opts = opts or {}
  if opts.url then M.config.url = opts.url end
  if opts.revision then M.config.revision = opts.revision end

  setup_filetypes()

  if opts.auto_install then
    vim.api.nvim_create_autocmd({"FileType"}, {
      pattern = {"elisp", "emacs", "fennel"},
      callback = function()
        if not M.is_installed() then
          M.install()
        end
      end,
      once = true,
    })
  end
end

return M
