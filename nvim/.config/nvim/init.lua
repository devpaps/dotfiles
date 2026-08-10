-- Silence deprecated vim.lsp.buf_get_clients() called by outdated plugins
-- (project.nvim) until they update to vim.lsp.get_clients()
vim.lsp.buf_get_clients = function(bufnr)
	return vim.lsp.get_clients({ bufnr = bufnr })
end
vim.opt.rtp:prepend(vim.fn.stdpath("config"))

require("settings")
require("lsp-setup")
require("treesitter")
require("keymaps")
require("autocmds")
