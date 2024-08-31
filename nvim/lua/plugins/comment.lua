return {
  -- ts-comments.nvim preferred over Comment.nvim as it is more feature rich and support jsx + tsx
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    -- enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
