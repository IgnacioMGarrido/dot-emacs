(setq
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil)

(setq custom-file (make-temp-name "/tmp/"))

;; (add-to-list 'default-frame-alist '(font . "Source Code Pro"))
 ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
 ;; (set-face-attribute 'default nil :height 100)
 (set-face-attribute 'default nil :font "Source Code Pro" :height 100)
 (set-face-attribute 'variable-pitch nil :font "SF Mono-12")
;; (set-face-attribute 'default nil
;;                     :font "Source Code Pro"
;;                     :height 100
;;                     :weight 'Medium)

;; (set-face-attribute 'variable-pitch nil
;;                     :font "Source Code Pro"
;;                     :height 100
;;                     :weight 'Medium)

;; (set-face-attribute 'fixed-pitch nil
;;                     :font "Source Code Pro"
;;                     :height 100
;;                     :weight 'Medium)

;; (set-face-attribute 'font-lock-comment-face nil
;;                     :slant 'italic)

;; (set-face-attribute 'font-lock-keyword-face nil
;;                     :slant 'italic)

;; (add-to-list 'default-frame-alist '(font . "Source Code Pro"))

;;(load-theme 'tango-dark t)
   (use-package doom-themes
   :ensure t
   :config
   ;; Global settings (defaults)
   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	 doom-themes-enable-italic t) ; if nil, italics is universally disabled
   (load-theme 'doom-ir-black t)

   ;; Enable flashing mode-line on errors
   (doom-themes-visual-bell-config)
   ;; Enable custom neotree theme (all-the-icons must be installed!)
   (doom-themes-neotree-config)
   ;; or for treemacs users
   (setq doom-themes-treemacs-theme "doom-ir-black") ; use "doom-colors" for less minimal icon theme
   (doom-themes-treemacs-config)
   ;; Corrects (and improves) org-mode's native fontification.
   (doom-themes-org-config))


(let ((installed (package-installed-p 'all-the-icons)))
  (use-package all-the-icons :ensure t)
  (unless installed (all-the-icons-install-fonts)))

;; (use-package all-the-icons-dired
;;   :after all-the-icons
;;   :hook (dired-mode . all-the-icons-dired-mode))

;; -*- coding: utf-8; lexical-binding: t -*-
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'server)
(unless (server-running-p) (server-start))
(setq server-use-tcp t)
(defun server-ensure-safe-dir (dir) "Noop" t)

(setq gc-cons-threshold 100000000)
(setq max-specpdl-size 5000)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment "UTF-8")
(set-selection-coding-system 'utf-8)
'(keyboard-coding-system 'utf-8)

(global-hl-line-mode t)
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (pixel-scroll-mode))

(when (eq system-type 'darwin)
  (setq ns-auto-hide-menu-bar t))

(setq
 ;; No need to see GNU agitprop.
 inhibit-startup-screen t
 ;; No need to remind me what a scratch buffer is.
 initial-scratch-message nil
 ;; Double-spaces after periods is morally wrong.
 sentence-end-double-space nil
 ;; Never ding at me, ever.
 ring-bell-function 'ignore
 ;; Save existing clipboard text into the kill ring before replacing it.
 save-interprogram-paste-before-kill t
 ;; Prompts should go in the minibuffer, not in a GUI.
 use-dialog-box nil
 ;; Fix undo in commands affecting the mark.
 mark-even-if-inactive nil
 ;; Let C-k delete the whole line.
 kill-whole-line t
 ;; accept 'y' or 'n' instead of yes/no
 ;; the documentation advises against setting this variable
 ;; the documentation can get bent imo
 use-short-answers t
 ;; my source directory
 default-directory "~/.emacs.d"
 ;; eke out a little more scrolling performance
 fast-but-imprecise-scrolling t
 ;; prefer newer elisp files
 load-prefer-newer t
 ;; when I say to quit, I mean quit
 confirm-kill-processes nil
 ;; if native-comp is having trouble, there's not very much I can do
 native-comp-async-report-warnings-errors 'silent
 ;; unicode ellipses are better
 truncate-string-ellipsis "..."
 ;; I want to close these fast, so switch to it so I can just hit 'q'
 help-window-select t
 ;; this certainly can't hurt anything
 delete-by-moving-to-trash t
 ;; keep the point in the same place while scrolling
 scroll-preserve-screen-position t
 ;; More dynamic scroll
 scroll-step 8
 ;; more info in completions
 completions-detailed t
 ;; highlight error messages more aggressively
 next-error-message-highlight t
 ;; don't let the minibuffer muck up my window tiling
 read-minibuffer-restore-windows t
 ;; scope save prompts to individual projects
 save-some-buffers-default-predicate 'save-some-buffers-root
 ;; don't keep duplicate entries in kill ring
 kill-do-not-save-duplicates t
 ;; Save last known place in file
 save-place-mode 1
 ;; Reset recent files
 recentf-mode 1
 ;; History mode
 history-lenght 25
 ;; Save hist mode
 savehist-mode 1
 )
;; Startup Windowing

(defun nm-ediff-setup-windows (buffer-A buffer-B buffer-C control-buffer)
  (ediff-setup-windows-plain buffer-A buffer-B buffer-C control-buffer))
(setq ediff-window-setup-function 'nm-ediff-setup-windows)
(setq ediff-split-window-function 'split-window-horizontally)
(setq split-window-preferred-function nil)

(setq next-line-add-newlines nil)
;;(setq truncate-partial-width-windows nil)
(split-window-horizontally)

(setq grep-command "grep -irHn ")
(when (string-equal system-type "windows-nt")
    (setq grep-command "findstr -s -n -i -l -c:"))

(use-package projectile
:ensure t
:config
(global-set-key (kbd "C-x p") 'projectile-command-map)
(projectile-mode 1))

(use-package which-key
      :ensure t
      :config (which-key-mode))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package iedit
  :ensure t
  :bind (:map iedit-mode-keymap ("C-h" . #'sp-backward-delete-char))
  :bind (:map iedit-mode-keymap ("C-f" . #'iedit-restrict-function))
  :bind ("C-;" . #'iedit-mode))

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
	(setq search-default-mode #'char-fold-to-regexp)

	(global-set-key "\C-s" 'swiper)
	(global-set-key (kbd "C-c C-r") 'ivy-resume)
	(global-set-key (kbd "<f6>") 'ivy-resume)
	(global-set-key (kbd "M-x") 'counsel-M-x)
	(global-set-key (kbd "M-f") 'counsel-find-file)
	(global-set-key (kbd "<f1> f") 'counsel-describe-function)
	(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
	(global-set-key (kbd "<f1> 1") 'counsel-describe-symbol)
	(global-set-key (kbd "<f1> l") 'counsel-find-library)
	(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
	(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
	(global-set-key (kbd "C-c g") 'counsel-git)
	(global-set-key (kbd "C-c j") 'counsel-git-grep)
	(global-set-key (kbd "C-c k") 'counsel-grep)
	(global-set-key (kbd "C-x l") 'counsel-locate)
	(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
	(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
	))

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

(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config))

(use-package dumb-jump
  :ensure t
  :init
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
  :config
  (setq dumb-jump-force-searcher nil)
  (setq dumb-jump-git-grep-search-args "pattern -- :/")
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(add-hook 'prog-mode-hook
	  (lambda () (interactive)
	    (setq show-trailing-whitespace 1)))

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
  ;;(sp-pair "'" nil :actions :rem)
  ;;(setq sp-highlight-pair-overlay nil)
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
;;(add-hook 'c-mode-common-hook #'rainbow-delimiters-mode)
;;Disable word wrapping
(add-hook 'c-mode-common-hook 'toggle-truncate-lines nil)

;;Adding directorise to search for related files
(setq ff-search-directories
    '("." "../src" "../include" "../../include" "../code" "../include/*" "../../include/*"))

(setq org-support-shift-select t)
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

(defun im-swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
	 (other (next-window))
	 (this-buffer (window-buffer this))
	 (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)))

(defun im-surround (begin end open close)
  "Put OPEN at START and CLOSE at END of the region.
	  If you omit CLOSE, it will reuse OPEN."
  (interactive  "r\nsStart: \nsEnd: ")
  ;; (when (string= close "")
  ;;   (setq close open))
	    ;;; try and be 'smart' about it
  (if (string= close "")
      (if (string= open "{") (setq close "}")
	(if (string= open "<") (setq close ">")
	  (if (string= open "[") (setq close "]")
	    (setq close open)))))
  (save-excursion
    (goto-char end)
    (insert close)
    (goto-char begin)
    (insert open)))

(defun im-surround-by-curly-brackets-func (begin end)
  (interactive "r")
  (save-excursion
    (goto-char end)
    (insert "}")
    (goto-char begin)
    (insert "{")))
(defun im-surround-by-curly-brackets ()
  (interactive)
  (call-interactively 'im-surround-by-curly-brackets-func))

  ;;;;;;;;;;;;;;;; macros and insertions
(defun im-todo ()
  (interactive "*")
  (insert "//TODO(im): ")
  )
(defun im-urgent ()
  (interactive "*")
  (insert "//URGENT(im): ")
  )

(defun ds-beginning-of-line (arg)
  "moves to the begining of line, or from there to first non-ws char"
  (interactive "p")
  (if (and (looking-at "^") (= arg 1)) (skip-chars-forward " \t") (move-beginning-of-line arg)))

(defun next-word-first-letter (p)
  (interactive "d")
  (forward-word)
  (forward-word)
  (backward-word))

(defun pt/unbind-bad-keybindings ()
  "Remove unhelpful keybindings."
  (-map (lambda (x) (unbind-key x)) '("C-x C-f" ;; find-file-read-only
				      "C-x C-d" ;; list-directory
				      "C-z" ;; suspend-frame
				      "C-x C-z" ;; again
				      "<mouse-2>" ;; pasting with mouse-wheel click
				      "<C-wheel-down>" ;; text scale adjust
				      "<C-wheel-up>" ;; ditto
				      "s-n" ;; make-frame
				      "s-t" ;; ns-popup-font-panel
				      "s-p" ;; ns-print-buffer
				      "C-x C-q" ;; read-only-mode
				      "C-/" ;; Undo
				      "C-r" ;; Reverse search
				      )))
(use-package s
  :ensure t)
(use-package dash
  :ensure t
  :config (pt/unbind-bad-keybindings))
(use-package shut-up
  :ensure t)

;;window management
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;;Movement
(global-set-key "\C-a" 'ds-beginning-of-line)

(global-set-key (kbd "M-b") 'ido-switch-buffer)
(global-set-key (kbd "M-B") 'ido-switch-buffer-other-window)

;;(global-set-key (kbd "M-w") 'other-window)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "M-F") 'find-file-other-window)

(setq ff-always-in-other-window t)
(setq ff-always-try-to-create nil)
(global-set-key (kbd "M-o") 'ff-find-related-file)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-r") 'undo-redo)
(global-set-key (kbd "M-m") 'imenu)
(global-set-key (kbd "C-q") 'im-swap-buffers-in-windows)
(global-set-key (kbd "M-.") 'xref-find-definitions-other-window)
;;Replace
(global-set-key (kbd "M-[") #'im-surround-by-curly-brackets)

(when (string-equal system-type "windows-nt")
  (global-set-key (kbd "C-c k") 'grep))
