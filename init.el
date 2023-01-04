;; I moved my config file into an org file
(org-babel-load-file "~/Apps/emacs-init-file/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   '("afffd2e82639b878a7e25d153e7e1d47704797d266f5f0c16de427255c918059" "bc02fd532a4853aba217ddb88b4966c39b331566ea0212aa8b2dfd0e3bbd73ed" "3b228dab7cbc6d14ea583e0bb5c857284a01d9489c0e24f5ecc4845e77dc84b0" default))
 '(display-fill-column-indicator t)
 '(fill-column 80)
 '(global-auto-revert-mode t)
 '(global-visual-line-mode t)
 '(package-selected-packages
   '(code-cells conda corfu citeproc multiple-cursors pdf-tools org-appear use-package))
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
 '(default ((t (:family "Roboto Mono" :height 110))))
 '(fixed-pitch ((t (:family "Roboto Mono" :height 110))))
 '(org-block ((t (:extend t :family "Roboto Mono" :height 110))))
 '(org-document-title ((t (:inherit default :weight bold :height 1.25))))
 '(org-level-1 ((t (:inherit default :weight bold :height 1.15))))
 '(org-level-2 ((t (:inherit default :weight bold :height 1.05))))
 '(variable-pitch ((t (:family "Baskerville" :height 160)))))
