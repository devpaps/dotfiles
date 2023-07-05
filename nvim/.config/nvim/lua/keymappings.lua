local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<NOP>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Github Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-Y>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

keymap("n", "<C-e>", "<cmd>lua require'nvim-tree.api'.tree.toggle()<CR>", { noremap = true, silent = true })

-- toggle neoclip - https://github.com/AckslD/nvim-neoclip.lua#startstop
keymap("n", ",tn", "<CMD>lua require('neoclip').toggle()<CR>", { noremap = true, silent = true })

-- Harpoon
keymap("n", "<Leader>ph", "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true })
keymap("n", "<Leader>pm", "<CMD>lua require('harpoon.mark).add_file()<CR>", { noremap = true })

-- Format
keymap("n", "<C-f>", "<CMD>lua vim.lsp.buf.format()<CR>", { noremap = true })

-- Projects
keymap("n", "<Leader>pp", "<CMD>Telescope projects<CR>", { noremap = true })

-- Better window movment
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Keep visual mode indenting
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected text around
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)

-- Save file by CTRL-S
keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
keymap("i", "<C-s>", "<ESC> :w<CR>", { noremap = true, silent = true })

-- Telescope
keymap("n", "<C-p>", "<CMD>lua require('plugins.telescope').project_files()<CR>", { noremap = true })
keymap("n", "<S-p>", "<CMD>lua require('plugins.telescope.pickers.multi-rg')()<CR>", { noremap = true })
keymap("n", "<A-p>", "<CMD>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", { noremap = true })

-- Remove highlights
keymap("n", "<CR>", ":noh<CR><CR>", { noremap = true, silent = true })

-- Find word/file across project
keymap("n", "<Leader>pg", "<CMD>Telescope git_files<CR><C-r>+<ESC>", { noremap = true })
keymap("n", "<Leader>pw", "<CMD>Telescope grep_string<CR><ESC>", { noremap = true })
keymap("n", "<Leader>pf", "<CMD>lua require'telescope.builtin'.find_files{}<CR><ESC>", { noremap = true })

-- Git
keymap("n", "<Leader>gla", "<CMD>lua require('plugins.telescope').my_git_commits()<CR>",
  { noremap = true, silent = true })
keymap("n", "<Leader>glc", "<CMD>lua require('plugins.telescope').my_git_bcommits()<CR>",
  { noremap = true, silent = true })

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", { noremap = true, silent = true })
keymap("n", "gn", ":bn<CR>", { noremap = true, silent = true })
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", { noremap = true, silent = true })
keymap("n", "gp", ":bp<CR>", { noremap = true, silent = true })
keymap("n", "<S-q>", ":BufferClose<CR>", { noremap = true, silent = true })

-- Move between barbar buffers
keymap("n", "<Space>1", ":BufferGoto 1<CR>", { silent = true })
keymap("n", "<Space>2", ":BufferGoto 2<CR>", { silent = true })
keymap("n", "<Space>3", ":BufferGoto 3<CR>", { silent = true })
keymap("n", "<Space>4", ":BufferGoto 4<CR>", { silent = true })
keymap("n", "<Space>5", ":BufferGoto 5<CR>", { silent = true })
keymap("n", "<Space>6", ":BufferGoto 6<CR>", { silent = true })
keymap("n", "<Space>7", ":BufferGoto 7<CR>", { silent = true })
keymap("n", "<Space>8", ":BufferGoto 8<CR>", { silent = true })
keymap("n", "<Space>9", ":BufferGoto 9<CR>", { silent = true })
keymap("n", "<A-1>", ":BufferGoto 1<CR>", { silent = true })
keymap("n", "<A-2>", ":BufferGoto 2<CR>", { silent = true })
keymap("n", "<A-3>", ":BufferGoto 3<CR>", { silent = true })
keymap("n", "<A-4>", ":BufferGoto 4<CR>", { silent = true })
keymap("n", "<A-5>", ":BufferGoto 5<CR>", { silent = true })
keymap("n", "<A-6>", ":BufferGoto 6<CR>", { silent = true })
keymap("n", "<A-7>", ":BufferGoto 7<CR>", { silent = true })
keymap("n", "<A-8>", ":BufferGoto 8<CR>", { silent = true })
keymap("n", "<A-9>", ":BufferGoto 9<CR>", { silent = true })

-- Don't yank on delete char
keymap("n", "x", '"_x', { noremap = true, silent = true })
keymap("n", "X", '"_X', { noremap = true, silent = true })
keymap("v", "x", '"_x', { noremap = true, silent = true })
keymap("v", "X", '"_X', { noremap = true, silent = true })

-- Don't yank on visual paste
keymap("v", "p", '"_dP', { noremap = true, silent = true })

-- Avoid issues because of remapping <c-a> and <c-x> below
vim.cmd [[
  nnoremap <Plug>SpeedDatingFallbackUp <c-a>
  nnoremap <Plug>SpeedDatingFallbackDown <c-x>
]]

-- Quickfix
keymap("n", "<Space>,", ":cp<CR>", { silent = true })
keymap("n", "<Space>.", ":cn<CR>", { silent = true })

-- Open links under cursor in browser with gx
if vim.fn.has('macunix') == 1 then
  keymap("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", { silent = true })
else
  keymap("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", { silent = true })
end
-- if vim.fn.has("mac") == 1 then
--   keymap("n", "gx", '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>', { silent = true })
-- elseif vim.fn.has("unix") == 1 then
--   keymap("n", "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', { silent = true })
-- else
--   keymap("n", "gx", '<Cmd>lua print("Error: gx is not supported on this OS!")<CR>', { silent = true })
-- end
-- LSP
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
-- keymap("n", "gr", "<cmd>Telescope lsp_references({ includeDeclaration = false })<CR>", { silent = true })
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", { silent = true })
keymap("n", "gh", "<cmd>lua vim.diagnostic.open_float( {border = 'rounded', max_width = 100} )<CR>", { silent = true })
keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", { silent = true })
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", { silent = true })
keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", { silent = true })
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true })
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", { silent = true })
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", { silent = true })
