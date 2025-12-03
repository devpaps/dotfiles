-- Keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- local resession = require("resession")
-- resession.setup()
--
-- Go to config
keymap("n", "<leader>rc", ":e $MYVIMRC<CR>", opts)

-- Go to dashboard
keymap("n", "<leader>d", "<cmd>Alpha<CR>", opts)

-- Resession
keymap("n", "<leader>ss", ":lua require('resession').save()<CR>", opts)
keymap("n", "<leader>sl", ":lua require('resession').load()<CR>", opts)
keymap("n", "<leader>sd", ":lua require('resession').delete()<CR>", opts)

-- Buffers
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-q>", "<cmd>lua require('mini.bufremove').delete(0, false)<CR>", opts)

-- Better window movment
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Keep visual mode indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- NeoTree
keymap("n", "<leader>e", ":Neotree filesystem toggle<CR>", opts)

keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
keymap("n", "go", "<cmd>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
keymap("n", "<leader>g", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

-- Search within my dotfiles
keymap("n", "<leader>df", ":lua require('fzf-lua').files({ cwd = vim.fn.expand('~/.dotfiles') })<CR>", opts)

keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source config" })

-- Search and replace word under cursor, yay
keymap(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Search and Replace Word Under Cursor" }
)

-- keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts)
-- keymap("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>", opts)
-- keymap("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize Horizontal Split Down" })
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize Horizontal Split Up" })
keymap("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Down" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Up" })

-- Obsidian
keymap(
	"n",
	"<leader>oc",
	"<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
	{ desc = "Obsidian Check Checkbox" }
)
keymap("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
keymap("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
keymap("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
keymap("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
keymap("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
keymap("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
keymap("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
keymap("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename title" })

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
