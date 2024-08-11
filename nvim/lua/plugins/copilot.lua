return {
  "github/copilot.vim",
  event = "BufRead",
  enabled = "true",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
