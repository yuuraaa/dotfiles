require("config.lazy")

vim.opt.termguicolors = true
vim.opt.mouse = ""

-- OSC52経由でヤンクをローカルのOSクリップボードに同期する（SSH越しでも共有できる）
-- ペーストはOSC52クエリがtmux越しでは応答されないことが多いため、
-- 端末側のネイティブペースト（bracketed paste）に任せる
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
vim.opt.clipboard = "unnamedplus"

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
