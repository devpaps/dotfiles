return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
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
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
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
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"folke/lazydev.nvim",
		},
		config = function()
			-- Configure diagnostics with v0.12 enhancements
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●", -- or "▎", "●", "■"
					spacing = 2,
					severity = vim.diagnostic.severity.WARN, -- Only show virtual text for warn and above
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
					severity = vim.diagnostic.severity.WARN, -- Underline errors and warnings
				},
				update_in_insert = false, -- Don't update diagnostics while in insert mode
				float = {
					border = "rounded",
					source = "always", -- Always show error source
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

			-- vtsls with Vue support
			local vue_typescript_plugin_path = vim.fn.stdpath("data")
				.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

			vim.lsp.config.vtsls = {
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
				-- v0.12: Enable linked editing for paired tags (HTML/Vue)
				linkedEditingRange = true,
			}

			vim.lsp.config.vue_ls = {
				filetypes = { "vue" },
				-- v0.12: Enable linked editing for Vue templates
				linkedEditingRange = true,
			}

			vim.lsp.config.marksman = {
				filetypes = { "markdown" },
			}

			vim.lsp.config.html = {
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
				-- v0.12: Enable linked editing for HTML paired tags
				linkedEditingRange = true,
			}

			vim.lsp.config.cssls = {
				filetypes = { "css", "scss", "less" },
				settings = {
					css = { validate = true },
					scss = { validate = true },
					less = { validate = true },
				},
			}

			vim.lsp.config.lua_ls = {
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
			}

			vim.lsp.config.rust_analyzer = {
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
						-- v0.12: Enable various LSP capabilities for better code lens display
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
			}

			vim.lsp.config.clangd = {}

			vim.lsp.config.eslint = {}

			vim.lsp.config.antlersls = {
				filetypes = { "antlers", "html" },
			}

			vim.lsp.config.intelephense = {
				filetypes = { "php", "blade" },
			}

			vim.lsp.config.lemminx = {}
			vim.lsp.config.jsonls = {}

			vim.lsp.enable({
				"vtsls",
				"vue_ls",
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
		end,
	},
}
