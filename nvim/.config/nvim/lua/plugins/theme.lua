return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			no_italic = true,

			custom_highlights = function(colors)
			-- stylua: ignore
			return {
			  LineNr     = { fg = colors.surface2 },
			  Visual     = { bg = colors.overlay0 },
			  Search     = { bg = colors.surface2 },
			  IncSearch  = { bg = colors.mauve },
			  CurSearch  = { bg = colors.mauve },
			  Comment = { 
				  fg = colors.flamingo,
				  bold = true,
				  underline = false
			},
			  MatchParen = { bg = colors.mauve, fg = colors.base, bold = true },
			}
			end,
			integrations = {
				-- barbar = true,
				blink_cmp = true,
				-- gitsigns = true,
				mason = true,
				noice = true,
				-- nvimtree = true,
				-- rainbow_delimiters = true,
				snacks = {
					enabled = true,
					indent_scope_color = "flamingo", -- catppuccin color (eg. `lavender`) Default: text
				},
				-- which_key = true,
				-- flash = true,
				-- lsp_trouble = true,
			},
		},
		-- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		-- 	comments = { "bold", "underline" }, -- Change the style of comments
		-- },
		-- -- config = function(_, opts)
		-- -- 	require("catppuccin").setup(opts)
		-- --
		-- -- 	vim.cmd.colorscheme("catppuccin")
		-- -- end,
	},
}
