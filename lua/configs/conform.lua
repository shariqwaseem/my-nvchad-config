local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" }, -- Add JavaScript formatter
    typescript = { "prettier" },
    json = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    go = { "gofumpt", "goimports" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
