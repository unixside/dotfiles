(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
  	(url-retrieve-synchronously
  	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
  	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'org)

 (setq package-list
        '(rainbow-mode
          rainbow-delimiters
          lua-mode
          rust-mode
          yaml-mode
          haskell-mode
          org-bullets
          olivetti
          which-key
          multiple-cursors
          ibuffer
          iedit
          projectile
          company
          company-box
          yasnippet
          yasnippet-snippets
          lsp-mode
          lsp-java
          lsp-jedi
          lsp-ui
          dap-mode
          vterm
          vterm-toggle
          vertico
          cape
          orderless
          consult
          consult-recoll
          marginalia
          zencoding-mode
          nerd-icons
          nerd-icons-dired
          dired-open
          diredfl
          peep-dired
          org-bullets
          counsel
          svg-lib
          yuck-mode
          ligature
          highlight-indent-guides))

  (dolist (package package-list)
    (progn (straight-use-package package)
	   (require package)))
