return {
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- This plugin is used in Rust projects to show the current crate's
	-- documentation in a floating window using none-ls
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "wakatime/vim-wakatime", event = "VeryLazy" },

	-- A plugin for previewing markdown files using the glow CLI
	{
		"ellisonleao/glow.nvim",
		event = "VeryLazy",
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
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			vim.keymap.set("n", "<leader>lt", "<cmd>TodoQuickFix<cr>", { noremap = true, silent = true }),
		},
	},
}
