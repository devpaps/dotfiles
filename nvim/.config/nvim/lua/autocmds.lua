vim.api.nvim_create_augroup("AutoUpdatePlugins", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = 'AutoUpdatePlugins' })

vim.api.nvim_create_augroup("Highlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", { command = "silent! lua vim.highlight.on_yank() {higroup='IncSearch', timeout=400}", group = 'Highlight' })

vim.api.nvim_create_augroup("LspNodeModules", { clear = true })
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)", group = 'LspNodeModules' })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)", group = 'LspNodeModules' })

vim.cmd("command! EslintFixAll lua RunEslintFixAll()")

function RunEslintFixAll()
    local job_id = vim.fn.jobstart({"eslint", "--fix", vim.fn.expand("%")}, {
        on_exit = function(j, exit_code, event)
            if exit_code == 0 then
                vim.cmd("e")
            else
                print("ESLint failed. Exit code:", exit_code)
            end
        end,
        detach = true
    })
end

vim.api.nvim_create_augroup("Eslint", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.vue",
    command = "EslintFixAll",
    group = "Eslint"
})


-- vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", { command = "lua vim.lsp.buf.format()", group = 'FormatOnSave' })
