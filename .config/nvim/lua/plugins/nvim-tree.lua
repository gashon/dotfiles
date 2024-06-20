return {
  "nvim-tree/nvim-tree.lua",
  events = "BufWinEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    hijack_cursor = true,
    -- reload the explorer every time buffer is written
    auto_reload_on_write = true,
    sort = {
      sorter = "name",
    },
    view = {
      width = 35,
      relativenumber = true,
      cursorline = true,
      side = "left",
    },

    renderer = {
      indent_markers = {
        enable = true,
      },
      highlight_git = true,
      highlight_modified = "icon",
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
        },
      },
      indent_markers = {
        -- Display indent markers when folders are open
        enable = false,
        -- Display folder arrows in the same column as indent marker
        -- when using |renderer.icons.show.folder_arrow|
        inline_arrows = true,
        -- Icons shown before the file/directory. Length 1.
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
    },
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
      use_system_clipboard = true,
      open_file = {
        window_picker = {
          enable = false,
        },
      },
    },
    filters = {},
    git = {
      show_on_dirs = true,
      show_on_open_dirs = true,
    },
  },
  config = function(_, opts)
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup(opts)
  end,
}
