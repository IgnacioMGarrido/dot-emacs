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
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
 '(backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
 '(company-c-headers-path-system
   '("C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Professional\\VC\\include" "C:\\Program Files (x86)\\Windows Kits\\10\\10.0.19041.0\\Include\\shared" "C:\\Program Files (x86)\\Windows Kits\\10\\10.0.19041.0\\Include\\um"))
 '(company-clang-arguments
   '("-IC:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\MSVC\\14.36.32532\\include" "-Ic:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.19041.0\\ucrt" "-v"))
 '(company-clang-executable
   "C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\Llvm\\bin\\clang.exe")
 '(company-clang-insert-arguments nil)
 '(keyboard-coding-system 'utf-8)
 '(package-selected-packages
   '(company-ctags doom-themes iedit expand-region flycheck dash rainbow-delimiters smartparens-config yasnippet which-key toc-org org-superstar org-modern counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
