;; 延迟加载
(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/miniforge3")
        conda-env-home-directory (expand-file-name "~/miniforge3/envs")
        conda-env-autoactivate-mode nil)
  :defer t
  :config
  ;; init once, only when you actually activate an env
  (defvar my/conda-initialized nil)
  (defun my/conda-init-once (&rest _)
    (unless my/conda-initialized
      (setq my/conda-initialized t)
      (conda-env-initialize-interactive-shells)
      (conda-env-initialize-eshell)))
  (advice-add 'conda-env-activate :before #'my/conda-init-once)

  ;; mode-line
  (add-to-list 'global-mode-string
               '(:eval (let ((name (and (boundp 'conda-env-current-name)
                                        conda-env-current-name)))
                        (when (and name (stringp name)
                                   (not (string-empty-p name)))
                          (format " 🐍(%s)" name)))))

  :bind
  (("C-c v" . conda-env-activate)
   ("C-c V" . conda-env-deactivate)))


(provide 'init-conda)
