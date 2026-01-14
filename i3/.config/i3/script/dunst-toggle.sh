#!/usr/bin/env bash
set -euo pipefail

# 1. 切换 dunst 勿扰（pause/unpause）
if ! command -v dunstctl >/dev/null 2>&1; then
  echo "dunstctl not found. Install dunst first."
  exit 1
fi

if dunstctl is-paused | grep -qx "true"; then
  dunstctl set-paused false
else
  dunstctl set-paused true
fi

# 2. 发送信号给 i3status-rs 让它刷新
pkill -SIGRTMIN+8 i3status-rs || true

