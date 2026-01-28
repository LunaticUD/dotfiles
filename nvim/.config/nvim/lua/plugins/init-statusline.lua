return {
	{
		"OXY2DEV/bars.nvim",
		config = function()
			require("bars").setup({ statuscolumn = false })
			require("bars").setup({ tabline = false })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",

		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup({
				options = {
					separator_style = "slant",
					always_show_bufferline = false,
					themable = false,
				},
			})
		end,
	},
}
