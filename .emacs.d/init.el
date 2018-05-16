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


;; use alt as meta
;; https://www.emacswiki.org/emacs/MetaKeyProblems
(set-keyboard-coding-system nil)

;; Parenthesis matching mode
(show-paren-mode 1)

;; show line number for customized modes
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d ")

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


;; ---------------------
;; -- backup settings --
;; ---------------------
;; Ref: https://www.emacswiki.org/emacs/ForceBackups

(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.

(setq vc-make-backup-files t)

;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
	  (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)


;; --------------------------------------
;; -- customize look and feel of emacs --
;; --------------------------------------

;; Theme
(load-theme 'tango-dark t)

;; powerline
(require 'powerline)
(powerline-default-theme)
(setq powerline-arrow-shape 'curve)


;; -------------------------
;; -- Additional packages --
;; -------------------------

;; Enabling ido-mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)


;; --------------------------------------
;; -- Language specific customizations --
;; --------------------------------------

;; ---------------------
;; -- Python settings --
;; ---------------------

;; Return for newline and indent
(add-hook 'python-mode-hook
	  (lambda ()
 	    (define-key python-mode-map "\r" 'newline-and-indent)))
(define-key global-map (kbd "RET") 'newline-and-indent)

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq python-indent-offset 4)))


;; ------------
;; -- Auctex --
;; ------------

(setq ispell-program-name "/usr/local/bin/ispell")
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
			     (push
			      '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
				:help "Run latexmk on file")
			      TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
           '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
;; (server-start) ; start emacs in server mode so that skim can talk to it

;; ---------------
;; -- hql files --
;; ---------------

(add-to-list 'auto-mode-alist '("\\.hql\\'" . sql-mode))

;; ----------
;; -- bash --
;; ----------

(setq sh-basic-offset 2)
(setq sh-indentation 2)

