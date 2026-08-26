;;; early-init.el --- -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; No site-wide run-time initializations.
(setq site-run-file nil)

;; No site-wide default library
;; (setq inhibit-default-init t)

;; Very large threshold for garbage collector during init
(setq gc-cons-threshold most-positive-fixnum)

;; Define directory for native compilation
(setq native-comp-eln-load-path
      (list (expand-file-name "eln-cache" user-emacs-directory)))

;; Reset garbage collector limit after init process has ended (8Mo)
(add-hook 'after-init-hook
          #'(lambda () (setq gc-cons-threshold (* 8 1024 1024))))

;; Evita que Emacs altere el tamaño y las barras del frame invisible inicial
(setq frame-inhibit-implied-resize t)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; Forzar parámetros seguros para Wayland/PGTK
(setq pgtk-use-im-context nil) ; Deshabilita bugs con métodos de entrada si fallan en Niri

(provide 'early-init)
;;; early-init.el ends here
