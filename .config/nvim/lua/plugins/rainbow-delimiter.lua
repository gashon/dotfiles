return {
  "HiPhish/rainbow-delimiters.nvim",
  opts = {
    -- strategy = {
    --   [""] = require("rainbow_delimiters").strategy["global"],
    --   vim = require("rainbow_delimiters").strategy["local"],
    -- },
    query = {
      [""] = "rainbow-delimiters",
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
    require("rainbow-delimiters").setup(opts)
  end,
}
