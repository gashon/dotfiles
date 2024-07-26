return {
  {

    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
      pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob",
            "!**/.git/*",
            "--glob",
            "!**/.idea/*",
            "--glob",
            "!**/.vscode/*",
            "--glob",
            "!**/build/*",
            "--glob",
            "!**/dist/*",
            "--glob",
            "!**/yarn.lock",
            "--glob",
            "!**/package-lock.json",
          },
        },
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
    end,
  },
}
