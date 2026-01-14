;; ----------------------------------------------------------------------
;; 1. 软件源设置 (中国大陆清华源加速)
;; ----------------------------------------------------------------------
(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

;; ----------------------------------------------------------------------
;; 2. 基础配置
;; ----------------------------------------------------------------------
;; Emacs 30 内置了 use-package，直接启用
(require 'use-package)
(setq use-package-always-ensure t) ; 总是自动下载缺失插件

;; 优化垃圾回收阈值，加快启动速度
(setq gc-cons-threshold (* 50 1000 1000))
;; 主题
(use-package catppuccin-theme
  :ensure t
  :init
  ;;在这里选择风味: 'latte, 'frappe, 'macchiato, 或 'mocha
  (setq catppuccin-flavor 'mocha) 
  :config
  ;; 加载主题
  (load-theme 'catppuccin :no-confirm)
  ;; 可选：微调 Catppuccin 的一些细节
  (setq catppuccin-enlarge-headings nil)  ; 让标题不要变得太大
  (catppuccin-reload))                    ; 确保设置生效

;; ----------------------------------------------------------------------
;; 3. 加载模块
;; ----------------------------------------------------------------------
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'init-ui)
(require 'init-default)
(require 'init-key)
(require 'init-dired)
(require 'init-org)
(require 'init-code)
;; ----------------------------------------------------------------------
;; 4. 自动生成配置分离
;; ----------------------------------------------------------------------
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(if (file-exists-p custom-file)
    (load custom-file))
