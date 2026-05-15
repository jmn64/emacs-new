;;; Extra config: Rust IDE Configuration

;;; Prereqs
;;; Must have rust toolchain installed (rustup)
;;; Must have language server installed (rustup component add rust-analyzer)
;;; Must have MELPA enabled

;;; Basic Mode

(use-package rustic
  :ensure t
  :custom
  (rustic-format-on-save t)
  (rustic-lsp-client 'eglot))

(use-package eglot
  :ensure nil
  :hook (rustic-mode . eglot-ensure))

(use-package consult-eglot
  :ensure t
  :after eglot)

(provide 'setup-rust)
