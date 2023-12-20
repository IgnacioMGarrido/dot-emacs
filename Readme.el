(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(setq backup-directory-alist '((".*" . "~/.emacs/.backup")))
;;Refresh Buffer
(global-set-key (kbd "<f5>") 'revert-buffer)

(use-package which-key
      :ensure t
      :config (which-key-mode))

(use-package counsel
      :ensure t)

    (use-package swiper
      :ensure t
      :config
      (progn
	(ivy-mode)
	(setq ivy-use-virtual-buffers t)
	(setq enable-recursive-minibuffers t)
	;; enable this if you want `swiper' to use it
	;; (setq search-default-mode #'char-fold-to-regexp)
	(global-set-key "\C-s" 'swiper)
	(global-set-key (kbd "C-c C-r") 'ivy-resume)
	(global-set-key (kbd "<f6>") 'ivy-resume)
	(global-set-key (kbd "M-x") 'counsel-M-x)
	(global-set-key (kbd "C-x C-f") 'counsel-find-file)
	(global-set-key (kbd "<f1> f") 'counsel-describe-function)
	(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
	(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
	(global-set-key (kbd "<f1> l") 'counsel-find-library)
	(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
	(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
	(global-set-key (kbd "C-c g") 'counsel-git)
	(global-set-key (kbd "C-c j") 'counsel-git-grep)
	(global-set-key (kbd "C-c k") 'counsel-ag)
	(global-set-key (kbd "C-x l") 'counsel-locate)
	(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
	(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
	))

(use-package  smartparens
  :ensure t
  :config
  (use-package smartparens-config))

(use-package rainbow-delimiters
  :ensure t)

;; better matching for finding buffers
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(defalias 'list-buffers 'ibuffer)

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dir '(~/.emacs.d/plugins/yasnippet))
  (yas-global-mode 1))

;;Add extensions
(setq auto-mode-alist
      (append
       '(("\\.cpp$"   . c++-mode)
	("\\.hpp$"    . c++-mode)
	("\\.c$"      . c++-mode)
	("\\.h$"      . c++-mode)
	("\\.inl$"    . c++-mode)
	("\\.hpp$"    . c++-mode)
	("\\.txt$"    . indented-text-mode)
	("\\.lua$"    . lua-mode))
       auto-mode-alist))

(require 'cc-mode)

     (defconst ry-c-style
     '((c-electric-pound-behavior . nil)
       (c-tab-always-indent       . t)
       (c-hanging-braces-alist    . ((class-open)
				     (class-close)
				     (defun-open)
				     (defun-close)
				     (inline-open)
				     (inline-close)
				     (brace-list-open)
				     (brace-list-close)
				     (brace-list-intro)
				     (brace-list-entry)
				     (block-open)
				     (block-close)
				     (substatement-open)
				     (state-case-open)
				     (class-open)))
       (c-hanging-colons-alist    . ((inher-intro)
				     (case-label)
				     (label)
				     (access-label)
				     (access-key)
				     (member-init-intro)))
       (c-cleanup-list            . (scope-operator
				     list-close-comma
				     defun-close-semi))
       (c-offsets-alist           . ((arglist-close         . c-lineup-arglist)
				     (label                 . -4)
				     (access-label          . -4)
				     (substatement-open     . 0)
				     (statement-case-intro  . 0)
				     (statement-case-open   . 4)
				     (statement-block-intro . c-lineup-for)
				     (block-open            . c-lineup-assignments)
				     (statement-cont        . (c-lineup-assignments 4))
				     (inexpr-class          . c-lineup-arglist-intro-after-paren)
				     (case-label            . 4)
				     (block-open            . 0)
				     (inline-open           . 0)
				     (innamespace           . 0)
				     (topmost-intro-cont    . 0) ; recently changed
				     (knr-argdecl-intro     . -4)
				     (brace-entry-open      . c-lineup-assignments)
				     (brace-list-open       . (c-lineup-arglist-intro-after-paren c-lineup-assignments))
				     (brace-list-open       . (c-lineup-assignments 0))
				     (brace-list-open	 . 0)
				     (brace-list-intro      . 4)
				     (brace-list-entry      . 0)
				     (brace-list-close      . 0)))
       (c-echo-syntactic-information-p . t))
     "ry-c-style")

(defun ry-c-style-hook-notabs ()
  (c-add-style "ryc" ry-c-style t)
  (setq tab-width 4)
  (c-set-offset 'innamespace 0)
  (c-toggle-auto-hungry-state 1)
  (setq c-hanging-semi&comma-criteria '((lambda () 'stop)))
  (setq electric-pair-inhibit-predicate
	(lambda (c)
	  (if (char-equal c ?\') t (electric-pair-default-inhibit c))))
  (sp-pair "'" nil :actions :rem)
  (setq sp-highlight-pair-overlay nil)
  (defadvice align-regexp (around align-regexp-with-spaces activate)
    (let ((indent-tabs-mode nil))
      ad-do-it)))

(defun psj-c-style-gl ()
(setq indent-tabs-mode 'only)
(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it)))

(add-hook 'c-mode-common-hook 'ry-c-style-hook-notabs)
(add-hook 'c-mode-common-hook 'psj-c-style-gl)
(add-hook 'c-mode-common-hook #'rainbow-delimiters-mode)
(add-hook 'c-mode-common-hook #'smartparens-config)

(require 'org-tempo)
(use-package org
  :hook ((org-mode . visual-line-mode) (org-mode . pt/org-mode-hook))
  :hook ((org-src-mode . display-line-numbers-mode)
	 (org-src-mode . pt/disable-elisp-checking))
  :bind (("C-c o c" . org-capture)
	 ("C-c o a" . org-agenda)
	 ("C-c o A" . consult-org-agenda)
	 :map org-mode-map
	 ("M-<left>" . nil)
	 ("M-<right>" . nil)
	 ("C-c c" . #'org-mode-insert-code)
	 ("C-c a f" . #'org-shifttab)
	 ("C-c a S" . #'zero-width))
  :custom
  (org-adapt-indentation nil)
  (org-directory "~/txt")
  (org-special-ctrl-a/e t)

  (org-default-notes-file (concat org-directory "/notes.org"))
  (org-return-follows-link t)
  (org-src-ask-before-returning-to-edit-buffer nil "org-src is kinda needy out of the box")
  (org-src-window-setup 'current-window)
  (org-agenda-files (list (concat org-directory "/todo.org")))
  (org-pretty-entities t)

  :config
  (defun pt/org-mode-hook ())
  (defun make-inserter (c) '(lambda () (interactive) (insert-char c)))
  (defun zero-width () (interactive) (insert "​"))

  (defun pt/disable-elisp-checking ()
    (flymake-mode nil))
  (defun org-mode-insert-code ()
    "Like markdown-insert-code, but for org instead."
    (interactive)
    (org-emphasize ?~)))

(use-package org-modern
  :ensure t
  :config (global-org-modern-mode)
  :custom (org-modern-variable-pitch nil))

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode)
  :config (org-superstar-configure-like-org-bullets))

;;window management
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(load-theme 'tango-dark t)

(set-face-attribute 'default t :font "Ac437 ToshibaSat 8x14-14")
(add-to-list 'default-frame-alist '(font . "Ac437 ToshibaSat 8x14-14"))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
