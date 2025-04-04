local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- require("lazyvim.config").init()
require("lazy").setup({
  spec = {
    { import = "plugins" },
    -- Load google plugins
    -- { import = "plugins.google" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = false },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
