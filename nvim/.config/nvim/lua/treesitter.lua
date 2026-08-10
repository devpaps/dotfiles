vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
		[".*%.antlers%.html"] = "antlers",
	},
})

vim.cmd.packadd("nvim-treesitter")

local treesitter = require("nvim-treesitter")
local install_dir = vim.fn.stdpath("data") .. "/site"
treesitter.setup({
	install_dir = install_dir,
	auto_install = false,
})
vim.opt.runtimepath:append(install_dir)

local ensure_installed = {
	"bash",
	"git_config",
	"c",
	"css",
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
	"vue",
	"yaml",
}
treesitter.install(ensure_installed)

local patterns = ensure_installed
vim.api.nvim_create_autocmd("FileType", {
	pattern = patterns,
	callback = function(args)
		vim.treesitter.start(args.buf)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Antlers files use the html treesitter parser for highlighting
vim.api.nvim_create_autocmd("FileType", {
	pattern = "antlers",
	callback = function(args)
		vim.treesitter.start(args.buf, "html")
	end,
})
