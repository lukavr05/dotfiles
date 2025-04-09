local palette = {
  light_blue = "#7d92a2",
  warm_orange = "#c2953e",
  warm_white = "#c4b68f",
  light_red = "#c65f5f",
}

local options = {
    base46 = {
        theme = "chocolate", -- default theme
        hl_add = {
          SnacksDashboardNormal = { fg = palette.warm_white },
          SnacksDashboardDesc = { fg = palette.light_blue },
          SnacksDashboardHeader = { fg = palette.warm_orange, bold = true },
          SnacksDashboardTitle = { link = "SnacksDashboardHeader" },
          SnacksDashboardFooter = { italic = true },
          SnacksDashboardIcon = { link = "SnacksDashboardHeader" },
          SnacksDashboardDir = { fg = palette.light_blue, italic = true },
          SnacksDashboardFile = { fg = palette.warm_white, bold = true },
          SnacksDashboardSpecial = { link = "SnacksDashboardIcon" },
          SnacksDashboardKey = { fg = palette.light_red },
        },

        hl_override = {

          -- EDITOR
          Comment = { italic = true },
          ["@comment"] = { link = "Comment" },

          Keyword = { fg = "#c2953e" },
          ["@keyword"] = { link = "Keyword" },
          ["@keyword.repeat"] = { link = "Keyword" },
          ["@keyword.conditional"] = { fg = "#d08b65" },
          ["@keyword.conditional.ternary"] = { fg = "#d08b65" },

          Character = { link = "Keyword" },
          ["@character"] = { link = "Character" },

          Constant = { link = "Keyword" },
          ["@constant"] = { link = "Constant" },

          Identifier = { fg = "#d6ba95" },
          ["@identifier"] = { link = "Identifier" },

          Property = { fg = "#c2b288"  },
          ["@property"] = { link = "Property" },

          Boolean = { bold = true },
          ["@boolean"] = { link = "Boolean" },

          Function = { bold = true },
          ["@function"] = { link = "Function" },
          ["@function.method.call"] = { italic = true },

          -- UI
          TelescopeBorder = { fg = "#a98b6f" }, -- Warm borders
          TelescopePromptPrefix = { fg = "#c68b59" }, -- Prompt icon color

          NvimTreeFolderName = { fg = "#c19a6b" }, -- Warm folder color
          NvimTreeOpenedFolderName = { fg = "#d8b67e", bold = true }, -- Highlighted open folder
          StatusLine = { bg = "#2c211a", fg = "#d6ba95" }, -- Status line with warmer colors
          TabLine = { bg = "#2c211a", fg = "#a98b6f" }, -- Tab line with warmer colors
          TabLineSel = { bg = "#4a3527", fg = "#e6d2b5", bold = true }, -- Selected tab

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
          theme = "default", -- default/vscode/vscode_colored/minimal
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
