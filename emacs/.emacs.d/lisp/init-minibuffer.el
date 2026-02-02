;; 1. Vertico: 垂直补全 UI（轻量，建议直接开）
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t)
  :bind
  (:map vertico-map
        ("C-n" . vertico-next)
        ("C-p" . vertico-previous)
	("RET" . vertico-directory-enter)
        ("<return>" . vertico-directory-enter)))

;; 2. Orderless: 匹配逻辑（必须尽早设置 completion-styles）
(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; 3. Marginalia: 注解（建议延迟到首次 minibuffer 使用时再开）
(use-package marginalia
  :ensure t
  :defer t
  :hook (minibuffer-setup . marginalia-mode))

;; 4. Consult: 增强命令（按键触发加载，已经是延迟）
(use-package consult
  :load-path "~/.emacs.d/elpa/consult"
  :defer t
  :custom
  (setq consult-buffer-filter '("\\`\\*.*\\*\\'"))
  :bind (("C-s" . consult-line)
         ("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)))
(add-hook 'minibuffer-setup-hook
          (lambda ()
            (when (bound-and-true-p display-line-numbers-mode)
              (display-line-numbers-mode -1))))
(use-package all-the-icons-completion
  :ensure t
  :defer t
  :after marginalia
  ;; marginalia 真正启用时再加载图标支持
  :hook (marginalia-mode . (lambda ()
                             (require 'all-the-icons-completion)
                             (all-the-icons-completion-mode 1)
                             (all-the-icons-completion-marginalia-setup))))


(provide 'init-minibuffer)
