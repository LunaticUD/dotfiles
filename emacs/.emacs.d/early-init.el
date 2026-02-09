;;; early-init.el -*- lexical-binding: t -*-
;; visual-fill-column

;; (add-hook 'text-mode-hook #'visual-line-mode)
;; (setq-default line-move-visual t)

;; (add-hook 'text-mode-hook
;;           (lambda () (setq-local fill-column 120)))

;; (add-hook 'prog-mode-hook
;;           (lambda () (setq-local fill-column 100)))

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
;; (set-face-attribute 'mode-line nil 
;;                     :height 1.2 )
;;; Minimal Frame 
(push '(vertical-scroll-bars) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(internal-border-width . 0) default-frame-alist)
(push '(undecorated-round . t) default-frame-alist)

(tooltip-mode -1)

;; Font Config	
(let ((mono "Maple Mono NF CN")
      (cjk  "LXGW Neo XiHei Plus"))
  (set-face-attribute 'default nil :family mono :height 150)
  (set-face-attribute 'fixed-pitch nil :family mono :height 150)
  (set-face-attribute 'variable-pitch nil :family mono :height 150)
  (set-fontset-font t 'ascii  (font-spec :family mono))
  (set-fontset-font t 'latin  (font-spec :family mono))
  (set-fontset-font t 'symbol (font-spec :family mono))
  ;; CJK 中文
  (dolist (charset '(han kana cjk-misc bopomofo))
    (set-fontset-font t charset (font-spec :family cjk :height 130))))

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


;; ;;; Startup Timer
;; (defun zen/display-startup-time ()
;;   (message "📑 loaded in %s with %d 🚮"
;;            (format "%.2f ⌛"
;;                    (float-time
;;                     (time-subtract after-init-time before-init-time)))
;;            gcs-done))


;;; Hooks
(add-hook 'emacs-startup-hook
          (lambda ()
            ;; (zen/display-startup-time)
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
                    :box nil            ; 必须去掉 box，否则会有 3D 边框
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

;; ----- 增强版 Python 运行配置 -----
(with-eval-after-load 'python
  ;; 1) 解释器设置：优先使用 IPython
  (cond
   ((executable-find "ipython3")
    (setq python-shell-interpreter "ipython3"
          python-shell-interpreter-args "-i --simple-prompt --no-autoindent"))
   (t
    (setq python-shell-interpreter "python3"
          python-shell-interpreter-args "-i")))

  ;; 禁用不稳定的原生补全（可选）
  (setq python-shell-completion-native-enable nil)

  ;; 2) 布局设置：Python REPL 窗口显示在右侧，占用 25% 宽度
  (add-to-list 'display-buffer-alist
               '("\\*Python\\*.*"
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . right)
                 (slot . 0)
                 (window-width . 0.25)))

  ;; --- 功能函数定义 ---

  (defun my/python-repl-toggle ()
    "切换 Python REPL。如果正在运行，则关闭进程并杀死缓冲区；如果未运行，则在右侧启动它。"
    (interactive)
    (let ((proc (python-shell-get-process)))
      (if (and proc (process-live-p proc))
          ;; 关闭逻辑
          (let ((buf (process-buffer proc)))
            (delete-windows-on buf) ; 同时关闭显示该缓冲区的窗口
            (kill-process proc)
            (when (buffer-live-p buf)
              (kill-buffer buf))
            (message "Python REPL killed"))
        ;; 启动逻辑
        (run-python (python-shell-calculate-command) nil nil)
        (let ((new-proc (python-shell-get-process)))
          (when new-proc
            (display-buffer (process-buffer new-proc)))))))

  (defun my/python-send-selection-or-line ()
    "发送选区或当前行到 Python REPL。如果 Region 激活，发送选区；否则发送当前行。如果 REPL 未启动，会自动启动。"
    (interactive)
    ;; 检查并启动 REPL
    (unless (and (python-shell-get-process)
                 (process-live-p (python-shell-get-process)))
      (my/python-repl-toggle))
    
    (if (use-region-p)
        (let ((beg (region-beginning))
              (end (region-end)))
          (python-shell-send-region beg end)
          (deactivate-mark)
          (message "Sent region to Python"))
      (progn
        (python-shell-send-region (line-beginning-position) (line-end-position))
        (message "Sent line to Python"))))

  ;; --- 按键绑定 ---

  ;; 针对标准 python-mode
  (let ((map python-mode-map))
    (define-key map (kbd "<f5>") #'my/python-repl-toggle)
    (define-key map (kbd "<C-return>") #'my/python-send-selection-or-line)
    (define-key map (kbd "<S-return>") #'my/python-send-selection-or-line)
    (define-key map (kbd "C-c C-c") #'python-shell-send-buffer))

  ;; 针对 Emacs 29+ 的 python-ts-mode (Tree-sitter)
  (when (boundp 'python-ts-mode-map)
    (let ((map python-ts-mode-map))
      (define-key map (kbd "<f5>") #'my/python-repl-toggle)
      (define-key map (kbd "<C-return>") #'my/python-send-selection-or-line)
      (define-key map (kbd "<S-return>") #'my/python-send-selection-or-line)
      (define-key map (kbd "C-c C-c") #'python-shell-send-buffer))))




(provide 'early-init)
