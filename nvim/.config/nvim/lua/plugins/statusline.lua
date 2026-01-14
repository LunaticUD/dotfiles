return {
	{
		"OXY2DEV/bars.nvim",
		config = function()
			require("bars").setup({ statuscolumn = false })
			require("bars").setup({ tabline = false })
		end,
	},
}
