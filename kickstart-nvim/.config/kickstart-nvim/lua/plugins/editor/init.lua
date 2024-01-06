return {
	"kdheepak/lazygit.nvim",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},

	{ "wakatime/vim-wakatime", lazy = true },

	-- A plugin for previewing markdown files using the glow CLI
	{
		"ellisonleao/glow.nvim",
		lazy = true,
		config = true,
		cmd = "Glow",
		opts = {
			width = 180,
			border = "rounded",
			width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
			height_ratio = 0.7,
		},
	},
	{
		-- Make todo comments stand out in code
		"folke/todo-comments.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			vim.keymap.set("n", "<leader>lt", "<cmd>TodoQuickFix<cr>", { noremap = true, silent = true }),
		},
	},
}
