return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "ayu_dark",
      icons_enabled = true,
    },
    sections = {
      lualine_a = {},
      lualine_b = {}, 
      lualine_c = {
      lualine_c = {
        {
          "filename",
          path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = {}, 
      lualine_y = {},
      lualine_z = {},
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
