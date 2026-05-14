;;; Linux Prereqs
;;; sudo dnf install sbcl

(use-package sly
  :ensure t
  :custom
  (inferior-lisp-program "sbcl")
  :config
  (setq sly-complete-symbol-function 'sly-flex-completions))

(provide 'setup-lisp)
