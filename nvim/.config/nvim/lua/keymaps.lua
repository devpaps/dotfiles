-- Keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- local resession = require("resession")
-- resession.setup()
--
--
-- fzf-lua keymaps
-- vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>",          { desc = "Find files" })
-- vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>",      { desc = "Live grep" })
-- vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>",       { desc = "Recent files" })
-- vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>",        { desc = "Buffers" })
-- vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>",      { desc = "Help tags" })
-- vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua commands<CR>",       { desc = "Commands" })

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>", opts)

vim.keymap.set("i", "<c-space>", function()
	vim.lsp.completion.get()
end)

-- Projects
vim.keymap.set(
	"n",
	"<leader>pp",
	vim.schedule_wrap(function()
		require("telescope").extensions.projects.projects({})
	end),
	{ desc = "Projects", noremap = true, silent = true }
)

keymap("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
keymap("n", "<leader>g", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

-- Git
-- vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>",     { desc = "Git status" })
-- vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>",    { desc = "Git commits" })

-- Buffers
vim.keymap.set("n", "<Tab>", function()
	local snipe = require("snipe")
	local m = snipe.global_menu
	if m and m.win and vim.api.nvim_win_is_valid(m.win) then
		m:close()
	else
		snipe.open_buffer_menu()
	end
end, opts)

-- Better window movment
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Keep visual mode indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Search within my dotfiles
-- keymap("n", "<leader>df", ":lua require('fzf-lua').files({ cwd = vim.fn.expand('~/.dotfiles') })<CR>", opts)

-- Search and replace word under cursor, yay
keymap(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search and Replace Word Under Cursor" }
)

-- Resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize Horizontal Split Down" })
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize Horizontal Split Up" })
keymap("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Down" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Up" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)

-- Highlight under cursor
keymap("n", "gh", "<cmd>lua vim.diagnostic.open_float( {border = 'rounded', max_width = 120} )<CR>", opts)

-- Code action
keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- Lazygit
keymap("n", "<leader>lg", "<CMD>LazyGit<CR>", opts)

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", opts)

--Split vertical
keymap("n", "<leader>v", ":vsplit<CR>", opts)

--Split horizontal
keymap("n", "<leader>h", ":split<CR>", opts)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', opts)

-- Close buffer
keymap("n", "<S-q>", "<cmd>bdelete<CR>", { desc = "Close Buffer", noremap = true, silent = true })
