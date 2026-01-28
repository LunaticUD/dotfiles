return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		signs = true, -- 显示图标
		keywords = {
			FIX = {
				icon = " ", -- 图标
				color = "#DC2626", -- 颜色
				alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- 其他关键字
			},
			TODO = { icon = " ", color = "#10B981" },
			HACK = { icon = " ", color = "#7C3AED" },
			WARN = { icon = " ", color = "#F59E0B", alt = { "WARNING", "XXX" } },
			PERF = { icon = " ", color = "#2563EB", alt = { "OPTIM", "PERFORMANCE" } },
			NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } },
		},
	},
}
-- TODO:
-- FIX:
-- BUG:
-- PERF:
-- HACK:
-- NOTE:
-- WARN:
