-- LSP configuration for vim.pack using modern Neovim 0.12 API

-- Mason setup
local mason_opts = {
	ensure_installed = {
		"clangd",
		"lemminx",
		"intelephense",
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
	},
}

require("mason").setup(mason_opts)
local mr = require("mason-registry")

local function ensure_installed()
	for _, tool in ipairs(mason_opts.ensure_installed) do
		local p = mr.get_package(tool)
		if not p:is_installed() then
			p:install()
		end
	end
end
if mr.refresh then
	mr.refresh(ensure_installed)
else
	ensure_installed()
end

-- Fidget setup
pcall(function()
	require("fidget").setup({})
end)

-- Lazydev setup
pcall(function()
	require("lazydev").setup({
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end)

-- Configure diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		severity = vim.diagnostic.severity.WARN,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✖",
			[vim.diagnostic.severity.WARN] = "⚠",
			[vim.diagnostic.severity.HINT] = "󰌶",
			[vim.diagnostic.severity.INFO] = "ℹ",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
		},
	},
	underline = {
		severity = vim.diagnostic.severity.WARN,
	},
	update_in_insert = false,
	float = {
		border = "rounded",
		source = "always",
		header = "Diagnostics",
		prefix = "● ",
	},
})

-- LspAttach autocmd for server-specific keymaps and settings
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr = ev.buf
		if not client then
			return
		end

		-- clangd: disable signature help (conflicts with other plugins)
		if client.name == "clangd" then
			client.server_capabilities.signatureHelpProvider = false
		end

		-- Enable code lenses for all servers that support it
		if client.supports_method("textDocument/codeLens") then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold" }, {
				buffer = bufnr,
				callback = function()
					vim.lsp.codelens.refresh()
				end,
			})
		end
	end,
})

-- Vue TypeScript plugin path
local vue_typescript_plugin_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- Configure LSP servers using Neovim 0.12 vim.lsp API
-- This replaces the deprecated lspconfig framework

vim.lsp.config("vtsls", {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_typescript_plugin_path,
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

vim.lsp.config("volar", {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
})

vim.lsp.config("marksman", {
	cmd = { "marksman", "server" },
	filetypes = { "markdown" },
})

vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
	settings = {
		html = {
			suggest = {
				completion = {
					enabled = true,
					triggerCharacter = "<",
				},
			},
		},
	},
})

vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
})

vim.lsp.config("lua_ls", {
	cmd = {
		vim.fn.stdpath("data") .. "/mason/packages/lua-language-server/lua-language-server",
	},
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			runtime = {
				version = "LuaJIT",
			},
			completion = {
				keywordSnippet = "Replace",
			},
			hint = {
				enable = true,
				setType = false,
				paramType = true,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			workspace = {
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			checkOnSave = true,
			procMacro = {
				enable = true,
			},
			lens = {
				enable = true,
				debug = true,
				implementations = true,
				methodReferences = true,
				references = true,
				run = true,
			},
		},
	},
})

vim.lsp.config("clangd", {
	cmd = { "clangd" },
})

vim.lsp.config("eslint", {
	cmd = { "vscode-eslint-language-server", "--stdio" },
})

vim.lsp.config("antlersls", {
	cmd = { "antlers-language-server", "--stdio" },
	filetypes = { "antlers", "html" },
})

vim.lsp.config("intelephense", {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php", "blade" },
})

vim.lsp.config("lemminx", {
	cmd = { "lemminx" },
})

vim.lsp.config("jsonls", {
	cmd = { "vscode-json-language-server", "--stdio" },
})

-- Enable all configured servers
vim.lsp.enable({
	"vtsls",
	"volar",
	"marksman",
	"html",
	"cssls",
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"eslint",
	"antlersls",
	"intelephense",
	"lemminx",
	"jsonls",
})
