;;; lisp/init-code.el

;; --- 1. 基础补全界面 (Corfu) ---
(use-package corfu
  :ensure t
  ;; 允许在某些模式下手动开启，这里建议保持 global
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  ;; --- 关键修改 1: 自动选中第一个候选词 ---
  ;; 将 'prompt 改为 'valid 或 0，这样 Enter 才能直接补全第一个
  (corfu-preselect 'valid) 
  
  :bind
  ;; --- 关键修改 2: 绑定 Tab 和 Enter ---
  (:map corfu-map
        ("TAB" . corfu-next)          ; Tab 下一个
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)    ; Shift+Tab 上一个
        ([backtab] . corfu-previous)
        ("<return>" . corfu-insert)   ; Enter 确认补全
        ("RET" . corfu-insert))
  :config
  ;; 如果你希望在输入空格时自动退出补全（类似 IDE 体验）
  (setq corfu-quit-at-boundary 'separator))

;; --- 2. 括号匹配与自动补全 (新增) ---
;; 2.1 彩虹括号：让不同层级的括号显示不同颜色，一眼识别匹配关系
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; 2.2 自动补全括号：输入 ( 自动补全 )，内置功能，轻量稳定
(electric-pair-mode 1)

;; --- 3. 缩进参考线 (新增) ---
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :custom
  ;; 显示方式：'character (字符线) 或 'bitmap (像素线，更美观但有时会有显示问题)
  (highlight-indent-guides-method 'character) 
  ;; 自动根据背景色调整线的颜色
  (highlight-indent-guides-responsive 'top))

;; --- 4. Python 核心增强 (Eglot + Conda + Treesitter) ---

;; 4.1 代码片段模板 (新增)：编写 def/class/if 时按 Tab 展开
(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode))
  :config (yas-reload-all))

;; 4.2 Python Mode 设置
(use-package python
  :ensure nil
  :hook
  ;; 启用 Eglot LSP
  (python-mode . eglot-ensure)
  ;; 如果是 Emacs 29+，启用 Tree-sitter 获得更精准的高亮
  (python-ts-mode . eglot-ensure))

(use-package eglot
  :ensure nil
  :config
  ;; 优化：禁止 Eglot 在 minibuffer 疯狂提示文档，改为手动触发或鼠标悬停
  (setq eglot-ignored-server-capabilities '(:hoverProvider))
  ;; 优化：Eglot 默认使用 pyright (需 pip install pyright) 性能更好
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("pyright-langserver" "--stdio"))))

(use-package conda
  :ensure t
  :config
  ;; --- Miniforge 路径适配 ---
  (setq conda-anaconda-home (expand-file-name "~/miniforge3"))
  (setq conda-env-home-directory (expand-file-name "~/miniforge3"))
  
  ;; 初始化
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)

  ;; --- 自动适配设置 ---
  (setq conda-env-subdirectory "envs")

  ;; 强制刷新 modeline
  (add-hook 'conda-postactivate-hook (lambda () (force-mode-line-update)))
  (add-hook 'conda-postdeactivate-hook (lambda () (force-mode-line-update))))

;; --- 5. 自动格式化 (保存即美化) ---
(use-package apheleia
  :ensure t
  :init (apheleia-global-mode +1))

;; --- 6. R 语言 ---
(use-package ess
  :ensure t
  :init (require 'ess-site))

;; --- 7. 数据文件支持 ---
(use-package csv-mode :ensure t)
(use-package vlf :ensure t)

(provide 'init-code)
