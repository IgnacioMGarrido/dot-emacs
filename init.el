(require 'package)
(setq package-enable-at-startup nil)
 (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages"))

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
 '(package-selected-packages
   '(dash rainbow-delimiters smartparens-config yasnippet which-key toc-org org-superstar org-modern counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
