local options = {
    base46 = {
        theme = "chocolate", -- default theme
        hl_add = {
          SnacksDashboardNormal = { fg = "#c4b68f" },
          SnacksDashboardDesc = {},
          SnacksDashboardHeader = { link = "SnacksDashboardTitle" },
          SnacksDashboardTitle = { fg = "#78acb0", bold = true },
          SnacksDashboardFooter = { italic = true },
          SnacksDashboardIcon = { fg = "#568e94" },
          SnacksDashboardDir = { italic = true },
          SnacksDashboardFile = { bold = true },
          SnacksDashboardSpecial = { link = "SnacksDashboardIcon" },
          SnacksDashboardKey = { link = "SnacksDashboardNormal" },
        },

        hl_override = {
          ["@comment"] = { italic = true },

          Keyword = { fg = "#c2953e" },
          ["@keyword"] = { link = "Keyword" },
          ["@keyword.repeat"] = { link = "Keyword" },
          ["@keyword.conditional"] = { fg = "#d08b65" },
          ["@keyword.conditional.ternary"] = { fg = "#d08b65" },

          Character = { link = "Keyword" },
          ["@character"] = { link = "Character" },

          Constant = { link = "Keyword" },
          ["@constant"] = { link = "Constant" },

          Property = { fg = "#c2b288"  },
          ["@property"] = { link = "Property" },

          Boolean = { bold = true },
          ["@boolean"] = { link = "Boolean" },


          ["@function"] = { bold = true },
          ["@function.method.call"] = { italic = true },
      },

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
      enabled = true,
      mode = "virtual", -- fg, bg, virtual
      virt_text = "󱓻 ",
      highlight = { hex = true, lspvars = false },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
