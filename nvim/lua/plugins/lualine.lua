return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "ayu_dark",
      icons_enabled = true,
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
