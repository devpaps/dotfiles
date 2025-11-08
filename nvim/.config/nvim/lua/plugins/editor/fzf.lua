return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({
			files = {
				file_ignore_patterns = {
					"vendor",
					"node_modules",
					"package-lock.json",
					"yarn.lock",
					"lazy-lock.json",
				},
			},
		})
	end,
}
