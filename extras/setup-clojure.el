(use-package cider
  :ensure t
  :custom
  (cider-repl-display-help-banner nil)
  :config
  (add-hook 'cider-mode-hook #'corfu-mode))

(provide 'setup-clojure)
