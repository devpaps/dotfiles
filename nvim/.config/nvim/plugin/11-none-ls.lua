-- None-ls for additional LSP sources (formatting, diagnostics, etc.)

vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
})

-- Configure none-ls
local ok, null_ls = pcall(require, "null-ls")
if ok then
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			-- Prettier for JS/TS/Vue/CSS/JSON/YAML/Markdown/GraphQL
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
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
					"html",
				},
			}),
			null_ls.builtins.formatting.blade_formatter.with({
				filetypes = { "blade" },
			}),
		},
	})
else
	vim.notify("Failed to load null-ls: " .. null_ls, vim.log.levels.ERROR)
end
