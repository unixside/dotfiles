;;; File name: mono-light-theme.el
(deftheme mono-light
  "Mono theme light variant")

(let ((bg         "#ffffff")
      (fg         "#37474F")
      (faded      "#B0BEC5")
      (subtle     "#ECEFF1")
      (muted      "#9893a5")
      (strong     "#000000")
      (highlight  "#FAFAFA")
      (salient    "#673AB7")
      (critical   "#FF6F00")
      (popout     "#FFAB91"))
  
  (custom-theme-set-faces
   'mono-light

   `(default      ((t (:background ,bg :foreground ,fg))))
   `(cursor       ((t (:background ,strong))))
   `(highlight    ((t (:background ,highlight))))
   `(error        ((t (:foreground ,critical))))
   `(success      ((t (:foreground ,salient))))
   `(shadow       ((t (:foreground ,faded))))
   `(warning      ((t (:foreground ,critical))))
   `(fringe       ((t (:background ,bg))))
   `(region       ((t (:background ,faded))))
   `(link         ((t (:foreground ,salient :underline t))))
   `(link-visited ((t (:foreground ,fg :underline t))))

   `(line-number  ((t (:foreground ,muted :slant italic))))
   `(line-number-current-line  ((t (:foreground ,strong :weight bold :slant italic))))

   `(minibuffer-prompt ((t (:foreground ,salient))))

   `(window-divider ((t (:foreground ,bg :background ,bg))))
   `(window-divider-first-pixel ((t (:foreground ,bg :background ,bg))))
   `(window-divider-last-pixel ((t (:foreground ,bg :background ,bg))))

   ;; Modeline
   `(mode-line          ((t (:foreground ,bg :background ,fg))))
   `(mode-line-active   ((t (:foreground ,bg :background ,fg))))
   `(mode-line-inactive ((t (:foreground ,fg :background ,subtle))))

   ;; Header line
   `(header-line           ((t (:background ,subtle :box (:line-width 3 :color ,subtle)))))
   `(header-line-active    ((t (:background ,subtle :box (:line-width 3 :color ,subtle)))))
   `(header-line-inactive  ((t (:background ,subtle :box (:line-width 3 :color ,subtle)))))

   ;; Mono modeline
   `(header-line-default   ((t (:foreground ,fg :background ,subtle :box (:line-width 3 :color ,subtle)))))
   `(header-line-name      ((t (:foreground ,fg :background ,subtle :weight bold))))
   `(header-line-primary   ((t (:foreground ,fg :background ,subtle :weight light :slant italic))))
   `(header-line-secondary ((t (:foreground ,muted :background ,subtle :weight regular))))
   
   `(header-line-status-** ((t (:foreground ,bg :background ,popout :weight bold :box (:line-width 3 :color ,popout)))))
   `(header-line-status-RO ((t (:foreground ,bg :background ,fg     :weight bold :box (:line-width 3 :color ,popout)))))
   `(header-line-status-RW ((t (:foreground ,bg :background ,faded  :weight bold :box (:line-width 3 :color ,faded)))))

   `(header-line-thin      ((t (:foreground ,fg :background ,fg))))
   `(header-line-thin-tty  ((t (:foreground ,fg :background ,fg))))

   ;; Font locks
   `(font-lock-keyword-face       ((t (:foreground ,salient))))
   `(font-lock-type-face       ((t (:foreground ,salient))))
   `(font-lock-constant-face      ((t (:foreground ,salient))))
   `(font-lock-builtin-face      ((t (:foreground ,salient))))
   `(font-lock-comment-face       ((t (:foreground ,muted))))
   `(font-lock-string-face        ((t (:foreground ,popout))))
   `(font-lock-function-name-face ((t (:foreground ,salient))))
   `(font-lock-variable-name-face ((t (:foreground ,strong))))
   
   ))

(provide-theme 'mono-light)
(provide 'mono-light-theme)
;;; mono-light-theme.el ends here
