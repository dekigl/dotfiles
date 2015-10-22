;;************************************************************
;; パスの定義
;;************************************************************
(setq load-path (cons
	(expand-file-name "~/emacs/lisp")	;; private
	load-path))

;;************************************************************
;; package.el
;;************************************************************
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;************************************************************
;; 言語設定
;;************************************************************
; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; フォント設定
;(if window-system
;    ((create-fontset-from-ascii-font "Menlo-14:weight=normal:slant=normal" nil "menlokakugo")
;     (set-fontset-font "fontset-menlokakugo"
;		       'unicode
;		       (font-spec :family "Hiragino Kaku Gothic ProN" :size 16)
;		       nil
;		       'append)
;     (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))
;     ))

;; cocoa emacs 24のフォント設定
;; https://gist.github.com/yoshinari-nomura/3465571
(when (and (>= emacs-major-version 24)
           (eq window-system 'ns))
  ;; フォントセットを作る
  (let* ((fontset-name "myfonts") ; フォントセットの名前
         (size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
         (asciifont "Menlo") ; ASCIIフォント
         (jpfont "Hiragino Maru Gothic ProN") ; 日本語フォント
         (font (format "%s-%d:weight=normal:slant=normal" asciifont size))
         (fontspec (font-spec :family asciifont))
         (jp-fontspec (font-spec :family jpfont)) 
         (fsn (create-fontset-from-ascii-font font nil fontset-name)))
    (set-fontset-font fsn 'japanese-jisx0213.2004-1 jp-fontspec)
    (set-fontset-font fsn 'japanese-jisx0213-2 jp-fontspec)
    (set-fontset-font fsn 'katakana-jisx0201 jp-fontspec) ; 半角カナ
    (set-fontset-font fsn '(#x0080 . #x024F) fontspec)    ; 分音符付きラテン
    (set-fontset-font fsn '(#x0370 . #x03FF) fontspec)    ; ギリシャ文字
    )
 
  ;; デフォルトのフレームパラメータでフォントセットを指定
  (add-to-list 'default-frame-alist '(font . "fontset-myfonts"))
 
  ;; フォントサイズの比を設定
  (dolist (elt '(("^-apple-hiragino.*"               . 1.2)
		 (".*osaka-bold.*"                   . 1.2)
		 (".*osaka-medium.*"                 . 1.2)
		 (".*courier-bold-.*-mac-roman"      . 1.0)
		 (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
		 (".*monaco-bold-.*-mac-roman"       . 0.9)))
    (add-to-list 'face-font-rescale-alist elt))
 
  ;; デフォルトフェイスにフォントセットを設定
  ;; # これは起動時に default-frame-alist に従ったフレームが
  ;; # 作成されない現象への対処
  (set-face-font 'default "fontset-myfonts"))

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

;;************************************************************
;; ローカルなキーバインドの定義
;;************************************************************
;(define-key ctl-x-map "v" '(lambda ()
;			     (interactive);			     (scroll-up 10)))
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


;;************************************************************
;; auto-complete
;;************************************************************
(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)
(ac-config-default)

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

;;************************************************************
;; ruby
;;************************************************************
;; ruby-mode
;(autoload 'ruby-mode "ruby-mode"
;  "Mode for editing ruby source files" t)
;(setq auto-mode-alist
;      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;    				     interpreter-mode-alist))
;
;(setq ruby-use-encoding-map nil)
;
;;; inf-ruby
;(autoload 'run-ruby "inf-ruby"
;  "Run an inferior Ruby process")
;(autoload 'inf-ruby-keys "inf-ruby"
;  "Set local key defs for inf-ruby in ruby-mode")
;(add-hook 'ruby-mode-hook
;          '(lambda ()
;             (inf-ruby-keys)
;	     ))

;;************************************************************
;; motion-mode
;;************************************************************
(require 'motion-mode)
;; following add-hook is very important.
(add-hook 'ruby-mode-hook 'motion-recognize-project)
(add-to-list 'ac-modes 'motion-mode)
(add-to-list 'ac-sources 'ac-source-dictionary)
;; set key-binds as you like
(define-key motion-mode-map (kbd "C-c C-c") 'motion-execute-rake)
(define-key motion-mode-map (kbd "C-c C-d") 'motion-dash-at-point)


;;************************************************************
;; 最後に
;;************************************************************
;; サーバモードで起動する。
;(server-start)

;; gnuserv
;(require 'gnuserv)
;(gnuserv-start)

