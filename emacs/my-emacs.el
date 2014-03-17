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
(add-to-list 'load-path "auto-complete")
(add-to-list 'load-path "")
(add-to-list 'load-path "yasnippet")
 
(global-linum-mode 1)
;; sets verticale bar at 80 chars
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-color "darkblue")
(setq fci-rule-column 80)

;; sets up cmake file 
(require 'cmake-mode)
;; (cmake-mode 1)

;; Ensure c/c++ mode for .h, .c, .cpp
(require 'cc-mode)


;;sets up auto code indentation 
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

 ;; yasnippet (templated auto complete)
 ;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;; stuff for auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>")

;;TODO get auto complete and yasnipperts to work tother
;; (custom-set-variables
;; '(ac-auto-start nil)
;; '(ac-use-menu-map t)
;; '(ac-trigger-key "TAB"))

;; hightlight uncommited code 
;; (global-diff-hl-mode)


; roslaunch highlighting
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))


(provide 'my-emacs)


