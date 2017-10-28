(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; (global-evil-leader-mode)
;; (evil-leader/set-leader ",")
;; (evil-leader/set-key
;;  "e" 'find-file
;;  "b" 'switch-to-buffer
;;  "k" 'kill-buffer
;;  "c" 'compile
;;  "o" 'ff-find-other-file
;;  "g" 'magit-status)
;; (use-package evil
;;   :ensure t
;;   :config
;;   (evil-mode t))

(tool-bar-mode -1)

;;(toggle-frame-maximized)

(setq inhibit-startup-screen t)

(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
(require 'powerline)
(require 'moe-theme)

;; show highlighted buffer-id as decoration (default: nil)
(setq moe-theme-highlight-buffer-id t)
(moe-theme-set-color 'cyan)
(moe-dark)

(global-set-key (kbd "C-x g") 'magit-status) ; pull up magit status
(global-set-key (kbd "C-c o") 'ff-find-other-file) ; switch between h and cpp files
(global-set-key (kbd "C-c m") 'compile) ; compile command
(global-set-key (kbd "C-c a") 'org-agenda) ; agenda for org
(global-set-key (kbd "C-c c") 'org-capture) ; agenda for org

(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil)

(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(use-package flycheck
 :ensure t
 :init (global-flycheck-mode))

(ido-mode t)

(require 'yasnippet)
(yas-global-mode 1)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-irony
  :ensure t
  :config
  (add-to-list 'company-backends 'company-irony))

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(use-package irony
  :ensure t
)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; (add-hook 'c++-mode-hook 'linum-mode)
;; (add-hook 'c-mode-hook 'linum-mode)

(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)

(setq clang-format-style-option "llvm")

(setq org-log-done 'time)

(setq org-agenda-files (list "~/programming/planning/index.org"
                             "~/org/gcal.org"
                             "~/programming/planning/tasks.org"))

(setq org-default-notes-file (concat org-directory "/notes.org"))
;; Templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/programming/planning/tasks.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    ))
