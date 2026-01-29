-- 1. 定义一个统一的字体变量（方便维护）
local font_names = "Maple Mono NF CN,LXGW WenKai"

-- 2. 根据环境设置不同的字号
if vim.g.neovide then
	-- Neovide 环境：通常需要比终端稍微大一点点或保持一致
	-- 注意：这里我建议你尝试 h11 或 h12，h7 真的太小了
	vim.opt.guifont = font_names .. ":h12"

	-- Neovide 特有配置
	vim.g.neovide_opacity = 0.95
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_no_idle = true
	-- 2. 边缘间距 (Padding)
	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_left = 5
	vim.g.neovide_padding_right = 0
	-- 如果觉得还是不一致，尝试强制 1.0 缩放
	vim.g.neovide_scale_factor = 1.0
else
	-- 终端环境（可选，部分终端支持 guifont 变量）
	vim.opt.guifont = font_names .. ":h11"
end
