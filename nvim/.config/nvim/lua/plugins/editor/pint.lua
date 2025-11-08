return {
	"oliverhkraft/nvim-pint",
	config = function()
		require("nvim-pint").setup({
			silent = true, -- No notifications
			exclude_folders = { "resources/views" }, -- Accepts comma separated array to exlude folders
		})
	end,
}
