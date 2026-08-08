-- ~/.config/nvim/lua/plugins/dashboard.lua
--
-- alpha-nvim: 自分でレイアウトを組み立てるタイプのダッシュボードプラグイン
-- https://github.com/goolord/alpha-nvim
--
-- 基本構造:
--   dashboard.section.header  -> 上部のロゴ/文字
--   dashboard.section.buttons -> 中央のメニュー(キー押下でコマンド実行)
--   dashboard.section.footer  -> 下部のテキスト
--   3つを opts.layout に並べる、という組み立て方をします。

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter", -- Neovim起動時、ファイルを開かず起動した場合に発火
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- アイコン表示用

    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      -- ① ヘッダー(ロゴ部分)
      -- 文字列の配列。1要素=1行。好きな文字列/ASCIIアートに差し替え可能
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      -- ② ボタン(中央のメニュー項目)
      -- dashboard.button(キー, 表示文字列, 実行コマンド) という形式
      -- 実行コマンドは通常の :コマンド をそのまま文字列で書けばOK
      local separator = {
        type = "text",
        val = string.rep("―", 50),
        opts = {
          pattern = "center",
          h1 = "Comment"
        }
      }

      local file_group = {
        dashboard.button("f", "  Find file",       ":FzfLua files<CR>"),
        dashboard.button("g", "  Find text",       ":FzfLua live_grep<CR>"),
        dashboard.button("n", "  New file",        ":ene <BAR> startinsert<CR>"),
      }

      local other_group = {
        dashboard.button("l", "  Lazy",             ":Lazy<CR>"),
        dashboard.button("p", "󰁦  Plugins Setting",  ":FzfLua files cwd=~/.config/nvim/lua/plugins<CR>"),
        dashboard.button("q", "  Quit",             ":qa<CR>"),
      }

      local buttons = {}
      vim.list_extend(buttons, file_group)
      table.insert(buttons, separator)
      vim.list_extend(buttons, other_group)

      dashboard.section.buttons.val = buttons

      -- ③ フッター(下部の一言)。起動プラグイン数などを表示する例
      dashboard.section.footer.val = function()
        local ok, lazy = pcall(require, "lazy")
        if not ok then
          return ""
        end
        local stats = lazy.stats()
        return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded"
      end

      -- ④ 見た目の微調整(任意)
      -- ボタンごとの上下余白
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "Function"
        button.opts.hl_shortcut = "Type"
      end
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.footer.opts.hl = "Comment"

      -- 各セクション間の余白(お好みで数値を増減してください)
      dashboard.opts.layout[1].val = 4 -- ヘッダー上部の空行数

      return dashboard.opts
    end,

    config = function(_, opts)
      -- alpha自体は自動読み込みされないプラグインなので、明示的にsetupを呼ぶ
      require("alpha").setup(opts)
    end,
  },
}
