;; I moved my config file into an org file
(org-babel-load-file "~/Apps/emacs-init-file/config.org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(zenburn))
 '(custom-safe-themes
   '("28a34dd458a554d34de989e251dc965e3dc72bace7d096cdc29249d60f395a82" default))
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
 '(org-block ((t (:extend t :background "#494949" :family "Roboto Mono" :height 110))))
 '(org-document-title ((t (:inherit default :foreground "#8CD0D3" :weight bold :height 1.25))))
 '(org-level-1 ((t (:inherit default :foreground "#DFAF8F" :weight bold :height 1.1))))
 '(variable-pitch ((t (:family "Baskerville" :height 150)))))
