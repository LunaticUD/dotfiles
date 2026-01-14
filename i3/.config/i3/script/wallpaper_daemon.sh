#!/bin/bash
# 监听 i3 事件
i3-msg -t subscribe -m '[ "workspace" ]' | while read -r event; do
    # 提取当前 focus 的工作区名称或编号
    WS_NAME=$(echo "$event" | jq -r '.current.name')

    # 根据工作区名称切换壁纸
    case "$WS_NAME" in
        "2")
            feh --bg-fill ~/.config/i3/handout-beginner.png
            ;;
        "3")
            feh --bg-fill ~/.config/i3/handout-intermediate.png
            ;;
        "4")
            feh --bg-fill ~/.config/i3/handout-tips.png
            ;;
        *)
            # 默认壁纸（其他工作区）
            feh --bg-fill ~/.config/i3/default.png
            ;;
    esac
done
