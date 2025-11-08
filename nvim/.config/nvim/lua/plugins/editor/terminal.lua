return {
	{
		"akinsho/nvim-toggleterm.lua",
		event = "VeryLazy",
		version = "*",
		config = true,
		cmd = "ToggleTerm",
		build = ":ToggleTerm",
		opts = {
			open_mapping = [[<F12>]],
			-- directory = "getcwd()<CR>",
			direction = "float",
			auto_scroll = true,
			hide_numbers = true,
			insert_mappings = true,
			terminal_mappings = true,
			start_in_insert = true,
			close_on_exit = true,
			shell = "zsh",

			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.8
				end
			end,
		},
	},
}
