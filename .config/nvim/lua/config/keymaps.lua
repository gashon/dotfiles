local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-x>", { desc = "Split window horizontall" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- telescope
local builtin = require("telescope.builtin")
keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Open telescope find files modal" })
keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Open ripgrep modal" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "View all telescope buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- nvim tree
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

-- lsp (mason)
-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local opts = { buffer = 0, silent = true }
keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
keymap.set("n", "gd", vim.lsp.buf.definition, opts)
keymap.set("n", "K", vim.lsp.buf.hover, opts)
keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
-- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
keymap.set("n", "<C-k>", vim.lsp.buf.type_definition, opts)
keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
keymap.set("n", "gr", vim.lsp.buf.references, opts)

-- Noice
-- add kepmap to dismiss the noice popup
keymap.set("n", "<C-d>", "<cmd>Noice dismiss<cr>", { noremap = true, silent = true })

--UndoTree
keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap = true, silent = true })
