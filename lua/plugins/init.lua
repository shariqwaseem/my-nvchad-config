-- local cmp = require "cmp"

return {
  -- Add nvim-tree configuration to show hidden files
  {
    "nvim-tree/nvim-tree.lua",
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      
      -- Override the filters to show hidden files
      conf.filters.dotfiles = false -- Show dotfiles (hidden files)
      conf.filters.git_ignored = false -- Also show git ignored files if desired
      
      return conf
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or "zbirenbaum/copilot.lua"
      { "nvim-lua/plenary.nvim" },
    },
    -- load at startup rather than lazily
    build = "make tiktoken",

    lazy = false,
    opts = {
      model = "gpt-4.1",
    },
    config = function(_, opts)
      -- 1. Turn off Copilot's default Tab mapping
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- 2. Remap <C-l> in insert mode to accept the suggestion
      vim.api.nvim_set_keymap("i", "<C-a>", [[copilot#Accept("\<CR>")]], { expr = true, silent = true, noremap = true })

      -- 3. Finally, initialise CopilotChat with your opts
      require("CopilotChat").setup(opts)
    end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup()
    end,

    lazy = false,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
        },
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      }
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
        "nvim-lua/plenary.nvim",
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

      conf.defaults.vimgrep_arguments = {
        "rg",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case", -- Enables smart case search
        -- "--ignore-case", -- Enables case insensitive search
        "--fixed-strings", -- Disables regex; treats the search term literally
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
