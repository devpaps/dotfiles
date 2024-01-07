return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				"eslint_d",
				"prettier",
				"rust-analyzer",
				"typescript-language-server",
				"vue-language-server",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
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
		end,
	},
	{
		-- Fidget shows the current LSP server and its status in the statusline
		"j-hui/fidget.nvim",
		event = "BufReadPre",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")

			local function setup_servers()
				local servers = {
					"tsserver",
					"eslint",
					"lua_ls",
					"marksman",
					"html",
					"cssls",
					"jsonls",
					"sqlls",
					"bashls",
					"jdtls",
					"rust_analyzer",
				}

				for _, lsp in ipairs(servers) do
					lspconfig[lsp].setup({})
				end
			end

			local lua_ls_settings = {
				workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false },
				diagnostics = {
					disable = { "missing-fields", "incomplete-signature-doc", "trailing-space" },
					groupSeverity = { strong = "Warning", strict = "Warning" },
					globals = { "vim", "require" },
				},
				completion = { workspaceWord = true, callSnippet = "Both" },
				hover = { expandAlias = false },
				hint = {
					enable = true,
					setType = false,
					paramType = true,
					paramName = "Disable",
					semicolon = "Disable",
					arrayIndex = "Disable",
				},
				runtime = { version = "LuaJIT" },
				type = { castNumberToInteger = true },
				format = {
					enable = true,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
						continuation_indent_size = "2",
					},
				},
			}

			local rust_analyzer_settings = {
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
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
				},
			}

			local tsserver_settings = {
				-- capabilities = require("cmp_nvim_lsp").default_capabilities(
				-- 	vim.lsp.protocol.make_client_capabilities()
				-- ),
				-- on_attach = function(client)
				-- 	client.resolved_capabilities.document_formatting = false
				-- end,
				single_file_support = false,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "literal",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = false,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			}

			setup_servers()

			lspconfig.lua_ls.setup({ settings = lua_ls_settings })
			lspconfig.rust_analyzer.setup({ settings = rust_analyzer_settings })
			lspconfig.tsserver.setup({
				settings = tsserver_settings,
				-- on_attach = tsserver_settings.on_attach,
				-- capabilities = tsserver_settings.capabilities,
			})
			lspconfig.eslint.setup({
				settings = {
					rootPath = vim.fn.getcwd(),
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})
		end,
	},
}
