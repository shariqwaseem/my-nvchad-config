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

-- this line causes ; to initiate command mode. but i dont want that since ; is used to repeat old commands :-)
-- map("n", ";", ":", { desc = "CMD enter command mode" })
--

map(
  "n",
  "<leader>fe",
  '<cmd>lua require("telescope.builtin").find_files({ find_command = { "rg", "--files", "--glob", "*.env" }, hidden = true, no_ignore = true })<CR>',
  { noremap = true, silent = true }
)

map(
  "n",
  "<leader>fx",
  '<cmd>lua require("telescope.builtin").live_grep({ search_dirs = {"."}, additional_args = function(opts) return {"--glob", "**/.env", "--hidden", "--no-ignore"} end })<CR>',
  { noremap = true, silent = true }
)
map("i", "jj", "<ESC>")
map("n", "<leader>fr", ":lua require('telescope.builtin').resume()<CR>", {})
map("n", "<leader>fk", live_grep_args_shortcuts.grep_word_under_cursor)
map("v", "<leader>fk", live_grep_args_shortcuts.grep_visual_selection)
map("i", "<C-n>", cmp.mapping.complete())

vim.g.neovide_input_use_logo = 1

map("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
map("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
map("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
map("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

map("n", "<C-t>", "<C-i>", { noremap = true, silent = true })

-- Gitsigns Keybindings
local gitsigns = require "gitsigns"

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.next_hunk()
  end
end, { noremap = true, silent = true, desc = "Next Git Hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.prev_hunk()
  end
end, { noremap = true, silent = true, desc = "Previous Git Hunk" })

map("n", "<leader>gb", function()
  gitsigns.blame_line { full = false }
end, { noremap = true, silent = true, desc = "Blame Line" })
map("n", "<leader>gd", gitsigns.diffthis, { noremap = true, silent = true, desc = "Diff This" })
map("n", "<leader>gD", function()
  gitsigns.diffthis "~"
end, { noremap = true, silent = true, desc = "Diff Against Previous Commit" })
