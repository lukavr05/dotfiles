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
      enabled = true,
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
  "RileyGabrielson/inspire.nvim",
  config = function()
    require("inspire").setup({})
  end,
},

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require "configs.snacks"
    end,
  }
}
