;;; Extra config: Rust IDE Configuration

;;; Prereqs
;;; Must have rust toolchain installed (rustup)
;;; Must have language server installed (rustup component add rust-analyzer)
;;; Must have MELPA enabled

;;; Basic Mode

(use-package rustic
  :ensure t
  :bind (:map rustic-mode-map
	      ("M-j" . lsp-ui-imenu) ; Jump to symbol in file
	      ("M-?" . lsp-find-references) ; Find usages
	      ("C-c C-c l" . flycheck-list-errors)
	      ("C-c C-c r" . lsp-rename)
	      ("C-c C-c b" . rustic-cargo-build)
	      ("C-c C-c t" . rustic-cargo-test))
  :config
  ;; Format code on save using rustfmt
  (setq rustic-format-on-save t)

  ;; Display compilation output
  (setq rustic-compile-backtrace "1")

  ;; Use lsp-mode
  (setq rustic-lsp-client 'lsp-mode))

;;; LSP Mode

(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook ((rustic-mode . lsp) ;; auto start when opening .rs files)
	 (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-parameter-hints t)

  ;; Performance
  (lsp-file-watch-threshold 2000)

  ;; Breadcrumbs
  (lsp-headerline-breadcumb-enable t)
  (lsp-headerline-breadcrumb-segments '(path-up-to-project file-symbols)))

;; LSP-UI adds sidebars and popups
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t) ; Show docs on hover
  (lsp-ui-doc-position 'at-point) ; docs display at cursor
  (lsp-ui-sideline-enable t) 
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t))

;; Use Company for autocomplete
(use-package company
  :ensure t
  :hook (rustic-mode . company-mode)
  :config
  (setq company-idle-delay 0.0) ;; Immediate popups
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t))
