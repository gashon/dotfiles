-- formatter
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    -- Define formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true, async = false, quiet = false },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
