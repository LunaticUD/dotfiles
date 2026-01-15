-- UTF-8
vim.opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
-- 剪切板桥梁
vim.opt.clipboard = "unnamedplus"
-- 基本设置
-- vim.opt.laststatus = 0 -- 不显示状态栏
vim.g.VM_show_warnings = 0 -- 禁止警告
-- 解释器路径
-- vim.g.python3_host_prog = "/E/Minconda/python"
-- 是否报错响铃及行为
vim.opt.errorbells = true
vim.opt.visualbell = true
-- 文件和路径名可用的字符
-- 文本格式化方式
vim.opt.formatoptions:append("1") -- 自动换行时不打断长行
vim.opt.formatoptions:remove("t") -- 不自动换行文本
vim.opt.formatoptions:remove("o") -- 不自动插入注释
-- 关闭兼容模式
vim.opt.compatible = false
-- 检测到的文件类型
vim.cmd("filetype plugin indent on")
vim.cmd("filetype plugin on")
-- 开启语法高亮显示
vim.cmd("syntax on")
-- Mouse
vim.opt.mouse = "nv" -- 在普通模式和可视模式下启用鼠标
-- 不保存缓存文件
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.swapfile = false
-- 显示行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 启用真彩色支持
-- vim.opt.termguicolors = true
-- 更好的搜索体验
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- 自动读取外部更改
vim.opt.autoread = true
-- 设置剪贴板使用系统剪贴板
vim.opt.clipboard = "unnamedplus"
-- 更好的窗口管理
vim.opt.splitright = true
vim.opt.splitbelow = true
-- 设置滚动时保留上下文行数
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
-- 设置命令行高度
vim.opt.cmdheight = 1
-- 设置超时时间
vim.opt.timeoutlen = 500
-- 禁止自动换行
vim.opt.wrap = false
-- bar
vim.o.showtabline = 2
-- 自动保存
-- 创建一个自动命令组
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost" }, {
	group = autosave_group,
	pattern = "*", -- 对所有文件生效
	command = "silent! wall", -- 静默保存所有更改
	nested = true,
})
