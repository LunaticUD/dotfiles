;; 你的 init-custom.el 路径（按需改）
(defvar my/custom-file (expand-file-name "custom-defun.el" user-emacs-directory)
  "File that contains my custom interactive commands.")

(defun my/load-custom-file ()
  "Load `my/custom-file` if it exists."
  (when (file-exists-p my/custom-file)
    (load my/custom-file nil 'nomessage)))

(defun my/commands-defined-in-file (file)
  "Return interactive commands whose definition comes from FILE."
  (let ((true (file-truename file))
        (out '()))
    (mapatoms
     (lambda (sym)
       (when (and (fboundp sym)
                  (commandp sym)
                  (let ((src (ignore-errors (symbol-file sym 'defun))))
                    (and src (string= (file-truename src) true))))
         (push sym out))))
    (sort out (lambda (a b) (string< (symbol-name a) (symbol-name b))))))

(defun my/run-custom-command ()
  "Load `my/custom-file`, then pick a command defined in it and run."
  (interactive)
  (my/load-custom-file)
  (let* ((cmds (my/commands-defined-in-file my/custom-file)))
    (unless cmds
      (user-error "No interactive commands found in %s" my/custom-file))
    (let* ((cands (mapcar (lambda (sym) (cons (symbol-name sym) sym)) cmds))
           (choice (completing-read "Run custom command: " cands nil t)))
      (call-interactively (cdr (assoc choice cands))))))

(global-set-key (kbd "C-c r") #'my/run-custom-command)


(provide 'init-custom)
