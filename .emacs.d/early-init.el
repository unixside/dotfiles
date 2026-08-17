;;; early-init.el --- -*- leaxical-binding: t -*-
;;; Commentary:
;;; Code:

;; No site-wide run-time initializations.
(setq site-run-file nil)

;; No site-wide default library
(setq inhibit-default-init t)

;; Very large threshold for garbage collector during init
(setq gc-cons-threshold most-positive-fixnum)

;; Define directory for native compilation
(setq native-comp-eln-load-path
      (list (expand-file-name "eln-cache" user-emacs-directory)))

;; Reset garbage collector limit after init process has ended (8Mo)
(add-hook 'after-init-hook
          #'(lambda () (setq gc-cons-threshold (* 8 1024 1024))))
;;; early-init.el ends here
