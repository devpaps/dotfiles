local on_windows = vim.loop.os_uname().version:match("Windows")

local function join_paths(...)
    local path_sep = on_windows and "\\" or "/"
    local result = table.concat({ ... }, path_sep)
    return result
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir
if on_windows then
    temp_dir = vim.loop.os_getenv("TEMP")
else
    temp_dir = "/tmp"
end

vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))

local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls_config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting
    null_ls.setup({
        sources = {
            formatting.prettier,
        },
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = vim.lsp.buf.formatting_sync,
                })
            end
        end,

        debug = true,
    })
end

local function load_plugins()
    require("packer").startup({
        {
            "wbthomason/packer.nvim",
            {
                "jose-elias-alvarez/null-ls.nvim",
                requires = { "nvim-lua/plenary.nvim" },
                config = null_ls_config,
            },
        },
        config = {
            package_root = package_root,
            compile_path = compile_path,
        },
    })
end

if vim.fn.isdirectory(install_path) == 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
    load_plugins()
    require("packer").sync()
else
    load_plugins()
    require("packer").sync()
end
