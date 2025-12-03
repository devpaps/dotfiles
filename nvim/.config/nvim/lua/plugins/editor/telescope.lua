return {
	"cljoly/telescope-repo.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local project_nvim = require("project_nvim")
			local actions = require("telescope.actions")

			local opts = {
				defaults = {
					preview = {
						treesitter = false,
					},
					file_ignore_patterns = {
						"node_modules",
						"package-lock.json",
						"yarn.lock",
						"lazy-lock.json",
						"vendor",
						".git",
						"dist",
						"build",
					},
					layout_config = {
						horizontal = {
							mirror = false,
						},
						vertical = {
							mirror = false,
						},
						prompt_position = "top",
					},
					file_sorter = require("telescope.sorters").get_fzy_sorter,
					prompt_prefix = " 🔍 ",
					color_devicons = true,
					sorting_strategy = "ascending",
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					mappings = {
						i = {
							["<C-x>"] = false,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-s>"] = actions.cycle_previewers_next,
							["<C-a>"] = actions.cycle_previewers_prev,
							["<C-d>"] = project_nvim.delete_project,
						},
						n = {
							["<C-s>"] = actions.cycle_previewers_next,
							["<C-a>"] = actions.cycle_previewers_prev,
						},
					},
					extensions = {
						fzf = {
							override_generic_sorter = false,
							override_file_sorter = true,
							case_mode = "smart_case",
						},
					},
				},
			}

			telescope.setup(opts)

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("repo")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("lazygit")
			require("telescope").load_extension("ui-select")

			local function project_files()
				local opts = {} -- define here if you want to define something
				local ok = pcall(builtin.git_files, opts)
				if not ok then
					builtin.find_files(opts)
				end
			end

			-- vim.keymap.set("n", "<C-p>", project_files, {})
			-- vim.keymap.set("n", "<S-p>", builtin.live_grep, {})
		end,
	},
}
