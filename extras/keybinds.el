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

   ;; Terminals
   "k" '(:ignore t :which-key "terminal")
   "kt" '(vterm :which-key "open vterm")
   "kT" '(vterm-other-window :which-key "vterm other window")

   ;; Buffers
   "b" '(:ignore t :which-key "buffers")
   "bb" '(switch-to-buffer :which-key "switch buffer")
   "bk" '(kill-this-buffer :which-key "kill buffer")

   ;; Embark
   "e" '(:ignore t :which-key "embark")
   "ea" '(embark-act :which-key "embark act")
   "ed" '(embark-dwim :which-key "embark dwim")

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

   ;; Search
   "s" '(:ignore t :which-key "search")
   "sj" '(avy-goto-char-timer :which-key "jump to char")
   "sl" '(avy-goto-line :which-key "jump to line")
   "sw" '(avy-goto-word-1 :which-key "jump to word")
   "ss" '(consult-line :which-key "search buffer")
   "sr" '(consult-ripgrep :which-key "search directory/ripgrep")

   ;; Web Browser
   "w" '(:ignore t :which-key "web browser")
   "ww" '(eww :which-key "Open URL")
   "wb" '(eww-back-url :which-key "back")
   "wf" '(eww-forward-url :which-key "forward")

   ;; Programming
   "p" '(:ignore t :which-key "programming")
   "pa" '(eglot-code-actions :which-key "code actions")
   "pr" '(eglot-rename :which-key "rename symbol")
   "pf" '(eglot-format :which-key "format buffer")
   "ps" '(consult-eglot-symbols :which-key "search symbols")

   ;; Org Mode
   "o" '(:ignore t :which-key "org")
   "oa" '(:org-agenda :which-key "agenda")
   "oc" '(org-capture :which-key "capture")
   ;; Org Export
   "oe" '(:ignore t :which-key "export")
   "oec" '(ox-clip-formatted-copy :which-key "copy as rich text")
   ;; Org Roam
   "or" '(:ignore t :which-key "roam")
   "orf" '(org-roam-node-find :which-key "find node")
   "ori" '(org-roam-node-insert :which-key "insert link")
   "orb" '(org-roam-buffer-toggle :which-key "toggle side buffer")
   "orc" '(org-roam-capture :which-key "capture")
   "ors" '(consult-org-roam-search "which-key" "search nodes (grep)")
   "orr" '(org-roam-refile :which-key "refile heading to node")
   ;; Org Roam Dailies
   "ord" '(:ignore t :which-key "dailies")
   "ordt" '(org-roam-dailies-goto-today :which-key "today")
   "ordy" '(org-roam-dailies-goto-yesterday :which-key "yesterday")
   "ordm" '(org-roam-dailies-goto-tomorrow :which-key "tomorrow")
   "ordd" '(org-roam-dailies-goto-date :which-key "date")
   "ordc" '(org-roam-dailies-capture-today :which-key "capture today")
   ;; Org Links
   "ol" '(:ignore t :which-key "links")
   "ols" '(org-store-link :which-key "store link")
   "oli" '(org-insert-link-global :which-key "insert link")))

(provide 'keybinds)
