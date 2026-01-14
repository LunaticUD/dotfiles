;;; lisp/init-code.el

;; --- 1. 基础补全界面 (Corfu) ---
(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  :init (global-corfu-mode))

;; --- 2. Python 核心 (Eglot + Conda) ---
(use-package eglot
  :ensure nil
  :hook (python-mode . eglot-ensure))

(use-package conda
  :ensure t
  :config
  ;; --- Miniforge 路径适配 ---
  ;; 这里的路径必须指向包含 bin/conda 的文件夹
  (setq conda-anaconda-home (expand-file-name "~/miniforge3"))
  (setq conda-env-home-directory (expand-file-name "~/miniforge3"))
  
  ;; 初始化
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)

  ;; --- 自动适配设置 ---
  ;; 如果你想让 Emacs 自动在 Miniforge 的各环境文件夹中寻找
  (setq conda-env-subdirectory "envs")

  ;; 强制让 doom-modeline 刷新环境显示
  (add-hook 'conda-postactivate-hook (lambda () (force-mode-line-update)))
  (add-hook 'conda-postdeactivate-hook (lambda () (force-mode-line-update))))

;; --- 3. 自动格式化 (保存即美化) ---
(use-package apheleia
  :ensure t
  :init (apheleia-global-mode +1))

;; --- 4. R 语言 (保持不变) ---
(use-package ess
  :ensure t
  :init (require 'ess-site))

;; --- 5. 数据文件支持 ---
(use-package csv-mode :ensure t)
(use-package vlf :ensure t)

(provide 'init-code)
