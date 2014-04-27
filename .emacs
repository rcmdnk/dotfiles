;;; .emacs
;;;; uncomment this line to disable loading of "default.el" at startup
;;; (setq inhibit-default-init t)
;
;;; turn on font-lock mode
;(global-font-lock-mode t)
;
;;; enable visual feedback on selections
;;(setq transient-mark-mode t)
;      
;;; scratch モードの最初のメッセージは消す
;(setq initial-scratch-message nil) 
;
;;;wanderlust
;(autoload 'wl "wl" "Wanderlust" t)
;(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
;
;;; 日本語が化けないようにする
;(set-language-environment "Japanese")
;(set-default-coding-systems 'euc-jp-unix)
;(set-terminal-coding-system 'euc-jp-unix)
;(set-keyboard-coding-system 'euc-jp-unix)
;(set-buffer-file-coding-system 'euc-jp-unix)
;
;;;スクロールを1行単位にする
;(setq scroll-step 1)
;
;;;以前編集したファイルのカーソル位置を覚える
;;;(~/.emacs-places に記録される)
;(require 'saveplace)
;(setq-default save-place t)
;
;;;DEL を DEL(C-d)
;;;に割り当てる(デフォルトは BS)
;;(require 'saveplace)
;;(setq-default save-place t)
;
;
;;;;
;;;; for canna
;;;;
;
;;;(if (and (boundp 'CANNA) CANNA) ; 『かんな/emacs』であることを確認
;;;    ;;かんな/emacsの場合のみ以下を実行する
;;;    (progn
;;;    ;;;      (setq canna-underline t)   ;アンダーラインスタイル
;;;      (setq default-input-method 'japanese-canna)
;;;      (load-library "canna")
;;;      (setq canna-do-keybind-for-functionkeys nil)
;;;      (setq canna-server "localhost")
;;;      (canna)
;;;      
;;;    ;;; かんなでのリージョンの単語登録を C-tで行う
;;;      (global-set-key "\C-t" 'canna-touroku-region)
;;;      
;;;      
;;;    ;;; アンドゥの設定
;;;      (global-set-key "\C-_" 'canna-undo)
;;;      
;;;      ;;      (setq canna-use-color t)
;;;      
;;;;;    ;;;かんなの変換中に BS & DEL を使う
;;;	;(define-key canna-mode-map [backspace] [?\C-h])
;;;	;(define-key canna-mode-map [delete] [?\C-h])
;;;      
;;;    ;;;かんなの変換中に C-h を使う (with term/keyswap)
;;;    ;;;(define-key canna-mode-map [?\177] [?\C-h])
;;;      
;;;      (global-set-key "\C-\\" 'canna-toggle-japanese-mode)
;;;      (global-unset-key [kanji])
;;;      (global-set-key "\C-o" 'open-line)
;;;      )
;;;  )
;;;
;;;;; "nn" で「ん」を入力
;;;(setq enable-double-n-syntax t)
;
;;;(setq default-input-method 'japanese)
;
;
;
;
;;;;
;;;;w3mの設定
;;;;
;;; M-x w3mでw3mを起動する設定
;(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;
;;; M-x w3m-find-fileとして、ページャとしてのw3mの機能を利用する。
;(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)
;
;;; browse-url w3m
;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;(setq browse-url-browser-function 'w3m-browse-url)
;;; URIらしき部分を選択してC-xmするとemacs-w3m起動
;(global-set-key "\C-xm" 'browse-url-at-point)
;;; M(shift+m)した時のブラウザの設定。
;(setq browse-url-netscape-program "~/bin/open_navigator.sh")
;;; mailtoのURIを押下した時の設定 本当はこれではだめらしい。。
;(setq w3m-mailto-url-function 'wl-draft)
;
;;; 検索の設定 M-x w3m-search
;(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
;;; 検索をGoogle(日本語サイト)でおこなう
;(setq w3m-search-default-engine "google-ja")
;;; C-csを押下するとどのBufferからでも検索を開始
;(global-set-key "\C-cs" 'w3m-search)
;
;(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
;(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)
;;formに入力可能とする。今は不要かもしれない
;(setq w3m-use-form t)
;;うまく起動しない場合以下を設定してみるとよい
;;(setq w3m-command "/usr/local/bin/w3m")
;;初期起動時に表示する画面
;;(setq w3m-home-page "/Users/sakito/.w3m/bookmark.html")
;;画像を表示しない。必要ではないがとりあえず
;(setq w3m-display-inline-image nil)
;
;  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; 改行防止設定
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(setq next-line-add-newlines nil)
;
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; 行番号・桁番号の表示設定
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(line-number-mode t) ; 行番号
;(column-number-mode t) ; 桁番号
;
;
;(custom-set-variables
; '(jde-compiler (quote ("javac" "")))
; '(load-home-init-file t t))
;(custom-set-faces)
;
;
;;; Always end a file with a newline
;(setq require-final-newline t)
;
;;; Stop at the end of the file, not just add lines
;(setq next-line-add-newlines nil)
;
;
;;; Visual feedback on selections
;(setq-default transient-mark-mode t)
; 
;;; Enable wheelmouse support by default
;(cond (window-system
;       (mwheel-install)
;))
;
;
;;; Set up the keyboard so the delete key on both the regular keyboard
;;; and the keypad delete the character under the cursor and to the right
;;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
;(global-set-key [kp-delete] 'delete-char)
;
;(setq tex-default-mode 'latex-mode)
;;; C-c C-f で platex を実行
;(setq latex-run-command "platex")
;;; C-c C-v で pxdvi を起動
;(setq tex-dvi-view-command "pxdvi")
;;; C-c C-p で pdvips を実行
;(setq tex-dvi-print-command "pdvips")
;;; [esc]→[x]→[tex-alt-print] で用紙を設定して dvips を実行
;;(setq tex-alt-dvi-print-command
;;　　'(format "pdvips -t%s" (read-string "Use paper: ")))
;;; 上記「用紙を設定して dvips を実行」を C-c C-q に割り当てる設定
;;(add-hook 'tex-mode-hook
;;　　'(lambda () (local-set-key "\C-c\C-q" 'tex-alt-print)))
;
;
;;;for time stamp
;(add-hook 'write-file-hooks 'time-stamp)
;
;;;ビープ音
;(setq visible-bell t);;エラー時反転
;
;
;(setq viper-mode t)
;(require 'viper)
;
;;;(set-keyboard-coding-system 'euc-japan)
