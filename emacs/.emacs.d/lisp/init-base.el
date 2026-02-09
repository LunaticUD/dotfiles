;; 不折行
(use-package visual-fill-column
  :ensure t
  :init
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  :hook
  ((org-mode python-mode) . visual-fill-column-mode))
(use-package adaptive-wrap
  :ensure t
  :hook
  ((org-mode python-mode) . adaptive-wrap-prefix-mode))
(add-hook 'org-mode-hook #'visual-line-mode)
(add-hook 'python-mode-hook #'visual-line-mode)
(defun my/wrap-layout-toggle ()
  "Toggle pretty visual wrapping: visual-line + visual-fill-column + adaptive-wrap."
  (interactive)
  (require 'visual-fill-column nil t)
  (require 'adaptive-wrap nil t)
  (if (bound-and-true-p visual-fill-column-mode)
      (progn
        (when (fboundp 'visual-fill-column-mode) (visual-fill-column-mode -1))
        (when (fboundp 'adaptive-wrap-prefix-mode) (adaptive-wrap-prefix-mode -1))
        (visual-line-mode -1))
    (visual-line-mode 1)
    (when (fboundp 'visual-fill-column-mode) (visual-fill-column-mode 1))
    (when (fboundp 'adaptive-wrap-prefix-mode) (adaptive-wrap-prefix-mode 1))))
(global-set-key (kbd "C-c w") #'my/wrap-layout-toggle)


;; 全局elisp
(global-set-key (kbd "C-j") #'eval-print-last-sexp)
;; 警告设置
(setq warning-minimum-level :error)
;; 显示行号,只在编辑模式里开
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'display-line-numbers-mode))
;; 分屏
(setq split-width-threshold 120)
(setq split-height-threshold 80)
;; 控制 Help / 编译 / REPL 的出现位置
(setq display-buffer-alist
      '(
        ;; ---- Help: 右侧侧边栏 ----
        ("\\*Help\\*"
         (display-buffer-in-side-window)
         (side . right)
         (window-width . 0.4))
        ;; ---- Compilation & Warnings: 底部 ----
        ("\\*compilation\\*"
         (display-buffer-in-side-window)
         (side . bottom)
         (window-height . 0.3))
        ("\\*Warnings\\*"
         (display-buffer-in-side-window)
         (side . bottom)
         (window-height . 0.25))
        ;; ---- R (ESS): 右侧 ----
        ;; 匹配 *R* 以及 *R:xxx*
        ("\\*R\\(\\:.*\\)?\\*"
         (display-buffer-in-direction)
         (direction . right)
         (window-width . 0.35))
        ;; ---- Python: 右侧 ----
        ("\\*Python\\*"
         (display-buffer-in-direction)
         (direction . right)
         (window-width . 0.35))
        ))
;; scratch
(defun my/clear-scratch ()
  (interactive)
  (with-current-buffer "*scratch*"
    (erase-buffer)))
(global-set-key (kbd "C-c s c") #'my/clear-scratch)
(global-set-key (kbd "C-c s s")
                (lambda () (interactive) (switch-to-buffer "*scratch*")))
;; 缩进
(global-set-key
 (kbd "C-c >")
 (lambda ()
   (interactive)
   (indent-rigidly (region-beginning) (region-end) 2)))

(global-set-key
 (kbd "C-c <")
 (lambda ()
   (interactive)
   (indent-rigidly (region-beginning) (region-end) -2)))
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
               " "
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
