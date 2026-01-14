(use-package org
  :ensure nil
  :hook (org-mode . org-indent-mode)
  :config
  (setq org-directory "~/org/"
        org-ellipsis " ▾"
        org-src-fontify-natively t
        org-todo-keywords '((sequence "TODO" "WAIT" "|" "DONE"))))

;; 现代化美化
(use-package org-modern
  :ensure t
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)))

(provide 'init-org)
