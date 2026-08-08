-- ~/.config/nvim/lua/plugins/fzf-lua.lua
--
-- fzf-lua: fzfベースの高速ファジーファインダー
-- https://github.com/ibhagwan/fzf-lua
--
-- 前提(あると快適に動く。無くても動くが精度/速度が落ちる):
--   - fd  (ファイル探索。前に話した find_files 高速化と同じ役割)
--   - ripgrep (rg)  (テキスト検索用。 live_grep で使われる)
--
-- インストール例:
--   macOS:   brew install fd ripgrep
--   Ubuntu:  sudo apt install fd-find ripgrep
--   Arch:    sudo pacman -S fd ripgrep

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- アイコン表示(任意だが見た目が良くなる)
    cmd = "FzfLua", -- :FzfLua系のコマンドを打った時に初めて読み込む(起動を軽くするため)
    opts = {
      -- ここはお好みで。まずはデフォルトのままで十分動きます
      winopts = {
        height = 0.85,
        width = 0.80,
      },
      files = {
        actions = {
          ["ctrl-e"] = {
            fn = function(selected, opts)
              -- field_index="{q}" により selected[1] にプロンプトの入力文字列が入る
              local query = (selected and selected[1]) or opts.last_query
              if query and query ~= "" then
                local path = (opts.cwd and (opts.cwd .. "/") or "") .. query
                vim.cmd("edit " .. vim.fn.fnameescape(path))
              end
            end,
            field_index = "{q}",
          },
        },
      },
      keymap = {
        builtin = {
          ["<C-j>"] = "preview-page-down",
	  ["<C-k>"] = "preview-page-up",
	},
      },
    },
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    keys = {
      -- 普段使い用のキーマップも一緒に設定しておくと便利
      { "<leader>ff", "<cmd>FzfLua files<cr>",       desc = "Find Files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",   desc = "Find Text (grep)" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>",    desc = "Recent Files" },
    },
  },
}
