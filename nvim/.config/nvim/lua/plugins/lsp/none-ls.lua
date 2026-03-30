return {
	"ulisses-cruz/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lspconfig", "mason.nvim", "nvimtools/none-ls-extras.nvim" },
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
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"html",
					"vue",
					"json",
					"css",
					"svelte",
					"typescriptreact",
					"javascriptreact",
					"typescript",
					"javascript",
					"yaml",
					"markdown",
					"graphql",
				},
				-- Exclude antlers files from prettier
				condition = function(utils)
					local bufname = vim.api.nvim_buf_get_name(0)
					return not bufname:match("%.antlers%.html$") and not bufname:match("%.antlers%.php$")
				end,
			}),
				-- require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.completion.luasnip,
				null_ls.builtins.formatting.blade_formatter.with({
					filetypes = { "blade" },
				}),
			},
		})

		vim.keymap.set("n", "<C-f>", vim.lsp.buf.format, { desc = "Format buffer" })
		vim.keymap.set("i", "<C-y>", function()
			vim.lsp.completion.trigger()
		end, { desc = "Trigger completion" })
	end,
}
