;;; -------------------------
;;; Better completion matching
;;; -------------------------
(use-package orderless
  :custom
  ;; 让补全候选支持更灵活的匹配
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  ;; 文件名建议保留 basic/partial-completion，避免 orderless 影响路径补全体验
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;; -------------------------
;;; Corfu: completion UI
;;; -------------------------
(use-package corfu
  :custom
  (corfu-cycle t)                 ;; 候选循环
  (corfu-auto t)                  ;; 自动弹出补全
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 1)
  (corfu-on-exact-match 'insert)  ;; 精确匹配直接插入
  (corfu-scroll-margin 5)
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode)
  :config
  ;; 让 corfu-popupinfo / corfu-history 作为扩展启用
  (corfu-history-mode 1)
  (corfu-popupinfo-mode 1)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("RET" . corfu-insert)
        ([return] . corfu-insert)
        ("M-d" . corfu-popupinfo-toggle)))

;;; -------------------------
;;; Cape: extra CAPF sources
;;; -------------------------
(use-package cape
  :init
  ;; 给 CAPF 增加一些通用补全源（可按需删减）
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;;; -------------------------
;;; Emacs built-in completion behavior
;;; -------------------------
(use-package emacs
  :custom
  (completion-cycle-threshold 3)
  (tab-always-indent 'complete)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (text-mode-ispell-word-completion nil))

;;; -------------------------
;;; LSP: lsp-mode + pyright
;;; -------------------------
(use-package lsp-mode
  :custom
  ;; 关键：让 LSP 补全走 CAPF，这样 corfu 才能显示 LSP 候选
  (lsp-completion-provider :capf)
  (lsp-prefer-capf t)
  (lsp-enable-snippet t)
  (lsp-idle-delay 0.25)
  :commands (lsp lsp-deferred)
  :hook
  ((python-mode . lsp-deferred)))

;; 可选：让界面更友好（诊断列表/符号树等）
(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-hover t)
  :hook
  (lsp-mode . lsp-ui-mode))

;; Pyright 客户端（推荐）
(use-package lsp-pyright
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)))
  :custom
  ;; 让 pyright 用你当前的 python 环境（可按需改）
  (lsp-pyright-python-executable-cmd "python3")
  )

;;; -------------------------
;;; Python basic editing defaults
;;; -------------------------
(use-package python
  :ensure nil
  :hook
  (python-mode . (lambda ()
                   (setq tab-width 4)
                   (setq python-indent-offset 4))))

;;; -------------------------
;;; Quality-of-life
;;; -------------------------
;; 在 minibuffer 里也能用补全（可选）
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)
;; vim keying
(use-package evil
  :ensure t
  :config
  (evil-mode 1))




(provide 'init-code)
