(setq gc-cons-threshold 63000000
      gc-cons-percentage 0.6)

(add-to-list 'load-path "~/.emacs.d/elisp/")

(setq config-files '("~/.emacs.d/elisp/pkg.el"
		     "~/.emacs.d/elisp/general.el"
		     "~/.emacs.d/elisp/ui.el"
		     "~/.emacs.d/elisp/typography.el"
		     "~/.emacs.d/elisp/utilities.el"
		     "~/.emacs.d/elisp/programming.el"
		     "~/.emacs.d/elisp/org-mode.el"
		     "~/.emacs.d/elisp/agenda.el"
		     "~/.emacs.d/elisp/terminal.el"
		     "~/.emacs.d/elisp/file-manager.el"))

(dolist (config config-files)
  (load config))



