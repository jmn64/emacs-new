;; -*- lexical-binding: t -*-

(defun my-startup-screen ()
  "Create and display a custom startup buffer"
  (let ((buffer-name "*My-Dashboard*"))
    (with-current-buffer (get-buffer-create buffer-name)
      (let ((inhibit-read-only t))
	(erase-buffer)
	(insert "Welcome, " (user-full-name) ".\n\n")

	;; Git status check for config
	(let* ((config-dir user-emacs-directory)
	       (git-dir (expand-file-name ".git" config-dir)))
	  (if (not (file-directory-p git-dir))
	      ;; Config is not a git repo
	      (insert (propertize " .emacs.d is not a git repository\n"
				  'face '(:foreground "orange")))
	    ;; Config is a git repo, check status
	    (let* (
		  (expanded-dir (expand-file-name config-dir))
		  (git-status (shell-command-to-string
			       (format "git -C %s status --porcelain"
				       (shell-quote-argument expanded-dir)))))

	      (if (string-blank-p git-status)
		  ;; Clean
		  (insert (propertize " Config is current\n"
				      'face '(:foreground "green")))
		;; Dirty
		(insert (propertize " Config has uncommitted changes\n"
				    'face '(:foreground "red")))))))
	
	(insert "--- Org Agenda Files ---\n")
	(if (and (boundp 'org-agenda-files) org-agenda-files)
	    (dolist (file org-agenda-files)
	      (insert-button
	       (format " %s\n" (file-name-nondirectory file))
	       'action (lambda (btn) (find-file file))
	       'follow-link t
	       'help-echo (format "Open %s" file)))
	  (insert " No `org-agenda-files` defined.\n"))

	(insert "\n--- Org Capture Templates ---\n")
	(if (and (boundp 'org-capture-templates) org-capture-templates)
	    (dolist (template org-capture-templates)
	      (let ((key (nth 0 template))
		    (description (nth 1 template)))
		(insert-button
		 (format " [%s] %s\n" key description)
		 'action (lambda (btn) (org-capture nil key))
		 'follow-link t
		 'help-echo (format "Start capture: %s" description))))
	  (insert " No `org-capture-templates` defined.\n"))
	
	
	;; Super agenda dashboard
	(insert "\n--- Agenda Views ---\n")
	(insert-button " Open Work Dashboard\n"
		       'action (lambda (btn) (org-agenda nil "w"))
		       'follow-link t
		       'help-echo "Open work org-super-agenda view")

	(insert-button " Open Home Dashboard\n"
		       'action (lambda (btn) (org-agenda nil "h"))
		       'follow-link t
		       'help-echo "Open home org-super-agenda view")

	(insert-button " Open Review Dashboard\n"
		       'action (lambda (btn) (org-agenda nil "r"))
		       'follow-link t
		       'help-echo "Open review org-super-agenda view")

	;; Config Files
	(insert "\n--- Configuration ---\n")
	(let* ((extras-dir (expand-file-name "extras" user-emacs-directory)))
	  (insert-button " [Open Extras Config Folder]\n"
			 'action (lambda (btn) (dired extras-dir))
			 'follow-link t
			 'help-echo (format "Open %s in Dired" extras-dir))

	  ;; Link to open magit set to the config directory
	  (insert-button " [Open Magit (Config)]\n"
			 'action (lambda (btn) (magit-status user-emacs-directory))
			 'follow-link t
			 'help-echo "Open Magit status for .emacs.d"))
	
	;; Tool Inventory Functions
	(insert "\n--- Workshop Inventory ---\n")
	(insert-button " [Find a Tool]\n"
		       'action (lambda (btn) (my-workshop-find-tool))
		       'follow-link t
		       'help-echo "Search for a tool in the inventory")

	(insert-button " [Add a New Tool (C-c c i)]\n"
		       'action (lambda (btn) (my-workshop-add-tool))
		       'follow-link t
		       'help-echo "Add a new tool to the inventory")
	
	(insert "\n --- Other Actions ---\n")
	(insert-button " Find File (C-x C-f)\n"
		       'action (lambda (btn) (call-interactively 'find-file)))

	(goto-char (point-min))
	(setq-local inhibit-read-only nil)))

    (set-buffer buffer-name)))

(setq initial-buffer-choice #'my-startup-screen)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

(defun my-show-dashboard ()
  "Show the *My-Dashboard* buffer. If the buffer has been killed, recreate it"
  (interactive)
  (if (not (get-buffer "*My-Dashboard*"))
      (my-startup-screen)
    (switch-to-buffer "*My-Dashboard*")))

(global-set-key (kbd "C-c h") #'my-show-dashboard)
