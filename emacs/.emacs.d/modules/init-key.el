;; Which-key 辅助提示
(use-package which-key
  :ensure nil
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

;; 字体缩放
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; 快速打开配置
(global-set-key (kbd "<f2>") (lambda () (interactive) (find-file user-init-file)))

(provide 'init-key)
