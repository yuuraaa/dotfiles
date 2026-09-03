-- lua/plugins/blink-cmp.lua
return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = { preset = "default" },
    completion = {
      menu = { auto_show = true },
      documentation = { auto_show = true },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
