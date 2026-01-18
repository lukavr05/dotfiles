-- Enhanced clipboard mappings

-- Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Copy current line to system clipboard" })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard above" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Cut to system clipboard
vim.keymap.set("v", "<leader>d", '"+d', { desc = "Cut to system clipboard" })
vim.keymap.set("n", "<leader>d", '"+dd', { desc = "Cut line to system clipboard" })

-- OSC52 for remote/Tmux sessions (check if plugin is available)
local ok, osc52 = pcall(require, "osc52")
if ok then
  vim.keymap.set("v", "<C-c>", osc52.copy_visual, { desc = "Copy via OSC52" })
  vim.keymap.set("n", "<C-c>", osc52.copy_operator, { expr = true, desc = "Copy via OSC52" })
end

-- Fix system paste issues
vim.keymap.set("i", "<C-v>", '<C-r><C-r>+', { desc = "Paste from system clipboard in insert mode" })

-- Quick access to clipboard content
vim.keymap.set("n", "<leader>cp", ':put +<CR>', { desc = "Put clipboard content" })
vim.keymap.set("n", "<leader>cs", ':let @+ = @"<CR>', { desc = "Copy vim register to system clipboard" })
vim.keymap.set("n", "<leader>cr", ':let @" = @+<CR>', { desc = "Copy system clipboard to vim register" })