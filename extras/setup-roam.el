(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/org/org-roam/"))
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-mode)

  ;; Main Templates
  (setq org-roam-capture-templates
	'(("d" "default" plain "%?"
	   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
	   :unnarrowed t)))

  ;; Dailies Configuration
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
	'(("d" "default" entry
	   "* %?"
	   :target (file+head "%<%Y-%m-%d>.org"
			      "#+title: %<%Y-%m-%d>\n"))))

  (org-roam-setup))


(use-package consult-org-roam
  :ensure t
  :after org-roam
  :init
  (consult-org-roam-mode 1)
  :custom
  (consult-org-roam-grep-func #'consult-ripgrep))

(provide 'setup-roam)
