;;; Minimal init.el

;;; Guardrail

(when (< emacs-major-version 29)
  (error "Emacs Bedrock only works with Emacs 29 and newer; you have version %s" emacs-major-version))

;;; Startup
(setq gc-cons-threshold (* 50 1024 1024))
(add-hook 'emacs-startup-hook (lambda () (setq gc-cons-threshold (* 2 1024 1024))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Basic settings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Set my name
(setq user-full-name "Joshua Mead")

;; Prefer newer config if older byte compiled one exists
(setq load-prefer-newer t)

;;; Load Extras

(add-to-list 'load-path (expand-file-name "extras" user-emacs-directory))

(require 'setup-ui)
(require 'setup-defaults)
(require 'setup-completion)
(require 'setup-navigation)

(require 'base)
(require 'rainbow)
(require 'vim-like)
(require 'setup-org)
(require 'setup-roam)
(require 'setup-recutils)
(require 'clipboard)
(require 'setup-dev)
(require 'setup-tramp)
(require 'setup-vterm)
(require 'dashboard)
(require 'setup-rust)
(require 'setup-lisp)
(require 'setup-clojure)
(require 'ai)
(require 'keybinds)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Built-in customization framework
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Run emacs server
(require 'server)
(unless (server-running-p)
  (server-start))
