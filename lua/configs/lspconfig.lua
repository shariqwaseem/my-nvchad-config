-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Completely disable LSP-driven inline color previews
if capabilities.textDocument then
  capabilities.textDocument.colorProvider = nil
end
vim.lsp.handlers["textDocument/documentColor"] = function() end

local util = require "lspconfig.util"

local function with_defaults(opts)
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }, opts or {})
end

local function setup(server, opts)
  vim.lsp.config(server, with_defaults(opts))
  vim.lsp.enable(server)
end

local servers = { "html", "cssls", "ts_ls", "eslint" }

for _, server in ipairs(servers) do
  setup(server)
end

-- tailwindcss with DaisyUI support
setup("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }
        },
      },
      includeLanguages = {
        typescript = "javascript",
        typescriptreact = "javascript",
      },
      classAttributes = {
        "class",
        "className",
        "classList",
        "ngClass",
      },
    },
  },
  root_dir = util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.ts",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "postcss.config.js",
    "postcss.config.ts",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "package.json"
  ),
})

-- go
setup("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
        shadow = true,
      },
    },
  },
})
