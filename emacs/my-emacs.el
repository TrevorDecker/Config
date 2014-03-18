;; allows for easy lisp error checking inside this file
(setq install-mode nil) ;; only set to true when we are installing new packages
(setq debug-on-error install-mode) ;; only need to debug when we are installing 
;;messages for debugging emacs status
(print "loading my-emacs.el\n")
(setq path (file-name-directory load-file-name))
(print "the my-emacs.el file is being loaded form\n")
(print path)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

  ;; sets location where config files are stored
(add-to-list 'load-path (concat path "/auto-complete"))
(add-to-list 'load-path path)
(add-to-list 'load-path (concat path "/yasnippet"))

(global-linum-mode 1)
;; sets verticale bar at 80 chars
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-color "darkblue")
(setq fci-rule-column 80)

;; sets up cmake file
(require 'cmake-mode)
;;(cmake-mode 1) ;;TODO fix

;; Ensure c/c++ mode for .h, .c, .cpp
(require 'cc-mode)


;;sets up auto code indentation
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

 ;; yasnippet (templated auto complete)
 ;; should be loaded before auto complete so that they can work together
(require 'yasnippet) ;;TODO fix
(yas-global-mode 1) ;;TODO FIX

;; stuff for auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat path "/auto-complete/dict"))
(ac-config-default)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>")

;;TODO get auto complete and yasnipperts to work tother
 (custom-set-variables
 '(ac-auto-start nil)
 '(ac-use-menu-map t)
 '(ac-trigger-key "TAB"))

;; hightlight uncommited code
;;(global-diff-hl-mode) TODO fix

;; for file and buffer completion 
(require 'ido)
(ido-mode t)


; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
;; Convient package handling in emacs
(require 'package)
;; use packages from marmalade
(if install-mode (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) nil)
;; and the old elpa repo
(if install-mode (add-to-list 'package-archives '("elpa-old" . "http://tromey.com/elpa/")) nil)
;; and automatically parsed versiontracking repositories.
(if install-mode (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/")) nil)

;; Make sure a package is installed
(defun package-require (package)
  "Install a PACKAGE unless it is already installed 
or a feature with the same name is already active.

Usage: (package-require 'package)"
  ; try to activate the package with at least version 0.
  (package-activate package '(0))
  ; try to just require the package. Maybe the user has it in his local config
  (condition-case nil
      (require package)
    ; if we cannot require it, it does not exist, yet. So install it.
    (error (package-install package))))

;; Initialize installed packages
(package-initialize)  
;; package init not needed, since it is done anyway in emacs 24 after reading the init
;; but we have to load the list of available packages
(if install-mode package-refresh-contents nil)

;;;; Convenient printing
(require 'printing)
(pr-update-menus t)
;; make sure we use localhost as cups server
(setenv "CUPS_SERVER" "localhost")
(package-require 'cups)


;; word wrapping
(global-visual-line-mode t)

; Use the system clipboard
(setq x-select-enable-clipboard t)

; save minibuffer history
(require 'savehist)
(savehist-mode t)

; show recent files
(package-require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 1000)

;; Highlight TODO and FIXME in comments
(package-require 'fic-ext-mode)
(defun add-something-to-mode-hooks (mode-list something)
  "helper function to add a callback to multiple hooks"
  (dolist (mode mode-list)
    (add-hook (intern (concat (symbol-name mode) "-mode-hook")) something)))

(add-something-to-mode-hooks '(c++ tcl emacs-lisp python text markdown latex) 'fic-ext-mode)

; save the place in files
(require 'saveplace)
(setq-default save-place t)

; colored shell commands via C-!
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun babcore-shell-execute(cmd)
  "Execute a shell command in an interactive shell buffer."
   (interactive "sShell command: ")
   (shell (get-buffer-create "*shell-commands-buf*"))
   (process-send-string (get-buffer-process "*shell-commands-buf*") (concat cmd "\n")))
(global-set-key (kbd "C-!") 'babcore-shell-execute)



; stronger error display
(defface flymake-message-face
  '((((class color) (background light)) (:foreground "#b2dfff"))
    (((class color) (background dark))  (:foreground "#b2dfff")))
  "Flymake message face")

; show the flymake errors in the minibuffer
(package-require 'flymake-cursor)  

(provide 'my-emacs)


