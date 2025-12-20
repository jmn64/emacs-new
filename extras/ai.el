;;; extras/ai.el --- Gemini AI Integration

(use-package gptel
  :ensure t
  :bind (("C-c A s" . gptel-send)
         ("C-c A r" . gptel-rewrite)
         ("C-c A m" . gptel-menu)
         ("C-c A a" . gptel-add))
  :config
  ;; 1. API Key
  (let ((api-key (getenv "GEMINI_API_KEY")))
    (unless api-key
      (message "⚠️ WARNING: GEMINI_API_KEY not found."))
    
    ;; 2. Backend Setup
    (setq gptel-backend 
          (gptel-make-gemini "Gemini"
            :key api-key
            :stream t
            :models '(gemini-3-flash-preview
		      gemini-3-pro-preview
                      ))))

  ;; 3. Default Model (Fast)
  (setq gptel-model 'gemini-3-flash-preview)
  
  ;; 4. Evil Mode Support
  (add-hook 'gptel-mode-hook 'evil-insert-state))

;; SIMPLIFIED: Now installs directly from MELPA
(use-package aider
  :ensure t
  :bind ("C-c A o" . aider-transient-menu)
  :config
  (setq aider-args '("--model" "gemini/gemini-3-flash-preview")))

(provide 'ai)
