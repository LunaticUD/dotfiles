(use-package conda
  :ensure t
  :init
  ;; 1. 路径优化：确保路径解析正确
  (setq conda-anaconda-home (expand-file-name "~/miniforge3")
        conda-env-home-directory (expand-file-name "~/miniforge3")
        ;; 默认不自动激活，防止启动卡顿
        conda-env-autoactivate-mode nil)
  :config
  ;; 2. 增强型初始化
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  ;; 4. UI 增强：在 Mode-line 显示当前环境
  (add-to-list 'global-mode-string
               '(:eval (when (bound-and-true-p conda-env-current-name)
                         (format " 🐍(%s)" conda-env-current-name))))
  :bind
  ;; 使用 :bind 关键词让代码更整洁，且支持延迟加载
  (("C-c v"   . conda-env-activate)
   ("C-c V"   . conda-env-deactivate)))


(provide 'init-conda)
