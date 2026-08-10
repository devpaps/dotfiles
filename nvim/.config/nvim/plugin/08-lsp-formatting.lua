-- LSP formatting using conform.nvim

vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

-- Ensure plugin is in runtimepath and load formatting
local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/conform.nvim"

if vim.fn.isdirectory(pack_path) == 1 then
	vim.opt.rtp:prepend(pack_path)
end

require("formatting")
