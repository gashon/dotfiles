local M = {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "macchiato",
		transparent_background = true,
		styles = {
			keywords = { "bold" },
			functions = { "italic" },
		},
		integrations = {
			mason = true,
			neotree = false,
			neotest = true,
			which_key = true,
			neogit = false,
			nvimtree = true,
			rainbow_delimiters = false,
			dap = { enabled = true, enable_ui = true },
			telescope = { enabled = true, style = nil },
		},
		custom_highlights = function(colors)
			return {
				-- custom
				PanelHeading = {
					fg = colors.lavender,
					bg = colors.none,
					style = { "bold", "italic" },
				},

				-- lazy.nvim
				LazyH1 = {
					bg = colors.none,
					fg = colors.lavender,
					style = { "bold" },
				},
				LazyButton = {
					bg = colors.none,
					fg = colors.overlay0,
				},
				LazyButtonActive = {
					bg = colors.none,
					fg = colors.lavender,
					style = { " bold" },
				},
				LazySpecial = { fg = colors.sapphire },

				CmpItemMenu = { fg = colors.subtext1 },
				MiniIndentscopeSymbol = { fg = colors.overlay0 },

				FloatBorder = {
					fg = colors.overlay1,
					bg = colors.none,
				},

				FloatTitle = {
					fg = colors.lavender,
					bg = colors.none,
				},
			}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)

		vim.cmd.colorscheme("catppuccin")
	end,
}

return M
