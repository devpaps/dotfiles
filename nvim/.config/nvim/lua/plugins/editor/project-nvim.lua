return {
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			require("project_nvim").setup({
				manual_mode = false,
				detection_methods = { "lsp", "pattern" },
				show_hidden = false,
				silent_chdir = true,
				datapath = vim.fn.stdpath("data"),
				patterns = {
					".git",
					"Makefile",
					"package.json",
					"Cargo.toml",
					"go.mod",
					"go.sum",
					"composer.json",
					"composer.lock",
					"package-lock.json",
					"yarn.lock",
					"_darcs",
					".hg",
					".bzr",
					".svn",
				},
			})
		end,
		keys = {
			{
				"<leader>pp",
				vim.schedule_wrap(function()
					require("telescope").extensions.projects.projects({})
				end),
			},
		},
	},
}
