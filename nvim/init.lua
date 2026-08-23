require("config.lazy")

vim.opt.termguicolors = true
vim.opt.mouse = ""

vim.o.autoread = true
vim.o.updatetime = 1000

vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
  pattern = "*",
  command = "checktime",
})
