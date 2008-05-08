(add-to-list 'load-path "~/.emacs.d/")

(load "tjs.el") ;; Custom functionality

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-startup-echo-area-message (user-login-name))
(setq fill-column 78)        ;; the default, 72, is a bit too narrow
(blink-cursor-mode -1)       ;; no blinking cursor
(setq indent-tabs-mode nil)  ;; tabs are evil, always use spaces instead
(ido-mode t)                 ;; *very* nice buffer switching mode
(tool-bar-mode -1)           ;; i never use the tool bar anyways
(column-number-mode 1)       ;; show column number in status bar
(global-hl-line-mode 1)      ;; highlights the current line
(transient-mark-mode 1)      ;; show current selection

;; use Mac-like keys, but let Option = Meta.  This disables input of
;; special characters, but when do I need this anyways.
(require 'mac-key-mode)
(add-hook 'mac-key-mode-hook
	  (lambda() 
	    (interactive)
	    (if mac-key-mode
		(setq mac-option-modifier 'meta)
	      (setq mac-option-modifier nil) )))
(mac-key-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Global Keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Switching windows with C-TAB feels nicer.  I use TAB / M-TAB for
;; completion (depending on major mode).
(global-set-key [(control tab)] 'other-window)
;(global-set-key [(alt c)] 'clipboard-kill-ring-save)

;; On a MacBook running Ubuntu, Hyper is the Apple key.  On Aquamacs
;; this is set by default.
;(global-set-key [(hyper ?v)] 'yank)
;(global-set-key [(hyper ?c)] 'kill-ring-save)
;(global-set-key [(hyper ?s)] 'save-buffer)

;; I don't use those, ATM
;(define-key global-map [f2] 'bookmark-jump)
;(define-key global-map [(alt f2)] 'bookmark-set)
;(define-key global-map [(alt ?\-)] 'dabbrev-expand)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color Theme Stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")

(load "~/.emacs.d/.current_color_theme")
(my-color-theme)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ERC configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(require 'erc-nick-colors)

;; Enables growl notifications from within emacs
;(require 'growl)

;; (defun my-erc-hook (match-type nick message)
;;   "Shows a growl notification, when user's nick was mentioned.
;; If the buffer is currently not visible, makes it sticky."
;;   (and (eq match-type 'current-nick)
;;        (growl (concat "Your nick was mentioned on: "
;; 		      (buffer-name (current-buffer)))
;; 	      message
;; 	      (not (erc-buffer-visible (current-buffer))))))

;; (add-hook 'erc-text-matched-hook 'my-erc-hook)

;(require 'snippet)

;; nxml completion conflicts with cua-mode.  Use M-Tab instead

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq nxml-bind-meta-tab-to-complete-flag t)

;(add-hook 'flyspell-mode-hook;
;; 	  (lambda ()
;; 	    ;; let flyspell only correct the text
;; 	    (add-to-list 'flyspell-prog-text-faces 'nxml-text-face)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(defun my-emacs-lisp-hook ()
  (paredit-mode)        ;; almost structural editing mode for lisp
  (flyspell-prog-mode)) ;; spell-check inside comments

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-hook)


;;
;; Version Control Stuff
;;

;(require 'psvn)
(require 'darcs)   ;; not sure I really need this
(require 'darcsum) ;; very handy.  Use: `darcsum-whatsnew' 

;(require 'flymake)

;; (defun flymake-haskell-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-with-folder-structure nil nil
;;     "Makefile" ;buffer-file-name
;;     'flymake-get-haskell-cmdline))

;; (defun flymake-get-haskell-cmdline (source base-dir)
;;   `("ghc" ("--make" "-fno-code" ,(concat "-i" base-dir) ,source)))

;; (push '(".+\\.hs$" flymake-haskell-init)
;;       flymake-allowed-file-name-masks)
;; (push '(".+\\.lhs$" flymake-haskell-init)
;;       flymake-allowed-file-name-masks)
;; (push '("^\\(.*\\):\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)$" 1 2 3 4)
;;       flymake-err-line-patterns)

;; (defun credmp/flymake-display-err-minibuf ()
;; 	"Displays the error/warning for the current line in the
;; minibuffer"
;; 	(interactive)
;; 	(let* ((line-no             (flymake-current-line-no))
;; 				 (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;; 				 (count               (length line-err-info-list)))
;; 		(while (> count 0)
;; 			(when line-err-info-list	
;; 				(let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;; 							 (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;; 							 (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;; 							 (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;; 					(message "[%s] %s" line text)))
;; 			(setq count (1- count)))))


;;
;; Haskell Mode Stuff
;;

;(add-to-list 'load-path "~/Devel/Haskell/shim/")

(load "~/.emacs.d/haskell-mode-2.3/haskell-site-file")


(setq haskell-program-name "ghci")

;; Using a named function as a hook makes it a bit easier to add
;; changes, since re-evaluating the "add-hook" line, will keep the old
;; hook running, while re-evaluating the hook function will instead
;; change the old hook.
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(defun my-haskell-mode-hook ()
  (add-to-list 'load-path "~/devel/shim")
  ;(require 'shim)
  (require 'hoogle)

  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)
  ;; highlight spelling errors in comments and strings
  (flyspell-prog-mode)
  (setq fill-column 78)        ;; the default, 72, is a bit too narrow
  
  ;;(turn-on-haskell-simple-indent)
  (define-key haskell-mode-map "\C-c-" 'tjs-haskell-insert-line)
  (define-key haskell-mode-map "\C-ch" 'hoogle-lookup)
  (define-key haskell-mode-map [f5] 'switch-to-haskell)
;;   (define-key haskell-mode-map [(control f5)] 'inferior-haskell-load-file)
  (define-key haskell-mode-map [(meta alt l)] 'inferior-haskell-load-file) 
  (define-key haskell-mode-map [(meta alt r)] 'inferior-haskell-reload-file) 
  (define-key haskell-mode-map [f4] 'darcsum-whatsnew)
  
  ; (add-hook 'write-file-hooks 'delete-trailing-space)
  (snippet-with-abbrev-table 'haskell-mode-abbrev-table
			     ("case" .  "case $${expr} of\n$>$${_} -> $.")
					; ("im"  .  "import $$")
			     ("let" . "let $${decl} = $${undefined} in $.")
			     ("if"  .  "if $${expr} then $$ else $${undefined}"))
  )

;; (load "haskell-unicode")

;; (defun haskell-unicode ()
;;     (interactive)
;;     (substitute-patterns-with-unicode
;;      (list (cons "\\(<-\\)" 'left-arrow)
;;            (cons "\\(->\\)" 'right-arrow)
;;            (cons "\\(==\\)" 'identical)
;;            (cons "\\(/=\\)" 'not-identical)
;;            (cons "\\(()\\)" 'nil)
;;            (cons "\\<\\(sqrt\\)\\>" 'square-root)
;;            (cons "\\(&&\\)" 'logical-and)
;;            (cons "\\(||\\)" 'logical-or)
;;            (cons "\\<\\(not\\)\\>" 'logical-neg)
;;            (cons "\\(>\\)\\[^=\\]" 'greater-than)
;;            (cons "\\(<\\)\\[^=\\]" 'less-than)
;;            (cons "\\(>=\\)" 'greater-than-or-equal-to)
;;            (cons "\\(<=\\)" 'less-than-or-equal-to)
;;            (cons "\\<\\(alpha\\)\\>" 'alpha)
;;            (cons "\\<\\(beta\\)\\>" 'beta)
;;            (cons "\\<\\(gamma\\)\\>" 'gamma)
;;            (cons "\\<\\(delta\\)\\>" 'delta)
;;            (cons "\\(''\\)" 'double-prime)
;;            (cons "\\('\\)" 'prime)
;;            (cons "\\(!!\\)" 'double-exclamation)
;;            (cons "\\(\\.\\.\\)" 'horizontal-ellipsis)
;; 	   (cons "\\(`elem`\\)" 'element-of))))

;;  (add-hook 'haskell-mode 'haskell-unicode)

;;
;; Muse stuff
;;

;; (add-to-list 'load-path "~/.emacs.d/muse-3.02.93/lisp/")
;; (require 'muse-mode)
;; (require 'muse-publish)
;; (require 'muse-html)

;; (setq muse-project-alist
;;       '(("blog" ;
;; 	 ("~/Pages" :default "index")
;; 	 (:base "html" :path "~/Pages/public_html")
;; 	 (:base "pdf" :path "~/Pages/public_html/pdf"))))


;;
;; Org-mode stuff
;;
;(add-to-list 'load-path "~/.emacs.d/org-5.04/")  ;; org mode comes pre-installed with Carbon Emacs
;(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))

;(setq org-log-done t)
;(setq org-agenda-files (list "~/org/work.org"
;; 			     "~/org/school.org"
;; 			     "~/org/home.org"))
;; (define-key global-map [f2] 'org-agenda)
;; (setq org-todo-keywords
;;   '((sequence "TODO" "DONE")
;;     (sequence "QUESTION" "FEEDBACK" "DONE")))

(add-to-list 'load-path "~/.emacs.d/g-client0/g-client/")
(load-library "g")
;; /Applications/Emacs.app/Contents/MacOS/bin/emacs


;;
;; Dylan Stuff
;;

;(require 'dylan-mode)

;;
;;
;;



(load-file "~/.emacs.d/ProofGeneral/generic/proof-site.el")
(setq coq-version-is-V8-1 t)
