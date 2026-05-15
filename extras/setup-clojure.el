(use-package lsp-mode
  :ensure t
  :hook ((clojure-mode . lsp)
	 (clojurescript-mode . lsp))
  :config
  (setq lsp-enable-indentation t)
  (setq lsp-enable-on-type-formatting t)
  (add-hook 'before-save-hook #'lsp-format-buffer nil t))

(use-package cider
  :ensure t
  :custom
  (cider-repl-display-help-banner nil)
  :config
  (add-hook 'cider-mode-hook #'corfu-mode))

(use-package paredit
  :ensure t
  :hook ((clojure-mode . paredit-mode)
	 (cider-repl-mode . paredit-mode)
	 (emacs-lisp-mode . paredit-mode)))

(provide 'setup-clojure)
