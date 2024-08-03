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
      "yamlls",
    },
    automatic_installation = true,
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local util = require("lspconfig/util")

    require("mason").setup()
    require("mason-lspconfig").setup(opts)

    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      -- Mappings.
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    end

    -- Configure Pyright for better Python support
    lspconfig.pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
      root_dir = function(fname)
        return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
          or util.path.dirname(fname)
      end,
    })

    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            allFeatures = true,
            command = "clippy",
          },
        },
      },
    })
    lspconfig.tsserver.setup({ on_attach = on_attach })
    lspconfig.gopls.setup({ on_attach = on_attach })
    lspconfig.clangd.setup({ on_attach = on_attach })
    lspconfig.lua_ls.setup({ on_attach = on_attach })
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      settings = {
        yaml = {
          format = { enable = true },
          validate = true,
          schemas = {
            kubernetes = "/*.yaml",
            ["http://json.schemastore.org/kustomization"] = "/kustomization.yaml",
          },
        },
      },
    })
  end,
}
