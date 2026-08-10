require("toggleterm").setup({
	open_mapping = [[<F12>]],
	direction = "float",
	auto_scroll = true,
	hide_numbers = true,
	insert_mappings = true,
	terminal_mappings = true,
	start_in_insert = true,
	close_on_exit = true,
	shell = "zsh",

	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.8
		end
	end,
})

-- Follow CWD changes in all open terminals
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		local dir = vim.v.event.cwd
		local ok, terminal = pcall(require, "toggleterm.terminal")
		if not ok then return end
		for _, term in pairs(terminal.get_all()) do
			if term:is_open() then
				term:send("cd " .. vim.fn.shellescape(dir), false)
			end
		end
	end,
})
