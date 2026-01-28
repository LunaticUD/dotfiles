return {
	"chrisbra/csv.vim",
	ft = { "csv", "tsv", "tab" },
	config = function()
		-- 设置分隔符自动识别
		vim.g.csv_autocmd_column = 1
		-- 快捷键：<leader>ca 对齐列，<leader>un 取消对齐
		vim.api.nvim_set_keymap("n", "<leader>ca", ":CSVArrange<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>un", ":CSVUnArrange<CR>", { noremap = true, silent = true })
	end,
}
