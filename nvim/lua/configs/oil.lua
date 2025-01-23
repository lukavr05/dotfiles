require("oil").setup({
	default_file_explorer = true,
	columns = {
		"icon",
		-- "permissions",
		-- "size",
		-- "mtime",
	},

	-- Buffer-local options to use for oil buffers
	buf_options = {
		buflisted = true,
		bufhidden = "hide",
	},

	-- Window-local options to use for oil buffers
  win_options = {
    wrap = true,
  },
	-- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
	delete_to_trash = true,
	-- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
	skip_confirm_for_simple_edits = true,
	-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
	-- (:help prompt_save_on_select_new_entry)
	prompt_save_on_select_new_entry = true,
	-- Oil will automatically delete hidden buffers after this delay
	-- You can set the delay to false to disable cleanup entirely
	-- Note that the cleanup process only starts when none of the oil buffers are currently displayed
	cleanup_delay_ms = 2000,
	lsp_file_methods = {
		-- Time to wait for LSP file operations to complete before skipping
		timeout_ms = 1000,
	},
	-- Constrain the cursor to the editable parts of the oil buffer
	-- Set to `false` to disable, or "name" to keep it on the file names
	constrain_cursor = "editable",
	-- Set to true to watch the filesystem for changes and reload oil
	watch_for_changes = false,
	-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
	-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
	-- Additionally, if it is a string that matches "actions.<name>",
	-- it will use the mapping at require("oil.actions").<name>
	-- Set to `false` to remove a keymap
	-- See :help oil-actions for a list of all available actions
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "open in vertical split" },
		["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "open in horizontal split" },
		["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "open in new tab" },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["<leader>x"] = "actions.close",
		["<C-l>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	-- Set to false to disable all of the above keymaps
	use_default_keymaps = true,
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true,
		natural_order = true,
		-- Sort file and directory names case insensitive
		case_insensitive = false,
		sort = {
			{ "type", "asc" },
			{ "name", "asc" },
		},
	},
	-- Configuration for the floating window in oil.open_float
	float = {
		-- Padding around the floating window
		padding = 0,
		max_width = 80,
		max_height = 0,
		border = "rounded",
		win_options = {
			winblend = 5,
		},
		-- preview_split: Split direction: "auto", "left", "right", "above", "below".
		preview_split = "right",
		-- This is the config that will be passed to nvim_open_win.
		-- Change values here to customize the layout
		override = function(conf)
			return conf
		end,
	},
	-- Configuration for the actions floating preview window
	preview = {
    enabled = true,
		-- min_width and max_width can be a single value or a list of mixed integer/float type
		-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
		-- optionally define an integer/float for the exact width of the preview window
		width = 0.7,
		-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_height and max_height can be a single value or a list of mixed integer/float types.
		-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		-- Whether the preview window is automatically updated when the cursor is moved
		update_on_cursor_moved = true,
	},
	-- Configuration for the floating progress window
	progress = {
		max_width = 0.9,
		min_width = { 40, 0.4 },
		width = nil,
		max_height = { 10, 0.9 },
		min_height = { 5, 0.1 },
		height = nil,
		border = "rounded",
		minimized_border = "none",
		win_options = {
			winblend = 0,
		},
	},
	-- Configuration for the floating SSH window
	ssh = {
		border = "rounded",
	},
	-- Configuration for the floating keymaps help window
	keymaps_help = {
		border = "rounded",
	},
})
