;;; Configure TRAMP

(use-package tramp
  :config
  ;; can also use "plink" for windows)
  (setq tramp-default-method "ssh")

  ;; use ~/.ssh/config
  (setq tramp-use-ssh-config t)

  ;; Debug Verbosity -- 1, 2, or 3, 3 is full
  (setq tramp-verbose 1)

  ;; cache connection information
  (setq tramp-persistency-file-name (expand-file-name "tramp-persistency" user-emacs-directory))

  ;; Improves speed by reducing directory rechecks
  (setq tramp-completion-reread-directory-timeout nil)
)
