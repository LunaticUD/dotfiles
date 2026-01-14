-- return{
--     'RRethy/vim-illuminate',
--     opts = {},
--         config = function()
--       -- 设置高亮样式
--       vim.g.Illuminate_delay = 100  -- 延迟高亮显示时间
--       vim.api.nvim_set_hl(0, 'IlluminatedWordText', { fg = '#ffcc00', bg = '#000000', underline = true })
--       vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { fg = '#00ff00', underline = true })
--       vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { fg = '#ff00ff', underline = true })
--
--       -- 启用光标下的单词高亮
--       vim.g.illuminate_highlight_under_cursor = 1
--     end
--   }
-- lazy
return {
	"sontungexpt/stcursorword",
	event = "VeryLazy",
	config = true,
}
