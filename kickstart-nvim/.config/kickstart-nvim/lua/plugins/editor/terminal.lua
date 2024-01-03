return {
	{
		"akinsho/nvim-toggleterm.lua",
		lazy = true,
		version = "*",
		config = true,
		cmd = "ToggleTerm",
		build = ":ToggleTerm",
		keys = { { "<F12>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" } },
		opts = {
			open_mapping = [[<F12>]],
			direction = "vertical",
			auto_scroll = true,
			hide_numbers = true,
			insert_mappings = true,
			terminal_mappings = true,
			start_in_insert = true,
			close_on_exit = true,

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
