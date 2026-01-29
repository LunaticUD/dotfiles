-- mapleader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.termguicolors = true
-- 插件配置
require("config.lazy")
require("config.default")
require("config.key")
require("config.lsp")
require("config.neovide")
require("lazy").setup("plugins")
-- 主题设置
vim.cmd.colorscheme("catppuccin")
