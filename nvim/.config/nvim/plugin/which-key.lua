local wk = require("which-key")
-- require("which-key").setup()
wk.add({
	{ "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", desc = "Find files", mode = "n" },
	{
		"<leader>b",
		group = "buffers",
		expand = function()
			return require("which-key.extras").expand.buf()
		end,
	},
	{ "<leader>g", group = "file" }, -- group
	{ "<leader>g", "<cmd>lua require('fzf-lua').live_grep()<CR>", desc = "Grep file", mode = "n" },
})
