return {
  dir = vim.fn.stdpath("config") .. "/crev.nvim",
  cmd = { "Crev", "CrevLast", "CrevCommit", "CrevNoCommit", "CrevOpen" },
  opts = {},
}
