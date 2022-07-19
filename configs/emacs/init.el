(setq inhibit-startup-message t)
(setq visible-bell t) 
(setq-default tab-size 2)

(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

(scroll-bar-mode -1)   ; Disable visible scrollbar
(tool-bar-mode -1)     ; Disable the toolbar
(menu-bar-mode -1)     ; Disable the menu bar
(tooltip-mode -1)      ; Disable tooltips
(set-fringe-mode 10)   ; Give some breathing room

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers 'relative)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(defvar jef/default-font-size 120)

(set-face-attribute 'default nil :font "MesloLGS NF" :height jef/default-font-size)
(set-face-attribute 'fixed-pitch nil :font "MesloLGS NF" :height jef/default-font-size)
(set-face-attribute 'variable-pitch nil :font "Roboto" :height jef/default-font-size)
(set-face-attribute 'mode-line nil :family "Noto Sans" :height jef/default-font-size)
(set-face-attribute 'mode-line-inactive nil :family "Noto Sans" :height jef/default-font-size)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("gnu-devel" . "https://elpa.gnu.org/devel/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(setq doom-modeline-height 15)

(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(defun jef/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . jef/evil-hook)
  :config
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)

  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(evil-mode 1)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(defun jef/load-emacs-config ()
  (interactive)
  (find-file "~/.config/emacs/EmacsConfig.org"))

(defun jef/load-tasks-file ()
  (interactive)
  (find-file "~/personal/OrgDatabase/Tasks.org"))

(defun jef/load-org-index ()
  (interactive)
  (find-file "~/personal/OrgDatabase/Index.org"))

(use-package general
  :config
  (general-create-definer jef/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer jef/emacs-base
    :keymaps '(normal insert visual emacs)
    :prefix "C-,"
    :globa-prefix "C-S-,")

  (jef/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")
   "s" '(:ignore t :which-key "shells")
   "se" '(eshell :which-key "eshell")
   "sv" '(vterm :which-key "vterm")
   "st" '(term :which-key "term")
   "b" '(:ignore t :which-key "buffers")
   "bk" '(kill-buffer :which-key "kill buffer")
   "bK" '(kill-this-buffer :which-key "kill this buffer")
   "bc" '(counsel-ibuffer :which-key "switch")
   "g" '(:ignore t :which-key "git")
   "gs" '(magit-status :which-key "status")
   "gp" '(magit-push :which-key "push")
   "gf" '(magit-pull :which-key "pull")
   "gi" '(magit-pull :which-key "init")
   "gc" '(magit-commit :which-key "commit")
   "a" '(:ignore t :which-key "agenda")
   "aa" '(org-agenda :which-key "Open Agenda")
   "at" '(counsel-org-tag :which-key "Add Tag")
   "as" '(org-shiftright :which-key "Cycle Labels"))

  (jef/emacs-base
   "s" '(:ignore t :which-key "source")
   "se" '(jef/load-emacs-config :which-key "Edit ")
   "st" '(jef/load-tasks-file :which-key "Edit Tasks.org")
   "si" '(jef/load-org-index :which-key "Edit Index.org")))

(general-evil-setup)
(general-imap "k"
  (general-key-dispatch 'self-insert-command
    :timeout 0.2
    "j" 'evil-normal-state))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(jef/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package vterm)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects" "~/study" "~/personal")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package tree-sitter
:config
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
:after tree-sitter)

(defun jef/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . jef/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-peek-show-directory nil)
  :config
  (jef/leader-keys "tr" '(lsp-ui-peek-find-references :which-key "Find References")))

(use-package lsp-ivy)

(use-package company
:after lsp-mode
:hook (lsp-mode . company-mode)
:bind (:map company-active-map
            ("<tab>" . company-complete-selection))
      (:map lsp-mode-map
            ("<tab>" . company-indent-or-complete-common))
:custom
(company-minimum-prefix-length 1)
(company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package apheleia
:config
(apheleia-global-mode +1))

(use-package lsp-treemacs
  :after lsp)

(use-package typescript-mode
  :after tree-sitter
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(define-derived-mode typescriptreact-mode typescript-mode "Typescript TSX")
(add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
(add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx))

(use-package go-mode
  :mode "\\.go\\'"
  :hook (go-mode . lsp-deferred))

(add-hook 'go-mode (lambda () (setq tab-width 2)))

(use-package rust-mode
  :mode "\\.rs\\'"
  :config
  (setq rust-format-on-save t))

(add-hook 'rust-mode-hook
  (lambda () (setq indent-tabs-mode nil)))

(add-hook 'rust-mode-hook
  (lambda () (prettify-symbols-mode)))

(add-hook 'rust-mode-hook #'lsp)

;(define-key rust-mode-map (kbd "C-c C-c") 'rust-run)

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config
  (defalias 'ff 'find-file)
  (defalias 'ffo 'find-file-other-window)

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(defun jef/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (setq org-hide-emphasis-markers t)
  (setq evil-auto-indent nil))

(defun jef/org-font-setup ()

  (dolist (face '((org-level-1 . 1.2)
  		(org-level-2 . 1.1)
  		(org-level-3 . 1.05)
  		(org-level-4 . 1.0)
  		(org-level-5 . 1.1)
  		(org-level-6 . 1.1)
  		(org-level-7 . 1.1)
  		(org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "MesloLGS NF" :weight 'regular :height (cdr face)))
  
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-date nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

(defun jef/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.config/emacs/EmacsConfig.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook
          (lambda () (add-hook 'after-save-hook #'jef/org-babel-tangle-config)))

(use-package org
  :hook (org-mode . jef/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-agenda-files
	'("~/personal/OrgDatabase/Tasks.org"
	  "~/personal/OrgDatabase/Birthdays.org"))

  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
	  (sequence "APPOINTMENT(a)" "|" "COMPLETED(c)")
	  (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
	'(("Archive.org" :maxlevel . 1)
	  ("Tasks.org" :maxlevel . 1)))

  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
	'((:startgroup)
					;mutually exclusive tags go here
	  (:endgroup)
	  ("home" . ?h)
	  ("work" . ?w)
	  ("recurring" . ?r)))
  
  (setq org-agenda-custom-commands
	'(("d" "Dashboard"
	   ((agenda "" ((org-deadline-warning-days 7)))
	    (todo "NEXT"
	 	 ((org-agenda-overriding-header "Next Tasks")))
	    (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

	  ("n" "Next Tasks"
	   ((todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))))

	  ("A" "Appointments"
	   ((agenda "APPOINTMENT" ((org-agenda-overriding-header "Appointments")
				 (org-deadline-warning-days 7)))))

	  ("W" "Work Tasks" tags-todo "+work")

	  ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&Effort>0"
	   ((org-agenda-overriding-header "Low Effort Tasks")
	    (org-agenda-max-todos 20)
	    (org-agenda-files org-agenda-files)))

	  ("g" "German"
	   ((todo "TODO" ((org-agenda-overriding-header "German Lessons")
			  (org-agenda-files '("~/personal/OrgDatabase/German/DeutschToGo.org"))))))
	  

	  ("w" "Workflow Status"
	   ((todo "WAIT"
		  ((org-agenda-overriding-header "Waiting on External")
		   (org-agenda-files org-agenda-files)))
	    (todo "REVIEW"
		  ((org-agenda-overriding-header "In Review")
		   (org-agenda-files org-agenda-files)))
	    (todo "PLAN"
		  ((org-agenda-overriding-header "In Planning")
		   (org-agenda-todo-list-sublevels nil)
		   (org-agenda-files org-agenda-files)))
	    (todo "BACKLOG"
		  ((org-agenda-overriding-header "Project Backlog")
		   (org-agenda-todo-list-sublevels nil)
		   (org-agenda-files org-agenda-files)))
	    (todo "READY"
		  ((org-agenda-overriding-header "Ready for Work")
		   (org-agenda-files org-agenda-files)))
	    (todo "ACTIVE"
		  ((org-agenda-overriding-header "Active Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "COMPLETED"
		  ((org-agenda-overriding-header "Completed Projects")
		   (org-agenda-files org-agenda-files)))
	    (todo "CANC"
		  ((org-agenda-overriding-header "Cancelled Projects")
		   (org-agenda-files org-agenda-files)))))))

(setq org-capture-templates
      `(("t" "Tasks / Projects")
	("tt" "Task" entry (file+olp "~/personal/OrgDatabase/Tasks.org" "Inbox") "* TODO %?\n %U\n %a\n %i" :empty-lines 1)

	("j" "Journal Entries")
	("jj" "Journal" entry
	 (file+olp+datetree "~/personal/OrgDatabase/Journal.org")
	 "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
	 :clock-in :clock-resume
	 :empty-lines 1)
	("jm" "Meeting" entry
	 (file+olp+datetree "~/personal/OrgDatabase/Journal.org")
	 "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
	 :clock-in :clock-resume
	 :empty-lines 1)
	("e" "Expenses" table-line (file+headline "~/personal/OrgDatabase/Expenses.org" "Current")
	 "| %U | %^{Item} | %^{Value} |" :kill-buffer t)))

(jef/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun jef/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
	visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :defer t
  :hook (org-mode . jef/org-mode-visual-fill))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
