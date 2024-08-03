return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "flake8" },
        lua = { "luacheck" },
        typescript = { "eslint" },
        markdown = { "vale" },
        go = { "golangci-lint" },
        sh = { "shellcheck" },
        rust = { "rust-clippy" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft

      -- Auto-lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
