-- local cmp = require "cmp"

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  --
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        "eslint-lsp",
      },
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- load cmp on InsertEnter
  --   event = "InsertEnter",
  --   -- these dependencies will only be loaded when cmp loads
  --   -- dependencies are always lazy-loaded unless specified otherwise
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --   },
  --   config = function()
  --     print(cmp)
  --     -- ...
  --     -- conf.defaults.mappings.i = {
  --     --   -- ["<C-j>"] = require("telescope.actions").move_selection_next,
  --     --   -- ["<Esc>"] = require("telescope.actions").close,
  --     -- }
  --   end,
  -- },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = false,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      -- 支持jsx, tsx, vue
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    opts = function()
      local conf = require "nvchad.configs.telescope"
      conf.defaults.mappings.i = {
        -- ["<C-j>"] = require("telescope.actions").move_selection_next,
        -- ["<Esc>"] = require("telescope.actions").close,
      }
      -- or
      -- conf.vimgrep_arguments = { "--fixed-strings" }

      return conf
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, -- your configuration
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "javascript",
        "typescript",
        "css",
        "tsx",
      },
    },
  },
}
