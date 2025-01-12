require "nvchad.mappings"

-- add yours here

vim.keymap.set("n","-", function()
  require("telescope").extensions.file_browser.file_browser()
  end,
  {desc = "Toggle Oil floating window"}
)

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- open file_browser with the path of the current buffer
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
