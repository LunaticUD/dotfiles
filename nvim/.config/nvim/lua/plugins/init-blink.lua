-- Lua/plugins/blink-cmp.lua
local function has_words_before()
	local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	"Saghen/blink.cmp",
	dependencies = {
		"xzbdmw/colorful-menu.nvim",
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		keymap = {
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-U>"] = { "scroll_documentation_up", "fallback" },
			["<C-D>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = {
				"snippet_forward",
				"select_next",
				function(cmp)
					if has_words_before() or vim.api.nvim_get_mode().mode == "c" then
						return cmp.show()
					end
				end,
				"fallback",
			},
			["<S-Tab>"] = {
				"select_prev",
				"snippet_backward",
				function(cmp)
					if vim.api.nvim_get_mode().mode == "c" then
						return cmp.show()
					end
				end,
				"fallback",
			},
		},
		fuzzy = { implementation = "lua" },
		completion = {
			list = { selection = { preselect = false } },
			-- documentation = { auto_show = true },
			ghost_text = { enabled = true },

			documentation = {
				-- enabled = true,
				auto_show = true,
				-- Delay before showing the documentation window
				auto_show_delay_ms = 800,
				window = {
					min_width = 10,
					max_width = 120,
					max_height = 20,
					border = "rounded",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					-- Note that the gutter will be disabled when border ~= 'none'
					scrollbar = true,
					-- Which directions to show the documentation window,
					-- for each of the possible menu window directions,
					-- falling back to the next direction when there's not enough space
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},
			menu = {
				border = "rounded",
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
				},
			},
		},
		-- signature = {
		-- 	enabled = true,
		-- },
		signature = {
			-- enabled = false,
			auto_show = true,
			auto_show_delay_ms = 800,
			window = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "single", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
				winblend = 0,
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
				-- Which directions to show the window,
				-- falling back to the next direction when there's not enough space,
				-- or another window is in the way
				direction_priority = { "n" },
				-- Disable if you run into performance issues
				treesitter_highlighting = true,
				show_documentation = false,
			},
		},
		cmdline = {
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = true,
				},
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
