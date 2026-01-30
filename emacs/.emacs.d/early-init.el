;;; early-init.el -*- lexical-binding: t -*-

;;; Garbage Collection
(defvar file-name-handler-alist-original file-name-handler-alist)
(defvar vc-handled-backends-original vc-handled-backends)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(setq package-enable-at-startup nil)

;;; Performance
(setq site-run-file nil
      use-dialog-box nil
      use-file-dialog nil
      x-gtk-use-system-tooltips nil
      tooltip-delay 0.1
      read-process-output-max (* 8 1024 1024)
      inhibit-compacting-font-caches t
      x-underline-at-descent-line t
      redisplay-skip-fontification-on-input t
      frame-inhibit-implied-resize t
      vc-handled-backends nil
      file-name-handler-alist nil
      kill-ring-max 100000
      bidi-inhibit-bpa t
      ns-use-proxy-icon nil
      auto-mode-case-fold nil
      frame-title-format nil
      frame-resize-pixelwise t
      fast-but-imprecise-scrolling t
      debug-on-error t)

(setq idle-update-delay 1.0
      load-prefer-newer t)

(setq font-lock-maximum-decoration t
      font-lock-multiline t
      font-lock-support-mode 'jit-lock-mode
      jit-lock-stealth-time 1
      jit-lock-defer-time 0
      jit-lock-stealth-nice 0.1
      jit-lock-chunk-size 100)

(setq-default bidi-display-reordering nil
	          bidi-paragraph-direction 'left-to-right)


;;; Minimal Frame 
(push '(vertical-scroll-bars) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(internal-border-width . 0) default-frame-alist)
(push '(undecorated-round . t) default-frame-alist)

(tooltip-mode -1)


;;; Font Config
(let ((mono-font "JetBrains Mono"))
  (set-face-attribute 'default nil :family mono-font :height 150)
  (set-face-attribute 'fixed-pitch nil :family mono-font :height 1.0)
  (set-face-attribute 'variable-pitch nil :family mono-font :height 1.0))


;;; Pesky Behaviour
(setq inhibit-startup-buffer-menu t
      inhibit-startup-echo-area-message user-login-name
      initial-major-mode 'fundamental-mode
      inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-screen t
      inhibit-default-init t
      initial-scratch-message nil)


;;; Native Comp
(when (featurep 'native-compile)
  (setq native-comp-async-report-warnings-errors nil
        native-comp-deferred-compilation t))

;;; UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)


;;; Startup Timer
(defun zen/display-startup-time ()
  (message "📑 loaded in %s with %d 🚮"
           (format "%.2f ⌛"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))


;;; Hooks
(add-hook 'emacs-startup-hook
          (lambda ()
            (zen/display-startup-time)
            (set-frame-parameter nil 'alpha-background 95)
            (add-to-list 'default-frame-alist '(alpha-background . 95))
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1
                  vc-handled-backends vc-handled-backends-original
                  file-name-handler-alist file-name-handler-alist-original)))
;;custom
(setq custom-file (locate-user-emacs-file "var/custom.el"))
(load custom-file :no-error-if-missing)
;; 关键：修改背景色 (去除截图里的亮灰色条)
(set-face-attribute 'mode-line nil
                    :background "#272822"  ; 设为与背景同色，或者稍亮 #3E3D32
                    :foreground "#F8F8F2"
                    :box nil               ; 必须去掉 box，否则会有 3D 边框
                    :overline nil
                    :underline nil)
;; 设置窗口框架参数
(push '(background-color . "#272822") default-frame-alist)
(push '(foreground-color . "#F8F8F2") default-frame-alist)
(push '(cursor-color     . "#E6DB74") default-frame-alist)

;; 设置选中区域颜色
(add-hook 'window-setup-hook
          (lambda ()
            ;; 背景设为浅黄色，前景设为深色以保证文字可读性
            (set-face-attribute 'region nil :background "#E6DB74" :foreground "#272822")))    
;; 禁用自动生成的文件
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)
(setq site-run-file nil)

(provide 'early-init)
