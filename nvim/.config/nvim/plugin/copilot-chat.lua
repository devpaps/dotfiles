-- plugin/copilot-chat.lua
-- NOTE: using zbirenbaum/copilot.lua (not github/copilot.vim) — don't load both

-- Copilot suggestions need to attach early (on InsertEnter is fine)
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				keymap = {
					accept = "<Tab>",
					accept_word = "<C-Right>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = true },
		})
	end,
})

-- CopilotChat only loads when you actually invoke it
local function load_copilot_chat()
	require("CopilotChat").setup({ debug = false })
end

vim.api.nvim_create_user_command("CopilotChat", function(opts)
	load_copilot_chat()
	-- vim.cmd("CopilotChat " .. opts.args)
	require("CopilotChat").toggle()
end, { nargs = "*", desc = "Open CopilotChat" })

-- If you have a keymap for it, wrap it the same way:
-- vim.keymap.set({ "n", "v" }, "<leader>ac", function()
-- 	load_copilot_chat()
-- 	require("CopilotChat").toggle()
-- end, { desc = "Toggle CopilotChat" })

-- -- NOTE: using zbirenbaum/copilot.lua as the Copilot backend (not github/copilot.vim).
-- -- Do not load both at the same time — they conflict.
--
-- require("copilot").setup({
-- 	suggestion = {
-- 		enabled = true,
-- 		auto_trigger = true,       -- show ghost text automatically as you type
-- 		hide_during_completion = true, -- hide when LSP completion menu is open
-- 		keymap = {
-- 			accept = "<Tab>",      -- accept full suggestion
-- 			accept_word = "<C-Right>", -- accept next word
-- 			next = "<M-]>",
-- 			prev = "<M-[>",
-- 			dismiss = "<C-]>",
-- 		},
-- 	},
-- 	panel = { enabled = true },
-- })
--
-- require("CopilotChat").setup({
-- 	debug = false,
-- })
