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
        "html", "css", "c", "python", "java", "go",
        "javascript", "typescript", "json", "yaml", "markdown", "bash"
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
event = "VeryLazy",
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
event = "VeryLazy",
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
    event = "VeryLazy",
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
    end
  },

  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })
          
          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Prev hunk" })
          
          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function() gs.stage_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function() gs.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function() gs.blame_line({full=true}) end, { desc = "Blame line" })
          map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
          map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle deleted" })
          
          -- Text object
          map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      })
    end,
  }
}
