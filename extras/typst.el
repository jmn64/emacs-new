;;; Typst Configuration

;;; Requirements
;;; 1. cargo install tinymist
;;; 2. Tree-sitter grammar (M-x typst-ts-install-grammer)

(unless (package-installed-p 'typst-ts-mode)
  (package-vc-install "https://codeberg.org/meow_king/typst-ts-mode.git"))

(use-package typst-ts-mode
  :ensure nil
  :mode "\\.typ\\'"
  :custom
  (typst-ts-mode-indent-offset 2)
  (add-hook 'typst-ts-mode-hook 'typst-ts-compile-and-preview-mode))

(use-package lsp-mode
  :ensure t
  :hook (typst-ts-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "tinymist")
		    :major-modes '(typst-ts-mode)
		    :server-id 'tinymist)))
