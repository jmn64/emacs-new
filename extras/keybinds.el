(use-package hydra
  :ensure t)

(use-package general
  :ensure t
  :config
  ;; Initialize which-key
  (general-auto-unbind-keys)

  ;; Hydra - Resize Window
  (defhydra hydra-window (:color red :hint nil)
	    "
^Size^          ^Movement^
^^^^^^^^^^----------------------
_j_: shrink V   _h_: focus left
_k_: grow V     _j_: focus down
_l_: shrink H   _k_: focus up
_h_: grow H     _l_: focus right
_q_: quit
"
	    ("h" enlarge-window-horizontally)
	    ("l" shrink-window-horizontally)
	    ("k" enlarge-window)
	    ("j" shrink-window)
	    ("H" windmove-left)
	    ("J" windmove-down)
	    ("K" windmove-up)
	    ("L" windmove-right)
	    ("q" nil :exit t))

  ;; Leader key prefix
  (general-create-definer my-leader-def
			  :states '(normal insert visual emacs)
			  :keymaps 'override
			  :prefix "SPC"
			  :global-prefix "M-SPC")

  ;; Bindings
  (my-leader-def
   "c" '(:ignore t :which-key "clock")
   "ci" '(org-clock-in :which-key "clock in")
   "co" '(org-clock-out :which-key "clock out")
   "cg" '(org-clock-goto :which-key "active clock")
   "cr" '(org-clock-report :which-key "clock report")
   "cc" '(org-clock-cancel :which-key "cancel clock")

   "t" '(:ignore t :which-key "toggles")
   "tt" '(load-theme :which-key "choose theme")
   "tn" '(display-line-numbers-mode :which-key "line numbers")

   "f" '(:ignore t :which-key "files")
   "ff" '(find-file :which-key "find file")
   "fs" '(save-buffer :which-key "save file")

   "b" '(:ignore t :which-key "buffers")
   "bb" '(switch-to-buffer :which-key "switch buffer")
   "bk" '(kill-this-buffer :which-key "kill buffer")

   "w" '(:ignore t :which-key "window")
   "wr" '(hydra-window/body :which-key "resize/navigate")
   "wv" '(split-window-right :which-key "split vertical")
   "ws" '(split-window-below :which-key "split horizontal")
   "wd" '(delete-window :which-key "delete-window")

   "o" '(:ignore t :which-key "org")
   "oa" '(:org-agenda :which-key "agenda")
   "oc" '(org-capture :which-key "capture")
   "ol" '(:ignore t :which-key "links")
   "ols" '(org-store-link :which-key "store link")
   "oli" '(org-insert-link-global :which-key "insert link")))

(provide 'keybinds)
