local M = {}

local root_markers = {
	".git",
	"Makefile",
	"package.json",
	"Cargo.toml",
	"go.mod",
	"go.sum",
	"composer.json",
	"composer.lock",
	"package-lock.json",
	"yarn.lock",
	"_darcs",
	".hg",
	".bzr",
	".svn",
}

local function normalize(path)
	return vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
end

local function project_root(path)
	if not path or path == "" then
		return nil
	end

	local stat = vim.uv.fs_stat(path)
	local start = stat and stat.type == "directory" and path or vim.fs.dirname(path)
	if not start then
		return nil
	end

	return vim.fs.root(start, root_markers)
end

local function add_root(roots, path)
	local root = project_root(path)
	if root then
		roots[normalize(root)] = true
	end
end

function M.roots()
	local roots = {}

	add_root(roots, vim.uv.cwd())

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name ~= "" then
			add_root(roots, name)
		end
	end

	for _, oldfile in ipairs(vim.v.oldfiles or {}) do
		if vim.uv.fs_stat(oldfile) then
			add_root(roots, oldfile)
		end
	end

	local dotfiles = vim.fn.expand("~/.dotfiles")
	if vim.uv.fs_stat(dotfiles) then
		add_root(roots, dotfiles)
	end

	local list = vim.tbl_keys(roots)
	table.sort(list)
	return list
end

function M.pick()
	local roots = M.roots()
	if #roots == 0 then
		vim.notify("No projects found", vim.log.levels.WARN)
		return
	end

	require("fzf-lua").fzf_exec(roots, {
		prompt = "Projects> ",
		actions = {
			["default"] = function(selected)
				local root = selected and selected[1]
				if not root then
					return
				end

				vim.cmd("tcd " .. vim.fn.fnameescape(root))
				require("fzf-lua").files({ cwd = root })
			end,
		},
	})
end

return M
