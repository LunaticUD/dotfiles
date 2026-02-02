;; Org 知识库根目录
(setq org-directory "~/org")
;; 默认收集箱文件
(setq org-default-notes-file "~/org/inbox.org")
;; Capture 快捷键
(global-set-key (kbd "C-c c") 'org-capture)
;; Capture 模板
(setq org-capture-templates
      '(
        ;; 1. 快速记录笔记（进入 inbox）
        ("n" "Quick Note" entry
         (file+headline "~/org/inbox.org" "Notes")
         "* %?\n  %U\n")

        ;; 2. 快速记录任务（进入 projects）
        ("t" "Todo Task" entry
         (file+headline "~/org/projects.org" "Tasks")
         "* TODO %?\n  %U\n")

        ;; 3. 日记记录（进入 journal）
        ("j" "Journal" entry
         (file+datetree "~/org/journal.org")
         "* %?\n  %U\n")

        ;; 4. 阅读笔记（进入 reading.org）
        ("r" "Reading Note" entry
         (file+headline "~/org/notes/reading.org" "Reading")
         "* %^{Title}\n  %U\n  %?\n")
        ))
;; 快速切换index
(global-set-key (kbd "C-c s i")
                (lambda ()
                  (interactive)
                  (find-file "~/org/index.org")))

(provide 'init-org)
