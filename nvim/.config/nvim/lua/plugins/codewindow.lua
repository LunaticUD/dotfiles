return {
	"gorbit99/codewindow.nvim",
	config = function()
		local codewindow = require("codewindow")

		codewindow.setup({
			-- 1. 设置为自动开启，这样打开普通文件时就会直接显示
			auto_enable = true,

			-- 2. 关闭 Treesitter 集成，使用普通文本显示，不需要安装 extra
			use_treesitter = false,

			-- 3. 关键配置：在这里列出你不希望显示小地图的窗口类型
			-- 包括启动页(alpha, dashboard)、文件树(neo-tree, NvimTree)、帮助文档等
			exclude_filetypes = {
				"help", -- 帮助文档
				"alpha", -- 常见的启动页插件 alpha-nvim
				"dashboard", -- 常见的启动页插件 dashboard-nvim
				"starter", -- mini.starter 启动页
				"snacks_dashboard", -- snacks.nvim 启动页
				"NvimTree", -- 文件树
				"neo-tree", -- 文件树
				"TelescopePrompt", -- 搜索框
				"lazy", -- lazy 管理界面
				"mason", -- mason 管理界面
				"qf", -- quickfix 窗口
			},

			-- 其他推荐的视觉调整（可选）
			show_cursor = true, -- 显示当前光标在小地图的位置
			window_border = "none", -- 边框样式，可选 'single', 'double', 'rounded' 等
		})

		-- 如果你想要保留快捷键来临时手动开关，可以保留这行
		codewindow.apply_default_keybinds()
		vim.keymap.set("n", "<Leader>m", codewindow.toggle_minimap, { desc = "Toggle Minimap" })
	end,
}
