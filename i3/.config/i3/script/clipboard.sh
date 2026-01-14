#!/bin/bash

# 1. 获取选中的内容 (Rofi 传进来的第一个参数)
selection="$1"

# 2. 如果内容为空，直接退出
[ -z "$selection" ] && exit 0

# 3. 强制更新剪切板 (解决你原命令不更新的问题)
# 注意：同时更新 primary 和 clipboard 两个板，防止意外
echo -n "$selection" | xclip -selection primary
echo -n "$selection" | xclip -selection clipboard

# 4. 等待 i3 焦点切换 (关键！给窗口一点反应时间)
sleep 0.5

# 5. 模拟打字
# 使用 --delay 0 加快速度，使用 --clearmodifiers 防止 Ctrl 键卡住
xdotool type --delay 0 --clearmodifiers "$selection"

