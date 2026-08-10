local fzf = require("fzf-lua")

-- Extend default actions with Alt-i (toggle ignore) and Alt-h (toggle hidden)
local grep_actions = vim.tbl_extend("force", fzf.defaults.grep.actions, {
  ["alt-i"] = { fzf.actions.toggle_ignore },
  ["alt-h"] = { fzf.actions.toggle_hidden },
})

local files_actions = vim.tbl_extend("force", fzf.defaults.actions.files, {
  ["alt-i"] = { fzf.actions.toggle_ignore },
  ["alt-h"] = { fzf.actions.toggle_hidden },
})

fzf.setup({
  -- Global defaults
  "default",   -- or "fzf-native", "skim", etc. if you prefer

  grep = {
    actions = grep_actions,
    rg_opts = "--column --line-number --no-heading --color=always --smart-case "
      .. "--glob '!.git/**' "
      .. "--glob '!**/node_modules/**' "
      .. "--glob '!**/vendor/**' "
      .. "--glob '!package-lock.json' "
      .. "--glob '!yarn.lock' "
      .. "--glob '!lazy-lock.json'",
  },

  live_grep = {
    actions = grep_actions,
  },

  files = {
    actions = files_actions,
    file_ignore_patterns = {
      "vendor",
      "node_modules",
      "package-lock.json",
      "yarn.lock",
      "lazy-lock.json",
      "dist",
      "build",
    },
  },

  -- Optional: nicer UI
  winopts = {
    height = 0.85,
    width = 0.80,
    preview = {
      scrollbar = "float",
      scrollchars = { "█", " " },
    },
  },
})
