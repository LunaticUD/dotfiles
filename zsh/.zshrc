# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# Created by newuser for 5.9
# -----------------------------
# my config
# -----------------------------
export EDITOR="/usr/local/bin/nvim.appimage"
export VISUAL="/usr/local/bin/nvim.appimage"
export PATH="/home/loong/.cargo/bin:$PATH"
export PATH="/usr/sbin/rfkill:$PATH"
export GDK_BACKEND=wayland,x11
# Rustup mirror
export RUSTUP_DIST_SERVER=https://rsproxy.cn
export RUSTUP_UPDATE_ROOT=https://rsproxy.cn/rustup
# # >>> nvim config >>>
# alias n="/usr/local/bin/nvim.appimage"
# alias sn="sudoedit"
n() {
    # 直接使用你截图里定义的 VISUAL 变量 (即 /usr/local/bin/nvim.appimage)
    # 如果 VISUAL 没定义，就退回到 "nvim" 命令
    local editor="${VISUAL:-nvim}"
    # 1. 如果没有参数，直接打开编辑器
    if [ $# -eq 0 ]; then
        "$editor"
        return
    fi
    # 2. 检查是否有权限限制
    local use_sudo=0
    for file in "$@"; do
        if [ -e "$file" ]; then
            # 文件存在且当前用户不可写 -> 需要 sudo
            if [ ! -w "$file" ]; then
                use_sudo=1
                break
            fi
        else
            # 文件不存在（新建），检查父目录是否可写
            local dir=$(dirname "$file")
            [ "$dir" = "." ] && dir=$(pwd)
            
            if [ ! -w "$dir" ]; then
                use_sudo=1
                break
            fi
        fi
    done
    # 3. 执行
    if [ $use_sudo -eq 1 ]; then
        echo "🔒 [sudo] 正在编辑受保护文件..."
        # 这里的关键是告诉 sudoedit 使用你的 appimage
        SUDO_EDITOR="$editor" sudoedit "$@"
    else
        "$editor" "$@"
    fi
}
# <<< nvim config <<<
# axel下载
alias ax="axel -n 10"
# nala映射
alias install='sudo nala install'
alias purge='sudo nala purge'
alias search='sudo nala search'
alias remove='sudo nala autoremove'
alias update='sudo nala update && sudo nala upgrade'
# mamba 映射
# Create a new environment
alias mc='mamba create'
# Install packages
alias mi='mamba install'
# Update all packages 
alias mu='mamba update --all'
# Search for a specific package across repositories:
alias ms='mamba repoquery search' 
# List all environments:
alias me='mamba info --envs'
# Remove unused [p]ackages and [t]arballs from the cache:
alias mp='mamba clean -pt'
# Activate an environment:
alias ma='mamba activate'
# List all installed packages 
alias ml='mamba list'
# 常用
alias c="clear"
alias ll="ls -lAFh"
alias cp="cp -iv"
alias mv="mv -iv"
# git
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/loong/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/loong/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
# Put the line below in ~/.zshrc:
#
#   eval "$(jump shell zsh)"
#
# The following lines are autogenerated:

__jump_chpwd() {
  jump chdir
}

function __jump_z_complete() {
  [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

  if [[ "${#words[@]}" -eq 2 ]]; then
    if [[ -n $(echo ${~words[2]}*(/N)) ]]; then
      _cd -/
    elif [[ "${words[2]}" != */* ]]; then
      local hint="$(jump hint "${words[2]}" | head -1)"
      [[ -n "$hint" ]] && compadd -U -S '' -- "$hint"
    fi
  else
    local -a hints=("${(@f)$(jump hint "${words[2,-1]}")}")
    [[ ${#hints[@]} -gt 0 ]] && compadd -U -S '' -a hints
  fi
}

__jump_base_dir() {
  local base_dir="$JUMP_BASED_PATH"
  if [ -z "$base_dir" ]; then
    base_dir="$(command git rev-parse --show-toplevel 2>/dev/null)"
  fi
  echo "$base_dir"
}

j() {
  case "$1" in
    "..")
      builtin cd ..
      ;;
    "-")
      builtin cd -
      ;;
    ".")
      local dir="$(jump cd "$(__jump_base_dir)" ${@:2})"
      test -d "$dir" && builtin cd "$dir"
      ;;
    *)
      local dir="$(jump cd $@)"
      test -d "$dir" && builtin cd "$dir"
      ;;
  esac
}

typeset -gaU chpwd_functions
chpwd_functions+=__jump_chpwd

[[ "${+functions[compdef]}" -ne 0 ]] && compdef __jump_z_complete j

# cheat.sh
function q() {
  curl cheat.sh/$1
}
layout_anaconda() {
  local nm=$1
  if [ -z "$nm" ]; then
    nm=$(basename "$PWD")
  fi
  # 指向你的 miniforge 路径
  local CONDA_ROOT="$HOME/miniforge3"
  
  export CONDA_PREFIX="$CONDA_ROOT/envs/$nm"
  export PATH="$CONDA_PREFIX/bin:$PATH"
  unset CONDA_DEFAULT_ENV
  export CONDA_DEFAULT_ENV="$nm"
}
# direnv
denv() {
    local env_name=$1

    # 1. 检查是否提供了环境名称
    if [ -z "$env_name" ]; then
        echo "⚠️  错误: 请提供 Conda 环境名称。"
        echo "用法: denv <环境名称>"
        return 1
    fi

    # 2. 检查 .envrc 是否已存在，防止误覆盖 (可选，如果想强制覆盖可删除此段)
    if [ -f .envrc ]; then
        read -p "⚠️  当前目录已存在 .envrc，是否覆盖? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "已取消操作。"
            return 1
        fi
    fi

    # 3. 写入配置 (这里使用 layout miniforge，前提是你上一部配置了 direnvrc)
    # 如果你上一轮配置的是 layout_anaconda，请将下方改为 "layout anaconda $env_name"
    echo "layout miniforge $env_name" > .envrc

    # 4. 自动批准权限
    direnv allow

    echo "✅ 已成功配置 direnv 使用环境: $env_name"
}

# # ====================================================
# # Zsh 原生补全增强 (优化版)
# # ====================================================
#
# # --- 1. 核心逻辑修改：解决“过多提示”问题 ---
# export LISTMAX=0
# # --- 2. 启用菜单选择 ---
# zstyle ':completion:*' menu select
# # --- 3. 颜色与高亮配置 (整合重复项) ---
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 'ma=7;1'
# # --- 4. 分组与描述格式 ---
zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# # --- 5. 匹配策略 (保持你的模糊匹配逻辑) ---
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:?=* r:|=*'
# # --- 6. 交互提示优化 ---
# zstyle ':completion:*' select-prompt %S正在选择: 当前位于 %p%s
# # 避免在补全时因为有多个选项而不断发出哔哔声
# setopt no_list_beep

# ====================================================
# Zsh 原生补全增强 (高性能版)
# ====================================================

# --- 1. 性能核心优化 (关键) ---
# 启用缓存，大大加速 apt, git, docker 等复杂命令的补全
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# 不要设置 LISTMAX=0，这会导致列出几千个文件时卡死
# 这里不设置，使用默认值（通常是 100），超过时询问，保护性能

# --- 2. 菜单选择与样式 ---
zstyle ':completion:*' menu select
# 使用 LS_COLORS 颜色，但如果未定义则回退到默认，避免报错
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- 3. 匹配策略 (平衡速度与模糊匹配) ---
# 解释：
# 1. 第一步尝试精确匹配
# 2. 第二步尝试大小写不敏感 (A=a)
# 3. 第三步尝试部分补全 (例如输 f.b -> foo.bar)
# 注意：我不推荐开启 'l:?=* r:|=*' (任意子串匹配)，那个非常慢！
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'

# --- 4. 分组与界面优化 ---
zstyle ':completion:*' group-name ''
# 优化描述显示的格式，更紧凑
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' select-prompt ' >> 正在选择 %p'

# --- 5. 排除由于耗时而导致卡顿的目录 ---
# 在 ../ 时不补全当前目录
zstyle ':completion:*' ignore-parents parent pwd

# 禁用旧式补全的哔哔声
setopt no_list_beep
eval "$(direnv hook zsh)"

# Created by `pipx` on 2026-01-30 01:05:36
export PATH="$PATH:/home/loong/.local/bin"
# export PATH="/usr/sbin:$PATH"
ulimit -c 0

# fnm (added by Research-Claw)
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell bash)"
# Research-Claw config path (added by install.sh)
export OPENCLAW_CONFIG_PATH="/home/loong/research-claw/config/openclaw.json"

# Standalone pnpm (added by Research-Claw install.sh)
export PATH="/home/loong/research-claw/.tools/pnpm/bin:$PATH"
