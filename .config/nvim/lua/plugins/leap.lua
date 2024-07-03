-- https://github.com/ggandor/leap.nvim

return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  dependencies = { "tpope/vim-repeat" },
  config = function()
    require("leap").add_default_mappings()
  end,
}
