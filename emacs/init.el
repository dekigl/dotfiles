;;************************************************************
;; パスの定義
;;************************************************************
(setq load-path (cons
	(expand-file-name "~/dotfiles/emacs/elisp")	;; private
	load-path))

;;************************************************************
;; package.el
;;************************************************************
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

					;
;;************************************************************
;; init-loader
;;************************************************************
(require 'init-loader)
(setq init-loader-show-log-after-init 'error-only)
(init-loader-load "~/dotfiles/emacs/inits")
