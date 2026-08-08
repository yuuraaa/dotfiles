return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy", -- 起動直後の重い処理が終わってから遅延読み込みする
  keys = {
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<leader>bd", ":bd<cr>" }
  },
  opts = {
    options = {
      mode = "buffers", -- 開いているバッファを1つずつタブとして表示する
      diagnostics = "nvim_lsp", -- 各バッファ名の横にLSPの診断（エラー・警告数）を表示する
      always_show_bufferline = false, -- バッファが1つしかなくても常にバーを表示する
      show_buffer_close_icons = false, -- 各バッファタブに閉じるアイコン(×)を表示する
      show_close_icon = false, -- バー右端の「すべて閉じる」アイコンは表示しない
    },
  },
}
