;; 自定义函数
(defun swap-cn-en-and-wrap-cn (beg end)
  "谷氨酸Glu -> Glu（谷氨酸）"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (re-search-forward
              "^\\s-*\\([[:multibyte:]]+\\)\\s-*\\([A-Za-z][A-Za-z0-9-]*\\)\\s-*$"
              nil t)
        (replace-match "\\2(\\1)" t)))))

(defun my-delete-between-chars (start-char end-char)
  "删除选区中从 START-CHAR 开始到 END-CHAR 之前的内容。
START-CHAR 会被删除，END-CHAR 会保留。"
  (interactive
   (list
    (read-char "请输入起始字符（会被删除）: ")
    (read-char "请输入结束字符（保留）: ")))
  (unless (use-region-p)
    (user-error "请先选中一段区域"))
  (save-excursion
    (save-restriction
      (narrow-to-region (region-beginning) (region-end))
      (goto-char (point-min))
      (while (search-forward (char-to-string start-char) nil t)
        (let ((del-start (match-beginning 0)))
          (if (search-forward (char-to-string end-char) nil t)
              ;; point 在 end-char 之后；要保留 end-char，所以删到 end-char 的位置（不含它）
              (delete-region del-start (1- (point)))
            ;; 没找到 end-char：删到选区末尾（也就是 point-max）
            (delete-region del-start (point-max))))))))


