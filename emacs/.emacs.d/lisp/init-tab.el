(use-package awesome-tab
  :load-path "~/.emacs.d/elpa/awesome-tab"
  :config
  ;; 隐藏规则：
  ;; 1. * 开头的 buffer
  ;; 2. dirvish / dired buffer
  (setq awesome-tab-hide-tab-function
        (lambda (buf)
          (with-current-buffer buf
            (or
             ;; *Messages* *scratch* 等
             (string-prefix-p "*" (buffer-name))
             ;; Dirvish / Dired 不显示
             (derived-mode-p 'dirvish-mode 'dired-mode)))))

  (awesome-tab-mode 1))
(with-eval-after-load 'awesome-tab
  ;; 更像常见编辑器：C-w 关闭
  (define-key awesome-tab-mode-map (kbd "C-w") #'kill-current-buffer))



(provide 'init-tab)
