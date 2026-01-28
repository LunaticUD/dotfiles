return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",

		opts = {
			background_colour = "#FFFFFF",

			-- ===========================
			-- Cmdline UI（你的原本配置）
			-- ===========================
			cmdline = {
				enabled = true,
				view = "cmdline",
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = " ", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = {
						pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
						icon = "",
						lang = "lua",
					},
					help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
					input = { view = "cmdline_input", icon = "󰥻 " },
				},
			},

			-- ===========================
			-- 视图设置（你的原本 + presets）
			-- ===========================
			views = {
				cmdline_popup = {
					position = { row = 1, col = math.floor(vim.fn.winwidth(0) / 2) - 40 },
					size = { width = 80, height = "auto" },
				},
			},
			-- popupmenu = {
			--   enabled = false,
			-- },
			notify = {
				enabled = false,
			},
			-- ===========================
			-- LSP 文档增强
			-- ===========================
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},

			-- ===========================
			-- Noice 预置 UI（非常实用）
			-- ===========================
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},

			-- ===========================
			-- 路由过滤（移除讨厌的提示）
			-- ===========================
			-- routes = {
			-- 	{
			-- 		filter = {
			-- 			event = "notify",
			-- 			find = "No information available",
			-- 		},
			-- 		opts = { skip = true },
			-- 	},
			-- },
			routes = {
				-- Hide search count
				{ filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
				-- Hide written message
				{ filter = { event = "msg_show", kind = "" }, opts = { skip = true } },
			},
		},

		config = function(_, opts)
			require("noice").setup(opts)

			-- popup 文档滚动增强
			vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })
		end,

		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
