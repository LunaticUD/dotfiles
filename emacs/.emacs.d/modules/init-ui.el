;; 1. 基础图标支持 (Doom-modeline 和 Centaur-tabs 都需要)
(use-package nerd-icons
  :ensure t)

;; 2. 基础界面清理
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; 4. Doom Modeline (漂亮的底部状态栏)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 39)      ; 高度
  (setq doom-modeline-icon t)         ; 显示图标
  (setq doom-modeline-major-mode-icon t))

;; 5. 顶部 Bufferline 标签页
(use-package tab-line
  :ensure nil ; 内置功能
  :hook (after-init . global-tab-line-mode) ; 全局开启
  :config
  ;; 1. 只有当 buffer 数量 > 1 时才显示标签栏 (完美解决你的痛点)
  (setq tab-line-switch-cycling t)  
  (setq tab-line-tabs-function 'tab-line-tabs-window-buffers)
  
  ;; 隐藏机制：通过 hook 动态判断
  (defun my/auto-hide-tab-line ()
    "如果只有一个 buffer，隐藏 tab-line"
    (let* ((tabs (funcall tab-line-tabs-function))
           (count (length tabs)))
      (if (<= count 1)
          (setq tab-line-format nil)
        (setq tab-line-format '(:eval (tab-line-format))))))
  
  (add-hook 'window-configuration-change-hook 'my/auto-hide-tab-line)
  (add-hook 'buffer-list-update-hook 'my/auto-hide-tab-line)

  ;; 2. 外观美化 (去除丑陋的关闭按钮，改用纯文本)
  (setq tab-line-close-button-show nil)       ; 不显示 X 按钮
  (setq tab-line-new-button-show nil)         ; 不显示 + 按钮
  (setq tab-line-separator " ")               ; 标签间距
  
  ;; 3. 自定义标签样式 (选中高亮，未选中变暗)
  (set-face-attribute 'tab-line nil :background (face-background 'mode-line-inactive) :height 0.95 :box nil)
  (set-face-attribute 'tab-line-tab nil :inherit 'tab-line :box nil)
  (set-face-attribute 'tab-line-tab-current nil :background (face-background 'default) :foreground (face-foreground 'default) :weight 'bold :box nil)
  (set-face-attribute 'tab-line-tab-inactive nil :inherit 'tab-line :box nil)
  (set-face-attribute 'tab-line-highlight nil :inherit 'tab-line-tab :background "grey20"))

(provide 'init-ui)
