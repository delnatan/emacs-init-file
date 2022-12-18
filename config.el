(require 'package)
(package-initialize)

;; add MELPA archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t ; this adds ':ensure t' when using use-package
        use-package-expand-minimally t))

;; inhibit startup message
(setq inhibit-startup-message t)

(defun my-list-buffers (&optional arg)
  "Display a list of existing buffers.
The list is displayed in a buffer named \"*Buffer List*\".
See `buffer-menu' for a description of the Buffer Menu.
By default, all buffers are listed except those whose names start
with a space (which are for internal use).  With prefix argument
ARG, show only buffers that are visiting files."
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

;; bind the new function to C-b
(define-key ctl-x-map "\C-b" 'my-list-buffers)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "M-o") 'other-window)

(setq backup-directory-alist '(("" . "~/.emacs.d/bak")))

(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/bak/autosaves" t)))
(setq backup-by-copying t ; use copying to create backup files
      delete-old-versions t ; delete excess backup files
      kept-new-versions 4
      kept-old-versions 2
      version-control t)

(add-to-list 'load-path "~/.emacs.d/custom") ; add `custom` to load-path
(load "DE_fun01") ; search for file DE_fun01.el or DE_fun01.elc in load-path

(setq org-startup-indented t ; use indentation
    org-pretty-entities t ; toggle display of entities as utf-8 char
    org-startup-with-inline-images t) ; show inline images

(use-package citeproc
  :after org)

;; for some reason, I dont need the line below on my Mac
;; but need it on Ubuntu 22.04 to avoid getting 'unknown processor csl' error
;; when exporting org files to pdf
(require 'oc-csl)

(use-package org-appear
  :ensure t; install package if not already present
  :after org
  :hook (org-mode . org-appear-mode))

(use-package mixed-pitch
  :hook
  ;; use it in all text modes
  (text-mode . mixed-pitch-mode))

(use-package pdf-tools
  :pin manual ;; need to comment this out for initial setup
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights")
  )

(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
      TeX-source-correlate-start-server t)
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-S-c C-S-c" . mc/edit-lines)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click))
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell . t)))
