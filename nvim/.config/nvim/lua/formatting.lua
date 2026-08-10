-- Formatting with conform.nvim
local pack_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/conform.nvim"
vim.opt.rtp:prepend(pack_path)

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		rust = { "rust-analyzer" },
		svelte = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		blade = { "blade-formatter" },
		antlers = { "prettier" },
	},
	format_on_save = function(bufnr)
		return {
			lsp_fallback = true,
			async = false,
			timeout_ms = 2000,
		}
	end,
})

-- Manual format command
vim.keymap.set({ "n", "v" }, "<C-f>", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 2000,
	})
end, { desc = "Format file or range (in visual mode)" })

-- Manually trigger completion (C-y is already the native key to SELECT an item)
vim.keymap.set("i", "<C-Space>", function()
	vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })
