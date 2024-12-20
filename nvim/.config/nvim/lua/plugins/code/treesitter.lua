return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "VeryLazy" },
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"toml",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				-- autotag = {
				-- 	enable = true,
				-- },
			})
		end,
	},
}
