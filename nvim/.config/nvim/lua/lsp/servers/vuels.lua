local M = {}

M.filetypes = {
  "vue"
}

M.init_options = {
  config = {
    css = {},
    emmet = {},
    html = {
      suggest = {}
    },
    javascript = {
      format = {}
    },
    stylusSupremacy = {},
    typescript = {
      format = {
        enable = true
      }
    },
    vetur = {
      completion = {
        autoImport = true,
        tagCasing = "kebab",
        useScaffoldSnippets = true
      },
      format = {
        defaultFormatter = {
          html = "none",
          js = "prettier",
          ts = "prettier",
        },
        -- defaultFormatterOptions = {},
        -- scriptInitialIndent = false,
        -- styleInitialIndent = false
      },
      useWorkspaceDependencies = false,
      validation = {
        script = true,
        style = true,
        template = true,
        templateProps = true,
        interpolation = true
      },
      exprimental = {
        templateInterpolationService = true
      }
    }
  }
}

local on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end


M.on_attach = on_attach;

return M
