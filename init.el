;; MELPA package support
(require 'package)
;; add MELPA archive to the list of available repositories
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t))

;; I dont like the behavior of C-x C-b so this snippet just modifies it
;; so that listing buffers and choosing one opens it on the current frame
(defun my-list-buffers (&optional arg)
"Display a list of existing buffers.
The list is displayed in a buffer named \"*Buffer List*\".
See `buffer-menu' for a description of the Buffer Menu.
By default, all buffers are listed except those whose names start
with a space (which are for internal use).  With prefix argument
ARG, show only buffers that are visiting files."
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))
(define-key ctl-x-map "\C-b" 'my-list-buffers)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(leuven))
 '(display-fill-column-indicator t)
 '(fill-column 80)
 '(global-display-line-numbers-mode t)
 '(org-confirm-babel-evaluate nil)
 '(org-hide-emphasis-markers t)
 '(package-selected-packages '(org-ref pdf-tools mixed-pitch org-appear use-package))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; org-mode tweaks
(setq org-startup-indented t ; use indentation
      org-pretty-entities t ; toggle display of entities as utf-8 char
      org-startup-with-inline-images t) ; show inline images
      

;; custom emacs settings for resizing windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; keybinding to replace C-x o, switch to other window
(global-set-key (kbd "M-o") 'other-window)

;; inhibit startup message
(setq inhibit-startup-message t)
;; show line numbers in all buffers
(display-line-numbers-mode nil)

;; move all backup files into one directory
(setq backup-directory-alist '(("" . "~/.emacs.d/bak")))
(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/bak/autosaves" t)))
(setq backup-by-copying t ; use copying to create backup files
      delete-old-versions t ; delete excess backup files
      kept-new-versions 4
      kept-old-versions 2
      version-control t)

;; set these with M-x customize-variable
;; org-hide-emphasis-markers
;; tool-bar-mode

;; show hidden emphasis markers until cursor over

(use-package org-appear
  :ensure t; install package if not already present
  :after org
  :hook (org-mode . org-appear-mode))

;; use mixed-pitch package to display 
(use-package mixed-pitch
  :hook
  ;; use it in all text modes
  (text-mode . mixed-pitch-mode))

;; use pdf-tools
(use-package pdf-tools
  :pin manual
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  :custom
  (pdf-annot-activate-created-annotations t "automatically
 annotate highlights")
  )
;; make pdf-tools default
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(use-package org-ref)

;; Custom functions
(add-to-list 'load-path "~/.emacs.d/custom") ; add `custom` to load-path
(load "DE_fun01") ; search for file DE_fun01.el or DE_fun01.elc in load-path

;; enable languages for org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Roboto Mono" :height 110 :foundry "nil" :slant normal :weight light :width normal))))
 '(fixed-pitch ((t (:family "Roboto Mono"))))
 '(variable-pitch ((t (:family "Input Sans")))))
