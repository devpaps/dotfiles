return {
	"folke/snacks.nvim",
	event = "VeryLazy",
	opts = {
		scratch = {
			win = {
				keys = {
					["delete"] = {
						"<a-x>",
						function(self)
							vim.api.nvim_win_call(self.win, function()
								vim.cmd([[close]])
								os.remove(vim.api.nvim_buf_get_name(self.buf))
							end)
						end,
						desc = "Delete buffer",
						mode = { "n", "x" },
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
	},
}
