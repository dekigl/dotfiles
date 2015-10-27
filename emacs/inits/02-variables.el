;;************************************************************
;; 変数の設定
;;************************************************************
(setq require-final-newline t)
(setq visible-bell t)
(setq next-line-add-newlines nil)
(line-number-mode 1)
(put 'upcase-region 'disabled nil)

;; GCの頻度を下げる. デフォルト->400000
;(setq gc-cons-threshold 5242880)
