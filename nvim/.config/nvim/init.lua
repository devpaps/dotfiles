vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "

require("options")
require("keymappings")
require("autocmds")

require("lazy").setup({
	spec = {
		{ import = "plugins.code" },
		{ import = "plugins.editor" },
		-- { import = "plugins.lsp.none-ls" }, -- Ensure none-ls is loaded first
		{ import = "plugins.lsp" },
	},
})
