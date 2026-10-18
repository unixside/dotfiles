;;; init.el --- My personal config for GNU/Emacs  -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

;;; Packages
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;;; Startup

;; Disable start-up screen
(setq-default  inhibit-startup-screen t)

;; Disable startup message
(setq-default inhibit-startup-message t)

;; Disable initial echo message
(setq-default inhibit-startup-echo-area-message t)

;; Set text mode as inital mode
(setq-default initial-major-mode 'text-mode)

;; Open *scratch* buffer at init
(setq-default initial-buffer-choice t)

;; Message for the initial *scratch* buffer
(setq-default initial-scratch-message "")

;; Custom frame title format
(unless (alist-get 'undecorated initial-frame-alist)
  (setq-default frame-title-format "GNU/Emacs - %b"))

;; Encoding

;; Default to utf-8 encoding
(set-default-coding-systems 'utf-8)

;; Add utf-8 at the front for automatic detection.
(prefer-coding-system       'utf-8)

;; Set coding system of terminal output
(set-terminal-coding-system 'utf-8)

; Set coding system for keyboard input on TERMINAL
(set-keyboard-coding-system 'utf-8)

;; Set up multilingual environment
;; (set-language-environment "English")

;;; Preferences

;; Scrolling
(pixel-scroll-precision-mode 1)
(setq-default scroll-conservatively 101
              scroll-margin 0
              scroll-step 2)

;; Enable pop-up-windows
(setq pop-up-windows t)

;; Short comfirmation
(fset 'yes-or-no-p 'y-or-n-p)

;; Auto close brackets
(electric-pair-mode t)

;; Replace or delete selection text when paste
(delete-selection-mode 1)

;; Default display width of tabs
(setq-default tab-width 4)

;; Prefer spaces for indentation by default
(setq-default indent-tabs-mode nil)

;; Disable backup files
(setq make-backup-files nil)

;; Enable intuitive navigation betwen windows
;; (windmove-default-keybindings)

;; Dictionary
(use-package ispell
  :straight nil
  :config
  (setq ispell-program-name "aspell")

  ;; Force Hunspell to find defualt path of Linux
  (setq ispell-aspell-dictionary-alist
        '(("es_AR" "/usr/local/lib/ispell/spanish.aff")))

  ;; Set default dictionary with specific name
  (setq ispell-dictionary "spanish"))

;; Help
(setq help-window-select t)

;; History
(use-package savehist
  :straight nil
  :config
  (savehist-mode t))

;; Recent files
(use-package recentf
  :straight nil
  :config
  (setq recentf-max-menu-items 10
	recentf-max-saved-items 100)
  (recentf-mode)
  (bind-key "C-x C-r" #'recentf))

;;; Interface
(when (display-graphic-p)
  (use-package frame
    :straight nil
    :config
    (setq default-frame-alist '((min-height . 1)
				                (min-width  . 1)
				                (width      . 100)
				                (height     . 30)
				                (left-fringe . 0)
				                (right-fringe . 0)
				                (internal-border-width . 24)
				                (vertical-scroll-bars . nil)
                                (undecorated . t)
                                (alpha-background . 1.0))
	      initial-frame-alist default-frame-alist
          frame-resize-pixelwise t
          frame-inhibit-implied-resize t)
    (setq-default window-divider-default-right-width 20
    	          window-divider-default-places 'right-only
    	          left-margin-width 0
    	          right-margin-width 0
    	          window-combination-resize nil)
    (window-divider-mode t))
  )

;; Disable Menu bar
(menu-bar-mode -1)

;; Disable Scroll bar
(scroll-bar-mode -1)

;; Disable Tools bar
(tool-bar-mode -1)

;; Disable hightlight to cursor current line
(global-hl-line-mode -1)

;; Disable Tab Bar
(tab-bar-mode -1)

;; Cusros
(setq-default cursor-type '(bar . 2))
(blink-cursor-mode nil)

;; Line Spacing
(setq-default line-spacing 0.0)

(unless (display-graphic-p)
  ;; Line Numbers
  (use-package display-line-numbers
    :straight nil
    :config
    (setq display-line-numbers-width 3)
    :hook
    (prog-mode . display-line-numbers-mode))

  ;; Mode line
  (require 'svg)
  (setq buffer-status-indicator-width 7
        buffer-status-indicator-height 25)

  (defun buffer-status-indicator (&optional width height)
    (let ((color (cond (buffer-read-only    (face-foreground 'success))
                       ((buffer-modified-p) (face-foreground 'warning))
                       (t                   (face-foreground 'default))))
          (width (or width 5))
          (height (or height 20))
          (svg (svg-create width height)))
      (if (display-graphic-p)
          (progn (svg-rectangle svg 0 0 width height :fill color :stroke color)
                 (propertize " " 'display (svg-image svg :ascent 'center)))
        (propertize " " 'face `(:background ,color)))))

  (setq-default mode-line-format
                '((:eval (buffer-status-indicator
                          buffer-status-indicator-width
                          buffer-status-indicator-height))
                  " "
                  mode-line-buffer-identification
                  " "
                  mode-line-modes
                  " "
                  mode-line-format-right-align
                  vc-mode
                  "  "
                  (:eval (propertize (format-mode-line "C%c")))
                  "  ")))

(when (display-graphic-p)
  (use-package lean-modeline
    :load-path (lambda () (expand-file-name "~/Repos/lean-modeline/"))
    :config
    (setq lean-modeline-text-scale-factor 1.0)
    (setq lean-modeline-icon-scale-factor 1.0)
    (lean-modeline-mode)
    (lean/thin-mode-line)))

;; Theme
(use-package modus-themes
  :straight t
  :config
  (when (display-graphic-p)
    (use-package lean-themes
      :load-path (lambda () (expand-file-name "~/Repos/lean-themes/"))
      :config
      (setq lean-themes-to-toggle '(tokyonight-night rose-pine-dawn))
      (load-theme 'tokyonight-night :no-confirm)
      (bind-key "C-x t t" #'lean-themes-toggle)))

  (unless (display-graphic-p)
    (setq modus-themes-to-toggle '(modus-vivendi modus-vivendi-tritanopia))
    (load-theme 'modus-vivendi :no-confirm)
    (bind-key "C-x t t" #'modus-themes-toggle)))

(defun transparent-background-p ()
  (< (alist-get 'alpha-background default-frame-alist) 1.0))

(defun lean-background-transparency (&optional confirm)
  "Enable transparency when is terminal mode or CONFIRM is t."
  (when (or confirm (not (display-graphic-p))
            (transparent-background-p))
    (mapc #'(lambda (face) (set-face-background face "unspecified-bg"))       
          '(default line-number fringe internal-border))))

(set-frame-font "JetBrainsMono Nerd Font")

;; Rewrite faces on the fly
(use-package owr-faces
  :load-path (lambda () (expand-file-name "~/Repos/owr-faces/"))
  :config
  (setq owr-faces-face-attrs-preferences
        `((default :weight light :height 140)
		  (bold :weight bold)
		  (line-number :slant italic)
		  (line-number-current-line :slant italic)
		  (font-lock-keyword-face :weight regular
                                  :slant italic)
		  (font-lock-constant-face :slant italic)
		  (font-lock-function-name-face :weight regular :slant italic)
		  (font-lock-function-call-face :weight regular :slant italic)
		  (font-lock-variable-name-face :weight regular)
		  (font-lock-doc-face  :slant italic)
		  (font-lock-comment-face  :slant italic)
		  (font-lock-type-face :weight regular)
		  (font-lock-builtin-face :weight regular)
          (header-line :inherit nil)
          (org-document-title :family "Roboto Slab"
                              :weight bold :height 2.2)
          (org-document-info :slant italic)
          (org-document-info-keyword :family "Roboto Mono")
          (org-meta-line :family "Roboto Mono")
          (org-verbatim :family "Roboto Mono" :weight regular
                        :height 1.0)
          (org-block :family "Roboto Mono" :weight regular)
          (org-block-begin-line :family "Roboto Mono")
          (org-block-end-line :family "Roboto Mono")
          (org-level-1 :family "Roboto Slab" :weight bold :height 1.8)
          (org-level-2 :family "Roboto Slab" :weight bold :height 1.6)
          (org-level-3 :family "Roboto Slab" :weight bold :height 1.5)
          (org-level-4 :family "Roboto Slab" :weight bold :height 1.4)
          (org-level-5 :family "Roboto Slab" :weight bold :height 1.1)
          (org-level-6 :family "Roboto Slab" :weight bold :height 1.0)
          (org-level-7 :family "Roboto Slab" :weight bold :height 1.0)
          (org-level-8 :family "Roboto Slab" :weight bold :height 1.0)
          (variable-pitch :family "Roboto"
                          :height 1.0 :weight light)
          (italic :family "Roboto" :height 1.0)
          (fixed-pitch :family "Roboto Mono")
          ,@(mapcar
             (lambda (face)
               (let ((name (intern (format "rainbow-delimiters-%s-face"
                                           (symbol-name face)))))
                 `(,name :weight regular)))
             '(depth-1 depth-2 depth-3 depth-4 depth-5 depth-6 depth-7
                       depth-8 depth-9 unmatched mismatched))
          ))
  
  (add-hook 'owr-faces-functions-hook 'lean/thin-mode-line)
  (add-hook 'owr-faces-functions-hook 'lean-background-transparency)
  (owr-faces-mode t))

;;; Programming

;; Autocompletion
(use-package corfu
  :straight t
  :config
  (global-corfu-mode t)
  (setq corfu-auto t
	    corfu-auto-prefix 2
	    corfu-auto-delay 0.2
	    corfu-separator ?\s
	    corfu-quit-at-boundary nil
	    corfu-quit-no-match t
	    corfu-preview-current nil
	    corfu-on-exact-match nil
	    corfu-scroll-margin 5
	    corfu-popupinfo-delay 0.3))

(use-package cape
  :straight t
  :init
  (setq cape-dict-file "/usr/share/dict/spanish")
  (add-hook 'completion-at-point #'cape-dabbrev)
  (add-hook 'completion-at-point #'cape-file)  
  (add-hook 'completion-at-point #'cape-elisp-block)
  (add-hook 'completion-at-point #'cape-dabbrev)
  (add-hook 'text-mode-hook #'(lambda () (add-to-list 'completion-at-point #'cape-dict))))

(use-package orderless
  :straight t
  :config 
  (setq completion-styles '(substring orderless basic)
	orderless-component-separator 'orderless-escapable-split-on-space
	read-file-name-completion-ignore-case t
	read-buffer-completion-ignore-case t
	completion-ignore-case t))

;; Languages
(use-package slime
  :straight t
  :init
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  :config
  (slime-setup '(slime-fancy)))

(use-package kdl-mode
  :straight t)

(use-package markdown-mode
  :straight t)

(use-package yaml-mode
  :straight t)

;; Syntax Highlighting with Tree Sitter
(defvar treesit-modes-list
  '(("\\.py\\'"  . python-ts-mode)
    ("\\.js\\'"  . js-ts-mode)
    ("\\.ts\\'"  . typescript-ts-mode)
    ("\\.jsx\\'" . tsx-ts-mode)
    ("\\.tsx\\'" . tsx-ts-mode)
    ("\\.rs\\'"  . rust-ts-mode)
    ("\\.cpp\\'" . c++-ts-mode)
    ("\\.c\\'"   . c-ts-mode)
    ("\\.lua\\'" . lua-ts-mode)
    ;; ("\\.lisp\\'" . cl-ts-mode)
    ;; ("\\.cl\\'"   . cl-ts-mode)
    )
  "List of extensions and Tree Sitter Modes for add to `auto-mode-alist'.")

(dolist (mode treesit-modes-list)
  (add-to-list 'auto-mode-alist mode))

;; Add Tree Sitter Modes with hooks
(add-hook 'sh-mode-hook #'bash-ts-mode)

;; Options for specific modes
(setq typescript-ts-mode-indent-offset 4)

;; Project
(require 'project)

;; Eglot, Client for Language Servers Programming
(use-package eglot
  :straight nil
  :hook
  ((rust-ts-mode
    python-ts-mode
    js-ts-mode
    typescript-ts-mode
    tsx-ts-mode
    lua-ts-mode
    c-ts-mode)
   . eglot-ensure)
  :config
  (add-to-list
   'eglot-server-programs
   '((rust-ts-mode rust-mode) .
     ("rustup" "run" "stable" "rust-analyzer"
      :initializationOptions (:check
                              (:command "clippy")))))
  (add-to-list 'project-vc-extra-root-markers "tsconfig.json")
  (add-to-list
   'eglot-server-programs
   '((js-ts-mode jsx-ts-mode typescript-ts-mode tsx-ts-mode) .
     ("typescript-language-server" "--stdio"))))

;; Check erros on the fly
(use-package flymake
  :straight nil
  :config
  (setq flymake-indicator-type 'margins
        flymake-margin-indicator-position 'right-margin))

;;; Utilities

;;;; Tramp
(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(require 'tramp)

;;;; Minibuffer
(use-package vertico
  :straight t
  :config
  (setq vertico-resize nil
	vertico-count 10
	vertico-count-format nil)
  (vertico-mode))

(use-package consult
  :straight t
  :config
  (setq consult-preview-key nil)
  
  (defun my/consult-line ()
    "Consult line with live preview"
    (interactive)
    (let ((consult-preview-key 'any)
          (mini-frame-resize 'grow-only)) ;; !! Important
      (consult-line)))

  (defun my/consult-goto-line ()
    "Consult goto line with live preview"
    (interactive)
    (let ((consult-preview-key 'any))
      (consult-goto-line)))

  (bind-key "C-x C-r" #'consult-recent-file)
  (bind-key "C-x h"   #'consult-outline)
  (bind-key "C-x b"   #'consult-buffer)
  (bind-key "C-c h"   #'consult-history)
  (bind-key "C-s"     #'my/consult-line)
  (bind-key "M-g g"   #'my/consult-goto-line)
  (bind-key "M-g M-g" #'my/consult-goto-line))

(use-package marginalia
  :straight t
  :config
  (setq-default marginalia--ellipsis "…"    ; Nicer ellipsis
		marginalia-align 'right     ; right alignment
		marginalia-align-offset -1) ; one space on the right
  (marginalia-mode))

;; Ibuffer
(bind-key "C-x C-b" #'ibuffer)

;; Documentation
(use-package eldoc
  :straight nil
  :config
  (global-eldoc-mode t))

;; Search keybindings
(use-package which-key
  :straight nil
  :config
  (which-key-mode t))

(use-package multiple-cursors
  :straight t
  
  :config
  (bind-key "C->"     'mc/mark-next-like-this)
  (bind-key "C-<"     'mc/mark-previous-like-this)
  (bind-key "C-c C-<" 'mc/mark-all-like-this)

  (set-face-attribute 'mc/cursor-bar-face nil
                      :height 1.0))

(use-package rainbow-mode
  :straight t)

(use-package rainbow-delimiters
  :straight t
  :hook
  (prog-mode . rainbow-delimiters-mode))

;; Functions
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line)
  (setq start (point))
  (end-of-line) (forward-char)
  (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(bind-key "M-<up>" #'move-line-up)
(bind-key "M-<down>" #'move-line-down)

(defun lean/copy-line ()
  "Copies the current line without moving the column cursor."
  (interactive)
  (let* ((line (buffer-substring-no-properties
		(line-beginning-position)
		(line-end-position)))
	 (new-pos (+ (length line) (point) 1)))
    (end-of-line)
    (insert (format "\n%s" line))
    (goto-char new-pos)))

(bind-key "C-." #'lean/copy-line)

(defun lean/open-file-current-window ()
  "Open org file link in current window."
  (interactive)
  (let ((org-link-frame-setup (cons (cons 'file 'find-file)
                              org-link-frame-setup)))
    (org-open-at-point)))

(bind-key "C-o" #'lean/open-file-current-window)

;;; Org Mode
(use-package org
  :straight nil
  :custom
  (org-image-actual-width 500)
  :config
  (setq org-hide-leading-stars nil
        org-hide-emphasis-markers t
        org-yank-image-save-method "./img/")

  (defun org-mode-insert-src-block ()
    "Insert a temaplate src"
    (interactive)
    (org-insert-structure-template "src"))

  (bind-key "C-c i s" #'org-mode-insert-src-block)
  (bind-key "C-c i p" #'yank-media)
  (advice-add 'yank-media :after
              (lambda (&rest _)
                (org-link-preview-region
                 (line-beginning-position)
                 (line-end-position))))
  :hook
  (org-mode . org-indent-mode)
  (org-mode . visual-line-mode)
  (org-mode . variable-pitch-mode)
  (org-mode . flyspell-mode))

;; My own sustem for write notes
(use-package own-notes
  :load-path (lambda () (expand-file-name "~/Repos/own-notes"))
  :config
  (setq own-notes-directory "~/Org/Notas")
  (bind-key "M-n n" 'own-notes)
  (bind-key "M-n s" 'own-notes-subdirectory)
  (bind-key "M-n l" 'own-notes-add-link))

;; Custom mode for pgn files.
(use-package pgna-mode
  :load-path (lambda () (expand-file-name "~/Repos/pgna-mode")))

(provide 'init)
;;; init.el ends here
