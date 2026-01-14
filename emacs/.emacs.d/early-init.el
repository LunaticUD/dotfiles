;;; early-init.el --- Early Initialization

;; 1. 禁止垃圾回收 (极大提升启动速度)
;; 在启动完成后，我们会再次把它调回来
(setq gc-cons-threshold most-positive-fixnum)
(setq-default mode-line-format nil)
;; 2. 在窗口出现前，就关掉 GUI 元素 (防止工具栏闪烁)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; 3. 【关键】预设背景颜色 (防止白屏闪烁)
;; 我们手动设置一个和 Doom-One 主题一致的深灰色背景
;; 这样 Emacs 一启动就是黑的，等主题加载完无缝衔接
(push '(background-color . "#1e1e2e") default-frame-alist)
(push '(foreground-color . "#cdd6f4") default-frame-alist)
;; 4. (可选) 预设字号和字体
;; 如果启动时字体忽大忽小，可以在这里指定，例如：
(push '(font . "LXGW WenKai-24") default-frame-alist)
;; 4. 禁止 package.el 在早期激活 (我们用 init.el 里的配置来管理)
(setq package-enable-at-startup nil)
