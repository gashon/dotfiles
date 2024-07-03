-- Auto completion
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    -- go/luasnip-google
    {
      url = 'sso://user/mccloskeybr/luasnip-google.nvim',
      dependencies = {
        {
          "L3MON4D3/LuaSnip",
          build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require('luasnip-google').load_snippets()
      end,
    },

    -- Add autocomplete when typing b/, BUG=, and FIXED=
    -- go/cmp-buganizer
    {
      url = "sso://user/vicentecaycedo/cmp-buganizer",
      dependencies = { "nvim-lua/plenary.nvim" },
      cond = function()
        return vim.fn.executable("bugged") == 1
      end,
    },
  },
  event = "InsertEnter",
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local luasnip = require("luasnip")
    local cmp = require("cmp")
    return vim.tbl_deep_extend("force", opts, {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        -- If nothing is selected, add a newline.
        -- If something is explicitly selected, select it.
        ["<cr>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
        -- Select with <down> and <up>, and if no entry is selected, will confirm the first item
        ["<down>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end),
        ["<up>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
          else
            fallback()
          end
        end),
        ["<c-u>"] = cmp.mapping.scroll_docs(-4),
        ["<c-d>"] = cmp.mapping.scroll_docs(4),
        -- Navigate snippets with <tab> and <s-tab>
        ["<tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.jump(1)
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<s-tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = {
        { name = "nvim_ciderlsp", priority = 30 },
        { name = "nvim_lsp",      priority = 20 },
        { name = "luasnip",       priority = 10 },
        { name = "buffer",        priority = 1 },
        { name = "path",          priority = 1 },
        {
          name = 'buganizer',
          option = { notifications_enabled = true }
        },
        { name = "nvim_lsp_signature_help" },
      },
      formatting = {
        format = {
          menu = {
            nvim_ciderlsp = "(CiderLSP)",
            nvim_lsp = "(LSP)",
            nvim_lsp_signature_help = "󰊕",
            luasnip = "(LuaSnip)",
            buffer = "(Buffer)",
            path = "(Path)",
          },
        },
      },
      sorting = {
        comparators = {
          -- Default comparators for nvim-cmp
          -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/default.lua#L67-L78
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          -- cmp.config.compare.scopes,
          cmp.config.compare.score,
          -- Rank items that start with "_", lower. i.e. private fields and methods.
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          -- cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        }
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    local format_menu = opts.formatting.format.menu
    cmp.setup(vim.tbl_deep_extend("force", opts, {
      sources = cmp.config.sources(opts.sources),
      formatting = {
        format = function(entry, item)
          item.menu = format_menu[entry.source.name]
          return item
        end
      }
    }))
  end,
}
