local action_layout = require("telescope.actions.layout")
local actions = require("telescope.actions")

require("telescope").setup {
  defaults = {
    theme = "dropdown",
    mappings = {
      n = {
        ["<M-p>"] = action_layout.toggle_preview
      },
      i = {
        ["<C-p>"] = action_layout.toggle_preview,
        ["<esc>"] = actions.close,
      },
    },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.6,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "- ",
    entry_prefix = "  ",
    winblend = 5,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    scroll_strategy = "cycle",
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  },
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
