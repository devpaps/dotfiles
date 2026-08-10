vim.g.mapleader = " "
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.autoformat = true
vim.g.markdown_recommended_style = 0

local opt = vim.opt

-- Core editing
-- Autocomplete is configured per buffer type in plugin/02-ui.lua to exclude prompts

opt.autowrite = true -- Enable auto write
opt.autowriteall = true -- Write all buffers on SIGHUP/SIGQUIT
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menuone,noselect,popup"
opt.conceallevel = 1 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.cursorcolumn = false
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- Preview incremental substitute
opt.spell = false -- Enable spell checking
opt.spelllang = { "sv" }
opt.incsearch = true -- Show search matches while typing
opt.magic = true -- Enable extended regular expressions
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 10
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.colorcolumn = "100"
opt.showmode = false -- Don't show mode since we have a statusline
opt.winblend = 0 -- Floating window transparency
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.shelltemp = false
opt.termguicolors = true
opt.timeoutlen = 300
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.wildignorecase = true -- Case-insensitive tab completion in commands
opt.winminwidth = 5
opt.wrap = false
opt.list = false
opt.listchars = {
	tab = "  ",
	trail = "·",
	eol = "↲",
}

-- UI
opt.laststatus = 3
opt.cmdheight = 0
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 3
opt.pumblend = 10
opt.pummaxwidth = 80
opt.pumborder = "rounded"
opt.pumheight = 15
opt.fillchars = {
	foldopen = "▾",
	foldclose = "▸",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

opt.encoding = "UTF-8" -- Use UTF-8 encoding

-- Folding
opt.foldlevel = 99

-- Diff
opt.diffopt = "indent-heuristic,internal,algorithm:histogram,context:5"
opt.diffopt:append("vertical") -- Vertical diff splits
opt.diffopt:append("algorithm:patience") -- Better diff algorithm
opt.diffopt:append("linematch:60") -- Better diff highlighting (smart line matching)

-- Search
opt.shortmess:append("s") -- Don't show search count message

-- Split behaviour
opt.equalalways = true -- Don't resize windows on split/close

-- Buffer behaviour
opt.switchbuf = "useopen,uselast"
opt.autoread = true -- Auto reload file if changed outside

-- File handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000

opt.iskeyword:append("-") -- Treat dash as part of a word
opt.selection = "inclusive" -- Use inclusive selection

opt.errorbells = false -- Disable error sounds
opt.backspace = "indent,eol,start" -- Make backspace behave naturally

-- Performance
opt.ttimeoutlen = 10 -- Reduce key code delay
opt.updatetime = 100 -- Faster completion / CursorHold events
opt.hidden = true -- Enable background buffers
opt.synmaxcol = 300 -- Only highlight first 240 columns
opt.redrawtime = 15000 -- Allow more time for syntax on large files
opt.maxmempattern = 20000 -- Increase memory limit for pattern matching
opt.history = 100
opt.shada = "!,'100,<50,s10,h"

-- Experimental UI2: floating cmdline and messages
require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.3,
			timeout = 5000,
		},
		pager = {
			height = 0.5,
		},
	},
})

-- Smooth scroll (Neovim 0.10+)
if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
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
			vim.bo.autocomplete = true
		else
			vim.bo.autocomplete = false
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
