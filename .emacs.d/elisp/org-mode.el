;; General
(with-eval-after-load 'org
  (add-hook 'org-mode-hook #'visual-line-mode))
(add-hook 'org-mode-hook #'visual-line-mode)

(setq org-image-max-width 350
      org-image-align 'center)
(setq-default org-support-shift-select t)
(setq-default org-fontify-quote-and-verse-blocks t)
(setq-default org-hide-emphasis-markers nil)

(add-hook 'org-mode-hook
	  (lambda ()
	    (setq-local electric-pair-inhibit-predicate
			`(lambda (c)
			   (if (char-equal c ?<) t
			     (,electric-pair-inhibit-predicate c))))))

;; Bullets
(add-hook 'org-mode-hook #'org-bullets-mode)

;; Writer Mode
(require 'writer-mode)

;; Functions
(defun mda/org-open-current-window ()
  "Opens file in current window."
  (interactive)                                              
  (let ((org-link-frame-setup (cons (cons 'file 'find-file)
				    org-link-frame-setup)))
    (org-open-at-point)))

(define-key global-map (kbd "C-o") #'mda/org-open-current-window)
