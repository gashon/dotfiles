-- https://github.com/akinsho/git-conflict.nvim
-- autocommand conflict detection in config.commands

-- default mapping
-- co — choose ours
-- ct — choose theirs
-- cb — choose both
-- c0 — choose none
-- ]x — move to previous conflict
-- [x — move to next conflict

return { "akinsho/git-conflict.nvim", version = "*", config = true, default_mappings = true }
