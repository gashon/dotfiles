-- https://github.com/epwalsh/obsidian.nvim

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/vaults/work",
      },
    },
  },
}
