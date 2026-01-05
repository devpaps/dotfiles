return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		config = function()
			vim.filetype.add({
				extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
				filename = {
					["vifmrc"] = "vim",
				},
				pattern = {
					[".*/waybar/config"] = "jsonc",
					[".*/mako/config"] = "dosini",
					[".*/kitty/.+%.conf"] = "kitty",
					[".*/hypr/.+%.conf"] = "hyprlang",
					["%.env%.[%w_.-]+"] = "sh",
					[".*%.blade%.php"] = "blade",
				},
			})

			local treesitter = require("nvim-treesitter")
			local install_dir = vim.fn.stdpath("data") .. "/site"
			treesitter.setup({
				install_dir = install_dir,
			})
			vim.opt.runtimepath:append(install_dir)

			local ensure_installed = {
				"bash",
				"git_config",
				"c",
				"diff",
				"blade",
				"html",
				"php",
				"javascript",
				"jsdoc",
				"json",
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
			}
			treesitter.install(ensure_installed)

			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "TSUpdate",
			-- 	callback = function()
			-- 		require("nvim-treesitter.parsers").blade = {
			-- 			install_info = {
			-- 				url = "https://github.com/EmranMR/tree-sitter-blade",
			-- 				files = { "src/parser.c" },
			-- 				branch = "main",
			-- 				queries = "queries",
			-- 			},
			-- 			filetype = "blade",
			-- 		}
			-- 	end,
			-- })
			--
			-- vim.treesitter.language.register("blade", "blade")
			-- vim.treesitter.language.register("bash", "kitty")
			--
			-- Enable highlighting and indentation for supported filetypes
			local patterns = ensure_installed
			vim.api.nvim_create_autocmd("FileType", {
				pattern = patterns,
				callback = function(args)
					vim.treesitter.start(args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
