require("config.lazy")

vim.opt.termguicolors = true
vim.opt.mouse = ""

-- tmux(3.7)は同期出力(ESC[?2026l)を受けるたびにペイン全体を再描画し、その際の
-- 行末消去(ESC[K)でimage.nvimが表示したKittyグラフィックスの画像が消えてしまうため、
-- tmux内では同期出力を無効にする
if vim.env.TMUX then
  vim.o.termsync = false
end

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
