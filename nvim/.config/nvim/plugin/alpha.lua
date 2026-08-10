local dashboard = require("alpha.themes.dashboard")
require("alpha").setup(dashboard.opts)

local logo = [[
██╗  ██╗██╗███████╗██╗  ██╗██╗    ██╗  ██╗ █████╗ ██╗███████╗███████╗██╗
██║ ██╔╝██║██╔════╝██║  ██║██║    ██║ ██╔╝██╔══██╗██║██╔════╝██╔════╝██║
█████╔╝ ██║███████╗███████║██║    █████╔╝ ███████║██║███████╗█████╗  ██║
██╔═██╗ ██║╚════██║██╔══██║██║    ██╔═██╗ ██╔══██║██║╚════██║██╔══╝  ██║
██║  ██╗██║███████║██║  ██║██║    ██║  ██╗██║  ██║██║███████║███████╗██║
╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝╚═╝

                  - Wake from death and return to life -
]]

dashboard.section.header.val = vim.split(logo, "\n")

-- Buttons
dashboard.section.buttons.val = {
	dashboard.button("p", "  Projects", "<cmd> Telescope projects <cr>"),
	dashboard.button("r", "  Recent files", "<cmd>FzfLua oldfiles<CR>"),
	dashboard.button("c", "  Config", "<cmd>e $MYVIMRC<CR>"),
	dashboard.button("l", "󰒲  Update plugins", "<cmd>lua vim.pack.update()<CR>"),
	dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
}

-- Styling
for _, button in ipairs(dashboard.section.buttons.val) do
	button.opts.hl = "AlphaButtons"
	button.opts.hl_shortcut = "AlphaShortcut"
end

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Center the dashboard a bit
dashboard.opts.layout[1].val = math.max(10, math.floor(vim.o.lines * 0.3))

-- Hide statusline on Alpha dashboard
vim.api.nvim_create_autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.opt_local.laststatus = 0
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "alpha" then
			vim.opt.laststatus = 3
		end
	end,
})

-- Show startup time and plugin count in footer
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	once = true,
-- 	callback = function()
-- 		local packs = vim.pack.get()
-- 		local total = #packs
-- 		local loaded = vim.tbl_count(vim.tbl_filter(function(p)
-- 			return p.active
-- 		end, packs))
--
-- 		local ms = vim.fn.reltimefloat(vim.fn.reltime(vim.g.starttime)) * 1000
--
-- 		dashboard.section.footer.val = "⚡ "
-- 			.. loaded
-- 			.. " of "
-- 			.. total
-- 			.. " plugins loaded in "
-- 			.. string.format("%.0f", ms)
-- 			.. "ms"
--
-- 		pcall(vim.cmd.AlphaRedraw)
-- 	end,
-- })
