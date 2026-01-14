#!/bin/bash

# 1. 切换 mako 模式
makoctl mode -t dnd

# 2. 发送信号给 i3status-rs 让它刷新
# 注意：进程名通常是 i3status-rs，信号是 SIGRTMIN+8
pkill -SIGRTMIN+8 i3status-rs
