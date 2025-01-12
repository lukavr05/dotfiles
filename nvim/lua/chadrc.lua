local options = {
    base46 = {
        theme = "bearded-arc", -- default theme
        hl_add = {
          NvDashFooter = { fg = "#486fa3"},
          SnacksDashboardNormal = { fg = "#466185" },
          SnacksDashboardHeader = { link = "SnacksDashboardTitle" },
          SnacksDashboardTitle = { bold = true, fg = "#275aab" },
          SnacksDashboardFooter = { italic = true },
          SnacksDashboardDesc = { italic = true },
          SnacksDashboardIcon = { fg = "#275aab" },
          SnacksDashboardDir = { italic = true },
          SnacksDashboardFile = { fg = "#35aef0", bold = true }
        },
        hl_override = {},
        integrations = {},
        changed_themes = {},
        transparency = false,
        theme_toggle = {},
    },

    ui = {
      cmp = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      },

      telescope = { style = "borderless" }, -- borderless / bordered

      statusline = {
          enabled = true,
          theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
          -- default/round/block/arrow separators work only for default statusline theme
          -- round and block will work for minimal theme only
          separator_style = "arrow",
          order = nil,
          modules = nil,
      },

      -- lazyload it when there are 1+ buffers
      tabufline = {
          enabled = true,
          lazyload = true,
          order = { "treeOffset", "buffers", "tabs", "btns" },
          modules = nil,
      },
  },

  term = {
      winopts = { number = false, relativenumber = true },
      sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
      float = {
          relative = "editor",
          row = 0.3,
          col = 0.25,
          width = 0.5,
          height = 0.4,
          border = "single",
      },
  },

  lsp = { signature = true },

   cheatsheet = {
      theme = "grid", -- simple/grid
      excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { pkgs = {}, skip = {} },

  colorify = {
      enabled = false,
      mode = "virtual", -- fg, bg, virtual
      virt_text = "󱓻 ",
      highlight = { hex = true, lspvars = false },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
