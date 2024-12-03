-- Keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- local resession = require("resession")
-- resession.setup()

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
keymap("n", "<C-e>", ":Neotree filesystem toggle<CR>", opts)

keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
keymap("n", "go", "<cmd>Telescope lsp_type_definitions<CR>", opts)
keymap("n", "<leader>f", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
keymap("n", "<leader>g", "<cmd>lua require('fzf-lua').grep_visual()<CR>", { silent = true })

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
keymap("n", "<leader>gg", "<CMD>LazyGit<CR>", opts)

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", opts)

--Split vertical
keymap("n", "<leader>v", ":vsplit<CR>", opts)

--Split horizontal
keymap("n", "<leader>h", ":split<CR>", opts)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', opts)
