return {
	"LunarVim/bigfile.nvim",
	config = function()
		require("bigfile").setup({
			filesize = 2, -- 单位 MiB，超过 2MB 的文件将触发大文件模式
			pattern = { "*" }, -- 匹配所有文件
			features = { -- 触发大文件模式时关闭的功能
				"indent_blankline",
				"illuminate",
				"lsp",
				"treesitter",
				"syntax",
				"matchparen",
				"vimopts",
				"filetype",
			},
		})
	end,
}
