(use-package avy
  :ensure t
  :custom
  (avy-timeout-seconds 0.3) ; Adjust this for typing speed
  (avy-style 'at-full)
  :config
  (avy-setup-default))

(provide 'setup-navigation)
