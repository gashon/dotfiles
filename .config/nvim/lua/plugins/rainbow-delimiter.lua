return {
  "HiPhish/rainbow-delimiters.nvim",
  opts = {
    query = {
      lua = "rainbow-blocks",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  },
  config = function(_, opts)
    require("rainbow-delimiters.setup").setup(opts)
  end,
}
