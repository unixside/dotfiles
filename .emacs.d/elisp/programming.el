;; Company
(setq-default company-minimum-prefix-length 3
              company-idle-delay 0)
(global-company-mode)
(setq company-box-icons-in-terminal t)
(add-hook 'company-mode-hook 'company-box-mode)

;; Snippets
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"
  	"~/.emacs.d/straight/repos/yasnippet-snippets/snippets"))
(yas-global-mode t)

;; Emmet
(add-hook 'sgml-mode-hook 'zencoding-mode)

;; Projectile
(projectile-mode t)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


(defun my-projectile-run-project (&optional prompt)
  (interactive "P")
  (let ((compilation-read-command
  	 (or (not (projectile-run-command (projectile-compilation-dir)))
  	     prompt)))
    (projectile-run-project prompt)))

;; Rust
(setq rust-format-on-save t)
(define-key rust-mode-map (kbd "C-c C-c") 'rust-run)
(define-key rust-mode-map (kbd "C-c C-t") 'rust-test)
(define-key rust-mode-map (kbd "C-c C-o") 'rust-compile)
(define-key rust-mode-map (kbd "C-c C-r") 'rust-run-clippy)

;; LSP Emacs like VSCode
(setq lsp-keymap-prefix "C-c l")
(setq lsp-enable-symbol-highlighting nil)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-ui-sideline-show-diagnostics nil)
(setq lsp-rust-server 'rust-analyzer)

(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-mode-hook 'lsp)
(add-hook 'pyhton-mode-hook 'lsp)
(add-hook 'lua-mode-hook 'lsp)
(add-hook 'java-mode-hook 'lsp)
(add-hook 'javascript-mode-hook 'lsp)
(add-hook 'lsp-mode-hook 'lsp-enable-which-key-integration)

(with-eval-after-load 'js
  (define-key js-mode-map (kbd "M-.") nil))

