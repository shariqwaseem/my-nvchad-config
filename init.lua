vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

-- In your Neovim configuration (e.g., ~/.config/nvim/lua/custom/init.lua)

-- Function to run telescope live_grep with dynamic search directories
local function search_folder(args)
  local search_dirs = {}
  for dir in string.gmatch(args.args, "%S+") do
    table.insert(search_dirs, dir)
  end

  require("telescope.builtin").live_grep {
    search_dirs = search_dirs,
    additional_args = function()
      return { "--fixed-strings" }
    end,
  }
end

-- Create a user command 'SearchFolder' that takes arguments
vim.api.nvim_create_user_command("SearchFolder", search_folder, { nargs = 1 })

vim.schedule(function()
  require "mappings"
end)
