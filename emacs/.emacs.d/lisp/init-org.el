;;============================================
;; 1. 基础设置
;;============================================
(setq org-hide-emphasis-markers t)  ;; 隐藏强调标记
;; Org 知识库根目录
(setq org-directory "~/org")
;; 默认收集箱文件
(setq org-default-notes-file "~/org/inbox.org")

;;============================================
;; 2. org-capture 收集系统
;;============================================
;; Capture 快捷键
(global-set-key (kbd "C-c c") 'org-capture)
;; Capture 模板
(setq org-capture-templates
      '(;; 1. 快速记录笔记（进入 inbox）
        ("n" "Quick Note" entry
         (file+headline "~/org/inbox.org" "Notes")
         "* %?\n %U\n")
        ;; 2. 快速记录任务（进入 projects）
        ("t" "Todo Task" entry
         (file+headline "~/org/projects.org" "Tasks")
         "* TODO %?\n %U\n")
        ;; 3. 日记记录（进入 journal）
        ("j" "Journal" entry
         (file+datetree "~/org/journal.org")
         "* %?\n %U\n")
        ;; 4. 阅读笔记（进入 reading.org）
        ("r" "Reading Note" entry
         (file+headline "~/org/notes/reading.org" "Reading")
         "* %^{Title}\n %U\n %?\n")
        ))
;; 快速切换 index
(global-set-key (kbd "C-c s i")
                (lambda () (interactive)
                  (find-file "~/org/index.org")))

;;============================================
;; 3. org-bullets 美化
;;============================================
(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . (lambda ()
                      (org-bullets-mode 1)
                      (org-indent-mode 1)))
  :custom (org-bullets-bullet-list '("◉" "○" "✸" "✿" "◆" "▶"))
  :config
  ;; 不让 org-indent 自动隐藏星号
  (setq org-indent-mode-turns-on-hiding-stars nil))
;; 隐藏标题前的星号（org-bullets 会显示符号）
(setq org-hide-leading-stars t)

;;============================================
;; 4. org-roam 双链笔记系统
;;============================================
;; 先定义时间戳更新函数（必须在 use-package 之前）
(defun pv/org-find-time-file-property (property &optional anywhere)
  "返回时间文件 PROPERTY 的位置"
  (save-excursion
    (goto-char (point-min))
    (let ((first-heading (save-excursion (re-search-forward org-outline-regexp-bol nil t))))
      (when (re-search-forward (format "^#\\+%s:" property)
                                (if anywhere nil first-heading) t)
        (point)))))
(defun pv/org-set-time-file-property (property &optional anywhere pos)
  "在 preamble 中设置时间文件 PROPERTY"
  (when-let ((pos (or pos (pv/org-find-time-file-property property))))
    (save-excursion
      (goto-char pos)
      (if (looking-at-p " ") (forward-char) (insert " "))
      (delete-region (point) (line-end-position))
      (let* ((now (format-time-string "[%Y-%m-%d %a %H:%M]")))
        (insert now)))))
(defun pv/org-set-last-modified ()
  "更新 LAST_MODIFIED 文件属性"
  (when (derived-mode-p 'org-mode)
    (pv/org-set-time-file-property "last_modified")))
;; 保存文件时自动更新时间戳
(add-hook 'before-save-hook #'pv/org-set-last-modified)
(use-package org-roam
  :ensure t
  :after org
  :init
  (setq org-roam-v2-ack t)  ;; 确认 V2 升级
  :custom
  (org-roam-directory (concat org-directory "roam/"))  ;; 设置 org-roam 目录
  :config
  (org-roam-setup)  ;; 初始化
  ;; org-roam 模板
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new (file+head "${slug}-%<%Y%m%d%H%M%S>.org"
                    "#+title: ${title}\n#+date: %u\n#+last_modified: \n\n")
           :immediate-finish t)))
  ;; 快捷键绑定
  :bind
  ("C-c n f" . org-roam-node-find)  ;; 查找笔记
  (:map org-mode-map
        ("C-c n i" . org-roam-node-insert)  ;; 插入链接
        ("C-c n o" . org-id-get-create)      ;; 创建ID
        ("C-c n t" . org-roam-tag-add)       ;; 添加标签
        ("C-c n a" . org-roam-alias-add)     ;; 添加别名
        ("C-c n l" . org-roam-buffer-toggle) ;; 切换侧边栏
        ("C-c n d" . org-roam-dailies-goto-today) ;; 跳转今日日记
        ))


(provide 'init-org)