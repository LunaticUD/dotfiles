-- mapleader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.termguicolors = true
-- 插件配置
require("config.lazy")
require("config.default")
require("config.key")
require("config.lsp")
require("lazy").setup("plugins")
-- 主题设置
vim.cmd.colorscheme("catppuccin")
-- 字体
vim.opt.guifont = {
	"Maple Mono NF CN",
	"LXGW WenKai",
	"h15",
}
if vim.g.neovide then
	-- 基础美化
	vim.g.neovide_opacity = 0.75 -- 透明度
	vim.g.neovide_cursor_vfx_mode = "railgun" -- 炫酷的光标粒子效果
	-- 字体
	-- vim.opt.guifont = "Maple Mono NF CN:h15"
	vim.opt.guifont = {
		"Maple Mono NF CN",
		"LXGW WenKai",
		"h15",
	}
	-- 性能优化
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_no_idle = true
end
