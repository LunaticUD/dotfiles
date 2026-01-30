;; 定义函数
(defun my-dirvish-up-directory ()
  "Go to parent directory in the same buffer."
  (interactive)
  (find-alternate-file ".."))
;; 加载
(use-package dirvish
  :ensure t
  :init
  ;; 让 Dirvish 增强 dired 的显示与交互
  (dirvish-override-dired-mode)

  :config
  ;; 更接近“文件管理器”的体验：额外信息 + 更好看的 header
  (setq dirvish-attributes
	'(all-the-icons file-size file-time)) ; 去掉 vc-state


  ;; 预览行为：你也可以先不配，默认也能用
  (setq dirvish-preview-dispatchers
        '(image gif video audio epub pdf archive))
  ;; 常用按键
  (define-key dirvish-mode-map (kbd "TAB") #'dirvish-subtree-toggle)
   ;; ESC 回到上一级目录（关键）
  (define-key dirvish-mode-map (kbd "<escape>") #'my-dirvish-up-directory))

(provide 'init-dired)
