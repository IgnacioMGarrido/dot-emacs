(require 'server)
(unless (server-running-p)
  (cond
   ((eq system-type 'windows-nt)
    (setq server-auth-dir "~\\.emacs.d\\server\\"))
   ((eq system-type 'gnu/linux)
    (setq server-auth-dir "~/.emacs.d/server/")))
  (setq server-name "emacs-server-file")
  (server-start))

(require 'package)
(setq package-enable-at-startup nil)
 (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages"))
 (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
 (add-to-list 'package-archives '("ublt" . "https://elpa.ubolonton.org/packages/"))

(package-initialize)
;;Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

(defun reload-config ()
  "Reload the literate config from ~/.emacs.d/Readme.org."
  (interactive)
  (org-babel-load-file "~/.emacs.d/Readme.org"))

(reload-config)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
