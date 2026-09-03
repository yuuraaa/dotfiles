-- lua/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "saghen/blink.cmp" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "vtsls", "basedpyright" },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      vim.lsp.config("vtsls", {
        capabilities = capabilities,
        root_markers = { "tsconfig.json", "package.json", ".git" },
      })

      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        settings = {
          basedpyright = {
            analysis = {
              -- 仮想環境のパスを明示したい場合はここで指定
              -- venvPath = ".",
              -- venv = ".venv",
            },
          },
        },
      })

      vim.lsp.enable({ "vtsls", "basedpyright" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },
}
