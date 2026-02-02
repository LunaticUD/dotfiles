;; 显示行号,只在编辑模式里开
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
;; 分屏
(setq split-height-threshold nil)
(setq split-width-threshold 0)
;; scratch
(defun my/clear-scratch ()
  (interactive)
  (with-current-buffer "*scratch*"
    (erase-buffer)))
(global-set-key (kbd "C-c s c") #'my/clear-scratch)
(global-set-key (kbd "C-c s s")
                (lambda () (interactive) (switch-to-buffer "*scratch*")))
;; 括号匹配高亮
(electric-pair-mode t)
;; 选中时输入替换文本
(delete-selection-mode t)
;; 简短回答
(setq use-short-answers t)
(define-key y-or-n-p-map [return] 'act)
;; all-the-icons
(use-package all-the-icons
  :if (display-graphic-p))
;; color
(use-package colorful-mode
  ;; :diminish
  :ensure t ; Optional
  :defer t
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))
;; 状态栏
;; 1. 定义一个“右对齐”的占位符函数
(defun my-mode-line-fill-right ()
  "Return empty space string that aligns following text to right."
  (propertize " " 'display '((space :align-to (- right 10))))) 

;; 2. 重新定义 mode-line-format
(setq-default mode-line-format
              (list
               ;; --- 左侧内容 ---
               " "
               ;; 文件状态 (●/🔒/-)
               '(:eval (cond (buffer-read-only
                              (propertize "🔒" 'face 'font-lock-comment-face))
                             ((buffer-modified-p)
                              (propertize "" 'face 'error))
                             (t
                              (propertize "●" 'face 'success))))
               ""
               ;; 缓冲区名称 (加粗)
               (propertize "%b" 'face 'bold)
               ;; ✅ 在名称右侧显示 pwd
               "  🙶 "
               '(:eval
                 (propertize
                  (abbreviate-file-name default-directory)
                  'face 'font-lock-comment-face))
	       " 🙷 "
               ;; --- 右侧内容 ---
               ;; 主模式
               "  Ⓜ "
               (propertize "%m" 'face 'font-lock-string-face)
               "  "
               ;; --- 中间占位符 (把后面的推到右边) ---
               '(:eval (my-mode-line-fill-right))
               ;; 行号:列号
               "  "
               (propertize "%l:%c" 'face 'font-lock-constant-face)
               "  "
               ))
;; 设置默认光标
(setq-default cursor-type 'bar)
;; 非激活窗口设为更暗，以示区分
(set-face-attribute 'mode-line-inactive nil
                    :background "#1B1C16"  ; 比背景更黑一点
                    :foreground "#75715E"
                    :box nil)
;; ess
(use-package ess
  :defer t
  :mode ("\\.R\\'" . R-mode))

(provide 'init-base)
