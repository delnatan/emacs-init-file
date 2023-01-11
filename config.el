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

;; shorten the yes-or-no prompt to y-or-n
(defalias 'yes-or-no-p 'y-or-n-p)

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

(electric-pair-mode 1)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(use-package nano-theme
  :load-path ("~/Apps/emacs-init-file/themes/nano-theme")
  :config
  (load-theme 'nano t)
  (nano-light))

(use-package nano-modeline
  :init
  (require 'nano-modeline)
  (nano-modeline-mode 1))

(use-package auto-complete
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'auto-complete-mode)
  )

;; ;; define custom function to trigger show/hide in 'outline-minor-mode'
(defun de/hide_all ()
  (interactive)
  (if outline-minor-mode
      (progn (outline-hide-body)
             (outline-hide-sublevels 1))
    (message "Outline minor mode is not enabled.")))

(add-hook 'prog-mode-hook 'outline-minor-mode)

;; remap some of the terrible default keybindings
(let ((kmap outline-minor-mode-map))
  (define-key kmap (kbd "M-<up>") 'outline-move-subtree-up)
  (define-key kmap (kbd "M-<down>") 'outline-move-subtree-down)
  (define-key kmap (kbd "S-<tab>") 'outline-cycle)
  (define-key kmap (kbd "C-c h") 'de/hide_all)
  (define-key kmap (kbd "C-c s") 'outline-show-all))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

;; this was taken from https://www.emacswiki.org/emacs/DiredOmitMode
(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-sidebar-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
        (progn 
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar)
         :map dired-mode-map
         ("<backtab>" . dired-dotfiles-toggle))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "__"))

(add-to-list 'load-path "~/Apps/emacs-init-file/custom") ; add `custom` to load-path
(load "DE_fun01") ; search for file DE_fun01.el or DE_fun01.elc in load-path

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

;; Handy key definition
(define-key global-map "\M-Q" 'unfill-paragraph)

(setq org-startup-indented t) ; use indentation
(setq org-confirm-babel-evaluate nil) ; skip y/n prompt when executing src block
(setq org-hide-emphasis-markers t) ; hide emphasis marker
(setq org-src-fontify-natively t) ; org syntax highlighting
(setq org-fontify-whole-heading-line t)
(setq org-format-latex-options
      '(:foreground default
                    :background default
                    :scale 1.4
                    :html-foreground "Black"
                    :html-background "Transparent"
                    :html-scale 1.0
                    :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
(setq org-startup-with-inline-images t) ; show inline images

;; use fancy bullets in org-mode
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; enable variable pitch in org-mode
;; make sure you have the variable-pitch and fixed-pitch set in init.el
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; shortcut to insert a block of emacs-lisp/python code
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

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

(use-package pdf-tools
  :pin manual ;; need to comment this out for initial setup
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (setq pdf-view-use-scaling t)
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

;; custom function to kill current cell
(defun de/kill-cell ()
  "code-cells mode custom function to kill current cell"
  (interactive)
  (let ((beg (car (code-cells--bounds)))
        (end (cadr (code-cells--bounds))))
    (kill-region beg end)))

(defun de/restart-python ()
  "Clear current inferior python buffer and restart process"
  (interactive)
  (progn (with-current-buffer "*Python*" (comint-clear-buffer))
         (python-shell-restart)))

(use-package code-cells
  :bind
  (:map code-cells-mode-map
        ("C-c d d" . de/kill-cell)
        ("C-c C-c" . code-cells-eval)
        ("C-c r p" . de/restart-python)
        ("M-p" . code-cells-backward-cell)
        ("M-n" . code-cells-forward-cell)
        ("M-<up>" . code-cells-move-cell-up)
        ("M-<down>" . code-cells-move-cell-down)))

(use-package conda
  :defer t
  :init
  (setq conda-anaconda-home (expand-file-name "~/miniforge3"))
  (setq conda-env-subdirectory "envs")
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell))

;; attempt to turn any python file into code-cells
;; if it contains delimiters
(add-hook 'python-mode-hook 'code-cells-mode-maybe)

;; automatically scroll to the bottom when sending to inferior process
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;; truncate lines in the output of inferior buffer
(add-hook 'comint-mode-hook
          (lambda()
            (setq truncate-lines 1)))

;; rebind indentation keys, `s` is the super/command keys in MacOS
(use-package python
  :mode ("\\.py\\'" . python-mode)
  :config
  (define-key python-mode-map (kbd "s-[") 'python-indent-shift-left)
  (define-key python-mode-map (kbd "s-]") 'python-indent-shift-right))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (awk . t)
   (sed . t)
   (shell . t)
   (python . t)
   )
 )
