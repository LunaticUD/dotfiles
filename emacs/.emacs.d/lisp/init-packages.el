(require 'package)
(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
;; 启用 use-package
(eval-when-compile
  (require 'use-package))

;; 让 use-package 默认总是安装缺失的包
(setq use-package-always-ensure t)

(provide 'init-packages) 
