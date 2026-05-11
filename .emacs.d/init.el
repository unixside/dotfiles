;; init.el --- -*- lexical-binding: t -*-
;;; Package --- Summary
;;; Commentary:
;;; Code:

;; Minimal config for GNU/Emacs

;; Package Manager
(setq-local straight-check-for-modifications nil)

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

(setq package-enable-at-startup nil)
(straight-use-package 'use-package)

;; Startup

(setq-default  inhibit-startup-screen t               ; Disable start-up screen
	           inhibit-startup-message t              ; Disable startup message
	           inhibit-startup-echo-area-message t    ; Disable initial echo message
	           initial-major-mode 'text-mode
	           initial-scratch-message ""             ; Empty the initial *scratch* buffer
	           initial-buffer-choice t               ; Open *scratch* buffer at init
	           scroll-conservatively 101
	           scroll-margin 2)

(setq pop-up-windows nil)

;; Encoding
(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding
(prefer-coding-system       'utf-8)     ; Add utf-8 at the front for automatic detection.
(set-terminal-coding-system 'utf-8)     ; Set coding system of terminal output
(set-keyboard-coding-system 'utf-8)     ; Set coding system for keyboard input on TERMINAL
;;(set-language-environment "English")    ; Set up multilingual environment

(setq-default ispell-dictionary "spanish"
              ispell-alternate-dictionary "/usr/share/dict/spanish"
              ispell-program-name "hunspell")


;; Clipboard
(use-package xclip
  :straight t
  :config
  (setq xclip-program "wl-copy"
        xclip-method 'wl-copy)
  (xclip-mode +1))

;; Help
(setq help-window-select t)

(use-package f
  :straight t)

;; Recent files
(use-package recentf
  :ensure nil
  :config
  (setq recentf-max-menu-items 10
	recentf-max-saved-items 100)
  (recentf-mode))

;; Packages
(use-package rainbow-mode
  :straight t)

(use-package rainbow-delimiters
  :straight t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; Interface
(use-package frame
  :ensure nil
  :config
  (setq default-frame-alist '((min-height . 1)
				              (min-width  . 1)
				              (width      . 100)
				              (height     . 30)
				              (left-fringe . 0)
				              (right-fringe . 0)
				              (internal-border-width . 30)
				              (vertical-scroll-bars . nil)
                              (undecorated t))
	    initial-frame-alist default-frame-alist
        frame-resize-pixelwise t
        frame-inhibit-implied-resize t)
  (setq-default window-divider-default-right-width 24
		        window-divider-default-places 'right-only
		        left-margin-width 0
		        right-margin-width 0
		        window-combination-resize nil)
  (window-divider-mode t))

(electric-pair-mode t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-hl-line-mode -1)
(pixel-scroll-precision-mode 1)
(delete-selection-mode 1)

(setq-default tab-width 4)         ; Default display width of tabs
(setq-default indent-tabs-mode nil) ; Prefer spaces for indentation by default
(setq make-backup-files nil)

;; (require 'display-line-numbers)
;; (setq display-line-numbers-type 'relative
;;       display-line-numbers-width 4)

;; (add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; (add-hook 'conf-mode-hook 'display-line-numbers-mode)

;; Mode line
(use-package nerd-icons
  :straight t)

;; Treesiter, Syntax Highlighting
(use-package treesit-auto
  :straight t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (setq typescript-ts-mode-indent-offset 4)
  (global-treesit-auto-mode))

;; Ligatures
(use-package ligature
  :straight t
  :config
  ;; Enable all Iosevka ligatures in programming modes

  ;; Iosevka fonts
  (ligature-set-ligatures 'prog-mode
                          '("<---" "<--"  "<<-" "<-" "->" "-->"
                            "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                            "<==" "<===" "<=" "=>" "=>>" "==>" "===>"
                            ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                            "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                            ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:"
                            "=:" "<******>" "++" "+++"))
  
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package yasnippet
  :straight t
  :config
  (yas-global-mode t))

;; Force load of `project' from straight
(straight-use-package 'project)
(require 'project)

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
    qml-ts-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) . ("rustup" "run" "stable" "rust-analyzer"
                                             :initializationOptions (:check
                                                                     (:command "clippy")))))
  (add-to-list 'eglot-server-programs '(qml-ts-mode . ("qmlls6"))))

(use-package pyvenv
  :straight (:type git :host github :repo "jorgenschaefer/pyvenv"))

;; Projectile + Flycheck
(use-package projectile
  :straight t
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package flycheck
  :straight t
  :init (global-flycheck-mode))

(use-package flycheck-eglot
  :straight t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode +1))

(use-package flycheck-projectile
  :straight t
  :after (flycheck projectile))

;; Configuratios for language
(use-package qml-ts-mode
  :straight (:type git :host github :repo "xhcoding/qml-ts-mode"))

;;; Rust
(use-package rust-mode
  :straight t
  :after rust-ts-mode 
  :bind (:map rust-ts-mode-map
              ("C-c C-c" . #'rust-compile)
              ("C-c C-r" . #'rust-run)
              ("C-c C-t" . #'rust-test)
              ("C-c C-k" . #'rust-check)))

;;; KDL
(use-package kdl-mode
  :straight t)

;;; Lua
(use-package lua-mode
  :straight t)

;; Javascript
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-ts-mode))

(use-package jest-test-mode 
  :straight t 
  :commands jest-test-mode
  :hook (typescript-ts-mode js-ts-mode typescript-ts-mode tsx-ts-mode))

;;; Markdown
(use-package markdown-mode
  :straight t
  :commands gfm-mode markdown-mod
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  ("\\.markdown\\'" . markdown-mode))

;; Autocompletion
(use-package corfu
  :straight t
  :init
  (global-corfu-mode t)
  (corfu-popupinfo-mode t)
  :config
  (setq corfu-auto t
	    corfu-auto-prefix 2
	    corfu-auto-delay 0.2
	    corfu-separator ?\s
	    corfu-quit-at-boundary nil
	    corfu-quit-no-match t
	    corfu-preview-current nil
	    corfu-on-exact-match nil
	    corfu-scroll-margin 5
	    corfu-popupinfo-delay 1.0))

(use-package corfu-terminal
  :straight t
  :config
  (unless (display-graphic-p)
    (corfu-terminal-mode +1)))

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

(use-package ellama
  :straight t)

;; Utilities
(bind-key "C-x C-b" #'ibuffer)

(use-package iedit
  :straight t
  :config
  (bind-key "C-:" #'iedit-mode))

(use-package multiple-cursors
  :straight t
  :config
  (bind-key "C->" #'mc/mark-next-like-this)
  (bind-key "C-<" #'mc/mark-previous-like-this)
  (bind-key "C-c C-<" #'mc/mark-all-like-this))

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

(use-package which-key
  :ensure nil
  :config
  (which-key-mode t))

(use-package magit
  :straight t
  :config
  (bind-key "C-x g g" #'magit-status))

(use-package vterm
  :straight t)

(use-package vterm-toggle
  :straight t
  :config
  (setq vterm-toggle-fullscreen-p nil
	vterm-toggle-cd-auto-create-buffer t)

  (add-to-list 'display-buffer-alist
             '((lambda (bufname _) (equal bufname vterm-buffer-name))
               (display-buffer-reuse-window display-buffer-in-direction)
               (direction . bottom)
               (dedicated . t)
               (reusable-frames . visible)
               (window-height . 0.3)))
  (bind-key "C-x C-t" #'vterm-toggle))

(use-package agent-shell
  :straight t
  :bind (("C-c a s" . agent-shell)
         ("C-c a c" . agent-shell-send-context))
  :config
  (setq agent-shell-opencode-acp-command '("opencode" "acp")))

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


(defun modus-themes-terminal-transparency ()
  "TODO: docstring"
  (unless (display-graphic-p)
    (set-face-background 'default "unsepecific-bg")
    (set-face-background 'line-number "unsepecific-bg")
    (set-face-background 'fringe "unsepecific-bg")))

(use-package modus-themes
  :straight t
  :config

  (use-package rose-pine-themes
    :straight (:type git :host github :repo "unixside/rose-pine"))
  (load-theme 'rose-pine :no-confirm))

(use-package lean-modeline
  :straight (:type git :host github :repo "unixside/lean-modeline" :branch "dev")
  :custom (lean/font-scale 1.1)
  :config
  (lean-modeline-mode t))

(use-package owr-faces
  :straight (:type git :host github :repo "unixside/owr-faces")
  :config

  (setq owr-faces-face-attrs-preferences
        `((default :family "Iosevka Comfy" :weight light :height 140)
		  (bold :weight bold)
		  (line-number :slant italic)
		  (line-number-current-line :slant italic)
		  (font-lock-keyword-face :weight regular :slant italic)
		  (font-lock-constant-face :slant italic)
		  (font-lock-function-name-face :weight regular :slant italic)
		  (font-lock-function-call-face :weight regular :slant italic)
		  (font-lock-variable-name-face :weight regular)
		  (font-lock-doc-face  :slant italic)
		  (font-lock-comment-face  :slant italic)
		  (font-lock-type-face :weight regular)
		  (font-lock-builtin-face :weight regular)
          (header-line :inherit nil)
          (org-document-title :family "Latin Modern Sans" :weight bold :height 2.2)
          (org-document-info :family "Latin Modern Sans" :slant italic)
          (org-document-info-keyword :family "Roboto Mono")
          (org-meta-line :family "Roboto Mono")
          (org-level-1 :family "Latin Modern Sans" :weight bold :height 2.0)
          (org-level-2 :family "Latin Modern Sans" :weight bold :height 1.8)
          (org-level-3 :family "Latin Modern Sans" :weight bold :height 1.65)
          (org-level-4 :family "Latin Modern Sans" :weight bold :height 1.5)
          (org-level-5 :family "Latin Modern Sans" :weight bold :height 1.2)
          (org-level-6 :family "Latin Modern Sans" :weight bold :height 1.1)
          (org-level-7 :family "Latin Modern Sans" :weight bold :height 1.1)
          (org-level-8 :family "Latin Modern Sans" :weight bold :height 1.1)
          (variable-pitch :family "Latin Modern Sans" :height 1.1 :weight regular)
          (fixed-pitch :family "Roboto Mono")
          (highlight-indent-guides-character-face :inherit font-lock-comment-face :slant normal :weight light)
          (italic :family "Latin Modern Roman" :slant italic
                  :weight semibold :height 0.9)
          ,@(mapcar
             (lambda (face)
               (let ((name (intern (format "rainbow-delimiters-%s-face" (symbol-name face)))))
                 `(,name :weight regular)))
             '(depth-1 depth-2 depth-3 depth-4 depth-5 depth-6 depth-7
                       depth-8 depth-9 unmatched mismatched))))
  
  (add-hook 'owr-faces-functions-hook 'lean/thin-mode-line)
  (add-hook 'owr-faces-functions-hook 'modus-themes-terminal-transparency)
  (owr-faces-mode t))

;; (use-package highlight-indent-guides
;;   :straight t
;;   :hook
;;   (prog-mode . highlight-indent-guides-mode)
;;   :config
;;   (setq highlight-indent-guides-method 'character
;;         highlight-indent-guides-character ?|))

;; Accent
(use-package accent
  :straight t
  :config
  (bind-key "C-x C-a" #'accent-menu))

(use-package olivetti
  :straight t
  :config
  (setq olivetti-body-width 100))

(use-package org-superstar
  :straight t
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package org
  :ensure nil
  :custom
  (org-image-actual-width 500)
  :hook
  (org-mode . visual-line-mode)
  (org-mode . variable-pitch-mode)
  (org-mode . (lambda () (org-superstar-mode 1))))

(provide 'init)
;;; init.el ends here 

