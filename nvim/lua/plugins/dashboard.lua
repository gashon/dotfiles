return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    init = function()
      vim.cmd([[hi DashboardHeader guifg=#ee872d gui=bold]])
      vim.cmd([[hi DashboardProjectTitle guifg=#d55fde gui=bold]])
      vim.cmd([[hi DashboardProjectIcon guifg=#89ca78]])
      vim.cmd([[hi DashboardMruTitle guifg=#d55fde gui=bold]])
      vim.cmd([[hi DashboardShortCut guifg=#89ca78 gui=bold]])
    end,
    opts = {
      theme = "doom",
      preview = {
        -- command = "chafa --relative on --passthrough tmux -f kitty -s 60x60 -c full --fg-only --symbols braille --clear",
        -- file_path = '$(ls ' .. home .. '/.config/nvim/static/*.gif | sort -R)',
        -- file_path = os.getenv("HOME") .. "/.config/nvim/static/dashboard.webp",
        -- bug: overflow/descending image occurs when the size is too large
        -- wedge, braille, block, wide are the best symbols
        command = "chafa --animate on --color-space rgb -f kitty -c none --passthrough tmux -s 35x40 --fg-only --clear --symbols braille -f symbols",
        -- file_path = "/home/gashon/Downloads/dog-meme.jpeg",
        file_path = os.getenv("HOME") .. "/.config/nvim/static/braille.gif",
        -- file_path = "/home/gashon/Downloads/head3.gif",
        file_height = 24,
        file_width = 35,
      },
      config = {
        -- header = {
        --   [[]],
        --   [[░░░░░░░░░░░░░▄▄▄▄▄▄▄░░░░░░░░░]],
        --   [[░░░░░░░░░▄▀▀▀░░░░░░░▀▄░░░░░░░]],
        --   [[░░░░░░░▄▀░░░░░░░░░░░░▀▄░░░░░░]],
        --   [[░░░░░░▄▀░░░░░░░░░░▄▀▀▄▀▄░░░░░]],
        --   [[░░░░▄▀░░░░░░░░░░▄▀░░██▄▀▄░░░░]],
        --   [[░░░▄▀░░▄▀▀▀▄░░░░█░░░▀▀░█▀▄░░░]],
        --   [[░░░█░░█▄░░░░█░░░▀▄░░░░░▐░█░░░]],
        --   [[░░▐▌░░█▀░░░▄▀░░░░░▀▄▄▄▄▀░░█░░]],
        --   [[░░▐▌░░█░░░▄▀░░░░░░░░░░░░░░█░░]],
        --   [[░░▐▌░░░▀▀▀░░░░░░░░░░░░░░░░▐▌░]],
        --   [[░░▐▌░░░░░░░░░░░░░░░▄░░░░░░▐▌░]],
        --   [[░░▐▌░░░░░░░░░▄░░░░░█░░░░░░▐▌░]],
        --   [[░░░█░░░░░░░░░▀█▄░░▄█░░░░░░▐▌░]],
        --   [[░░░▐▌░░░░░░░░░░▀▀▀▀░░░░░░░▐▌░]],
        --   [[░░░░█░░░░░░░░░░░░░░░░░░░░░█░░]],
        --   [[░░░░▐▌▀▄░░░░░░░░░░░░░░░░░▐▌░░]],
        --   [[░░░░░█░░▀░░░░░░░░░░░░░░░░▀░░░]],
        --   [[]],
        -- },
        center = {
          {
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            icon = " ", --
            desc = " Files",
            group = "Label",
            key = "f",
            action = "Telescope find_files",
          },
          {
            desc = "  Find text",
            group = "@property",
            key = "g",
            action = "Telescope live_grep ",
          },
          {
            desc = "Lazy",
            group = "DiagnosticHint",
            key = "l",
            action = "Lazy",
          },
          {
            desc = "  Config",
            group = "DiagnosticHint",
            key = "c",
            action = "e $MYVIMRC ",
          },

          {
            desc = " Recent files",
            group = "",
            key = "r",
            action = "Telescope oldfiles ",
          },
          {
            desc = "  Quit",
            group = "Number",
            key = "q",
            action = "qa",
          },
          -- {
          --     desc = "󰊳 Update",
          --     group = "@property",
          --     key = "u",
          --     action = "Lazy update",
          -- },
          -- {
          --     icon="",
          --     icon_hl = "@variable",
          --     desc = "Apps",
          --     group = "DiagnosticHint",
          --     key = "a",
          --     action = "Telescope app",
          -- },
          -- {
          --     desc = " dotfiles",
          --     group = "Number",
          --     key = "d",
          --     action = "Telescope dotfiles",
          -- },
        },
      },
      hide = {
        statusline = true, -- hide statusline default is true
        tabline = false, -- hide the tabline
        winbar = true, -- hide winbar
      },
    },
  },
}
