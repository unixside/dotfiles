(setq dired-listing-switches "-alh --group-directories-first"
        dired-free-space nil
        peep-dired-cleanup-on-disable t
        peep-dired-enable-on-directories t
        dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv")))

(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(add-hook 'dired-mode-hook #'diredfl-mode)
