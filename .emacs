(require 'cl)

(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq dhruv/packages
  '(spacemacs-theme
    evil
    rainbow-delimiters
    autopair
    powerline
    flycheck
    company
    projectile

    smex

    ;; typescript mode
    tide))

(defun dhruv/packages-installed-p ()
  (loop for pkg in dhruv/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (dhruv/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg dhruv/packages)
    (when (not (package-installed-p pkg))
      (message "Installing %s" pkg)
      (package-install pkg))))

(require 'evil)
(evil-mode 1)
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq inhibit-splash-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(linum-mode 1)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(setq tab-width 4
      indent-tabs-mode nil)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(require 'autopair)
(autopair-global-mode)

(require 'powerline)
(powerline-default-theme)

(projectile-mode +1)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(evil-define-key nil evil-normal-state-map
  (kbd "C-p") 'projectile-find-file)
(evil-define-key nil evil-normal-state-map
  (kbd "C-S-p") 'projectile-find-file)

(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(mode-enabled idle-change))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(package-selected-packages
   (quote
    (smex tide projectile company flycheck powerline autopair spacemacs-theme rainbow-delimiters evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'spacemacs-dark)

;;; .emacs ends here

