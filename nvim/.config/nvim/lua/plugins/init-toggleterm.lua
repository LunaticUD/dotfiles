-- return {
-- 	"akinsho/toggleterm.nvim",
-- 	config = function()
-- 		require("toggleterm").setup({
-- 			size = 20, -- 终端大小（可以根据需要调整）
-- 			open_mapping = [[<c-\>]], -- 触发打开终端的快捷键
-- 			direction = "float", -- 终端的方向（可选：float / vertical / horizontal）
-- 			close_on_exit = true,
-- 		})
-- 	end,
-- }
return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 20, -- 终端的大小（可以根据需要调整）
			open_mapping = [[<c-\>]], -- 触发打开终端的快捷键
			direction = "float",
			-- 终端的方向：float（浮动窗口）、vertical（垂直）、horizontal（水平）
			shade_terminals = true,
			shading_factor = 10,
			shading_ratio = 10,
			-- 设置终端的 shell 为 PowerShell，启动时不显示 logo
			-- shell = "powershell.exe",
			shell = "zsh",
			-- shellcmdflag = "-nologo",

			-- 配置 Escape 键退出终端
			close_on_exit = true, -- 终端退出时关闭窗口
			float_opts = {
				border = "curved", -- 可选：设置浮动终端的边框风格
			},
		})
	end,
}
-- return {}
