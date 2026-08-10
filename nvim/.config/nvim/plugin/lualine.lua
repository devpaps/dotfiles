-- Run what lazy's `init` hook used to do, before setup
vim.g.lualine_laststatus = vim.o.laststatus
if vim.fn.argc(-1) > 0 then
	vim.o.statusline = " "
else
	vim.o.laststatus = 0
end

-- Restore laststatus before passing to lualine (what lazy's `opts` function did)
vim.o.laststatus = vim.g.lualine_laststatus

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		globalstatus = false,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "neotree" } },
	},
	sections = {
		lualine_a = {
			"mode",
			{ "filename", path = 0 },
		},
		lualine_b = { "branch" },
		lualine_c = {
			{ "diagnostics" },
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
		},
		lualine_x = {
			{
				"diff",
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			},
		},
		lualine_y = {
			{ "progress", separator = " ", padding = { left = 1, right = 0 } },
			{ "location", padding = { left = 0, right = 1 } },
		},
		lualine_z = {
			function()
				return " " .. os.date("%R")
			end,
		},
	},
	extensions = { "neo-tree" }, -- dropped "lazy" since you're not using lazy.nvim
})
