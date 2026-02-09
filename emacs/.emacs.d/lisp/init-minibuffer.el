;; ;; 1. Vertico: 垂直补全 UI（轻量，建议直接开）
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t)
  (vertico-resize t)   ;; 让高度随内容自动调整（配合 posframe 很重要）
  (vertico-count 7)    ;; 最大 12 行
  :bind
  (:map vertico-map
        ("C-n" . vertico-next)
        ("C-p" . vertico-previous)))

(use-package vertico-directory
  :ensure nil
  :after vertico
  :bind
  (:map vertico-map
        ("RET" . vertico-directory-enter)
        ("<return>" . vertico-directory-enter)
        ("DEL" . vertico-directory-delete-char)
        ("M-DEL" . vertico-directory-delete-word)))

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
;; iedit
(use-package iedit
  :ensure t
  :defer t
  :bind (("C-;" . iedit-mode)              ;; 进入/退出 iedit
         ("C-c ;" . iedit-mode)
         :map iedit-mode-keymap
         ("C-g" . iedit-mode)))            ;; 习惯用 C-g 退出
(with-eval-after-load 'iedit
  ;; iedit 模式里更像多光标那样跳转
  (define-key iedit-mode-keymap (kbd "M-n") #'iedit-next-occurrence)
  (define-key iedit-mode-keymap (kbd "M-p") #'iedit-prev-occurrence)
  (define-key iedit-mode-keymap (kbd "C-'") #'iedit-toggle-unmatched-lines-visible))
(defun my/consult-line-iedit ()
  "consult-line, then iedit on symbol/word at point."
  (interactive)
  (consult-line)
  (when-let ((sym (thing-at-point 'symbol t))
             (_ (not (string-empty-p sym))))
    (iedit-mode 1)))

(global-set-key (kbd "C-c i l") #'my/consult-line-iedit)

;; ;; Vertico Posframe: 用 posframe 浮动显示 Vertico 候选（替代 mini-frame 的“浮动感”）
;; (use-package vertico-posframe
;;   :ensure t
;;   :after vertico
;;   :init
;;   (when (display-graphic-p)
;;     (vertico-posframe-mode 1))
;;   :custom
;;   ;; 居中
;;   (vertico-posframe-poshandler #'posframe-poshandler-frame-center)
;;   ;; 宽度
;;   (vertico-posframe-width 80))


(provide 'init-minibuffer)
