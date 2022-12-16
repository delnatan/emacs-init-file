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
  (setq use-package-always-ensure t ; this adds ':ensure t' when using use-package
	use-package-expand-minimally t))

;; inhibit startup message
(setq inhibit-startup-message t)

;; show line numbers in all buffers
;; (display-line-numbers-mode nil)

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
 '(global-visual-line-mode t)
 '(org-confirm-babel-evaluate nil)
 '(org-hide-emphasis-markers t)
 '(package-selected-packages
   '(multiple-cursors pdf-tools mixed-pitch org-appear use-package))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

;; org-mode tweaks
(setq org-startup-indented t ; use indentation
      org-pretty-entities t ; toggle display of entities as utf-8 char
      org-startup-with-inline-images t) ; show inline images

;; enable line-display for all major programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; custom emacs settings for resizing windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; keybinding to replace C-x o, switch to other window
(global-set-key (kbd "M-o") 'other-window)

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

;; use mixed-pitch package to display variable-width and fixed-width fonts
;; in org-mode
(use-package mixed-pitch
  :hook
  ;; use it in all text modes
  (text-mode . mixed-pitch-mode))

;; use pdf-tools
(use-package pdf-tools
  ;; :pin manual ;; need to comment this out for initial setup
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

;; please double check ~/.emacs.d/.mc-lists.el for command preferences!
;; sometimes if you remembered the wrong settings, inserting characters in org-mode
;; doesn't work
(use-package multiple-cursors
  ;; keybinding can be set by using
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
	 ("C-S-c C-S-c" . mc/edit-lines)
	 ("M-<mouse-1>" . mc/add-cursor-on-click)
	 )
  )

;; for using CSL in org-mode to handle citations
(use-package citeproc
  :after org)


;; Custom functions to load
(add-to-list 'load-path "~/.emacs.d/custom") ; add `custom` to load-path
(load "DE_fun01") ; search for file DE_fun01.el or DE_fun01.elc in load-pathg

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
 '(default ((t (:family "Inconsolata" :height 130 :foundry "nil" :slant normal :weight regular :width normal))))
 '(fixed-pitch ((t (:family "Inconsolata"))))
 '(variable-pitch ((t (:family "DejaVu Sans")))))
