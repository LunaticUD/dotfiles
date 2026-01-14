;; --- 界面 ---
(when (display-graphic-p)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; --- 启动页面 ---
(setq inhibit-startup-screen t)
;; initial-scratch-message nil)

;; --- 编程行号 ---
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; --- 最大宽度 ---
(setq-default fill-column 60)
(setq-default truncate-lines t)   ;; 比 toggle-truncate-lines 更符合“默认行为”

;; --- 剪切板 ---
(setq select-enable-clipboard t
      select-enable-primary t      ;; 不要 primary 就改成 nil
      save-interprogram-paste-before-kill t)

;; --- UTF-8 ---
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix
      default-process-coding-system '(utf-8-unix . utf-8-unix)
      file-name-coding-system 'utf-8-unix)

;; ---Font-----
(when (display-graphic-p)
  ;; 1) 英文
  (set-face-attribute 'default nil
                      :family "JetBrainsMono"
                      :height 160
                      :weight 'normal)
  ;; 2) 中文
  (dolist (charset '(han cjk-misc bopomofo))
    (set-fontset-font t charset
                      (font-spec :family "LXGW WenKai" :size 24))))

;;--- 选中替换 ---
(delete-selection-mode t)

;;--- 编程折叠 ---
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; --- 备份设置 ---
(setq make-backup-files nil) ; 彻底禁止生成 *.~ 备份文件
(setq auto-save-default nil) ; 彻底禁止生成 #*# 自动保存文件


(provide 'init-default)
