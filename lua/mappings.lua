require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local live_grep_args_shortcuts = require "telescope-live-grep-args.shortcuts"

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
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
