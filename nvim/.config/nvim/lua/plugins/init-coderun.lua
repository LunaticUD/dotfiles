return {
	"CRAG666/code_runner.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leater>r", "<cmd>RunCode<cr>", desc = "Run Code" },
		{ "<ESC>", "<cmd>RunClose<cr>", desc = "Run Quite" },
	},
	opts = {
		-- mode: Mode in which you want to run. Are supported: "better_term", "float", "tab", "toggleterm" (type: bool)
		mode = "term",
		-- Focus on runner window(only works on toggle, term and tab mode)
		focus = false,
		-- startinsert (see ':h inserting-ex')
		startinsert = false,
		term = {
			--  Position to open the terminal, this option is ignored if mode is tab
			position = "bot",
			-- window size, this option is ignored if tab is true
			size = 15,
		},
		-- 悬浮窗配置 (如果你把 mode 改为 'float' 的话)
		float = {
			border = "rounded", -- 圆角边框
			height = 0.8,
			width = 0.8,
			x = 0.5,
			y = 0.5,
		},
		filetype = {
			python = "python -u",
			-- python = function()
			-- 	local file = vim.fn.expand("%:p")
			-- 	local msys_file = vim.fn.system('cygpath -u "' .. file .. '" 2>/dev/null'):gsub("\n$", "")
			-- 	return '~/.config/nvim/python.sh"' .. msys_file .. '" $end'
			-- end,
			r = "Rscript",
		},
	},
	ft = { "lua", "python", "r" },
}
