(defun xemacs-p ()
  (string-match "XEmacs" emacs-version))

(defun carbon-emacs-p ()
  (and (string-match "GNU Emacs" (emacs-version))
       (string-match "Carbon" (emacs-version))))

(cond
 ((xemacs-p)
  (progn
    (setq user-init-file
	  (expand-file-name "init.el"
			    (expand-file-name ".xemacs" "~")))
    (setq custom-file
	  (expand-file-name "custom.el"
			    (expand-file-name ".xemacs" "~")))
      
    (load-file user-init-file)
    (load-file custom-file)))
 ((carbon-emacs-p)
  (progn
    (scroll-bar-mode -1)
    (show-paren-mode)
    (mac-hide-menu-bar)
    (setq initial-frame-alist '((top . 1) (left . 1) (width . 180) (height . 48)))
    (load "~/.emacs.d/init")
    (custom-set-variables '(load-home-init-file t t))
    (custom-set-faces)))
 (t
  (error "Unknown Emacs")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(completion-ignored-extensions (quote (".svn/" "CVS/" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".dvi" ".fmt" ".tfm" ".pdf" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".fasl" ".ufsl" ".fsl" ".dxl" ".pfsl" ".dfsl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo" ".hi")))
 '(g-user-email "nominolo@gmail.com")
 '(load-home-init-file t t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:stipple nil :background "gray20" :foreground "gray70" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :family "inconsolata"))))
;;  '(bold ((t (:foreground "gray90")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(muse-verbatim ((((class color) (background dark)) (:foreground "#9999ff")))))
