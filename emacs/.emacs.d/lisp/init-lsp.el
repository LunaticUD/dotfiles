;; yasnippet
(use-package yasnippet
  :ensure t
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)

;; lsp-bridge
(use-package lsp-bridge
  :load-path "~/.emacs.d/elpa/lsp-bridge"
  :defer t
  :commands (lsp-bridge-mode global-lsp-bridge-mode)
  :hook
  ;; 只有进入编程模式才启用
  (prog-mode . lsp-bridge-mode)
  :init
  ;; Python LSP（init 阶段，autoload 前就生效）
  (setq lsp-bridge-python-lsp-server 'pyright)
  ;; 不在 minibuffer 显示文档
  (setq lsp-bridge-show-documentation-in-minibuffer nil)
  ;; 文档 popup
  (setq lsp-bridge-doc-enable t)
  (setq lsp-bridge-doc-position 'right)
  ;; hover / signature
  (setq lsp-bridge-enable-hover-diagnostic t)
  (setq lsp-bridge-enable-signature-help nil)
  :config
  ;; 真正加载后才执行
  (message "lsp-bridge loaded"))

;; 补全键位（必须 after-load）
(with-eval-after-load 'lsp-bridge
  ;; TAB / S-TAB 切换
  (define-key acm-mode-map (kbd "<tab>") #'acm-select-next)
  (define-key acm-mode-map (kbd "TAB")   #'acm-select-next)
  (define-key acm-mode-map (kbd "<backtab>") #'acm-select-prev)
  (define-key acm-mode-map (kbd "S-TAB") #'acm-select-prev)

  ;; ENTER 确认
  (define-key acm-mode-map (kbd "RET") #'acm-complete)
  (define-key acm-mode-map (kbd "<return>") #'acm-complete)

  ;; 可选：TAB 不做缩进
  (setq acm-enable-tab-for-indent nil))
;; lsp-bridge 重启快捷键
(with-eval-after-load 'lsp-bridge
  (define-key lsp-bridge-mode-map
    (kbd "C-c l r") #'lsp-bridge-restart-process))
(defun my-action ()
  (interactive)
  (call-interactively (key-binding (kbd "C-c l r")))
  (call-interactively (key-binding (kbd "C-x C-v"))))
(global-set-key (kbd "C-x r") #'my-action)
;; eldoc -1
(add-hook 'python-mode-hook
          (lambda ()
            (eldoc-mode -1)))


(provide 'init-lsp)
