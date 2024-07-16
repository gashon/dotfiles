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
    notify_on_error = true,
    -- blocking format on save, todo use format_after_save for async
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      -- Used in config.commands
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 500,
        lsp_fallback = true,
        async = false,
        quiet = false,
      }
    end,
    -- Define formatters
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "goimports", "gofmt" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
    },
    -- Customize formatters
    formatters = {},
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
  end,
}
