return {
	{
		"AckslD/swenv.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("swenv").setup({
				-- 核心：定义获取虚拟环境的函数
				get_venvs = function(venvs_path)
					-- require('swenv.api').get_venvs 会扫描指定目录下所有的文件夹
					-- 请确保你的 Miniforge 路径正确，通常是 ~/miniforge3/envs
					return require("swenv.api").get_venvs(vim.fn.expand("~/miniforge3/envs"))
				end,

				-- 切换环境后的回调函数：重启 LSP 以识别新环境中的包
				post_set_venv = function()
					vim.cmd("LspRestart")
					-- 可选：发送通知确认切换成功
					vim.notify("Python Environment Switched & LSP Restarted", vim.log.levels.INFO)
				end,
			})
		end,
		keys = {
			-- 绑定快捷键，例如 <leader>sv (Switch Venv)
			{
				"<leader>sv",
				function()
					require("swenv.api").pick_venv()
				end,
				desc = "Switch Python Venv",
			},
		},
	},
}
