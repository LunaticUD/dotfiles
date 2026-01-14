-- 诊断信息设置
-- 查看 :help vim.diagnostic.Opts
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		severity = { min = vim.diagnostic.severity.ERROR }, -- 这里配置只显示的诊断级别
		text = {
			[vim.diagnostic.severity.ERROR] = " ", -- 这里配置“错误”的图标，需要nerd font字体
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
	},

	virtual_text = {
		source = "if_many",
		spacing = 2,
		severity = vim.diagnostic.severity.ERROR, -- 这里配置只显示的诊断级别
		prefix = "●",
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

-- 当光标处有诊断信息时自动显示
vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(nil, {
			focusable = false,
			close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
			border = "rounded",
			scope = "cursor",
		})
	end,
})
-- 保存格式化
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
