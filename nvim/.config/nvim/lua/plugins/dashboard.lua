local icons = M42.icons
local dashboard = require('dashboard')

dashboard.custom_header = {
  "                                                                                      ",
  "                                                                                      ",
  "                                                                                      ",
  "  ooooooooo                                                                           ",
  "   888    88o  ooooooooo8 oooo   oooo ooooooooo     ooooooo  ooooooooo    oooooooo8   ",
  "   888    888 888oooooo8   888   888   888    888   ooooo888  888    888 888ooooooo   ",
  "   888    888 888           888 888    888    888 888    888  888    888         888  ",
  "  o888ooo88     88oooo888     888      888ooo88    88ooo88 8o 888ooo88   88oooooo88   ",
  "                                       o888                   o888                    ",
  "                                                                                      ",
  "                                                                                      ",
  "                                                                                      ",
}

local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
-- vim.g.dashboard_session_directory = '~/.config/nvim/sessions'
-- vim.g.dashboard_default_executive = 'telescope'
-- dashboard.custom_center = {
--   -- {icon = {icons.fileNoBg ..            'Find File          '}, desc = 'Telescope find_files hidden=true'},
--   -- {icon = {icons.fileBg ..              'New File           '}, desc = 'DashboardNewFile'},
--   -- {icon = {icons.search ..              'Find Word          '}, desc = 'Telescope live_grep'},
--   -- {icon = {icons.hexCutOut ..           'Recents            '}, desc = 'Telescope oldfiles hidden=true'},
--   -- {icon = {icons.fileCopy ..            'Load Last Session  '}, desc = 'SessionLoad'},
--   -- {icon = {icons.light ..               'Sync Plugins       '}, desc = 'PackerSync'},
--   -- {icon = {icons.snippet ..             'Install Plugins    '}, desc = 'PackerInstall'},
--   -- {icon = {icons.settings ..            'Settings           '}, desc = 'edit $MYVIMRC'},
--   -- {icon = {icons.warningTriangle ..     'Exit               '}, desc = 'exit'},
--   { icon = { icons.fileCopy }, desc = 'Recently latest session                  ', shortcut = 'SPC s l', action = 'SessionLoad' },
--   -- { icon = { icons.fileNoBg }, desc = 'Find File               ', shortcut = 'SPC some', action = 'Telescope find_files hidden=true' },
-- }

dashboard.custom_center = {
  { icon = icons.hexCutOut,
    desc = 'Recent        ',
    action = 'Telescope oldfiles hidden=false' },
  { icon = icons.fileCopy,
    desc = 'Load Last Session        ',
    action = 'SessionLoad' },
  { icon = icons.light,
    desc = 'Sync Plugins        ',
    action = 'PackerSync' },
  { icon = icons.snippet,
    desc = 'Install Plugins       ',
    action = 'PackerInstall' },
  { icon = icons.settings,
    desc = 'Settings       ',
    action = 'edit $MYVIMRC' },
  { icon = icons.warningTriangle,
    desc = 'Exit        ',
    action = 'exit' },
}

dashboard.custom_footer = { icons.container .. plugins_count .. " plugins loaded" }
