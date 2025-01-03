(require 'recentf)

(setenv "LANG" "en_US.UTF-8")
(set-default-coding-systems 'utf-8)    ; Default to utf-8 encoding
(prefer-coding-system       'utf-8)    ; Add utf-8 at the front for automatic detection.
(set-terminal-coding-system 'utf-8)    ; Set coding system of terminal output
(set-keyboard-coding-system 'utf-8)    ; Set coding system for keyboard input on TERMINAL
(set-language-environment "English")   ; Set up multilingual environment

(setq-default c-basic-offset 4
	      inhibit-startup-screen t      
              inhibit-startup-message t     
              inhibit-startup-echo-area-message t 
              initial-scratch-message "" 
              initial-buffer-choice t
              inhibit-x-resources t
	      use-short-answers t                     ; Replace yes/no prompts with y/n
  	      confirm-nonexistent-file-or-buffer nil  ; Ok to visit non existent files
	      select-enable-clipboard t) ; Merge system's and Emacs' clipboard

(setq scroll-step            1
      scroll-conservatively  10000
      ;scroll-margin          2
      ;recenter-position      '(5 bottom)
      system-time-locale "C"
      make-backup-files nil
      recentf-max-menu-items 10
      recentf-max-saved-items 100
      frame-title-format "GNU Emacs - %b")

(let (message-log-max)
  (recentf-mode 1))

(setq-default cursor-type '(bar . 2)
	      cursor-in-non-selected-window nil
	      cursor-intangible-mode nil
	      x-stretch-cursor nil)

(blink-cursor-mode 1)
(electric-pair-mode t)
(tooltip-mode -1)                       ; No tooltips
(scroll-bar-mode -1)                    ; No scroll bars
(tool-bar-mode -1)                      ; No toolbar
(delete-selection-mode 1)
