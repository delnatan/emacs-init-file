;; I moved my config file into an org file
(org-babel-load-file "~/Apps/emacs-init-file/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(leuven))
 '(display-fill-column-indicator t)
 '(fill-column 80)
 '(global-visual-line-mode t)
 '(org-confirm-babel-evaluate nil)
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(citeproc multiple-cursors pdf-tools mixed-pitch org-appear use-package))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :height 120 :foundry "nil" :slant normal :weight regular :width normal))))
 '(fixed-pitch ((t (:family "Inconsolata"))))
 '(variable-pitch ((t (:family "Arial")))))
