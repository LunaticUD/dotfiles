(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (;; 选择相同对象（最常用）
   ("C->"     . mc/mark-next-like-this)
   ("C-<"     . mc/mark-previous-like-this)
   ("C-c C->" . mc/mark-all-like-this)
   ("C-\"" . mc/skip-to-next-like-this)
   ;; 行级多光标
   ("C-S-c C-S-c" . mc/edit-lines)))

(provide 'init-cursor)
