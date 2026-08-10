-- nvim-lspconfig is not needed with Neovim 0.11+ using vim.lsp.config API
-- All servers are configured manually below using vim.lsp.config

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end

		if client.name == "clangd" then
			client.server_capabilities.signatureHelpProvider = false
		end

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded", max_width = 80 })
		end, { buffer = ev.buf, desc = "Hover documentation" })

		-- Native LSP completion
		if client:supports_method("textDocument/completion") then
			-- Intelephense only triggers on special chars (-> :: $) by default.
			-- Extend to all letters/digits so completion fires as you type.
			if client.name == "intelephense" then
				local provider = client.server_capabilities.completionProvider
				if provider then
					local extra = {}
					for i = 65, 90 do
						table.insert(extra, string.char(i))
					end -- A-Z
					for i = 97, 122 do
						table.insert(extra, string.char(i))
					end -- a-z
					for i = 48, 57 do
						table.insert(extra, string.char(i))
					end -- 0-9
					for _, c in ipairs({ "_", "\\", " " }) do
						table.insert(extra, c)
					end
					local existing = provider.triggerCharacters or {}
					vim.list_extend(existing, extra)
					provider.triggerCharacters = existing
				end
			end
			-- autotrigger = false: copilot.lua auto_trigger and LSP autotrigger
			-- conflict over TextChangedI events. Copilot handles auto suggestions;
			-- use <C-Space> to manually open the LSP completion popup.
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
		end
	end,
})

local data_dir = vim.fn.stdpath("data")

-- Override or extend server configs from nvim-lspconfig with custom settings
-- TypeScript/JavaScript with Vue support
vim.lsp.config.vtsls = vim.tbl_extend("force", vim.lsp.config.vtsls or {}, {
	cmd = { data_dir .. "/mason/bin/vtsls", "--stdio" },
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = data_dir .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
})

vim.lsp.config.vue_ls = vim.tbl_extend("force", vim.lsp.config.vue_ls or {}, {
	cmd = { data_dir .. "/mason/bin/vue-language-server", "--stdio" },
	filetypes = { "vue" },
})

vim.lsp.config.lua_ls = vim.tbl_extend("force", vim.lsp.config.lua_ls or {}, {
	cmd = { data_dir .. "/mason/bin/lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
				-- Disable diagnostics for undefined globals that are common false positives
				undefined = false,
			},
			runtime = { version = "LuaJIT" },
			completion = { keywordSnippet = "Replace" },
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
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

vim.lsp.config.rust_analyzer = vim.tbl_extend("force", vim.lsp.config.rust_analyzer or {}, {
	cmd = { data_dir .. "/mason/bin/rust-analyzer" },
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			checkOnSave = {
				allFeatures = true,
				command = "clippy",
				extraArgs = { "--no-deps" },
			},
			procMacro = { enable = true },
		},
	},
})

vim.lsp.config.clangd = vim.tbl_extend("force", vim.lsp.config.clangd or {}, {
	cmd = { data_dir .. "/mason/bin/clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

vim.lsp.config("antlersls", {
	cmd = { data_dir .. "/mason/bin/antlersls", "--stdio" },
	filetypes = { "antlers", "html" },
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})

vim.lsp.config.intelephense = vim.tbl_extend("force", vim.lsp.config.intelephense or {}, {
	cmd = { data_dir .. "/mason/bin/intelephense", "--stdio" },
	filetypes = { "php", "blade" },
	root_markers = { "composer.json", "phpunit.xml", ".git" },
	settings = {
		intelephense = {
			diagnostics = {
				enable = true,
			},
			stubs = {
				"Core",
				"standard",
				"SPL",
				"curl",
				"date",
				"hash",
				"json",
				"Phar",
				"Reflection",
				"Simplexml",
				"pcntl",
				"PDO",
				"posix",
				"readline",
				"sockets",
				"fileinfo",
				"ftp",
				"gd",
				"gettext",
				"iconv",
				"intl",
				"imagick",
				"memcached",
				"mongodb",
				"mysql",
				"mysqli",
				"openssl",
				"pcre",
				"pgsql",
				"redis",
				"session",
				"soap",
				"sqlite3",
				"ssl",
				"tidy",
				"tokenizer",
				"xdebug",
				"xml",
				"xmlreader",
				"xmlwriter",
				"zlib",
				"laravel",
				"wordpress",
				"phpunit",
			},
			files = {
				maxSize = 5000000,
			},
		},
	},
})

vim.lsp.config.phpactor = vim.tbl_extend("force", vim.lsp.config.phpactor or {}, {
	cmd = { data_dir .. "/mason/bin/phpactor", "language-server" },
	filetypes = { "php" },
	root_markers = { "composer.json", ".git" },
})

vim.lsp.config.lemminx = vim.tbl_extend("force", vim.lsp.config.lemminx or {}, {
	cmd = { data_dir .. "/mason/bin/lemminx" },
	filetypes = { "xml" },
})

vim.lsp.config.jsonls = vim.tbl_extend("force", vim.lsp.config.jsonls or {}, {
	cmd = { data_dir .. "/mason/bin/vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
})

vim.lsp.config.marksman = vim.tbl_extend("force", vim.lsp.config.marksman or {}, {
	cmd = { data_dir .. "/mason/bin/marksman", "server" },
	filetypes = { "markdown" },
})

vim.lsp.config.html = vim.tbl_extend("force", vim.lsp.config.html or {}, {
	cmd = { data_dir .. "/mason/bin/vscode-html-language-server", "--stdio" },
	filetypes = { "html", "antlers" }, -- Also serve Antlers files since antlersls is broken
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	-- root_markers = { ".git", "composer.json", "package.json" },
	-- init_options = {
	-- 	configurationSection = { "html", "css", "javascript" },
	-- 	embeddedLanguages = { css = true, javascript = true },
	-- },
})

vim.lsp.config.cssls = vim.tbl_extend("force", vim.lsp.config.cssls or {}, {
	cmd = { data_dir .. "/mason/bin/vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
})

-- Enable all configured LSP servers
vim.lsp.enable({
	"vtsls",
	"vue_ls",
	"marksman",
	"html",
	"cssls",
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"antlersls",
	"intelephense",
	"phpactor",
	"lemminx",
	"jsonls",
})
