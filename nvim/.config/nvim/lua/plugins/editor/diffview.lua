return {
	"sindrets/diffview.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	event = "VeryLazy",
	config = function()
		require("diffview").setup({
			view = {
				default = {
					layout = "diff2_vertical",
				},
				merge_tool = {
					layout = "diff4_mixed",
					disable_diagnostics = true,
				},
			},
		})
	end,
	keys = {
		{ "<leader>gd", ":DiffviewOpen<CR>", desc = "diffviewopen" },
		{ "<leader>gc", ":DiffviewClose<CR>", desc = "diffviewclose" },
	},
}
