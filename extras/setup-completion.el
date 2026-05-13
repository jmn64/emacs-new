;; Vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)
	      ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :custom
  (vertico-cycle t))

;; Orderless -- allows searching out of order (e.g. "thing log" and "log thing")
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; Marginalia -- info to the margins (tags, file dates, sizes)
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; Consult -- Grep and preview functionality
(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode))

;; Embark
(use-package embark
  :ensure t)

(use-package embark-consult
  :ensure t
  :after (embark consult))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(provide 'setup-completion)
