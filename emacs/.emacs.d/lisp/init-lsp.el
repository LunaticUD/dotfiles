;; yasnippet（防炸）
(when (require 'yasnippet nil 'noerror)
  (yas-global-mode 1))

;; lsp-bridge
(add-to-list 'load-path "~/.emacs.d/elpa/lsp-bridge")
(require 'lsp-bridge)
;; 不在 minibuffer 显示文档
(setq lsp-bridge-show-documentation-in-minibuffer nil)
;; 启用文档 popup
(setq lsp-bridge-doc-enable t)
(setq lsp-bridge-doc-position 'right)
;; hover / signature
(setq lsp-bridge-enable-hover-diagnostic t)
(setq lsp-bridge-enable-signature-help t)
;; Python LSP
(setq lsp-bridge-python-lsp-server 'pyright)

(global-lsp-bridge-mode)

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



(provide 'init-lsp)
