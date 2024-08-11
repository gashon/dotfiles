return {
  "nvim-telescope/telescope.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "smartpde/telescope-recent-files",
    -- go/telescope-codesearch
    { url = "sso://user/vintharas/telescope-codesearch.nvim" },
    -- go/telescope-citc
    { url = "sso://user/aktau/telescope-citc.nvim" },
    -- go/neocitc
    { url = "sso://team/neovim-dev/neocitc" },
  },
  config = function(_, opts)
    -- Load recent_files extension to start recording files opened in current session.
    require("telescope").load_extension("recent_files")
    require("telescope").setup(opts)
  end,
  cmd = { "Telescope" },
  opts = {
    defaults = {
      -- The vertical layout strategy is good to handle long paths like those in
      -- google3 repos because you have nearly the full screen to display a file path.
      -- The caveat is that the preview area is smaller.
      layout_strategy = "vertical",
      -- Common paths in google3 repos are collapsed following the example of Cider
      -- It is nice to keep this as a user config rather than part of
      -- telescope-codesearch because it can be reused by other telescope pickers.
      path_display = function(opts, path)
        -- Do common google3 substitutions
        path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/google3/", "google3/", 1)
        path = path:gsub("^/google/src/cloud/[^/]+/[^/]+/", "depot/", 1)
        path = path:gsub("^google3/java/com/google/", "g3/j/c/g/", 1)
        path = path:gsub("^google3/javatests/com/google/", "g3/jt/c/g/", 1)
        path = path:gsub("^google3/third_party/", "g3/3rdp/", 1)
        path = path:gsub("^google3/", "g3/", 1)

        -- Do truncation. This allows us to combine our custom display formatter
        -- with the built-in truncation.
        -- `truncate` handler in transform_path memoizes computed truncation length in opts.__length.
        -- Here we are manually propagating this value between new_opts and opts.
        -- We can make this cleaner and more complicated using metatables :)
        local new_opts = {
          path_display = {
            truncate = true,
          },
          __length = opts.__length,
        }
        path = require("telescope.utils").transform_path(new_opts, path)
        opts.__length = new_opts.__length
        return path
      end,
    },
    extensions = {
      codesearch = {
        experimental = false,
      },
      citc = {
        -- Ignore files that can appear during merge conflicts.
        ignore_files_match = "%.orig$",
        -- Use default telescope entry_maker so that our custom `path_display` function
        -- from above is used.
        entry_maker = function(...)
          return require("telescope.make_entry").gen_from_file()(...)
        end,
      },
      recent_files = {
        -- This function rewrites all file paths to the current workspace.
        -- For example, if w2 is the current workspace, then
        -- /google/.../w1/google3/my_file.cc becomes /google/.../w2/google3/my_file.cc,
        transform_file_path = function(file)
          return require("neocitc").path_in_current_workspace(file)
        end,
        -- This is a useful option to speed up Telescope by avoiding the check
        -- for file existence.
        stat_files = false,
        -- Ignore common patterns that can show up from other google plugins
        ignore_patterns = {
          "/%.git/COMMIT_EDITING$",
          "/%.git/COMMIT_EDITMSG$",
          "/%.git/MERGE_MSG$",
          "^/tmp/%.pipertmp-",
          "/Related_Files$",
          "^term:",
          ";#toggleterm#",
        },
      },
    },
  },
  keys = {
    { "<leader>s", desc = "Search" },
    --- Codesearch queries
    {
      "<leader>ss",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{}<cr>",
      desc = "Codesearch",
    },
    {
      "<leader>se",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{default_text_expand='f:'..vim.fn.getcwd():gsub('^.*/google3/?', '')..' '}<cr>",
      desc = "Codesearch for text in current directory",
    },
    {
      "<leader>sW",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{default_text='trait:citc '}<cr>",
      desc = "Codesearch in current citc workspace",
    },
    {
      "<leader>sD",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{default_text='\\\\b'..vim.fn.expand('<cword>')..'\\\\b'}<cr>",
      desc = "Codesearch for word under the cursor",
    },
    {
      "<leader>sD",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{}<cr>",
      mode = "v",
      desc = "Codesearch for selected text",
    },
    {
      "<leader>sS",
      "<cmd>lua require('telescope').extensions.codesearch.find_query{default_text='f:'..vim.fn.expand('<cword>')}<cr>",
      desc = "Codesearch for a file that matches the word under the cursor",
    },
    -- Show modified files in citc workspace.
    -- If not in a citc, try to show modified files for git.
    {
      "<leader>sw",
      function()
        if string.find(vim.fn.getcwd(-1, -1), "/google/src/cloud") == 1 then
          require("telescope").extensions.citc.modified({ show_relative_paths = true })
        else
          require("telescope.builtin").git_status()
        end
      end,
      desc = "Search modified files",
    },
    {
      "<leader>sc",
      "<cmd>lua require('telescope').extensions.citc.workspaces()<cr>",
      desc = "Search citc workspaces",
    },
    -- Recent files
    {
      "<leader>sr",
      "<cmd>lua require('telescope').extensions.recent_files.pick()<cr>",
      desc = "Search for recently opened files",
    },
  },
}
