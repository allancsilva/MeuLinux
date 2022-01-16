;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;;       in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais
(setq kill-do-not-save-duplicates t)
(setq mode-require-final-newline t)
(setq next-line-add-newlines nil)
(setq save-abbrevs 'silently)
(setq sentence-end-double-space nil)
(menu-bar-mode -1)                      ; Disable the menu bar
(scroll-bar-mode -1)                    ; Disable visible scrollbar
(tool-bar-mode -1)                      ; Disable the toolbar
(tooltip-mode -1)                       ; Disable tooltips
(set-fringe-mode 10)                    ; Give some breathing room
(column-number-mode)
(global-display-line-numbers-mode t)
(display-time-mode 1)
(setq use-package-compute-statistics t)
(global-hl-line-mode 1)
(setq-default cursor-type 'bar) 
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)

;;; Ignore case for completion
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(defvar my/font-family "Iosevka")

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Global minor modes
(setq column-number-mode t)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-subword-mode 1)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; Aqui o Straigth el que funciona que nem o Package do Melpa
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Aqui o Package com o Melpa normal 
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

;; ;; Descomentar na primeira vez, e quando quiser atualizar
;;   ;; Initialize use-package on non-Linux platforms
;; (unless (package-installed-p 'use-package)
;;   (package-install 'use-package))
;; (unless package-archive-contents
;;   (package-refresh-contents))  

(require 'use-package)
(setq use-package-always-ensure t)


;; ;; Instalar o Quelpa se precisar!!
;; (if (require 'quelpa nil t)
;;     (quelpa-self-upgrade)
;;   (with-temp-buffer
;;     (url-insert-file-contents
;;      "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
;;     (eval-buffer)))
;; (quelpa
;;  '(quelpa-use-package
;;    :fetcher git
;;    :url "https://github.com/quelpa/quelpa-use-package.git"
;;    :stable nil))
;; (require 'quelpa-use-package)

(straight-use-package
 '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))

(require 'nano-theme-dark)

(require 'nano-faces)
(nano-faces)

(require 'nano-theme)
(nano-theme)

;; Nano header & mode lines
(require 'nano-modeline)

;; Welcome message
(let ((inhibit-message t))
  (message "Welcome to GNU Emacs / N Λ N O edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

(require 'nano-splash)


;; Pacotes começam aqui !!
(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package auto-complete
  :ensure t
  :init 
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))
    
(use-package ace-window
  :ensure t)    

(use-package page-break-lines
  :ensure t
  :init
  (global-page-break-lines-mode))

(use-package minions
  :ensure t
  :init
  (minions-mode))


;; (use-package neotree
;;   :ensure t)

;; (setq neo-theme 'arrow)
;; (setq-default neo-show-hidden-files t)
;; (global-set-key [f8] 'neotree-toggle)
;; (setq neo-window-width 30)

(use-package neotree
  :bind
  ("<f8>" . neotree-toggle)
  :config
  ;; needs package all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  ;; Disable line-numbers minor mode for neotree
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (display-line-numbers-mode -1)))

  ;; Every time when the neotree window is opened, let it find current
  ;; file and jump to node.
  (setq neo-smart-open t)
  (setq neo-window-width 30)
  (setq-default neo-show-hidden-files t)
)


;; Icones e Fontes

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package vscode-icon)

(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode)
         (conf-mode . yas-minor-mode)
         (text-mode . yas-minor-mode)
         (snippet-mode . yas-minor-mode)))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))

(use-package highlight-thing
  :ensure t
  :hook
  (prog-mode . highlight-thing-mode))

;; Flychech
;; pip install pylint
;; npm install eslint
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package smartparens
  :ensure t
  :config
    (add-hook 'prog-mode-hook 'smartparens-mode))

(use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


;; Linguagens aqui   

(use-package frontside-javascript
  :init (frontside-javascript))

(setq-default js-indent-level 2)
(use-package js2-mode
    :mode "\\.js\\'"
    :config
    (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")))
(use-package js2-refactor
    :config
    (js2r-add-keybindings-with-prefix "C-c C-m")
    (add-hook 'js2-mode-hook 'js2-refactor-mode))

 (use-package markdown-mode
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "multimarkdown"))

(use-package go-mode
    :config
    (add-hook 'before-save-hook 'gofmt-before-save))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package rust-mode)

;; Python aqui 
;; pip install elpy flake8 epc isort

(use-package pyvenv)

;; pip install black
(use-package blacken
    :config
    (add-hook 'python-mode-hook 'blacken-mode))


;; Git 
(use-package magit
    :bind ("C-x g" . magit-status))

(use-package git-gutter
    :config
    (global-git-gutter-mode 't))


;; ;; Ergoemacs aqui 
;; (use-package ergoemacs-mode
;;   :ensure t
;;   :config
;;   (progn
;;     (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
;;     (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
;;     (ergoemacs-mode 1)))

;; Outro tema do Emacs 
;; Pra usa-lo primeiro e preciso desabilitar o nano-emacs la em cima
;; Comente as linhas do nano-emacs e descomente essas aqui


;; ;; Temas do Emacs : O kaolin oferece muitos temas
;; (use-package kaolin-themes
;;   :config
;;   (load-theme 'kaolin-dark t)
;;   (kaolin-treemacs-theme))

;; ;; ;; Temas kaolin
;; ;; kaolin-dark - a dark jade variant inspired by Sierra.vim
;; ;; kaolin-light - light variant of the original kaolin-dark.
;; ;; kaolin-aurora - Kaolin meets polar lights.
;; ;; kaolin-bubblegum - Kaolin colorful theme with dark blue background.
;; ;; kaolin-eclipse - a dark purple variant
;; ;; kaolin-galaxy - bright theme based on one of the Sebastian Andaur arts.
;; ;; kaolin-ocean - a dark blue variant.
;; ;; kaolin-temple - dark background with syntax highlighting focus on blue, green and pink shades
;; ;; kaolin-valley-dark - colorful Kaolin theme with brown background.
;; ;; kaolin-valley-light - light variant of kaolin-valley theme.

;; ;; From melpa, M-x package-install RET doom-modeline RET.
;; (use-package doom-modeline
;;   :ensure t
;;   :init (doom-modeline-mode 1))

;; (setq doom-modeline-icon (display-graphic-p))
;; (setq doom-modeline-major-mode-icon t)
;; (setq doom-modeline-major-mode-color-icon t)
;; (setq doom-modeline-buffer-state-icon t)
;; (setq doom-modeline-buffer-modification-icon t)
;; (setq doom-modeline-minor-modes nil)
;; (setq doom-modeline-github-interval (* 30 60))

;; ;; Whether display the environment version.
;; (setq doom-modeline-env-version t)
;; ;; Or for individual languages
;; (setq doom-modeline-env-enable-python t)
;; (setq doom-modeline-env-enable-ruby t)
;; (setq doom-modeline-env-enable-perl t)
;; (setq doom-modeline-env-enable-go t)
;; (setq doom-modeline-env-enable-elixir t)
;; (setq doom-modeline-env-enable-rust t)

;; ;; Change the executables to use for the language version string
;; (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
;; (setq doom-modeline-env-ruby-executable "ruby")
;; (setq doom-modeline-env-perl-executable "perl")
;; (setq doom-modeline-env-go-executable "go")
;; (setq doom-modeline-env-elixir-executable "iex")
;; (setq doom-modeline-env-rust-executable "rustc")

;; ;; ;; Alternativa para a mode-line do Doom-emacs
;; (use-package spaceline
;;   :ensure t  
;;   :init (setq powerline-height 24
;;               spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
;;               powerline-default-separator 'arrow)
;;   :config
;;   (spaceline-spacemacs-theme))


;; Atalhos proprios 

(global-set-key  (kbd "C-<tab>") 'other-window)
(global-set-key  (kbd "M-<up>") 'enlarge-window)
(global-set-key  (kbd "M-<down>") 'shrink-window)
(global-set-key  (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key  (kbd "M-<right>") 'shrink-window-horizontally)

(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C-b") 'neotree-toggle)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(fira-code-mode doom-modeline-now-playing rainbow-mode rainbow-delimiters smartparens which-key use-package no-littering neotree flycheck auto-package-update auto-complete all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
