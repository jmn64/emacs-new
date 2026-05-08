(use-package hydra
  :ensure t)

;;; Recfix Utility
(defun my/rec-fix-auto ()
  "Run 'recfix --auto' on the current file and revert the buffer"
  (interactive)
  (if (buffer-file-name)
      (progn
	(save-buffer)
	(shell-command (format "recfix --auto %s" (shell-quote-argument (buffer-file-name))))
	(revert-buffer t t t)
	(message "recfix --auto applied"))
    (user-error "Buffer is not visiting a file")))

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
   ;; Org Clock
   "c" '(:ignore t :which-key "clock")
   "ci" '(org-clock-in :which-key "clock in")
   "co" '(org-clock-out :which-key "clock out")
   "cg" '(org-clock-goto :which-key "active clock")
   "cr" '(org-clock-report :which-key "clock report")
   "cc" '(org-clock-cancel :which-key "cancel clock")

   ;; Theme Management
   "t" '(:ignore t :which-key "toggles")
   "tt" '(load-theme :which-key "choose theme")
   "td" '((lambda () (interactive) (load-theme 'modus-vivendi-tinted t)) :which-key "dark theme")
   "tl" '((lambda () (interactive) (load-theme 'modus-operandi-tinted t)) :which-key "dark theme")
   "tn" '(display-line-numbers-mode :which-key "line numbers")

   ;; Files
   "f" '(:ignore t :which-key "files")
   "ff" '(find-file :which-key "find file")
   "fs" '(save-buffer :which-key "save file")

   ;; Buffers
   "b" '(:ignore t :which-key "buffers")
   "bb" '(switch-to-buffer :which-key "switch buffer")
   "bk" '(kill-this-buffer :which-key "kill buffer")

   ;; Window Management
   "w" '(:ignore t :which-key "window")
   "wr" '(hydra-window/body :which-key "resize/navigate")
   "wv" '(split-window-right :which-key "split vertical")
   "ws" '(split-window-below :which-key "split horizontal")
   "wd" '(delete-window :which-key "delete-window")

   ;; Recutils
   "r" '(:ignore t :which-key "records")
   "rc" '(rec-cmd-compile :which-key "compile")
   "re" '(rec-edit-mode :which-key "edit")
   "rf" '(my/rec-fix-auto :which-key "fix auto")
   "rs" '(rec-summary-mode :which-key "summary (table view)")
   "rq" '(rec-query :which-key "query/search")
   "ri" '(rec-edit-new-record :which-key "insert new item")
   "rn" '(rec-cmd-goto-next-rec :which-key "Next Record")
   "rb" '(rec-cmd-goto-previous-rec :which-key "Previous Record")
   "rt" '(rec-show-type :which-key "filter by type")

   ;; Org Mode
   "o" '(:ignore t :which-key "org")
   "oa" '(:org-agenda :which-key "agenda")
   "oc" '(org-capture :which-key "capture")
   "ol" '(:ignore t :which-key "links")
   "ols" '(org-store-link :which-key "store link")
   "oli" '(org-insert-link-global :which-key "insert link")))

(provide 'keybinds)
