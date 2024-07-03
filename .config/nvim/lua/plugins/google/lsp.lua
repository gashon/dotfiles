-- Configure CiderLSP
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    -- go/cmp-nvim-ciderlsp
    { url = "sso://user/fentanes/cmp-nvim-ciderlsp" },
  },
  -- event = { "BufRead,BufNewFile" },
  opts = function(_, opts)
    local ciderlsp_config = {
      cmd = {
        "/google/bin/releases/cider/ciderlsp/ciderlsp",
        "--tooltag=nvim-lsp",
        "--noforward_sync_responses",
      },
      -- From the table at http://go/ciderlsp
      filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
        "java",
        "kotlin",
        "go",
        "python",
        "typescript",
        "typescriptreact",
        "proto",
        "textproto",
        "dart",
        "bzl",
        "cs",
        "googlesql",
        "eml",
        "mlir",
        "dataz",
        "soy",
        "graphql",

        -- CiderLSP does have some support for more filetypes that are
        -- not listed in the table above.
        "javascript",
        "javascriptreact",
        "css",
        "scss",
        "html",
        "json",
        "jslayout",
        "gcl",
        "borg",
        "markdown",
        "piccolo",
        "ncl",
        "conf",
      },
      root_dir = require("lspconfig").util.root_pattern("BUILD"),
      settings = {},
    }
    require("lspconfig.configs").ciderlsp = {
      default_config = ciderlsp_config,
    }

    local auto_format = {}
    for _, filetype in ipairs(ciderlsp_config.filetypes) do
      auto_format[filetype] = true
    end

    -- Formatting is not supported on jsx, fallback to codefmt-google or conform.nvim.
    auto_format.javascriptreact = false

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities = require("cmp_nvim_ciderlsp").update_capabilities(capabilities)
    return vim.tbl_deep_extend("force", opts, {
      servers = {
        ciderlsp = {
          capabilities = capabilities,
          auto_format = auto_format,
        },
      },
    })
  end,
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local autocmd_group = vim.api.nvim_create_augroup("lsp_autoformat", {})
    if not opts.servers or not opts.servers.ciderlsp then
      vim.notify("Unable to setup CiderLSP", vim.log.levels.WARN)
    else
      opts.servers.ciderlsp.on_attach = function(client, bufnr)
        -- TODO(b/324369022): Diagnostics don't show up when first opening a file.
        -- The below is done to remedy this, a `textDocument/didChange` call is made
        -- that gets updated diagnostics. Remove when this bug is fixed.
        client.request("textDocument/didChange", {
          textDocument = { uri = vim.uri_from_bufnr(bufnr), version = 2 },
        }, function() end)

        -- Use CiderLSP to format the buffer if enabled from this plugin's opts,
        -- AND if either codefmt-google or conform.nvim are enabled for this filetype.
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local codefmt = require("lazy.core.config").plugins["codefmt-google"]
        local codefmt_opts = require("lazy.core.plugin").values(codefmt or {}, "opts", false)
        local conform = require("lazy.core.config").plugins["conform.nvim"]
        local conform_opts = require("lazy.core.plugin").values(conform or {}, "opts", false)
        if
          opts.servers.ciderlsp.auto_format
            and opts.servers.ciderlsp.auto_format[filetype]
            and (codefmt_opts.auto_format and codefmt_opts.auto_format[filetype])
          or (conform_opts.formatters_by_ft and conform_opts.formatters_by_ft[filetype])
        then
          vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
          -- Disable formatting for codefmt.
          vim.api.nvim_buf_set_var(bufnr, "_use_ciderlsp_formatter", 1)
          vim.api.nvim_buf_set_var(bufnr, "codefmt_auto_format_buffer", 0)
          -- Disable formatting for conform.
          if conform then
            require("conform").formatters_by_ft[filetype] = nil
          end
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = autocmd_group,
            callback = function()
              vim.lsp.buf.format({ timeout_ms = 3000 })
            end,
          })
        end
      end
    end
    for server_name, server_opts in pairs(opts.servers or {}) do
      lspconfig[server_name].setup(server_opts)
    end
  end,
  keys = {
    {
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<cr>",
      desc = "Goto declaration",
    },
    {
      "gW",
      "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>",
      desc = "Search for workspace symbol",
    },
    {
      "gk",
      "<cmd>lua vim.lsp.buf.hover()<cr>",
      desc = "LSP hover",
    },
    {
      "<leader>rn",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      desc = "Rename word under cursor",
    },
    {
      "<leader>ca",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      desc = "Code Actions",
    },
    {
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<cr>",
      desc = "Goto definition",
    },
    {
      "gi",
      "<cmd>lua vim.lsp.buf.implementation()<cr>",
      desc = "Goto implementation",
    },
    {
      "gr",
      "<cmd>lua vim.lsp.buf.references()<cr>",
      desc = "Show references",
    },
    {
      "[d",
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      desc = "Goto previous diagnostic",
    },
    {
      "]d",
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      desc = "Goto next diagnostic",
    },
  },
}
