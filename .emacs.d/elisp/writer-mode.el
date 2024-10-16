(defun clear-face-add-relative (face)
  "Clear specific face."
  (face-remap-add-relative face
			   '(:family     'unspecified
			     :foundry    'unspecified
			     :width      'unspecified
			     :height     'unspecified
			     :weight     'unspecified
			     :slant      'unspecified
			     :foreground 'unspecified		     
			     :distant-foreground 'unspecified
			     :background 'unspecified			     
			     :underline  'unspecified
			     :overline   'unspecified
			     :strike-through 'unspecified
			     :box        'unspecified
			     :inverse    'unspecified
			     :stipple    'unspecified
			     :font       'unspecified
			     :fontset    'unspecified
			     :extend     'unspecified
			     :inherit    'unspecified)))

(setq faces-list '(org-archived
		   org-block
		   org-block-begin-line
		   org-block-end-line
		   org-checkbox
		   org-checkbox-statistics-done
		   org-checkbox-statistics-todo
		   org-cite
		   org-cite-key
		   org-clock-overlay
		   org-code
		   org-column
		   org-column-title
		   org-date
		   org-date-selected
		   org-default
		   org-dispatcher-highlight
		   org-document-info
		   org-document-info-keyword
		   org-document-title
		   org-done
		   org-drawer
		   org-ellipsis
		   org-footnote
		   org-formula
		   org-hide
		   org-imminent-deadline
		   org-indent
		   org-inline-src-block
		   org-latex-and-related
		   org-level-1
		   org-level-2
		   org-level-3
		   org-level-4
		   org-level-5
		   org-level-6
		   org-level-7
		   org-level-8
		   org-link
		   org-list-dt
		   org-macro
		   org-meta-line
		   org-mode-line-clock
		   org-mode-line-clock-overrun
		   org-priority
		   org-property-value
		   org-quote
		   org-scheduled
		   org-scheduled-previously
		   org-scheduled-today
		   org-sexp-date
		   org-special-keyword
		   org-table
		   org-table-header
		   org-tag
		   org-tag-group
		   org-target
		   org-todo
		   org-upcoming-deadline
		   org-upcoming-distant-deadline
		   org-verbatim
		   org-verse
		   org-warning))

(defun writer-mode ()
  "My own writer mode"
  (interactive)
  (setq org-hide-emphasis-markers t)
  (variable-pitch-mode)
  (face-remap-add-relative 'org-document-title
			   :family "Roboto Slab"
			   :height 240
			   :weight 'bold)
  (face-remap-add-relative 'org-document-info
			   :family "Victor Mono"
			   :height 180
			   :slant 'italic
			   :weight 'light)
  (face-remap-add-relative 'org-level-1
			   :family "Roboto Slab"
			   :height 200
			   :weight 'bold)
  (face-remap-add-relative 'org-level-2
			   :family "Roboto Slab"
			   :height 180
			   :weight 'bold)
  (face-remap-add-relative 'org-level-3
			   :family "Roboto Slab"
			   :height 165
			   :weight 'bold)
  (face-remap-add-relative 'org-level-4
			   :family "Roboto Slab"
			   :height 155
			   :weight 'bold)
  (face-remap-add-relative 'org-level-5
			   :family "Roboto Slab"
			   :height 150
			   :weight 'bold)
  (face-remap-add-relative 'org-level-6
			   :family "Roboto Slab"
			   :height 145
			   :weight 'bold)
  (face-remap-add-relative 'org-level-7
			   :family "Roboto Slab"
			   :height 145
			   :weight 'bold)
  (face-remap-add-relative 'org-level-8
			   :family "Roboto Slab"
			   :height 145
			   :weight 'bold)
  (face-remap-add-relative 'variable-pitch
			   :family "Roboto"
			   :height 150
			   :weight 'light)
  (face-remap-add-relative 'fixed-pitch
			   :family "Roboto Mono"
			   :height 140
			   :weight 'light)
  (face-remap-add-relative 'bold
			   :family "Roboto Slab"
			   :height 140
			   :weight 'bold)
  (face-remap-add-relative 'italic
			   :family "Victor Mono"
			   :height 140
			   :slant  'italic))

(provide 'writer-mode)
