return {
	-- "gcc" to comment visual regions/lines
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		init = function()
			-- Skip the deprecated module (required for native Neovim integration)
			vim.g.skip_ts_context_commentstring_module = true
		end,
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
				languages = {
					blade = "{{-- %s --}}",
				},
			})

			-- Integrate with Neovim's native commenting (gc/gcc)
			local get_option = vim.filetype.get_option
			---@diagnostic disable-next-line: duplicate-set-field
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
		end,
	},
}
