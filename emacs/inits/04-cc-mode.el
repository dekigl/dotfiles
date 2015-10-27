;;************************************************************
;; cc-modeの設定
;;************************************************************
(fmakunbound 'c-mode)
(makunbound 'c-mode-map)
(fmakunbound 'c++-mode)
(makunbound 'c++-mode-map)
(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode   "cc-mode" "C Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
		("\\.cc$" . c++-mode)
		("\\.cpp$" . c++-mode)
		("\\.c$"  . c-mode)   ; to edit C code
		("\\.h$"  . c-mode)   ; to edit C code
		("\\.m$"  . objc-mode)
		("\\.mm?$"  . objc-mode)
		("\\.java$"  . java-mode)
		("\\.js$"  . js-mode)
		) auto-mode-alist))

(add-hook 'js-mode-hook
	  '(lambda()
	     (set tab-width 4)))

