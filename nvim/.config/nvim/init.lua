vim.opt.rtp:prepend(vim.fn.stdpath("config"))

require("settings")
require("lsp-setup")
require("treesitter")
require("keymaps")
require("autocmds")
