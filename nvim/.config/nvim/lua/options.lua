vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Enable LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 1 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = false -- Disable cursor column highlighting
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 15 -- Increase items in completion popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Keep more context when scrolling
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
-- opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.colorcolumn = "80"
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Keep more context when side scrolling
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen" -- Keep text on screen while splitting
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	-- fold = "⸱",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end

-- Folding
vim.opt.foldlevel = 99

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Add these performance-related options
opt.ttyfast = true -- Faster terminal rendering
opt.lazyredraw = true -- Don't redraw while executing macros
opt.redrawtime = 1500 -- Allow more time for loading syntax on large files
opt.ttimeoutlen = 10 -- Reduce key code delay
opt.updatetime = 100 -- Faster completion (default is 4000ms)
opt.hidden = true -- Enable background buffers

-- Optimize syntax highlighting for large files
opt.synmaxcol = 240 -- Only highlight the first 240 columns

-- Add memory-related optimizations
opt.maxmempattern = 2000 -- Increase memory limit for pattern matching
opt.history = 100 -- Reduce command history size
opt.shada = "!,'100,<50,s10,h" -- Optimize shada file settings

-- Enhance search behavior
opt.incsearch = true -- Show search matches while typing
opt.shortmess:append("s") -- Don't show search count message when searching
opt.magic = true -- Enable extended regular expressions

-- Better split handling
opt.equalalways = false -- Don't resize windows on split/close

-- Buffer optimizations
opt.switchbuf = "useopen,uselast" -- Reuse open buffers and jump to last window
opt.autoread = true -- Auto reload file if changed outside

-- UI improvements
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 3 -- Decrease matching paren highlight time
opt.cmdheight = 1 -- Smaller command line height

-- Better file handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before overwriting file
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Enable persistent undo
opt.undolevels = 10000 -- Maximum number of changes that can be undone
