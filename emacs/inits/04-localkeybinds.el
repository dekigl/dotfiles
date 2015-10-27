;;************************************************************
;; ローカルなキーバインドの定義
;;************************************************************
(define-key esc-map "C" '(lambda()
   (interactive)
   (insert "----- =-8 ---------- =-8 ---------- =-8 ---------- =-8 -----")
   (insert ?\n)))
(define-key esc-map "T" '(lambda()
   (interactive)
   (insert "--(ここから)--------- >8 ----------- =8 ----------- >8 -----")
   (insert ?\n)))
(define-key esc-map "B" '(lambda()
   (interactive)
   (insert "--(ここまで)--------- >8 ----------- =8 ----------- >8 -----")
   (insert ?\n)))
(define-key ctl-x-map ":" 'goto-line)
(define-key ctl-x-map "\C-n" nil)
(put 'set-goal-column 'disabled t)

;(global-set-key "\C-\\" 'undo)

(define-key ctl-x-map "l" 'what-page)
(define-key ctl-x-map "v" 'shrink-window)
(define-key esc-map "o" 'overwrite-mode)
(define-key global-map [home]		'beginning-of-line)
(define-key global-map [end]		'end-of-line)


