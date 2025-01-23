return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
    lazy = true,
    enabled = true,
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "c", "python", "java", "go"
  		},

      highlight = {
        enable = true,
        use_languagetree = true,
      },

      indent = { enable = true },
  	},
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require "configs.telescope"
    end,
  },

  -- oil: nvim's best text-based file explorer
  {
      "stevearc/oil.nvim",
      enabled = false,
      depends = "nvim-tree/nvim-web-devicons",
      config = function()
          require "configs.oil"
      end,
      lazy = false,
  },

  -- noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require "configs.noice"
    end,
    lazy = false,
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    config = function()
      require "configs.mason"
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      animate = { enabled = true },
      bigfile = { enabled = true },
      dashboard = {
        preset = {
          keys = {
            { icon = "   ", key = "-", desc = "File Browser", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "   ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = "   ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "   ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "   ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰒲   ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = "󰚥   ", key = "M", desc = "Mason", action = ":Mason" },
            { icon = "󰩈   ", key = "q", desc = "Quit", action = ":qa" },
          },

          header = [[
                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      indent = { enabled = true },
      debug = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      win = { enabled = true },
      terminal = { enabled = true },
      dim = { enabled = true }
    },
  }
}
