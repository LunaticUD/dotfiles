#!/bin/bash

# 1. 终止正在运行的 bar 实例
# -q 表示安静模式，如果没进程被杀也不报错
killall -q polybar

# 2. 等待直到进程彻底死透
# pgrep 检查是否还有 polybar 活着，如果有就 sleep 1 秒继续等
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# 3. 启动新的 Polybar 实例
# "main" 是你在 config.ini 里定义的 bar 的名字 ([bar/main])
# 2>&1 | tee ... 是为了把日志保存到 /tmp 下，万一启动失败方便查错
echo "---" | tee -a /tmp/polybar.log
polybar main 2>&1 | tee -a /tmp/polybar.log & disown

# 脚本结束，无任何额外通知

