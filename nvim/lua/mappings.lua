require "nvchad.mappings"

-- add yours here
require "mappings.clipboard"

vim.keymap.set("n","-", function()
  require("telescope").extensions.file_browser.file_browser()
  end,
  {desc = "Toggle Telescop File Browser"}
)

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Quick save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j") 
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Oil file explorer
map("n", "<leader>e", "<cmd> Oil <cr>", { desc = "Open file explorer" })

-- Clear highlights
map("n", "<leader>h", "<cmd> nohlsearch <cr>", { desc = "Clear highlights" })

-- Buffer navigation
map("n", "<Tab>", "<cmd> bnext <cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd> bprevious <cr>", { desc = "Previous buffer" })
