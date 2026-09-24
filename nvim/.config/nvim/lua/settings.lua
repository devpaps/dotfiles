vim.g.mapleader = " "
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.autoformat = true
vim.g.markdown_recommended_style = 0

local opt = vim.opt
local o = vim.o

-- Core editing
-- Autocomplete is configured per buffer type in plugin/02-ui.lua to exclude prompts

o.autowrite = true -- Enable auto write
o.autowriteall = true -- Write all buffers on SIGHUP/SIGQUIT
o.autoindent = true -- Copy indent from current line when starting a new line
o.clipboard = "unnamedplus" -- Sync with system clipboard
o.completeopt = "menuone,noselect,popup"
o.conceallevel = 1 -- Hide * markup for bold and italic
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Enable highlighting of the current line
o.cursorcolumn = false
o.expandtab = true -- Use spaces instead of tabs
o.formatoptions = "jcroqlnt"
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.ignorecase = true -- Ignore case
o.inccommand = "nosplit" -- Preview incremental substitute
o.spell = false -- Enable spell checking
o.spelllang = "sv"
o.incsearch = true -- Show search matches while typing
o.magic = true -- Enable extended regular expressions
o.mouse = "a"
o.number = true
o.relativenumber = true
o.scrolloff = 10
o.sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"
o.shiftround = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.colorcolumn = "100"
o.showmode = false -- Don't show mode since we have a statusline
o.winblend = 0 -- Floating window transparency
o.sidescrolloff = 8
o.signcolumn = "yes"
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitkeep = "screen"
o.splitright = true
o.shelltemp = false
o.termguicolors = true
o.timeoutlen = 300
o.virtualedit = "block"
o.wildmode = "longest:full,full"
o.wildignorecase = true -- Case-insensitive tab completion in commands
o.winminwidth = 5
o.wrap = false
o.list = false
o.listchars = "tab:  ,trail:·,eol:↲"

-- UI
o.laststatus = 3
o.cmdheight = 1
o.showmatch = true -- Highlight matching brackets
o.matchtime = 3
o.pumblend = 10
o.pummaxwidth = 80
o.pumborder = "rounded"
o.pumheight = 15
o.fillchars = "foldopen:▾,foldclose:▸,fold: ,foldsep: ,diff:╱,eob: "

o.encoding = "UTF-8" -- Use UTF-8 encoding

-- Folding
o.foldlevel = 99

-- Diff
o.diffopt =
	"internal,filler,closeoff,indent-heuristic,algorithm:histogram,inline:char,linematch:60,vertical,context:5"

-- Search
opt.shortmess:append("s") -- Don't show search count message

-- Split behaviour
o.equalalways = true -- Don't resize windows on split/close

-- Buffer behaviour
o.switchbuf = "useopen,uselast"
o.autoread = true -- Auto reload file if changed outside

-- File handling
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.undolevels = 10000

opt.iskeyword:append("-") -- Treat dash as part of a word
o.selection = "inclusive" -- Use inclusive selection

o.errorbells = false -- Disable error sounds
o.backspace = "indent,eol,start" -- Make backspace behave naturally

-- Performance
o.ttimeoutlen = 10 -- Reduce key code delay
o.updatetime = 100 -- Faster completion / CursorHold events
o.hidden = true -- Enable background buffers
o.synmaxcol = 300 -- Only highlight first 240 columns
o.redrawtime = 15000 -- Allow more time for syntax on large files
o.maxmempattern = 20000 -- Increase memory limit for pattern matching
o.history = 100
o.shada = "!,'100,<50,s10,h"

o.messagesopt = "wait:5000,history:500,maxheight:10,timeout:5000,pager:0.5,progress:c"

-- Smooth scroll (Neovim 0.10+)
if vim.fn.has("nvim-0.10") == 1 then
	o.smoothscroll = true
end

-- Autocomplete only in regular buffers, not in prompts/search
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- List of buffer types to exclude from autocomplete
		local exclude_buffers = {
			"prompt", -- Command mode prompts
			"nofile", -- Special buffers like fzf-lua
			"terminal", -- Terminal buffers
		}

		-- Check if current buffer type is in exclude list
		local is_excluded = false
		for _, buftype in ipairs(exclude_buffers) do
			if vim.bo.buftype == buftype then
				is_excluded = true
				break
			end
		end

		-- Enable autocomplete only for regular buffers
		if not is_excluded then
			vim.api.nvim_set_option_value("autocomplete", true, { buf = 0 })
		else
			vim.api.nvim_set_option_value("autocomplete", false, { buf = 0 })
		end
	end,
})

-- Quick :LspInfo command
vim.api.nvim_create_user_command("LspInfo", function()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		print("No LSP clients attached")
		return
	end
	local lines = { "Active LSP clients:" }
	for _, client in ipairs(clients) do
		table.insert(lines, string.format("  - %s (id: %d)", client.name, client.id))
	end
	print(table.concat(lines, "\n"))
end, {})

-- Use OSC 52 for clipboard in remote SSH sessions
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}
