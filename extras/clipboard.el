(use-package xclip
  :ensure t
  :config
  ;; Check if on WSL
  (if (getenv "WSL_DISTRO_NAME")
      ;; on wsl, use wl-clipboard
      (progn
	(setq xclip-program-name "wl-copy")
	(setq xclip-paste-program "wl-paste")
	(setq xclip-select-enable-primary nil)
	(setq xclip-select-enable-clipboard t))

    ;; On native linux, use default clipboard
    (setq xclip-select-enable-clipboard t))
  ;; enable clipboard mode in all cases
  (xclip-mode 1))

(provide 'clipboard)
