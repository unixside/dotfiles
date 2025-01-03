;; Frame
(require 'frame)

;; Default frame settings
(setq default-frame-alist '((min-height . 20)  (height . 32)
                            (min-width  . 40)  (width  . 86)
			    (undecorated . t)
                            (vertical-scroll-bars . nil)
                            (internal-border-width . 35)
                            (left-fringe . 0)
                            (right-fringe . 0)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)))

;; Default frame settings
(setq initial-frame-alist default-frame-alist)

(setq x-underline-at-descent-line t)

;; Window
(setq-default window-divider-default-right-width 24
  	      window-divider-default-places 'right-only		
  	      left-margin-width 0
  	      right-margin-width 0
  	      window-combination-resize nil) 

(window-divider-mode 1)

;; Dialog
(setq-default show-help-function nil    ; No help text
  	      use-file-dialog nil       ; No file dialog
  	      use-dialog-box nil        ; No dialog box
  	      pop-up-windows nil)       ; No popup windows

;; Functions
(defun my/frame-recenter (&optional frame)
  "Center FRAME on the screen.
      FRAME can be a frame name, a terminal name, or a frame.
      If FRAME is omitted or nil, use currently selected frame."
  (interactive)
  (unless (eq 'maximised (frame-parameter nil 'fullscreen))
    (let* ((frame (or (and (boundp 'frame)
                           frame)
                      (selected-frame)))
           (frame-w (frame-pixel-width frame))
           (frame-h (frame-pixel-height frame))
           ;; frame-monitor-workarea returns (x y width height)
           ;; for the monitor
           (monitor-w (nth 2 (frame-monitor-workarea frame)))
           (monitor-h (nth 3 (frame-monitor-workarea frame)))
           (center (list (/ (- monitor-w frame-w) 2)
                         (/ (- monitor-h frame-h) 2))))
      (apply 'set-frame-position
             (flatten-list (list frame center))))))

(add-hook 'after-init-hook #'my/frame-recenter)
(add-hook 'after-make-frame-functions #'my/frame-recenter)

(defun my/make-frame ()
  "Create a new frame and switch to *scratch* buffer."
  (interactive)
  (select-frame
   (make-frame '((internal-border-width . 30)
                 (left-fringe . 1)
                 (right-fringe . 1))))
  (switch-to-buffer "*scratch*")
  (my/frame-recenter))

;; Hightlight current line
;;(add-hook 'prog-mode-hook #'hl-line-mode)
;;(add-hook 'text-mode-hook #'hl-line-mode)

;; Colors
(add-to-list 'custom-theme-load-path "~/.emacs.d/elisp/themes/")
(load-theme 'rose-pine t)

;; Headerline and Modeline
(add-to-list 'load-path "~/.emacs.d/elisp/mono-modeline")
(require 'mono-modeline)

(add-hook 'prog-mode-hook        #'mono-modeline-mode)
(add-hook 'org-mode-hook         #'mono-modeline-mode)
(add-hook 'conf-mode-hook        #'mono-modeline-mode)
(add-hook 'fundamental-mode-hook #'mono-modeline-mode)
(add-hook 'dired-mode-hook 'mono-nil-mode-line)
(mono-thin-mode-line)

