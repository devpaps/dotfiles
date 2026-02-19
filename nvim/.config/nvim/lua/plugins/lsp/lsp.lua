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
				"eslint_d",
				"prettier",
				"prettierd",
				"vtsls",
				"rust-analyzer",
				"typescript-language-server",
				-- "tailwindcss-language-server",
				"vue-language-server",
				"antlers-language-server",
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
		event = "BufReadPre",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		version = "*",
		event = "BufReadPre",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			local function disable_formatting(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			local servers = {
				vue_ls = {
					init_options = {
						vue = {
							hybridMode = true,
						},
					},
					filetypes = { "vue" },
					on_attach = function(client, bufnr)
						disable_formatting(client) -- Disable volar formatting
					end,
				},
				vtsls = {
					filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
					cmd = { "vtsls", "--stdio" },
					on_attach = function(client, bufnr)
						-- Disable formatting for Vue files (use conform.nvim instead)
						if vim.bo[bufnr].filetype == "vue" then
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end
					end,
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
				marksman = {
					filetypes = { "md" },
				},
				-- tailwindcss = {},
				html = {
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
				},
				cssls = {
					filetypes = { "css", "scss", "less" },
					settings = {
						["css.validate"] = true,
					},
				},
				lua_ls = {
					-- on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim", "use" },
							},
							runtime = {
								version = "LuaJIT",
								path = vim.split(package.path, ";"),
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
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
							},
						},
					},
				},
				rust_analyzer = {
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
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
				clangd = {
					on_attach = function(client, bufnr)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"K",
							"<cmd>lua vim.lsp.buf.hover()<CR>",
							{ noremap = true, silent = true }
						)
						client.server_capabilities.signatureHelpProvider = false
					end,
				},
				eslint = {
					settings = {
						rootPath = vim.fn.getcwd(),
					},
					on_attach = function(client, bufnr)
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								if vim.fn.exists(":EslintFixAll") > 0 then
									vim.cmd("EslintFixAll")
								end
							end,
						})
					end,
				},
				antlersls = {
					filetypes = { "antlers", "html" },
					settings = {
						antlers = {
							formatFrontMatter = true,
						},
					},
					root_dir = function(fname)
						return vim.fs.root(fname, { "composer.json", ".git" }) or vim.fs.dirname(fname)
					end,
				},
				intelephense = {
					filetypes = { "php", "blade" },
					settings = {
						intelephense = {
							files = {
								maxSize = 5000000, -- 5MB file size limit
							},
							stubs = {
								"apache",
								"bcmath",
								"bz2",
								"calendar",
								"com_dotnet",
								"Core",
								"ctype",
								"curl",
								"date",
								"dba",
								"dom",
								"enchant",
								"exif",
								"FFI",
								"fileinfo",
								"filter",
								"fpm",
								"ftp",
								"gd",
								"gettext",
								"gmp",
								"hash",
								"iconv",
								"imap",
								"intl",
								"json",
								"ldap",
								"libxml",
								"mbstring",
								"meta",
								"mysqli",
								"oci8",
								"odbc",
								"openssl",
								"pcntl",
								"pcre",
								"PDO",
								"pdo_ibm",
								"pdo_mysql",
								"pdo_pgsql",
								"pdo_sqlite",
								"pgsql",
								"Phar",
								"posix",
								"pspell",
								"readline",
								"Reflection",
								"session",
								"shmop",
								"SimpleXML",
								"snmp",
								"soap",
								"sockets",
								"sodium",
								"SPL",
								"sqlite3",
								"standard",
								"superglobals",
								"sysvmsg",
								"sysvsem",
								"sysvshm",
								"tidy",
								"tokenizer",
								"xml",
								"xmlreader",
								"xmlrpc",
								"xmlwriter",
								"xsl",
								"Zend OPcache",
								"zip",
								"zlib",
								"wordpress",
								"woocommerce",
								"acf-pro",
								"wordpress-globals",
								"wp-cli",
								"polylang",
								"laravel",
							},
						},
					},
				},
				lemminx = {},
				jsonls = {},
			}

			-- Register server configurations with vim.lsp.config
			for lsp, config in pairs(servers) do
				vim.lsp.config[lsp] = config
			end

			-- Enable all configured servers
			vim.lsp.enable(vim.tbl_keys(servers))
		end,
	},
}
