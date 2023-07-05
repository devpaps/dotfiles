local M = {}

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

M.on_attach = on_attach;

M.settings = {
  experimentalPostfixCompletions = true,
  analyses = {
    unusedparams = true,
    shadow = true,
  },
  staticcheck = true,
}

return M
