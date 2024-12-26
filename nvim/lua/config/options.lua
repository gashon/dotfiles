vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.shell = "zsh"

vim.opt.wrap = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true -- highlight current line

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.showcmd = true

vim.opt.cmdheight = 2
vim.opt.scrolloff = 10

vim.opt.smarttab = true
vim.opt.ignorecase = true -- case insensitive unless capital in search or /C
vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows above
vim.opt.splitkeep = "cursor"

vim.opt.mouse = "a" -- enable mouse in all modes

-- vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
-- vim.opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
vim.opt.clipboard:append("unnamedplus")

vim.g.nvim_tree_lsp_diagnostics = 1 -- show lsp diagnostics in nvim-tree
vim.g.nvim_tree_git_hl = 1 -- show git status in nvim-tree

-- required for obsidian.nvim (https://github.com/epwalsh/obsidian.nvim/issues/286)
vim.opt.conceallevel = 1

-- vim.g.clipboard = {
--   name = "xclip",
--   copy = {
--     ["+"] = "xclip -selection clipboard -i",
--     ["*"] = "xclip -selection clipboard -i",
--   },
--   paste = {
--     ["+"] = "xclip -selection clipboard -o",
--     ["*"] = "xclip -selection clipboard -o",
--   },
--   cache_enabled = 0,
-- }
