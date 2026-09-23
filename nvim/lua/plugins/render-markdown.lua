return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- markdownファイルを開いたときだけ読み込む
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- コードブロックの言語アイコン表示用
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown render" },
  },
  opts = {
    completions = { blink = { enabled = true } }, -- blink.cmpでチェックボックス・callout等を補完する
    code = {
      sign = false, -- サインカラムに言語アイコンを出さない
      width = "block", -- コードブロックの背景を行末までではなく内容の幅に合わせる
      right_pad = 1,
    },
    heading = {
      sign = false, -- サインカラムに見出しアイコンを出さない
    },
  },
}
