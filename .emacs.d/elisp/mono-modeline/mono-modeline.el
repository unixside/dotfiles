;;; File name: mono-modeline.el
(defgroup mono-modeline nil
  "My own header-line-mode"
  :group 'convenience)

(defcustom mono-modeline-position #'top
  "Default position for the mono modeline"

  :type '(choice (const :tag "Top"    'top)
                 (const :tag "Bottom" 'bottom))
  :group 'mono-modeline)

(defface header-line-status-RO
  '((t (:inherit nil
	:background "#4F4F4f"
	:foreground "#FFFFFF"
	:weight regular
	:slant normal
	:box (:line-width 3 :color "#4F4F4f"))))
  "Face for status file Read only"
  :group 'mono-modeline)

(defface header-line-status-RW
  '((t (:inherit nil	 
	:background "#323232"
	:foreground "#FFFFFF"
	:weight regular
	:slant normal
	:box (:line-width 3 :color "#323232"))))
  "Face for status file read and write"
  :group 'mono-modeline)

(defface header-line-status-**
  '((t (:inherit nil	 
	:background "#6D6D6D"
	:foreground "#FFFFFF"
	:weight regular
	:slant normal
	:box (:line-width 3 :color "#6D6D6D"))))
  "Face for status file modified"
  :group 'mono-modeline)

(defface header-line-default
  '((t (:inherit nil
	:background "#DDDDDD"
	:foreground "#323232"
	:weight light
	:slant italic
	:box (:line-width 3 :color "#DDDDDD"))))
  "Face for default headerline"
  :group 'mono-modeline)

(defface header-line-name
  '((t (:inherit header-line-default
		 :slant normal
		 :weight regular)))
  "Face for current name buffer."
  :group 'mono-modeline)

(defface header-line-name
  '((t (:inherit header-line-default
		 :weight regular
		 :slant normal)))
  "Face for current name buffer."
  :group 'mono-modeline)

(defface header-line-primary
  '((t (:inherit header-line-default
		 :weight light)))
  "Face for current mode in buffer."
  :group 'mono-modeline)

(defface header-line-secondary
  '((t (:inherit header-line-default
		 :weight regular
		 :slant normal)))
  "Face for line number and column indicator."
  :group 'mono-modeline)

(defface header-line-thin
  '((t (:inherit nil
	:box nil
	:height 0.1		 
	:underline nil
	:overline nil)))
  "Face for nice mode line."
  :group 'mono-modeline)

(defface header-line-thin-tty
  '((t (:inherit default
		 :underline nil
		 :overline t)))
  "Face for nice mode line on tty mode"
  :group 'mono-modeline)

(defun mono-vc-branch ()
  "Get version control branch."
  (if vc-mode
      (let ((backend (vc-backend buffer-file-name)))
       	(concat "#"
		(substring-no-properties
		 vc-mode
       		 (+ (if (eq backend 'Hg) 2 3) 2)))) nil))

(defun mono-thin-mode-line ()
  "Set modeline like a underline"
  (interactive)
  (setq mode-line-format (list ""))
    (set-face-attribute 'mode-line-active nil
			:inherit 'header-line-thin
			:background (face-background 'header-line-status-RW)
			:foreground (face-background 'header-line-status-RW))
    (set-face-attribute 'mode-line-inactive nil
			:inherit 'header-line-thin
			:background (face-background 'default)
			:foreground (face-background 'default)))

(defun mono-nil-mode-line ()
  "Disable modeline mode"
  (interactive)
  (dolist (face '(mode-line mode-line-active mode-line-inactive))
    (face-remap-add-relative face
			     :box nil
			     :underline nil
			     :overline nil
			     :height 0.1))
  (setq mode-line-format (list "")))

(defun mono-modeline-prefix ()
  "Get prefix for modeline"
  (cond (buffer-read-only    "RO")
	((buffer-modified-p) "**")
	(t                   "RW")))

(defun mono-modeline-face-prefix ()
  "Get face for prefix."
  (cond (buffer-read-only    'header-line-status-RO)
	((buffer-modified-p) 'header-line-status-**)
	(t                   'header-line-status-RW)))

(defun mono-major-mode ()
  "Get major mode of current buffer."
  (format-mode-line mode-name))

(defun mono-primary-format ()
  "Format primary for mode line with mode."
  (concat "(" (format-mode-line mode-name)
	  (if (mono-vc-branch)
	      (concat " " (mono-vc-branch)) "") ")"))

(defun mono-propertize (item face dpyraise)
  "TODO DOC."
  (setq item (concat item " "))
  (propertize item 'face face 'display `(raise ,dpyraise)))

(defun mono-modeline-fill (reserve)
  "Return empty space using FACE and leaving
     RESERVE space on the right."
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
  	      'face `(:inherit header-line-default)
  	      'display
  	      `((space
		 :align-to (- (+ right right-fringe right-margin)
			      ,reserve)))))

(defun mono-modeline-format (prefix name primary secondary)
  "TODO."
  (interactive)
  (setq name (concat " " name))
  (list
   (mono-propertize    ""         (mono-modeline-face-prefix) 0.36)
   (mono-propertize    prefix     (mono-modeline-face-prefix) 0.18)
   (mono-propertize    name       'header-line-name 0.18)
   (mono-propertize    primary    'header-line-primary 0.18)
   (mono-modeline-fill (+ (length secondary) 1))
   (mono-propertize    secondary  'header-line-secondary 0.18)))

(defun mono-modeline-mode ()
  (interactive)
  (setq format
	'(:eval
	  (mono-modeline-format (mono-modeline-prefix)
				(buffer-name)
				(mono-primary-format)
				(format-mode-line "%l:%c"))))

  (cond ((eq mono-modeline-position 'top)
	 (setq header-line-format format
	       mode-line-format (list "")))
	((eq mono-modeline-position 'bottom)
	 (setq mode-line-format format))))
  
(provide 'mono-modeline)
;;; mono-modeline.el ends here
