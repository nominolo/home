;; My custom stuff that isn't directly related to configuration (ie.,
;; no hooks)

(defun tjs-make-transparent ()
	"Make editor window transparent.  Only tested on Mac OS X + Aquaqumacs."
  (interactive)
  (modify-frame-parameters (selected-frame) '((alpha . 90))))

(defun tjs-make-opaque ()
	"Make editor window opaque.  Only tested on Mac OS X + Aquaqumacs."
  (interactive)
  (modify-frame-parameters (selected-frame) '((alpha . 100))))

(defun tjs-haskell-insert-line ()
  "Insert a horizontal line."
  (interactive)
  (beginning-of-line)
  (insert (make-string 72 ?\-) "\n"))

(defun tjs-fullstreen ()
  (interactive)
  (setq initial-frame-alist '((top . 1) (left . 1) (width . 180) (height . 48))))


(defun tjs-default-mode ()
  "Set default font size."
  t)

(defun tjs-open-paren (&optional n)
  (interactive () "P")
  (cond ((or (tjs-hs-in-string-p)
	     (tjs-hs-in-comment-p))
	 (insert "("))
	((not (tjs-hs-in-char-p))
	 (tjs-hs-insert-pair n "(" ")" 'goto-char))))

;;; By "xd" on #haskell

;; balanced-parens minor mode
(defun bp-balanced-open (l r)
  (save-excursion
    (insert r))
  (insert l))

(defun bp-balanced-close (char)
  (cond ((eq char (following-char)) (forward-char 1))
 	(t (insert char))))

(defun bp-lparen ()
  (interactive)
  (bp-balanced-open ?\( ?\)))
  
(defun bp-rparen ()
  (interactive)
  (bp-balanced-close ?\)))

(defun bp-lbracket ()
  (interactive)
  (bp-balanced-open ?\[ ?\]))
  
(defun bp-rbracket ()
  (interactive)
  (bp-balanced-close ?\]))

(defun bp-lbrace ()
  (interactive)
  (bp-balanced-open ?\{ ?\}))
  
(defun bp-rbrace ()
  (interactive)
  (bp-balanced-close ?\}))

(defun bp-doublequote ()
  (interactive)
  (progn 
    (cond ((eq ?\" (following-char)) (forward-char 1))
 	  (t (insert "\"\"") (backward-char 1)))))

(defun bp-delbalanced ()
  (interactive)
  (progn
    (backward-char 1)
    (cond ((looking-at "{}\\|()\\|\\[]\\|\"\"") (delete-char 2))
	  (t (delete-char 1)))))

(define-minor-mode balanced-paren-mode
  "Toggle balanced paren mode"
  ;; Initial value
  nil
  ;; Modeline
  " BP"
  ;; keybinds
  '(("(" . bp-lparen)
    (")" . bp-rparen)
    ("[" . bp-lbracket)
    ("]" . bp-rbracket)
    ("{" . bp-lbrace)
    ("}" . bp-rbrace)
    ("\"" . bp-doublequote)
    ([backspace] . bp-delbalanced))
  :group balanced)