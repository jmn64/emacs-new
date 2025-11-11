;;; Emacs Bedrock
;;;
;;; Extra config: Org-mode starter config

;;; Usage: Append or require this file from init.el for some software
;;; development-focused packages.
;;;
;;; Org-mode is a fantastically powerful package. It does a lot of things, which
;;; makes it a little difficult to understand at first.
;;;
;;; We will configure Org-mode in phases. Work with each phase as you are
;;; comfortable.
;;;
;;; YOU NEED TO CONFIGURE SOME VARIABLES! The most important variable is the
;;; `org-directory', which tells org-mode where to look to find your agenda
;;; files.

;;; See "org-intro.txt" for a high-level overview.

;;; Contents:
;;;
;;;  - Critical variables
;;;  - Phase 1: editing and exporting files
;;;  - Phase 2: todos, agenda generation, and task tracking
;;;  - Phase 3: extensions (org-roam, etc.)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Critical variables
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; These variables need to be set for Org-mode's full power to be unlocked!
;;;
;;; You can read the documentation for any variable with `C-h v'. If you have
;;; Consult configured (see the `base.el' file) then it should help you find
;;; what you're looking for.

;;; Phase 1 variables

;;; Phase 2 variables

;; Agenda variables
(setq org-directory "~/Documents/org/") ; Non-absolute paths for agenda and
                                        ; capture templates will look here.

(setq org-agenda-files (list "~/Documents/org/inbox.org"
			     "~/Documents/org/work.org"
			     "~/Documents/org/home.org"
			     "~/Documents/org/reference.org"))

;; Default tags
(setq org-tag-alist '(
                      ;; domain
                      (:startgroup)
                      ("personal" . ?p)
                      ("work" . ?w)
                      (:endgroup)
                      (:newline)
                      ;; context
                      (:startgroup)
                      ("call")
                      ("email")
                      ("mail")
                      ("web")
                      ("errand")
		      ("computer")
                      (:endgroup)
                      (:newline)
		      ;; classification
		      (:startgroup)
		      ("project")
		      ("meeting")
		      ("someday")
		      (:endgroup)
		      (:newline)
                      ))

;; Org-refile: where should org-refile look?
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))

;; Allow refile to create headings
(setq org-refile-allow-creating-parent-nodes t)

;;; Phase 3 variables

;; Org-roam variables
(setq org-roam-directory "~/Documents/org-roam/")
(setq org-roam-index-file "~/Documents/org-roam/index.org")

;;; Optional variables

;; Advanced: Custom link types
;; This example is for linking a person's 7-character ID to their page on the
;; free genealogy website Family Search.
;;(setq org-link-abbrev-alist
;;      '(("family_search" . "https://www.familysearch.org/tree/person/details/%s")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 1: editing and exporting files
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Indent org headings
(setq org-startup-indented t)

(use-package org
  :hook ((org-mode . visual-line-mode)  ; wrap lines at word breaks
         (org-mode . flyspell-mode))    ; spell checking!

  :bind (:map global-map
	      ("C-c c" . org-capture)               ; capture
	      ("C-c a" . org-agenda)                ; agenda
              ("C-c l s" . org-store-link)          ; Mnemonic: link → store
              ("C-c l i" . org-insert-link-global)) ; Mnemonic: link → insert
  :config
  (require 'oc-csl)                     ; citation support
  (add-to-list 'org-export-backends 'md)

  ;; Make org-open-at-point follow file links in the same window
  (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file)

  ;; Make exporting quotes better
  (setq org-export-with-smart-quotes t)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 2: todos, agenda generation, and task tracking
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Yes, you can have multiple use-package declarations. It's best if their
;; configs don't overlap. Once you've reached Phase 2, I'd recommend merging the
;; config from Phase 1. I've broken it up here for the sake of clarity.
(use-package org
  :config
  ;; Instead of just two states (TODO, DONE) we set up a few different states
  ;; that a task can be in. Run
  ;;     M-x describe-variable RET org-todo-keywords RET
  ;; for documentation on how these keywords work.
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)" "CANCELLED(c!)")
          (sequence "WAITING(w@/!)" "HOLD(h@)")))

  ;; Refile configuration
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-use-outline-path 'file)

  (setq org-capture-templates
        '(
          ("t" "Todo (Inbox)" entry
           (file "inbox.org")
           "* TODO %?\n")

          ("n" "Note (Inbox)" entry
           (file "inbox.org")
           "* %?\n")

          ("j" "Journal Entry" entry
           (file+datetree "journal.org")
	   "* %(format-time-string \"%H:%M\") %? \n")

	  ("p" "Paste Clipboard (inbox)" entry
	   (file "inbox.org")
	   "* TODO %?\n\n%x")

	  ("c" "WSL Clipboard (inbox)" entry
	   (file "inbox.org")
	   "* TODO %?\n\n%(shell-command-to-string (format \"%s | tr -d '\\r'\" xclip-paste-program))")
          )
	)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Phase 3: extensions
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO

;; Org Habit Tracking
(add-to-list 'org-modules 'org-habit t)

;; Makefolding work without changing to insert mode
(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobjects insert navigation)))

;; Org Super Agenda
(use-package org-super-agenda
  :ensure t
  :config
  (org-super-agenda-mode)
  (setq org-agenda-custom-commands
	'(
	  ;; Review Dashboard Attempt
	  ("r" "Review Dashboard"
	   ((tags-todo "-DONE"
		       ((org-agenda-overriding-header "Review Dashboard\n")
			(org-agenda-span 'day)
			(org-super-agenda-groups
			 '(;; Group 1: Process Inbox
			   (:name "1. Process Inbox"
				  :file-path "inbox.org")
			   ;; Group 2: Review Active Projects
			   (:name "2. Review Active Projects"
				  :tag "project")
			   (:name "3. Review Someday/Maybe Items"
				  :tag "someday")))))))

    	  ;; Work Dashboard
    	  ("w" "Work Dashboard"
    	   ((agenda "" ((org-agenda-span 'day)
    			(org-agenda-files '("~/Documents/org/work.org"))
    			(org-super-agenda-groups
    			 '(;; Group 1: Overdue deadlines
    			   (:name "Overdue"
    				  :deadline 'past)
    			   ;; Group 2: Task Scheduled Today
    			   (:name "Today"
    				  :time-grid t
    				  :scheduled 'today
    				  :deadline 'today)
    			   ;; Group 3: Tasks tagged as "NEXT"
    			   (:name "Up Next"
    				  :todo "NEXT")
    			   ;; Group 4: Tasks waiting
    			   (:name "Waiting"
    				  :todo "WAITING")))))))

    	  ;; Home Dashboard
    	  ("h" "Home Dashboard"
    	   ((agenda "" ((org-agenda-span 'day)
    			(org-agenda-files '("~/Documents/org/home.org"))
    			(org-super-agenda-groups
    			 '(;; Group 1: Overdue deadlines
    			   (:name "Overdue"
    				  :deadline 'past)
    			   ;; Group 2: Task Scheduled Today
    			   (:name "Today"
    				  :time-grid t
    				  :scheduled 'today
    				  :deadline 'today)
    			   ;; Group 3: Tasks tagged as "NEXT"
    			   (:name "Up Next"
    				  :todo "NEXT")
    			   ;; Group 4: Tasks waiting
    			   (:name "Waiting"
    				  :todo "WAITING")))))))

    	  ("c" "My Dashboard"
    	   ((agenda "" ((org-agenda-span 'day) ; Today's tasks
    			(org-super-agenda-groups
    			 '(;; Group 1: Overdue deadlines
    			   (:name "Overdue"
    				  :deadline 'past)
    			   ;; Group 2: Tasks Scheduled Today
    			   (:name "Today"
    				  :time-grid t
    				  :scheduled 'today
    				  :deadline 'today)
    			   ;; Group 3: Tasks tagged as "NEXT"
    			   (:name "Up Next"
    				  :todo "NEXT")
    			   ;; Group 4: Tasks waiting
    			   (:name "Waiting"
    				  :todo "WAITING"))))))))))
