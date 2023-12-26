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
 '(custom-safe-themes
   '("f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "545ab1a535c913c9214fe5b883046f02982c508815612234140240c129682a68" "ce4234c32262924c1d2f43e6b61312634938777071f1129c7cde3ebd4a3028da" "8b6506330d63e7bc5fb940e7c177a010842ecdda6e1d1941ac5a81b13191020e" "1cae4424345f7fe5225724301ef1a793e610ae5a4e23c023076dc334a9eb940a" "5b9a45080feaedc7820894ebbfe4f8251e13b66654ac4394cb416fef9fdca789" "ff24d14f5f7d355f47d53fd016565ed128bf3af30eb7ce8cae307ee4fe7f3fd0" "1aa4243143f6c9f2a51ff173221f4fd23a1719f4194df6cef8878e75d349613d" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "5586a5db9dadef93b6b6e72720205a4fa92fd60e4ccfd3a5fa389782eab2371b" "683b3fe1689da78a4e64d3ddfce90f2c19eb2d8ab1bab1738a63d8263119c3f4" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "467dc6fdebcf92f4d3e2a2016145ba15841987c71fbe675dcfe34ac47ffb9195" "4ff1c4d05adad3de88da16bd2e857f8374f26f9063b2d77d38d14686e3868d8d" "f458b92de1f6cf0bdda6bce23433877e94816c3364b821eb4ea9852112f5d7dc" "016f665c0dd5f76f8404124482a0b13a573d17e92ff4eb36a66b409f4d1da410" "49acd691c89118c0768c4fb9a333af33e3d2dca48e6f79787478757071d64e68" "eca44f32ae038d7a50ce9c00693b8986f4ab625d5f2b4485e20f22c47f2634ae" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" "bf948e3f55a8cd1f420373410911d0a50be5a04a8886cabe8d8e471ad8fdba8e" "680f62b751481cc5b5b44aeab824e5683cf13792c006aeba1c25ce2d89826426" "a44e2d1636a0114c5e407a748841f6723ed442dc3a0ed086542dc71b92a87aee" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" default))
 '(flycheck-c/c++-clang-executable
   '"C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\VC\\Tools\\Llvm\\bin\\clang.exe")
 '(irony-extra-cmake-args
   '("-DLIBCLANG_INCLUDE_DIR=C:\\Program Files\\LLVM\\include" "-DLIBCLANG_LIBRARY=C:\\Program Files\\LLVM\\lib\\libclang.lib" "-A x64" "-G Visual Studio 17 2022"))
 '(keyboard-coding-system 'utf-8)
 '(package-selected-packages
   '(flycheck-irony irony-eldoc ggtags helm projectile Projectile dumb-jump lsp-mode company-ctags doom-themes iedit expand-region flycheck dash rainbow-delimiters smartparens-config yasnippet which-key toc-org org-superstar org-modern counsel)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
