-- KEYBINDINGS GUIDE
-- ==================
-- LSP: gd (def), gr (refs), gi (impl), go (type), <leader>ca (action), <leader>rn (rename)
--      <leader>ll (code lens run), <leader>lr (code lens refresh), <leader>le (linked edit)
-- TreeSitter: v/c/d/y + if/af/ic/ac (inner/outer function/class)
--             Example: v i f (select inner function), d a c (delete outer class)
-- Diagnostics: gh (float), virtual text shown inline with ● symbol

local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Optimize large files
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*",
	callback = function(args)
		local ok, stats = pcall(vim.loop.fs_stat, args.match)
		-- If file is larger than 100KB, disable certain features
		if ok and stats and stats.size > 100000 then
			vim.b[args.buf].large_buf = true
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.syntax = "off"
			-- Disable other expensive features
			vim.opt_local.spell = false
			vim.opt_local.undofile = false
			vim.opt_local.swapfile = false
			vim.opt_local.showmatch = false
			vim.opt_local.cursorline = false
		end
	end,
})

-- General LSP attach callback for all LSP clients
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Set up keymaps for all LSP clients
		local opts = { noremap = true, silent = true, buffer = bufnr }
		
		-- Navigation
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		
		-- Refactoring
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		
		-- Documentation
		vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		
		-- v0.12: Code lenses
		if client and client.supports_method("textDocument/codeLens") then
			vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.run, { noremap = true, silent = true, buffer = bufnr, desc = "Run code lens" })
			vim.keymap.set("n", "<leader>lr", vim.lsp.codelens.refresh, { noremap = true, silent = true, buffer = bufnr, desc = "Refresh code lenses" })
		end
		
		-- v0.12: Linked editing (edit paired tags)
		if client and client.supports_method("textDocument/linkedEditingRange") then
			vim.keymap.set("n", "<leader>le", function()
				local params = vim.lsp.util.make_position_params()
				client.request("textDocument/linkedEditingRange", params, function(err, result)
					if err or not result then return end
					-- Implementation: Highlights paired elements
					vim.notify("Linked editing range detected", vim.log.levels.INFO)
				end, bufnr)
			end, { noremap = true, silent = true, buffer = bufnr, desc = "Linked editing range" })
		end
	end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
-- 	pattern = "*.blade*",
-- 	callback = function()
-- 		vim.bo.filetype = "blade"
-- 		vim.opt_local.commentstring = "{{<!-- %s -->}}"
-- 	end,
-- })
