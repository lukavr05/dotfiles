require("snacks").setup({
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
        },
        formats = {
          key = function(item)
            return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
          end,
        },
        sections = {
          { section = "header" },
          { section = "terminal", cmd = "fortune -s", align = "center", padding = 1, gap = 1, height = 7 },
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
})
