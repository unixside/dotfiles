;;; init.el --- My personal config for GNU/Emacs  -*- lexical-binding: t -*-
;;; Commentary:

;;; Code: 

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
  :ensure nil
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
  :ensure nil
  :config
  (savehist-mode t))

;; Recent files
(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-menu-items 10
	recentf-max-saved-items 100)
  (recentf-mode)
  (bind-key "C-x C-r" #'recentf))

;;; Interface
(when (display-graphic-p)
  (use-package frame
    :ensure nil
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
(blink-cursor-mode t)

;; Line Spacing
(setq-default line-spacing 0.0)

(unless (display-graphic-p)
  ;; Line Numbers
  (use-package display-line-numbers
    :ensure nil
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
    (lean-modeline-mode)
    (lean/thin-mode-line)))

;; Theme
(require-theme 'modus-themes)

(defun transparent-background-p ()
  (< (alist-get 'alpha-background default-frame-alist) 1.0))

(let ((current nil) (alternative nil))
  (if (and (display-graphic-p)
           (not (transparent-background-p)))
      (setq current 'modus-operandi
            alternative 'modus-vivendi)
    (setq current 'modus-vivendi
          alternative 'modus-vivendi-tritanopia))
  (setq modus-vivendi-palette-overrides modus-themes-preset-overrides-faint
        modus-operandi-palette-overrides modus-themes-preset-overrides-cooler
        modus-themes-to-toggle `(,current ,alternative))
  (load-theme current :no-confirm))

(bind-key "C-x t t" #'modus-themes-toggle)

(defun lean-background-transparency (&optional confirm)
  "Enable transparency when is terminal mode or CONFIRM is t."
  (when (or confirm (not (display-graphic-p))
            (transparent-background-p))
    (mapc #'(lambda (face) (set-face-background face "unspecified-bg"))       
          '(default line-number fringe internal-border))))

(set-frame-font "IntoneMono NF")

;; Rewrite faces on the fly
(use-package owr-faces
  :load-path (lambda () (expand-file-name "~/Repos/owr-faces/"))
  :config
  (setq owr-faces-face-attrs-preferences
        `((default :weight regular :height 150)
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

;; Languages
(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "/usr/local/bin/sbcl")
  :config
  (slime-setup '(slime-fancy)))

(use-package kdl-mode
  :vc (:url "https://github.com/taquangtrung/emacs-kdl-mode" :rev :newest))

(use-package markdown-mode
  :vc (:url "https://github.com/jrblevin/markdown-mode" :rev :newest))

(use-package yaml-mode
  :vc (:url "https://github.com/yoshiki/yaml-mode"))

;; (use-package lisp-ts-mode
;;   :vc (:url "https://codeberg.org/zshaftel/lisp-ts-mode")
;;   :init
;;   (setf (alist-get 'lisp-ts-mode font-lock-ignore)
;;         lisp-ts-mode-font-lock-ignore-keywords))

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

;; Tramp
(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path "/home/lean/.npm-global/bin")
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; Eglot, Client for Language Servers Programming
(use-package eglot
  :ensure nil
  :hook
  ((rust-ts-mode
    python-ts-mode
    js-ts-mode
    typescript-ts-mode
    tsx-ts-mode
    lua-ts-mode
    c-ts-mode
    qml-ts-mode)
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
  :ensure nil
  :config
  (setq flymake-indicator-type 'margins
        flymake-margin-indicator-position 'right-margin))

;;; Utilities

;; Mini Buffer Completions
(use-package minibuffer
  :ensure nil
  :config
  ;; Do not inform me about the default keybindings to select a
  ;; candidate.
  (setq completion-show-help nil)

  ;; Do not print messages in the echo area that pertain to
  ;; completion---those are distracting.
  (setq completion-show-inline-help nil)

  ;; Show useful annotations in various minibuffer prompts (though the
  ;; `marginalia' package greatly improves this).
  (setq completions-detailed t)

  ;; Do not use rows and columns for completions: a single vertical
  ;; list is easier to follow.
  (setq completions-format 'one-column)

  ;; Put an upper limit to the Completions window, so that it does not
  ;; disorient me.
  (setq completions-max-height 12)

  ;; Rely on previous inputs to surface candidates towards the top of
  ;; the list (enable the built-in `savehist-mode' to persist
  ;; history).
  (setq completions-sort 'historical)

  ;; Show the Completions buffer if I hit TAB but there is no unique match yet.
  (setq completion-auto-help t)

  ;; Never switch to the Completions buffer when I type TAB, because I
  ;; want to select candidates while the minibuffer is still in focus,
  ;; per `minibuffer-visible-completions'.  This has the advantage of
  ;; auto-updating the completions as I type.
  (setq completion-auto-select nil
        minibuffer-visible-completions t)

  ;; Those two are also relevant for the `completion-category-overrides', which I
  ;; cover elsewhere in this article.
  (setq completion-eager-display t)
  (setq completion-eager-update t)

  ;; Pattern-matching styles to interpret our input in every context.
  (setq completion-styles '(basic substring initials flex))

  ;; An exception to the above for the `file' category, where we
  ;; specifically want to use the `partial-completion' style:
  (setq completion-category-overrides
        '((file . ((styles partial-completion)))))

  (setq tab-always-indent 'complete)
  
  (define-key minibuffer-local-completion-map (kbd "SPC") 'self-insert-command))

;; Ibuffer
(bind-key "C-x C-b" #'ibuffer)

;; Documentation
(use-package eldoc
  :ensure nil
  :config
  (global-eldoc-mode t))

;; Search keybindings
(use-package which-key
  :ensure nil
  :config
  (which-key-mode t))

(use-package multiple-cursors
  :vc (:url "https://github.com/magnars/multiple-cursors.el")
  
  :config
  (bind-key "C->"     'mc/mark-next-like-this)
  (bind-key "C-<"     'mc/mark-previous-like-this)
  (bind-key "C-c C-<" 'mc/mark-all-like-this)

  (set-face-attribute 'mc/cursor-bar-face nil
                      :height 1.0))

(use-package rainbow-mode
  :vc (:url "https://github.com/emacsmirror/rainbow-mode"))

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
  :ensure nil
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
