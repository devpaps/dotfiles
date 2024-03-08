-- Keymappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

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
