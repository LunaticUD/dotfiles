(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :config
  (setq dirvish-attributes
        '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
  :bind (("C-x d" . dirvish)
         :map dirvish-mode-map
         ("a"   . dirvish-quick-access)
         ("TAB" . dirvish-subtree-toggle)
         ("q"   . dirvish-quit)))

(provide 'init-dired)
