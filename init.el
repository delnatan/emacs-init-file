;; I moved my config file into an org file
(org-babel-load-file "~/Apps/emacs-init-file/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-fill-column-indicator t)
 '(fill-column 80)
 '(global-auto-revert-mode t)
 '(global-visual-line-mode t)
 '(package-selected-packages
   '(nano-modeline code-cells conda corfu citeproc multiple-cursors pdf-tools org-appear use-package))
 '(python-shell-interpreter "ipython3")
 '(python-shell-interpreter-args "--simple-prompt")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; Customize and set theme
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Roboto Mono" :weight light :height 110))))
 '(fixed-pitch ((t (:family "Roboto Mono" :weight light :height 110))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-title ((t (:inherit variable-pitch :weight bold :height 1.25))))
 '(org-level-1 ((t (:inherit variable-pitch :weight bold :height 1.15))))
 '(org-level-2 ((t (:inherit variable-pitch :weight bold :height 1.05))))
 '(org-table ((t (:inherit fixed-pitch :height 0.95))))
 '(org-verbatim ((t (:inherit fixed-pitch))))
 '(variable-pitch ((t (:family "sans" :height 140)))))
 
