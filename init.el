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
 '(org-confirm-babel-evaluate nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.4 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(code-cells conda corfu boxquote citeproc multiple-cursors pdf-tools mixed-pitch org-appear use-package))
 '(python-indent-offset 4)
 '(python-shell-interpreter "ipython3")
 '(python-shell-interpreter-args "--simple-prompt")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Roboto Mono" :height 120 :foundry "GOOG" :slant normal :weight regular :width normal))))
 '(fixed-pitch ((t (:family "Roboto Mono"))))
 '(variable-pitch ((t (:family "Roboto")))))

;; Customize and set theme
(setq modus-themes-mode-line '(borderless accented))
(setq modus-themes-region '(bg-only))
(setq modus-themes-org-blocks 'gray-background)
(setq modus-themes-headings
      '((1 . (variable-pitch 1.5))
	(2 . (1.3))
	(agenda-date . (1.3))
	(agenda-structure . (variable-pitch light 1.8))
	(t . (1.1))))
(load-theme 'modus-operandi t)
