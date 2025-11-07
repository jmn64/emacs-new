;; -*- lexical-binding: t -*-

(defun my-startup-screen ()
  "Create and display a custom startup buffer"
  (let ((buffer-name "*My-Dashboard*"))
    (with-current-buffer (get-buffer-create buffer-name)
      (let ((inhibit-read-only t))
	(erase-buffer)
	(insert "Welcome, " (user-full-name) ".\n\n")
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
