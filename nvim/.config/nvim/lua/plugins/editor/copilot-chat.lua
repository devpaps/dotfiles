return {
	{
		"zbirenbaum/copilot.lua",
		opts = {
			suggestion = { enabled = true },
			panel = { enabled = true },
		},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		event = "VeryLazy",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
}
