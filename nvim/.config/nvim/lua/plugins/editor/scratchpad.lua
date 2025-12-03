return {
	"athar-qadri/scratchpad.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local scratchpad = require("scratchpad")
		scratchpad:setup({ settings = { sync_on_ui_close = true } })
	end,
	keys = {
		{
			"<Leader>es",
			function()
				local scratchpad = require("scratchpad")
				scratchpad.ui:new_scratchpad()
			end,
			desc = "show scratch pad",

			vim.keymap.set({ "n", "v" }, "<leader>ps", function()
				local scratchpad = require("scratchpad")
				scratchpad.ui:sync()
			end, { desc = "Push selection / current line to scratchpad" }),
		},
	},
}
