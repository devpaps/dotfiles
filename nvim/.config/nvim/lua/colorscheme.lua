local status_ok, _ = pcall(vim.cmd, "colorscheme " .. M42.colorscheme)

if not status_ok then
  vim.notify("colorscheme " .. M42.colorscheme .. " not found!")
  return
end
