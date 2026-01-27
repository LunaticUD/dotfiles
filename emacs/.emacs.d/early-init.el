;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;; 禁用 package.el 自动初始化（推荐）
(setq package-enable-at-startup nil)

;; 启动时提高 GC 阈值，加快启动
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; 启动完成后恢复 GC
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 50 1000 1000)
                  gc-cons-percentage 0.1)))

;; 禁用 UI 元素（防止闪屏）
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
;; 3. 关键：修改背景色 (去除截图里的亮灰色条)
(set-face-attribute 'mode-line nil
                    :background "#272822"  ; 设为与背景同色，或者稍亮 #3E3D32
                    :foreground "#F8F8F2"
                    :box nil               ; 必须去掉 box，否则会有 3D 边框
                    :overline nil
                    :underline nil)
;; 禁用自动生成的文件
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)
(setq site-run-file nil)
;; 隐藏启动消息
(setq inhibit-startup-message t)
;; 优化
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)
;; 字体
(push '(font . "JetBrains Mono-14") default-frame-alist)
;; 1. 设置窗口框架参数
(push '(background-color . "#272822") default-frame-alist)
(push '(foreground-color . "#F8F8F2") default-frame-alist)
(push '(cursor-color     . "#E6DB74") default-frame-alist)

;; 2. 设置选中区域颜色
(add-hook 'window-setup-hook
          (lambda ()
            ;; 背景设为浅黄色，前景设为深色以保证文字可读性
            (set-face-attribute 'region nil :background "#E6DB74" :foreground "#272822")))    
