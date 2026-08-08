-- lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = VimEnter,
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- アイコン表示用
  },
  config = function()
    -- netrw(標準のファイラ)を無効化しておく(公式推奨)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
	side = "right",
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            git = true,
            folder = true,

            file = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- true にすると隠しファイルを非表示
      },
      git = {
        enable = true,
      },
      actions = {
        open_file = {
          quit_on_open = true, -- ファイルを開いたときツリーを閉じるか
        },
      },
    })

    -- キーマップ例
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "NvimTree toggle" })
    vim.keymap.set("n", "<leader>o", api.tree.focus, { desc = "NvimTree focus" })
  end,
}
