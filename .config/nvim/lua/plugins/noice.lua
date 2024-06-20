return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  opts = {
    background_colour = "#000000",
    cmdline = {
      enabled = true,
      view = "cmdline_popup",
    },
    message = { enabled = true, view = "notify" },
    popupmenu = {
      enabled = true,
      backend = "nui",
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    require("notify").setup({
      stages = "slide",
      render = "minimal",

      background_colour = "#1E1E1E", -- Darker background
    })

    -- dismiss keymap is in config.keymaps
  end,
}
