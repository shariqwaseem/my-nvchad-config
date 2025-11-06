local M = {}

local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "FloatBorder",
  "SignColumn",
  "EndOfBuffer",
  "FoldColumn",
  -- Cursor line and column
  "CursorLine",
  "CursorColumn",
  "CursorLineNr",
  -- Common plugin windows
  "NeoTreeNormal",
  "NeoTreeNormalNC",
  "NeoTreeEndOfBuffer",
  "NeoTreeWinSeparator",
  "NeoTreeCursorLine",
  "TelescopeNormal",
  "TelescopeBorder",
  -- nvim-tree (file explorer)
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NvimTreeEndOfBuffer",
  "NvimTreeSignColumn",
  "NvimTreeWinSeparator",
  "NvimTreeCursorLine",
  -- Generic separators
  "WinSeparator",
}

local function set_transparent()
  for _, name in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, name, { bg = "NONE", ctermbg = "NONE" })
  end
end

function M.enable()
  -- Apply immediately
  set_transparent()

  -- Re-apply whenever colorscheme changes
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("TransparentBG", { clear = true }),
    callback = set_transparent,
  })

  -- Re-apply after specific UI/filetype windows initialize (they may set hl late)
  vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
    group = vim.api.nvim_create_augroup("TransparentBGWindows", { clear = true }),
    pattern = {
      "NvimTree",
      "neo-tree",
      "TelescopePrompt",
      "TelescopeResults",
    },
    callback = set_transparent,
  })
end

return M
