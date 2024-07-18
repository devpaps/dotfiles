return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "mason.nvim", "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")
		require("crates").setup({
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		})
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				-- require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.completion.luasnip,
			},
		})

		vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, {})
		vim.keymap.set("i", "<C-y>", vim.lsp.buf.completion, {})
	end,
}
