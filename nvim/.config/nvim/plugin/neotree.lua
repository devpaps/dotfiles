require("neo-tree").setup({
	sources = { "filesystem", "buffers", "git_status", "document_symbols" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
	enable_diagnostics = true,

	update_focused_file = {
		enable = true,
		update_root = {
			enable = true,
			ignore_list = {},
		},
	},

	filesystem = {
		bind_to_cwd = true,
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_by_pattern = {
				"node_modules",
				"vendor",
				".git",
				"storage",
				"bootstrap/cache",
				"*.min.js",
				"*.min.css",
				"dist",
				"build",
				".idea",
				".vscode",
			},
		},
	},

	hide_root_node = true,
	retain_hidden_root_indent = false,
	enable_git_status = true,
	enable_modified_markers = false,

	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
})
