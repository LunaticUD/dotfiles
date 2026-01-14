-- return {
--     'nvim-lualine/lualine.nvim',
--     dependencies = { 'nvim-tree/nvim-web-devicons' },
--     opts = {
-- 	-- options = { theme = 'dracula' }
-- 	  options = {
--     icons_enabled = true,
--     theme = 'auto',
--     component_separators = { left = '', right = ''},
--     section_separators = { left = '', right = ''},
--     disabled_filetypes = {
--       statusline = {},
--       winbar = {},
--     },
--     ignore_focus = {},
--     always_divide_middle = true,
--     globalstatus = false,
--     refresh = {
--       statusline = 1000,
--       tabline = 1000,
--       winbar = 1000,
--     }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
--   },
--   tabline = {},
--   winbar = {},
--   inactive_winbar = {},
--   extensions = {}
--     }
-- }
return {
	"nanozuki/tabby.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		-- 启用全局状态栏
		vim.opt.laststatus = 3
		local theme = {
			-- this is carbonfox theme
			fill = "TabLineFill",
			head = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
			current_tab = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
			tab = { fg = "#c5cdd9", bg = "#1c1e26", style = "italic" },
			win = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
			tail = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
		}

		require("tabby.tabline").set(function(line)
			return {
				{
					{ "  ", hl = theme.head },
					line.sep("", theme.head, theme.fill),
				},
				line.tabs().foreach(function(tab)
					local hl = tab.is_current() and theme.current_tab or theme.tab

					-- remove count of wins in tab with [n+] included in tab.name()
					local name = tab.name()
					local index = string.find(name, "%[%d")
					local tab_name = index and string.sub(name, 1, index - 1) or name

					-- indicate if any of buffers in tab have unsaved changes
					local modified = false
					local win_ids = require("tabby.module.api").get_tab_wins(tab.id)
					for _, win_id in ipairs(win_ids) do
						if pcall(vim.api.nvim_win_get_buf, win_id) then
							local bufid = vim.api.nvim_win_get_buf(win_id)
							if vim.api.nvim_buf_get_option(bufid, "modified") then
								modified = true
								break
							end
						end
					end

					return {
						line.sep("", hl, theme.fill),
						tab_name,
						modified and "",
						line.sep("", hl, theme.fill),
						hl = hl,
						margin = " ",
					}
				end),
				line.spacer(),
				{
					line.sep("", theme.tail, theme.fill),
					{ "  ", hl = theme.tail },
				},
				hl = theme.fill,
			}
		end)
	end,
}
