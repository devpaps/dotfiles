return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
				typescriptreact = { "eslint_d", "prettier" },
				vue = { "eslint_d", "prettier" },
				rust = { "rust-analyzer" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				-- Antlers: use LSP (antlersls/html) instead of prettier
				antlers = { lsp_format = "prefer" },
			},
			format_on_save = function(bufnr)
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				-- Skip conform entirely for antlers files, use BufWritePre autocmd instead
				if bufname:match("%.antlers%.html$") or bufname:match("%.antlers%.php$") then
					return false
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 2000,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Format antlers files on save using LSP (excluding null-ls/prettier)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.antlers.html", "*.antlers.php" },
			callback = function()
				vim.lsp.buf.format({
					filter = function(client)
						-- Only use antlersls or html LSP, not null-ls (which has prettier)
						return client.name == "antlersls" or client.name == "html"
					end,
					async = false,
					timeout_ms = 2000,
				})
			end,
		})
	end,
}
