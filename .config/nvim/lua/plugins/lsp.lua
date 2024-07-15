return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  opts = {
    --opts for mason-lspconfig.nvim
    ensure_installed = {
      "rust_analyzer",
      "pyright",
      "tsserver",
      "clangd",
      "gopls",
      "lua_ls",
      "sqlls",
    },
    automatic_installation = true,
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup(opts)

    lspconfig.rust_analyzer.setup({})
    lspconfig.pyright.setup({})
    lspconfig.tsserver.setup({})
    lspconfig.gopls.setup({})
    lspconfig.clangd.setup({})
    lspconfig.lua_ls.setup({})
    lspconfig.sqlls.setup({})
  end,
}
