;;************************************************************
;; 関数
;;************************************************************
;; バッファ内の不要なスペース／タブのクリア
(defun clear-buffer ()
  "Clear buffer's useless spaces and tabs."
  (interactive)
  (save-excursion
    (save-restriction
      (mark-whole-buffer)
      (untabify (point)(mark))
      (mark-whole-buffer)
      (replace-regexp "[\t 　]*$" ""))))

;; 折り返しモードのスイッチ
(defun truncate-switch ()
  (interactive)
  (setq truncate-lines
	(if truncate-lines
	    (progn (message "truncate-off") nil)
	  (progn (message "truncate-on") t)))
  (redraw-display))
(define-key ctl-x-map "t" 'truncate-switch)

(defun my-get-date-gen (form) (insert (format-time-string form))) 
(defun my-get-date () (interactive) (my-get-date-gen "[%Y-%m-%d]")) 
(defun my-get-time () (interactive) (my-get-date-gen "[%H:%M]")) 
(defun my-get-dtime () (interactive) (my-get-date-gen "[%Y-%m-%d %H:%M]")) 
(global-set-key "\C-c\C-d" 'my-get-date) 
(global-set-key "\C-c\C-t" 'my-get-time) 
(global-set-key "\C-c\ed" 'my-get-dtime) 

