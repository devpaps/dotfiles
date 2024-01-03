return {
	"nvimtools/none-ls.nvim",
	event = "BufReadPre",
	dependencies = { "mason.nvim" },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.completion.luasnip,
			},
		})

		vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, {})
		vim.keymap.set("i", "<C-y>", vim.lsp.buf.completion, {})
	end,
}
