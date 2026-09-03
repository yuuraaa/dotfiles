require("config.lazy")

vim.opt.termguicolors = true
vim.opt.mouse = ""

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.o.autoread = true
vim.o.updatetime = 1000

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})
