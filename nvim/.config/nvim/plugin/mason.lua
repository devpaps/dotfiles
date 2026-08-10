-- plugin/mason.lua

-- Fidget can load on VimEnter since it needs to catch LSP progress
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.defer_fn(function()
			require("fidget").setup({})
		end, 0)
	end,
})

-- Mason loads only on :Mason command or explicit call
local function load_mason()
	vim.cmd("packadd mason.nvim")

	require("mason").setup()

	local mr = require("mason-registry")
	local ensure_installed = {
		"clangd",
		"lemminx",
		"intelephense",
		"phpactor",
		"stylua",
		"marksman",
		"html-lsp",
		"shellcheck",
		"css-lsp",
		"eslint-lsp",
		"eslint_d",
		"prettier",
		"prettierd",
		"rust-analyzer",
		"vue-language-server",
		"antlers-language-server",
		"lua-language-server",
		"json-lsp",
		"vtsls",
	}

	local function ensure_tools()
		for _, tool in ipairs(ensure_installed) do
			local p = mr.get_package(tool)
			if p and not p:is_installed() then
				p:install()
			end
		end
	end

	if mr.refresh then
		mr.refresh(ensure_tools)
	else
		ensure_tools()
	end

	mr:on("package:install:success", function()
		vim.defer_fn(function()
			vim.notify("Mason: Package installed", vim.log.levels.INFO)
		end, 100)
	end)
end

-- Expose as command
vim.api.nvim_create_user_command("Mason", function()
	load_mason()
	vim.cmd("Mason")
end, { desc = "Open Mason installer" })

-- Also trigger lazily after startup is fully settled
-- so ensure_installed still runs on first launch
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.defer_fn(load_mason, 1000) -- 1s delay, well after UI is painted
	end,
})

-- require("mason").setup()
--
-- local mr = require("mason-registry")
--
-- local ensure_installed = {
--   "clangd", "lemminx", "intelephense", "stylua", "marksman",
--   "html-lsp", "shellcheck", "css-lsp", "eslint-lsp", "eslint_d",
--   "prettier", "prettierd", "rust-analyzer", "vue-language-server",
--   "antlers-language-server", "lua-language-server", "json-lsp", "vtsls",
-- }
--
-- local function ensure_tools()
--   for _, tool in ipairs(ensure_installed) do
--     local p = mr.get_package(tool)
--     if p and not p:is_installed() then
--       p:install()
--     end
--   end
-- end
--
-- if mr.refresh then
--   mr.refresh(ensure_tools)
-- else
--   ensure_tools()
-- end
--
-- -- Optional: notification on install
-- mr:on("package:install:success", function()
--   vim.defer_fn(function()
--     vim.notify("Mason: Package installed", vim.log.levels.INFO)
--   end, 100)
-- end)
--
-- require("fidget").setup({})
