;;************************************************************
;; エディットモードの設定
;;************************************************************
;(setq auto-mode-alist  '(
;			 ("\\.text$" . text-mode)
;			 ("\\.mss$" . text-mode)
;			 ("\\.tex$" . tex-mode)
;			 ("/\\..*emacs" . emacs-lisp-mode)
;			 ("\\.el$" . emacs-lisp-mode)
;			 ("\\.ml$" . lisp-mode)
;			 ("\\.l$" . lisp-mode)
;			 ("\\.lisp$" . lisp-mode)
;			 ("\\.ol$" . outline-mode)
;			 ("\\.pl$" . perl-mode)
;			 ("\\.tcl$" . tcl-mode)
;			 ("\\.tk$" . tcl-mode)
;			 ("\\.xml$" . xml-mode)
;			 ("\\.*$" . text-mode)
;			 ("\\$" . text-mode)))

(setq default-major-mode 'text-mode)
(setq default-fill-column 78)
(setq default-truncate-lines nil)	; 行の折り返しをするか
(setq next-screen-context-lines 2)	; C-vやM-vで重なる行数
(setq blink-matching-paren t)		; かっこの対応表示をするか
(setq scroll-step 1)	;; pointがウィンドウから出た時にスクロールする行数
(setq page-delimiter "")

(setq text-mode-hook '(lambda ()
			(auto-fill-mode 1)))

(setq outline-mode-hook '(lambda ()
			   ;(setq truncate-lines t)
			   (hide-body)))

