require "nvchad.mappings"
-- add yours here
local cmp = require "cmp"
local map = vim.keymap.set

local live_grep_args_shortcuts = require "telescope-live-grep-args.shortcuts"
--
-- Map leader o to insert a line below without leaving normal mode
map("n", "zj", "o<Esc>", { noremap = true, silent = true })

-- Map leader O to insert a line above without leaving normal mode
map("n", "zk", "O<Esc>", { noremap = true, silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map(
  "n",
  "<leader>fw",
  ":lua require('telescope.builtin').live_grep({ additional_args = { '--fixed-strings' }})<CR>",
  {}
)
map("n", "<leader>fk", live_grep_args_shortcuts.grep_word_under_cursor)
map("v", "<leader>fk", live_grep_args_shortcuts.grep_visual_selection)
map("i", "<C-n>", cmp.mapping.complete())
