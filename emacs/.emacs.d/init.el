;; 1. 将 lisp 目录加入加载路径
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; 2. 保持 init.el 干净：将 Emacs 自动生成的配置 (M-x customize) 存到独立文件
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
;; 3. 依次加载模块
(require 'init-packages)
(require 'init-base)
(require 'init-code)
