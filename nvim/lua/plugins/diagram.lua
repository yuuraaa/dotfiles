return {
  "3rd/diagram.nvim",
  ft = { "markdown" },
  dependencies = { "3rd/image.nvim" },
  keys = {
    {
      "<leader>md",
      function() require("diagram").show_diagram_hover() end,
      ft = "markdown",
      desc = "Show Mermaid diagram in tab",
    },
  },
  opts = function()
    return {
      integrations = {
        require("diagram.integrations.markdown"),
      },
      renderer_options = {
        mermaid = {
          cli_args = { "-p", vim.fn.stdpath("config") .. "/mermaid-puppeteer.json" },
        },
      },
    }
  end,
}
