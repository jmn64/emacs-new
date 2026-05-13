(use-package vterm
  :ensure t
  :config
  (setq vterm-shell "/bin/bash")
  (setq vterm-max-scrollback 10000))

(use-package evil-collection
  :ensure t
  :after (evil vterm)
  :config
  (evil-collection-vterm-setup))

(provide 'setup-vterm)
