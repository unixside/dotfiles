;; Settings
(setq-default fill-column 80
  	      sentence-end-double-space nil
  	      bidi-paragraph-direction 'left-to-right
  	      truncate-string-ellipsis "…")

(setq x-underline-at-descent-line nil
      x-use-underline-position-properties t
      underline-minimum-offset 10)

;; Line numbers
(require 'display-line-numbers)
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Delimiters
(add-hook 'org-mode-hook  #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Ligatures
(ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                     ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                     "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                     "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                     "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                     "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                     "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                     "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                     ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                     "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                     "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                     "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                     "\\\\" "://"))

(add-hook 'prog-mode-hook #'ligature-mode)

;; Indent Guides
(setq highlight-indent-guides-method 'character
      highlight-indent-guides-character ?|)

(set-face-foreground
 'highlight-indent-guides-character-face (face-foreground 'line-number))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; Fonts
(set-face-attribute 'default nil
                    :family "Iosevka NF"
                    :weight 'light
                    :height 150)

(set-face-attribute 'bold nil
                    :family "Iosevka SS15"
                    :weight 'bold)

(set-face-attribute 'italic nil
                    :family "Iosevka SS15"
                    :weight 'semibold
                    :slant 'italic)

(set-fontset-font t 'unicode
                  (font-spec :name "Inconsolata") nil)

(set-fontset-font t '(#xe000 . #xffdd)
                  (font-spec :name "Iosevka NF"
                             :size 16) nil)

(set-face-attribute 'line-number nil
  		    :family "Iosevka SS07")

(set-face-attribute 'font-lock-keyword-face nil
  		    :family "Iosevka SS15"
		    :slant 'italic
		    :weight 'regular)

(set-face-attribute 'font-lock-type-face nil
  		    :family "Iosevka SS07")

(set-face-attribute 'font-lock-variable-name-face nil
  		    :family "Iosevka SS12")

(set-face-attribute 'font-lock-string-face nil
  		    :family "Iosevka NF")

(set-face-attribute 'font-lock-comment-face nil
		    :family "Iosevka SS15"
		    :slant 'italic)

(setq delimiters-faces '(rainbow-delimiters-depth-1-face
  			 rainbow-delimiters-depth-2-face
  			 rainbow-delimiters-depth-3-face
  			 rainbow-delimiters-depth-4-face
  			 rainbow-delimiters-depth-5-face
  			 rainbow-delimiters-depth-6-face
  			 rainbow-delimiters-depth-7-face
  			 rainbow-delimiters-depth-8-face
  			 rainbow-delimiters-depth-9-face
  			 rainbow-delimiters-unmatched-face
  			 rainbow-delimiters-mismatched-face))

(dolist (face delimiters-faces)
  (set-face-attribute face nil
  		      :family "Iosevka SS15"
		      :foreground (face-foreground 'default)
		      :weight 'semibold))
