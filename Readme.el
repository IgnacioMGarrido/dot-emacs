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

(require 'cc-mode)

;; show unncessary whitespace that can mess up your diff
  (add-hook 'prog-mode-hook
	    (lambda () (interactive)
	      (setq show-trailing-whitespace 1)))
;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))
(global-set-key (kbd "C-c w") 'whitespace-mode)

(use-package company
  :ensure t
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))

  (define-key c-mode-map  [(control tab)] 'company-complete)
  (define-key c++-mode-map  [(control tab)] 'company-complete)

(use-package projectile
  :ensure t
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t))

(use-package helm
    :ensure t
    :init
    (progn
      (require 'helm-grep)
      ;; To fix error at compile:
      ;; Error (bytecomp): Forgot to expand macro with-helm-buffer in
      ;; (with-helm-buffer helm-echo-input-in-header-line)
      (if (version< "26.0.50" emacs-version)
	  (eval-when-compile (require 'helm-lib)))

      (defun helm-hide-minibuffer-maybe ()
	(when (with-helm-buffer helm-echo-input-in-header-line)
	  (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
	    (overlay-put ov 'window (selected-window))
	    (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
				    `(:background ,bg-color :foreground ,bg-color)))
	    (setq-local cursor-type nil))))

      (add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)
      ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
      ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
      ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
      (global-set-key (kbd "C-c h") 'helm-command-prefix)
      (global-unset-key (kbd "C-x c"))

      (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
      (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
      (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

      (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
      (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
      (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

      (when (executable-find "curl")
	(setq helm-google-suggest-use-curl-p t))

      (setq helm-google-suggest-use-curl-p t
	    helm-scroll-amount 4 ; scroll 4 lines other window using M-<next>/M-<prior>
	    ;; helm-quick-update t ; do not display invisible candidates
	    helm-ff-search-library-in-sexp t ; search for library in `require' and `declare-function' sexp.

	    ;; you can customize helm-do-grep to execute ack-grep
	    ;; helm-grep-default-command "ack-grep -Hn --smart-case --no-group --no-color %e %p %f"
	    ;; helm-grep-default-recurse-command "ack-grep -H --smart-case --no-group --no-color %e %p %f"
	    helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window

	    helm-echo-input-in-header-line t

	    ;; helm-candidate-number-limit 500 ; limit the number of displayed canidates
	    helm-ff-file-name-history-use-recentf t
	    helm-move-to-line-cycle-in-source t ; move to end or beginning of source when reaching top or bottom of source.
	    helm-buffer-skip-remote-checking t

	    helm-mode-fuzzy-match t

	    helm-buffers-fuzzy-matching t ; fuzzy matching buffer names when non-nil
					  ; useful in helm-mini that lists buffers
	    helm-org-headings-fontify t
	    ;; helm-find-files-sort-directories t
	    ;; ido-use-virtual-buffers t
	    helm-semantic-fuzzy-match t
	    helm-M-x-fuzzy-match t
	    helm-imenu-fuzzy-match t
	    helm-lisp-fuzzy-completion t
	    ;; helm-apropos-fuzzy-match t
	    helm-buffer-skip-remote-checking t
	    helm-locate-fuzzy-match t
	    helm-display-header-line nil)

      (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

      (global-set-key (kbd "M-x") 'helm-M-x)
      (global-set-key (kbd "M-y") 'helm-show-kill-ring)
      (global-set-key (kbd "C-x b") 'helm-buffers-list)
      (global-set-key (kbd "C-x C-f") 'helm-find-files)
      (global-set-key (kbd "C-c r") 'helm-recentf)
      (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
      (global-set-key (kbd "C-c h o") 'helm-occur)
      (global-set-key (kbd "C-c h o") 'helm-occur)

      (global-set-key (kbd "C-c h w") 'helm-wikipedia-suggest)
      (global-set-key (kbd "C-c h g") 'helm-google-suggest)

      (global-set-key (kbd "C-c h x") 'helm-register)
      ;; (global-set-key (kbd "C-x r j") 'jump-to-register)

      (define-key 'help-command (kbd "C-f") 'helm-apropos)
      (define-key 'help-command (kbd "r") 'helm-info-emacs)
      (define-key 'help-command (kbd "C-l") 'helm-locate-library)

      ;; use helm to list eshell history
      (add-hook 'eshell-mode-hook
		#'(lambda ()
		    (define-key eshell-mode-map (kbd "M-l")  'helm-eshell-history)))

  ;;; Save current position to mark ring
      (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

      ;; show minibuffer history with Helm
      (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
      (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

      (define-key global-map [remap find-tag] 'helm-etags-select)

      (define-key global-map [remap list-buffers] 'helm-buffers-list)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; PACKAGE: helm-swoop                ;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Locate the helm-swoop folder to your path
      (use-package helm-swoop
	:bind (("C-c h o" . helm-swoop)
	       ("C-c s" . helm-multi-swoop-all))
	:config
	;; When doing isearch, hand the word over to helm-swoop
	(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

	;; From helm-swoop to helm-multi-swoop-all
	(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

	;; Save buffer when helm-multi-swoop-edit complete
	(setq helm-multi-swoop-edit-save t)

	;; If this value is t, split window inside the current window
	(setq helm-swoop-split-with-multiple-windows t)

	;; Split direcion. 'split-window-vertically or 'split-window-horizontally
	(setq helm-swoop-split-direction 'split-window-vertically)

	;; If nil, you can slightly boost invoke speed in exchange for text color
	(setq helm-swoop-speed-or-color t))

      (helm-mode 1)

      ))

(setq helm-gtags-prefix-key "\C-cg")

(use-package helm-gtags
  :ensure t
  :init
  (progn
    (setq helm-gtags-ignore-case t
	  helm-gtags-auto-update t
	  helm-gtags-use-input-at-cursor t
	  helm-gtags-pulse-at-cursor t
	  helm-gtags-prefix-key "\C-cg"
	  helm-gtags-suggested-key-mapping t)

    ;; Enable helm-gtags-mode in Dired so you can jump to any tag
    ;; when navigate project tree with Dired
    (add-hook 'dired-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in Eshell for the same reason as above
    (add-hook 'eshell-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in languages that GNU Global supports
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'java-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)

    ;; key bindings
    (with-eval-after-load 'helm-gtags
      (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
      (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
      (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
      (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
      (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
      (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history))))

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
