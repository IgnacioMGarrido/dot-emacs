;; -*- coding: utf-8; lexical-binding: t -*-
  (unless (package-installed-p 'use-package)
	  (package-refresh-contents)
	  (package-install 'use-package))

  (setq inhibit-startup-message t)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (setq visible-bell 1)
  (fset 'yes-or-no-p 'y-or-n-p)
  (set-charset-priority 'unicode)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-language-environment "UTF-8")
  (set-selection-coding-system 'utf-8)
  '(keyboard-coding-system 'utf-8)

;;Refresh Buffer
  (global-set-key (kbd "<f5>") 'revert-buffer)
  (global-hl-line-mode t)

; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package iedit
  :ensure t
  :bind (:map iedit-mode-keymap ("C-h" . #'sp-backward-delete-char))
  :bind (:map iedit-mode-keymap ("C-f" . #'iedit-restrict-function))
  :bind ("C-;" . #'iedit-mode))

(use-package which-key
      :ensure t
      :config (which-key-mode))

(use-package projectile
  :ensure t
  :config
  (global-set-key (kbd "C-x p") 'projectile-command-map)
  (projectile-mode 1))

(use-package company
		     :ensure t
		     :config
		     (company-tng-configure-default)
		     (setq company-idle-mode 0.1)
		     (setq company-minimum-prefix-length 2)
		     (add-hook 'c++-mode-hook 'company-mode)
		     (add-hook 'c-mode-hook 'company-mode))

		 ;;Set variables to find includes for c++ on windows

	       (setenv "PATH" (concat (getenv "PATH") "C:\\Program Files\\Llvm\\bin"))
		 (custom-set-variables
		 '(company-c-headers-path-system
		    (quote
		     ( "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\include" "C:\\Program Files (x86)\\Windows Kits\\10\\10.0.19041.0\\Include\\shared" "C:\\Program Files (x86)\\Windows Kits\\10\\10.0.19041.0\\Include\\um")))
		  '(company-clang-arguments
		    (quote
		     ("-IC:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\MSVC\\14.36.32532\\include" "-Ic:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt" "-v")))
		  '(company-clang-executable
		    "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\Llvm\\bin\\clang.exe")
		  '(company-clang-insert-arguments nil))
		 ;;TODO add additional includes (Maybe do it per project?)
	       (setq company-tooltip-limit 4)

	     ;;TODO: It is extremly slow when the codebase is too large. find a way to make it faster
	     ;;  (use-package company-ctags
	     ;;    :ensure t)

	     ;;  (with-eval-after-load 'company (company-ctags-auto-setup))
	     ;; To make Irony server to work make sure you send this command when running M-x irony-install-server
	     ;; "cmake" "-DCMAKE_INSTALL_PREFIX=c:/Users/ignacio.martinez/.emacs.d/irony/" "-DLIBCLANG_INCLUDE_DIR=C:\Program Files\LLVM\include" "-DLIBCLANG_LIBRARY=C:\Program Files\LLVM\lib\libclang.lib" "-A x64" "-G Visual Studio 17 2022" "c:/Users/ignacio.martinez/.emacs.d/elpa/irony-1.6.1/server" && "cmake" --build . --use-stderr --config Release --target install

	     ;; Irony mode
	     (use-package company-irony
	       :ensure t
	       :config (add-to-list 'company-backends 'company-irony))

	     (use-package irony
	       :ensure t
	       :config
	       (add-hook 'c++-mode-hook 'irony-mode)
	       (add-hook 'c-mode-hook 'irony-mode)
	       (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

 ;; Windows performance tweaks
   (when (boundp 'w32-pipe-read-delay)
     (setq w32-pipe-read-delay 0))
   ;; Set the buffer size to 64K on Windows (from the original 4K)
   (when (boundp 'w32-pipe-buffer-size)
     (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

'(irony-extra-cmake-args
  '("-DLIBCLANG_INCLUDE_DIR=C:\\Program Files\\LLVM\\include" "-DLIBCLANG_LIBRARY=C:\\Program Files\\LLVM\\lib\\libclang.lib" "-A x64" "-G Visual Studio 17 2022"))

     ;;	(use-package irony-eldoc
     ;;	  :ensure t
     ;;	  :config
     ;;	  (add-hook 'irony-mode-hook #'irony-eldoc))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (custom-set-variables '(flycheck-c/c++-clang-executable (quote "C:\\Program Files\\Llvm\\bin\\clang.exe")))
  )

(use-package flycheck-irony
  :ensure t
   :config
   (progn
     (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

(use-package dumb-jump
  :ensure t
  :init
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; (use-package ggtags
;;   :ensure t
;;   :config
;;   (setq ggtags-executable-directory "C:\\ProgramData\\chocolatey\\lib\\universal-ctags\\tools"))
;; (add-hook 'c-mode-common-hook
;; 	  (lambda ()
;; 	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;; 	      (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

;;(use-package lsp-mode
;;  :ensure t
;;  :bind (:map lsp-mode-map ("C-c l" . #'lsp-command-map))
;;  :bind (:map lsp-mode-map ("C-c d" . #'lsp-describe-thing-at-point))
;;  :bind (:map lsp-mode-map ("C-c a" . #'lsp-execute-code-action))
;;  :config
;;  (lsp-enable-which-key-integration t)
;;  (setq lsp-clients-clangd-executable "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\Llvm\\bin\\clangd.exe")
;;  (add-hook 'prog-mode-hook #'lsp))

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

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dir '(~/.emacs.d/plugins/yasnippet))
  (yas-global-mode 1))

;; better matching for finding buffers
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(defalias 'list-buffers 'ibuffer)

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

(defun my-move-function-up ()
    "Move current function up."
    (interactive)
    (save-excursion
      (c-mark-function)
      (let ((fun-beg (point))
	    (fun-end (mark)))
	(transpose-regions (progn
			     (c-beginning-of-defun 1)
			     (point))
			   (progn
			     (c-end-of-defun 1)
			     (point))
			   fun-beg fun-end))))

(defun my-move-function-down ()
    "Move current function down."
    (interactive)
    (save-excursion
      (c-mark-function)
      (let ((fun-beg (point))
	    (fun-end (mark)))
	(transpose-regions fun-beg fun-end
			   (progn
			     (c-beginning-of-defun -1)
			     (point))
			   (progn
			     (c-end-of-defun 1)
			     (point))))))


(add-hook 'c-mode-common-hook 'ry-c-style-hook-notabs)
(add-hook 'c-mode-common-hook 'psj-c-style-gl)
(add-hook 'c-mode-hook 'display-line-numbers-mode)
(add-hook 'c++-mode-hook 'display-line-numbers-mode)
(add-hook 'c-mode-common-hook #'rainbow-delimiters-mode)
;;Disable word wrapping
(add-hook 'c-mode-common-hook 'toggle-truncate-lines nil)
;;TODO: This messes up previous tab setup
;;(add-hook 'c-mode-common-hook #'smartparens-config)

;; jump between .cpp and .h
(add-hook 'c-mode-common-hook
	  (lambda() 
	    (local-set-key  (kbd "C-c m d") 'ff-find-other-file)))

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

(setq org-src-tab-acts-natively t)

;;window management
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

(load-theme 'tango-dark t)
;; (use-package doom-themes
;; :ensure t
;; :config
;; ;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; (load-theme 'doom-miramare t)

;; ;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)
;; ;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; ;; or for treemacs users
;; (setq doom-themes-treemacs-theme "doom-opera") ; use "doom-colors" for less minimal icon theme
;; (doom-themes-treemacs-config)
;; ;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config))

;; (add-to-list 'default-frame-alist '(font . "Source Code Pro"))
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (set-face-attribute 'default nil :height 100)
 (set-face-attribute 'default nil :font "Source Code Pro" :height 100)
 (set-face-attribute 'variable-pitch nil :font "SF Mono-12")
