return {
	-- "gcc" to comment visual regions/lines
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		config = function()
			require("ts_context_commentstring").setup({
				languages = {
					blade = "{{-- %s --}}",
				},
			})
		end,
	},
}
