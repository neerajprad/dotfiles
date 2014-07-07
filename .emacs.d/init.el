;; ---------------------
;; -- Global Settings --
;; ---------------------

;; initialize package.el repositories
(require 'package)
(add-to-list 'package-archives 
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; --------------------------------------
;; -- customize look and feel of emacs --
;; --------------------------------------

;; Theme
(load-theme 'tango-dark t)

;; powerline
(require 'powerline)
(powerline-default-theme)
(set-face-attribute 'mode-line nil
                    :foreground "White"
                    :background "AquaMarine4"
                    :box nil
		    )
(setq powerline-default-separator 'arrow)

;; Parenthesis matching mode
(show-paren-mode 1)

;; show line number for customized modes
(require 'linum)
(global-linum-mode t)
(setq linum-format "%d ")

(defcustom linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode org-mode text-mode dired-mode doc-view-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )

(defcustom linum-disable-starred-buffers 't
  "* Disable buffers that have stars in them like *Gnu Emacs*"
  :type 'boolean
  :group 'linum)

(defun linum-on ()
  "* When linum is running globally, disable line number in modes defined in `linum-disabled-modes-list'. Changed by linum-off. Also turns off numbering in starred modes like *scratch*"

  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list)
              (and linum-disable-starred-buffers (string-match "*" (buffer-name)))
              )
    (linum-mode 1)))

(provide 'setup-linum)

;; Delete should be backspace                                                                        
(normal-erase-is-backspace-mode 0)

;; -------------------------
;; -- Additional packages --
;; -------------------------

;; Enabling ido-mode
(require 'ido)
(ido-mode t)

;; Org Mode
(require 'org)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
	 "* TODO %?\n  %i\n  %a")
	("a" "Appointments" entry (file+headline (concat org-directory "/gtd.org") "Appointments")
	 "* Appointment: %?\n%^T\n%i\n  %a")
	))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))                        
(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "CANCELED" "DONE"))                  
(setq org-agenda-include-diary t)                                              
(setq org-agenda-include-all-todo t)  

;; --------------------------------------
;; -- Language specific customizations --
;; --------------------------------------

;; Python settings

;; Smart tabs
(smart-tabs-insinuate 'python)

;; Return for newline and indent
(add-hook 'python-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))


;; Enabling jedi for python
;; (add-hook 'python-mode-hook 'auto-complete-mode)
;; (add-hook 'python-mode-hook 'jedi:ac-setup)

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

;; ;; Based upon https://github.com/paul7/dev-conf/blob/master/.emacs-haskell
;; (defvar cabal-use-sandbox t)
;; ;; (setq-default haskell-program-name "ghci")
;; (defun cabal-toggle-sandboxing-local ()
;;   (interactive)
;;   (set (make-local-variable 'cabal-use-sandbox) (not cabal-use-sandbox))
;;   (message (format "This buffer haskell-process-type is ``%s''"
;;                    (set (make-local-variable 'haskell-process-type)
;;                         (if cabal-use-sandbox
;;                             'cabal-repl
;;                           'ghci)))))

;; (defun cabal-toggle-sandboxing ()
;;   (interactive)
;;   (setq cabal-use-sandbox (not cabal-use-sandbox))
;;   (message (format "haskell-process-type is ``%s''"
;;                    (setq haskell-process-type
;;                         (if cabal-use-sandbox
;;                             'cabal-repl
;;                           'ghci)))))

;; ;; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(haskell-program-name "ghci"))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:background nil)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-input-method "TeX")
 '(haskell-program-name "cabal repl")
 '(org-agenda-files (quote ("~/org/gtd.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
