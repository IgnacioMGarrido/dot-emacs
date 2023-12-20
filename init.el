(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages"))

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
