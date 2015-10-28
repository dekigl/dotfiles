;; shellの環境変数を取り込む
;; http://syohex.hatenablog.com/entry/20130718/1374154709
(exec-path-from-shell-initialize)

; load environment variables
(let ((envs '("PATH" "http_proxy" "https_proxy")))
  (exec-path-from-shell-copy-envs envs))
