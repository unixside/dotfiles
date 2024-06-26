;;; File name: mono-light-theme.el
(deftheme mono-light
  "Monochromatic theme light variant")

(let ((class '((class color) (min-colors 89)))      
      (fg        "#323232")
      (surface   "#4F4F4F")
      (overlay   "#6D6D6D")
      (subtle    "#8A8A8A")
      (muted     "#A7A7A7")
      (strong    "#C4C4C4")      
      (highlight "#E2E2E2")
      (bg-alt    "#F1F1F1")
      (bg        "#FFFFFF"))

  (custom-theme-set-faces
   'mono-light
   `(default                    ((,class :background ,bg :foreground ,fg)))
   `(highlight                  ((,class :background ,bg-alt)))
   `(cursor                     ((,class :background ,bg)))
   `(fringe                     ((,class :background ,bg)))
   `(hl-line                    ((,class :background ,highlight)))
   `(line-number                ((,class :foreground ,muted :weight light :slant italic)))
   `(line-number-current-line   ((,class :foreground ,surface :background ,highlight :weight bold :slant italic)))
   `(mode-line                  ((,class :background ,fg :foreground ,bg)))
   `(mode-line-active           ((,class :background ,fg :foreground ,bg)))
   `(mode-line-inactive         ((,class :background ,highlight :foreground ,fg)))
   `(window-divider             ((,class :foreground ,bg)))
   `(window-divider-first-pixel ((,class :foreground ,bg)))
   `(window-divider-last-pixel  ((,class :foreground ,bg)))
   
   `(font-lock-string-face      ((,class :foreground ,overlay)))
   `(font-lock-doc-face         ((,class :foreground ,overlay)))
   `(font-lock-scape-face       ((,class :foreground ,fg :weight semilight)))
   `(font-lock-keyword-face     ((,class :foreground ,fg :weight regular :slant italic)))
   `(font-lock-function-name-face ((,class :foreground ,surface :weight light :slant italic)))
   `(font-lock-function-call-face ((,class :foreground ,surface :weight light :slant italic)))
   `(font-lock-comment-face       ((,class :foreground ,muted :weight light :slant normal)))
   `(font-lock-constant-face    ((,class :foreground ,overlay :weight regular :slant normal)))
   `(font-lock-builtin-face     ((,class :foreground ,fg :weight regular :slant normal)))
   `(font-lock-type-face        ((,class :foreground ,surface :weight light :slant italic)))
   `(font-lock-variable-name-face ((,class :foreground ,fg :weight light :slant italic)))
   `(font-lock-variable-use-face  ((,class :foreground ,fg :weight light :slant normal)))

   `(rainbow-delimiters-depth-1-face ((,class :foreground ,fg      :weight bold)))
   `(rainbow-delimiters-depth-2-face ((,class :foreground ,surface :weight bold)))
   `(rainbow-delimiters-depth-3-face ((,class :foreground ,overlay :weight bold)))
   `(rainbow-delimiters-depth-4-face ((,class :foreground ,fg      :weight regular)))
   `(rainbow-delimiters-depth-5-face ((,class :foreground ,surface :weight regular)))
   `(rainbow-delimiters-depth-6-face ((,class :foreground ,overlay :weight regular)))
   `(rainbow-delimiters-depth-7-face ((,class :foreground ,fg      :weight light)))
   `(rainbow-delimiters-depth-8-face ((,class :foreground ,surface :weight light)))
   `(rainbow-delimiters-depth-9-face ((,class :foreground ,overlay :weight light)))

   `(variable-pitch ((,class :family "Roboto" :height 160 :weight light)))
   `(fixed-pitch    ((,class :family "Roboto Mono" :height 140 :weight light)))

   `(org-level-1 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-2 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-3 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-4 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-5 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-6 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-7 ((,class :inherit variable-pitch :weight bold)))
   `(org-level-8 ((,class :inherit variable-pitch :weight bold)))

   `(org-document-title ((,class :inherit variable-pitch :foreground ,fg :height 2.0)))
   `(org-document-info  ((,class :inherit variable-pitch)))
   `(org-document-info-keyword ((,class :inherit fixed-pitch :foreground ,muted)))
   `(org-block          ((,class :inherit fixed-pitch :background ,bg-alt)))
   `(org-code           ((,class :inherit fixed-pitch)))
   `(org-date           ((,class :inherit fixed-pitch :foreground ,overlay :underline t)))
   `(org-table          ((,class :inherit fixed-pitch :foreground ,muted)))
   `(org-tag            ((,class :inherit fixed-pitch :foreground ,subtle)))
   `(org-hide           ((,class :foreground ,bg)))
   `(org-drawer         ((,class :inherit fixed-pitch :weight thin)))
   `(org-special-keyword ((,class :inherit fixed-pitch :weight thin)))
   `(org-meta-line      ((,class :inherit fixed-pitch :weight thin)))
   `(org-todo           ((,class :inherit default :foreground ,fg    :weight semibold)))
   `(org-done           ((,class :inherit default :foreground ,muted :weight semibold)))

   `(org-agenda-structure ((,class :family "Roboto Condensed" :height 190 :weight light :slant italic)))
   `(org-scheduled        ((,class :family "Roboto Mono" :height 140 :weight light :foreground ,fg)))
   `(org-scheduled-today  ((,class :family "Roboto Mono" :height 140 :weight light :foreground ,fg)))
   `(org-time-grid        ((,class :family "Roboto Mono" :height 140 :weight light :foreground ,muted)))
   ))

(provide-theme 'mono-light)
(provide 'mono-light-theme)
;;; mono-light-theme.el ends here
