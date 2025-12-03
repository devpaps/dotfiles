return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		local grep_actions = vim.tbl_extend("force", fzf.defaults.grep.actions, {
			["alt-i"] = { fzf.actions.toggle_ignore },
			["alt-h"] = { fzf.actions.toggle_hidden },
		})

		local files_actions = vim.tbl_extend("force", fzf.defaults.actions.files, {
			["alt-i"] = { fzf.actions.toggle_ignore },
			["alt-h"] = { fzf.actions.toggle_hidden },
		})

		require("fzf-lua").setup({
			grep = {
				actions = grep_actions,
				-- Set base rg_opts with your exclusions (applies always); toggles add/remove --no-ignore and --hidden
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --glob '!.git/**' --glob '!**/node_modules/**' --glob '!**/vendor/**' --glob '!package-lock.json' --glob '!yarn.lock' --glob '!lazy-lock.json'",
			},
			live_grep = {
				actions = grep_actions,
				-- rg_opts = "--column --line-number --no-heading --color=always --smart-case --glob '!.git/**' --glob '!**/node_modules/**' --glob '!**/vendor/**' --glob '!package-lock.json' --glob '!yarn.lock' --glob '!lazy-lock.json'",
			},
			files = {
				actions = files_actions,
				file_ignore_patterns = {
					"vendor",
					"node_modules",
					"package-lock.json",
					"yarn.lock",
					"lazy-lock.json",
				},
			},
		})
	end,
}
