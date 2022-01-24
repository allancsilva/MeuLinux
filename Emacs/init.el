;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;;       in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais

(menu-bar-mode -1)                      ; Disable the menu bar

(setq kill-do-not-save-duplicates t)
(setq mode-require-final-newline t)
(setq next-line-add-newlines nil)
(setq save-abbrevs 'silently)
(setq sentence-end-double-space nil)

(scroll-bar-mode -1)                    ; Disable visible scrollbar
(tool-bar-mode -1)                      ; Disable the toolbar
(tooltip-mode -1)                       ; Disable tooltips
(set-fringe-mode 10)                    ; Give some breathing room
(column-number-mode)
(global-display-line-numbers-mode t)
(display-time-mode 1)
(setq use-package-compute-statistics t)
;; (global-hl-line-mode 1)
(setq-default cursor-type 'bar) 
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(setq create-lockfiles nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq help-window-select t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Improve scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq use-dialog-box nil)


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
;; (defvar my/font-family "Iosevka")

;; ;; Make frame transparency overridable
;; (defvar efs/frame-transparency '(90 . 90))

;; ;; Set frame transparency
;; (set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
;; (add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
;; (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Global minor modes
(setq column-number-mode t)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-subword-mode 1)


;; Highlight whitespace.
(setq whitespace-line-column fill-column)
(setq whitespace-style
      '(face lines-tail trailing tabs empty))
(global-whitespace-mode +1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;; Cuidado com isso !! Cuidado com isso !! Cuidado com isso !! 
;; Native Compilation
;; I've started experimenting with the native-comp branch of Emacs for increased performance. 
;; Here are some settings to tweak the behavior slightly:
(setq comp-async-report-warnings-errors nil)



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

;; Always use straight to install on systems other than Linux
(setq straight-use-package-by-default (not (eq system-type 'gnu/linux)))

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)

;; Load the helper package for commands like `straight-x-clean-unused-repos'
(require 'straight-x)


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

;; Change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))



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
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package perspective
  :demand t
  :bind (("C-x C-b" . persp-list-buffers) 
         ("C-M-k" . persp-switch)
         ("C-M-l" . persp-next)
         ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-initial-frame-name "Main")
  :config
  ;; Running `persp-mode' multiple times resets the perspective list...
  (unless (equal persp-mode t)
    (persp-mode)))

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

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; (setq neo-theme 'arrow)
;; (setq-default neo-show-hidden-files t)
;; (global-set-key [f8] 'neotree-toggle)
;; (setq neo-window-width 30)

;; (use-package neotree
;;   :bind
;;   ("<f8>" . neotree-toggle)
;;   :config
;;   ;; needs package all-the-icons
;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;;   ;; Disable line-numbers minor mode for neotree
;;   (add-hook 'neo-after-create-hook
;;             (lambda (&rest _) (display-line-numbers-mode -1)))

;;   ;; Every time when the neotree window is opened, let it find current
;;   ;; file and jump to node.
;;   (setq neo-smart-open t)
;;   (setq neo-window-width 30)
;;   (setq-default neo-show-hidden-files t)
;; )


(use-package bufler
  :disabled
  :straight t
  :bind (("C-M-j" . bufler-switch-buffer)
         ("C-M-k" . bufler-workspace-frame-set))
  :config
  (evil-collection-define-key 'normal 'bufler-list-mode-map
    (kbd "RET")   'bufler-list-buffer-switch
    (kbd "M-RET") 'bufler-list-buffer-peek
    "D"           'bufler-list-buffer-kill)

  (setf bufler-groups
        (bufler-defgroups
          ;; Subgroup collecting all named workspaces.
          (group (auto-workspace))
          ;; Subgroup collecting buffers in a projectile project.
          (group (auto-projectile))
          ;; Grouping browser windows
          (group
           (group-or "Browsers"
                     (name-match "Vimb" (rx bos "vimb"))
                     (name-match "Qutebrowser" (rx bos "Qutebrowser"))
                     (name-match "Chromium" (rx bos "Chromium"))))
          (group
           (group-or "Chat"
                     (mode-match "Telega" (rx bos "telega-"))))
          (group
           ;; Subgroup collecting all `help-mode' and `info-mode' buffers.
           (group-or "Help/Info"
                     (mode-match "*Help*" (rx bos (or "help-" "helpful-")))
                     ;; (mode-match "*Helpful*" (rx bos "helpful-"))
                     (mode-match "*Info*" (rx bos "info-"))))
          (group
           ;; Subgroup collecting all special buffers (i.e. ones that are not
           ;; file-backed), except `magit-status-mode' buffers (which are allowed to fall
           ;; through to other groups, so they end up grouped with their project buffers).
           (group-and "*Special*"
                      (name-match "**Special**"
                                  (rx bos "*" (or "Messages" "Warnings" "scratch" "Backtrace" "Pinentry") "*"))
                      (lambda (buffer)
                        (unless (or (funcall (mode-match "Magit" (rx bos "magit-status"))
                                             buffer)
                                    (funcall (mode-match "Dired" (rx bos "dired"))
                                             buffer)
                                    (funcall (auto-file) buffer))
                          "*Special*"))))
          ;; Group remaining buffers by major mode.
          (auto-mode))))


(use-package openwith
  :config
  (setq openwith-associations
        (list
          (list (openwith-make-extension-regexp
                '("mpg" "mpeg" "mp3" "mp4"
                  "avi" "wmv" "wav" "mov" "flv"
                  "ogm" "ogg" "mkv"))
                "mpv"
                '(file))
          (list (openwith-make-extension-regexp
                '("xbm" "pbm" "pgm" "ppm" "pnm"
                  "png" "gif" "bmp" "tif" "jpeg")) ;; Removed jpg because Telega was
                  ;; causing feh to be opened...
                  "feh"
                  '(file))
          (list (openwith-make-extension-regexp
                '("pdf"))
                "zathura"
                '(file)))))

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
  :after (yasnippet)
  :config (yas-global-mode 1))

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
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'geiser-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode))


(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'notifications))


(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))


(use-package transpose-frame)

;; Linguagens aqui   

;;; C/C++
(use-package cmake-ide
  :init (use-package rtags)
  :config (cmake-ide-setup))

(use-package frontside-javascript
  :init (frontside-javascript))

(setq-default js-indent-level 2)
(use-package js2-mode
    :mode "\\.js\\'"
    :config
    (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")))
    
(use-package apheleia
  :config
  (apheleia-global-mode +1))

(use-package prettier-js
  ;; :hook ((js2-mode . prettier-js-mode)
  ;;        (typescript-mode . prettier-js-mode))
  :config
  (setq prettier-js-show-errors nil))

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

(use-package know-your-http-well
  :defer t)

(use-package web-mode
  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2))

;; 1. Start the server with `httpd-start'
;; 2. Use `impatient-mode' on any buffer
(use-package impatient-mode
  :straight t)

(use-package skewer-mode
  :straight t)

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

;; God-mode aqui 
;; (use-package god-mode
;;     :disabled
;;     :bind (("<escape>" . god-local-mode)
;;            ("C-x C-1" . delete-other-windows)
;;            ("C-x C-2" . split-window-below)
;;            ("C-x C-3" . split-window-right)
;;            ("C-x C-0" . delete-window)))

;; Let's Be Evil !!! 
;; Teclas do Vim aqui 
 
;; (defun dw/evil-hook ()
;;   (dolist (mode '(custom-mode
;;                   eshell-mode
;;                   git-rebase-mode
;;                   erc-mode
;;                   circe-server-mode
;;                   circe-chat-mode
;;                   circe-query-mode
;;                   sauron-mode
;;                   term-mode))
;;   (add-to-list 'evil-emacs-state-modes mode)))

;; (defun dw/dont-arrow-me-bro ()
;;   (interactive)
;;   (message "Arrow keys are bad, you know?"))

;; (use-package undo-tree
;;   :init
;;   (global-undo-tree-mode 1))

;; (use-package evil
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   (setq evil-respect-visual-line-mode t)
;;   (setq evil-undo-system 'undo-tree)
;;   :config
;;   (add-hook 'evil-mode-hook 'dw/evil-hook)
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

;;   ;; Use visual line motions even outside of visual-line-mode buffers
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;;   ;; (unless dw/is-termux
;;   ;;   ;; Disable arrow keys in normal and visual modes
;;   ;;   (define-key evil-normal-state-map (kbd "<left>") 'dw/dont-arrow-me-bro)
;;   ;;   (define-key evil-normal-state-map (kbd "<right>") 'dw/dont-arrow-me-bro)
;;   ;;   (define-key evil-normal-state-map (kbd "<down>") 'dw/dont-arrow-me-bro)
;;   ;;   (define-key evil-normal-state-map (kbd "<up>") 'dw/dont-arrow-me-bro)
;;   ;;   (evil-global-set-key 'motion (kbd "<left>") 'dw/dont-arrow-me-bro)
;;   ;;   (evil-global-set-key 'motion (kbd "<right>") 'dw/dont-arrow-me-bro)
;;   ;;   (evil-global-set-key 'motion (kbd "<down>") 'dw/dont-arrow-me-bro)
;;   ;;   (evil-global-set-key 'motion (kbd "<up>") 'dw/dont-arrow-me-bro))

;;   (evil-set-initial-state 'messages-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))

;; (use-package evil-collection
;;   :after evil
;;   :init
;;   (setq evil-collection-company-use-tng nil)  ;; Is this a bug in evil-collection?
;;   :custom
;;   (evil-collection-outline-bind-tab-p nil)
;;   :config
;;   (setq evil-collection-mode-list
;;         (remove 'lispy evil-collection-mode-list))
;;   (evil-collection-init))


;; (use-package general
;;   :config
;;   (general-evil-setup t)

;;   (general-create-definer dw/leader-key-def
;;     :keymaps '(normal insert visual emacs)
;;     :prefix "SPC"
;;     :global-prefix "C-SPC")

;;   (general-create-definer dw/ctrl-c-keys
;;     :prefix "C-c"))



(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-f" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-wrap t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)

  ;; Use different regex strategies per completion command
  (push '(completion-at-point . ivy--regex-fuzzy) ivy-re-builders-alist) ;; This doesn't seem to work...
  (push '(swiper . ivy--regex-ignore-order) ivy-re-builders-alist)
  (push '(counsel-M-x . ivy--regex-ignore-order) ivy-re-builders-alist)

  ;; Set minibuffer height for different commands
  (setf (alist-get 'counsel-projectile-ag ivy-height-alist) 15)
  (setf (alist-get 'counsel-projectile-rg ivy-height-alist) 15)
  (setf (alist-get 'swiper ivy-height-alist) 15)
  (setf (alist-get 'counsel-switch-buffer ivy-height-alist) 7))

(use-package ivy-hydra
  :defer t
  :after hydra)

(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'ivy-switch-buffer
                   '(:columns
                     ((ivy-rich-candidate (:width 40))
                      (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right)); return the buffer indicators
                      (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))          ; return the major mode info
                      (ivy-rich-switch-buffer-project (:width 15 :face success))             ; return project name using `projectile'
                      (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))  ; return file path relative to project root or `default-directory' if project is nil
                     :predicate
                     (lambda (cand)
                       (if-let ((buffer (get-buffer cand)))
                           ;; Don't mess with EXWM buffers
                           (with-current-buffer buffer
                             (not (derived-mode-p 'exwm-mode)))))))))

(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ;; ("C-M-j" . counsel-switch-buffer)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package flx  ;; Improves sorting for fuzzy-matched results
  :after ivy
  :defer t
  :init
  (setq ivy-flx-limit 10000))

(use-package wgrep)

(use-package ivy-posframe
  :disabled
  :custom
  (ivy-posframe-width      115)
  (ivy-posframe-min-width  115)
  (ivy-posframe-height     10)
  (ivy-posframe-min-height 10)
  :config
  (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
  (setq ivy-posframe-parameters '((parent-frame . nil)
                                  (left-fringe . 8)
                                  (right-fringe . 8)))
  (ivy-posframe-mode 1))

(use-package prescient
  :after counsel
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :after prescient
  :config
  (ivy-prescient-mode 1))

;; (dw/leader-key-def
;;   "r"   '(ivy-resume :which-key "ivy resume")
;;   "f"   '(:ignore t :which-key "files")
;;   "ff"  '(counsel-find-file :which-key "open file")
;;   "C-f" 'counsel-find-file
;;   "fr"  '(counsel-recentf :which-key "recent files")
;;   "fR"  '(revert-buffer :which-key "revert file")
;;   "fj"  '(counsel-file-jump :which-key "jump to file"))

(use-package marginalia
  :after vertico
  :straight t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package embark
  :straight t
  :bind (("C-S-a" . embark-act)
         :map minibuffer-local-map
         ("C-d" . embark-act))
  :config

  ;; Show Embark actions via which-key
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))


;; Outro tema do Emacs 
;; Pra usa-lo primeiro e preciso desabilitar o nano-emacs la em cima
;; Comente as linhas do nano-emacs e descomente essas aqui

; (use-package gruvbox-theme
;   :config
;   (load-theme 'gruvbox-dark-hard t))

;; ;; Lista de temas Gruvbox
;; gruvbox
;; gruvbox-dark-medium
;; gruvbox-dark-soft
;; gruvbox-dark-hard
;; gruvbox-light-medium
;; gruvbox-light-soft
;; gruvbox-light-hard


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


;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-dark+ t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-monokai-pro") ; use "doom-colors" for less minimal icon theme
;;   (doom-themes-treemacs-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

;; ;; Name	                                   Description
;; ;; doom-one	                               Flagship theme based on atom One Dark
;; ;; doom-one-light	                         Flagship theme based on atom One Light
;; ;; doom-vibrant	                           A more vibrant version of doom-one
;; ;; doom-1337	                             ported from VSCode's 1337 Theme
;; ;; doom-acario-dark	                       an original dark theme (thanks to gagbo)
;; ;; doom-acario-light	                     an original light theme (thanks to gagbo)
;; ;; doom-ayu-mirage	                       Dark variant from Ayu themes (thanks to LoveSponge)
;; ;; doom-ayu-light	Light                    variant from Ayu themes(thanks to LoveSponge)
;; ;; doom-badger	                           Based on original Badger theme
;; ;; doom-challenger-deep	                   based on Vim's Challenger deep theme (thanks to fuxialexander)
;; ;; doom-city-lights	                       based on Atom's City lights (thanks to fuxialexander)
;; ;; doom-dark+	                             ported from VS Code's Dark+ theme (thanks to ema2159)
;; ;; doom-dracula	                           an implementation of Dracula theme (thanks to fuxialexander)
;; ;; doom-ephemeral	                         inspired in the Ephemeral Theme from elenapan's dotfiles (thanks to karetsu)
;; ;; doom-fairy-floss	                       a candy colored Sublime theme by sailorhg (thanks to ema2159)
;; ;; doom-flatwhite	                         a unique light theme ported from Flatwhite Syntax (thanks to ShaneKilkelly)
;; ;; doom-gruvbox-light	                     adapted from Morhetz's Gruvbox light variant (thanks for jsoa)
;; ;; doom-gruvbox	                           adapted from Morhetz's Gruvbox (thanks to JongW)
;; ;; doom-henna	                             based on VS Code's Henna (thanks to jsoa)
;; ;; doom-homage-black	                     dark variant of doom-homage white. (thanks to mskorzhinskiy)
;; ;; doom-homage-white	                     a minimalistic, colorless theme, inspired by eziam, tao and jbeans themes. (thanks to mskorzhinskiy)
;; ;; doom-horizon	                           ported from VS Code's Horizon (thanks to karetsu)
;; ;; doom-Iosvkem	                           adapted from Iosvkem (thanks to neutaaaaan)
;; ;; doom-ir-black	                         Port of VIM's IR_Black color scheme (thanks to legendre6891)
;; ;; doom-laserwave	                         a clean 80's synthwave / outrun theme inspired by VS Code's laserwave (thanks to hyakt)
;; ;; doom-manegarm	                         an original autumn-inspired dark theme (thanks to kenranunderscore)
;; ;; doom-material	                         adapted from Material Themes (thanks to tam5)
;; ;; doom-material-dark	                     adapted from Material Dark Theme (thanks to trev-dev)
;; ;; doom-meltbus	                           a dark, mostly monochromatic theme (thanks to spacefrogg)
;; ;; doom-miramare	                         a port of Franbach's Miramare, a variant of gruvbox theme (thanks to sagittaros)
;; ;; doom-molokai	                           a theme based on Texmate's Monokai
;; ;; doom-monokai-classic	                   port of Monokai's Classic variant (thanks to ema2159)
;; ;; doom-monokai-pro	                       port of Monokai's Pro variant (thanks to kadenbarlow)
;; ;; doom-monokai-machine	                   port of Monokai's Pro (Machine) variant (thanks to minikN)
;; ;; doom-monokai-octagon	                   port of Monokai's Pro (Octagon) variant (thanks to minikN)
;; ;; doom-monokai-ristretto	                 port of Monokai's Pro (Ristretto) variant (thanks to minikN)
;; ;; doom-monokai-spectrum	                 port of Monokai's Pro (Spectrum) variant (thanks to minikN)
;; ;; doom-moonlight	                         ported from VS Code's Moonlight Theme (thanks to Brettm12345)
;; ;; doom-nord-light	                       light variant of Nord (thanks to fuxialexander)
;; ;; doom-nord	                             dark variant of Nord (thanks to fuxialexander)
;; ;; doom-nova	                             adapted from Nova (thanks to bigardone)
;; ;; doom-oceanic-next	                     adapted from Oceanic Next theme (thanks to juanwolf)
;; ;; doom-old-hope	                         based on An Old Hope theme (thanks to teesloane)
;; ;; doom-opera-light	                       an original light theme (thanks to jwintz)
;; ;; doom-opera	                             an original dark theme (thanks to jwintz)
;; ;; doom-outrun-electric	                   a neon colored theme inspired in VS Code's Outrun Electric (thanks to ema2159)
;; ;; doom-palenight	                         adapted from Material Themes (thanks to Brettm12345)
;; ;; doom-peacock	                           based on Peacock from daylerees' themes (thanks to teesloane)
;; ;; doom-plain-dark	                       based on plain (thanks to das-s)
;; ;; doom-plain	                             based on plain (thanks to mateossh)
;; ;; doom-rouge	                             ported from VSCode's Rouge Theme (thanks to JordanFaust)
;; ;; doom-shades-of-purple	                 a purple and vibrant theme inspired by VSCode's Shades of Purple (thanks to [jwbaldwin])
;; ;; doom-snazzy	                           a dark theme inspired in Atom's Hyper Snazzy (thanks to ar1a)
;; ;; doom-solarized-dark	                   dark variant of Solarized (thanks to ema2159)
;; ;; doom-solarized-dark-high-contrast	     high contrast dark variant of Solarized (thanks to jmorag)
;; ;; doom-solarized-light	                   light variant of Solarized (thanks to fuxialexander)
;; ;; doom-sourcerer	                         based on Sourcerer (thanks to defphil)
;; ;; doom-spacegrey	                         I'm sure you've heard of it (thanks to teesloane)
;; ;; doom-tokyo-night	                       based on Tokyo Night (thanks to FosterHangdaan)
;; ;; doom-tomorrow-day	                     Tomorrow's light variant (thanks to emacswatcher)
;; ;; doom-tomorrow-night	                   one of the dark variants of Tomorrow (thanks to emacswatcher)
;; ;; doom-wilmersdorf	                       port of Ian Pan's Wilmersdorf (thanks to ema2159)
;; ;; doom-xcode	                             Based off of Apple's Xcode Dark theme (thanks to kadenbarlow)
;; ;; doom-zenburn	                           port of the popular Zenburn theme (thanks to jsoa)


;; ;; From melpa, M-x package-install RET doom-modeline RET.
; (use-package doom-modeline
;   :ensure t
;   :init (doom-modeline-mode 1))

; (setq doom-modeline-icon (display-graphic-p))
; (setq doom-modeline-major-mode-icon t)
; (setq doom-modeline-major-mode-color-icon t)
; (setq doom-modeline-buffer-state-icon t)
; (setq doom-modeline-buffer-modification-icon t)
; (setq doom-modeline-minor-modes nil)
; (setq doom-modeline-github-interval (* 30 60))

; ;; Whether display the environment version.
; (setq doom-modeline-env-version t)
; ;; Or for individual languages
; (setq doom-modeline-env-enable-python t)
; (setq doom-modeline-env-enable-ruby t)
; (setq doom-modeline-env-enable-perl t)
; (setq doom-modeline-env-enable-go t)
; (setq doom-modeline-env-enable-elixir t)
; (setq doom-modeline-env-enable-rust t)

; ;; Change the executables to use for the language version string
; (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
; (setq doom-modeline-env-ruby-executable "ruby")
; (setq doom-modeline-env-perl-executable "perl")
; (setq doom-modeline-env-go-executable "go")
; (setq doom-modeline-env-elixir-executable "iex")
; (setq doom-modeline-env-rust-executable "rustc")

;; ;; Alternativa para a mode-line do Doom-emacs
;; (use-package spaceline
;;   :ensure t  
;;   :init (setq powerline-height 24
;;               spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
;;               powerline-default-separator 'wave)
;;   :config
;;   (spaceline-spacemacs-theme))


;; Atalhos proprios 

  ;; Lista: original Emacs teclas !!!
  ;;   ("C-x o" other-window)
  ;;   ("C-b" backward-char)
  ;;   ("C-f" forward-char)
  ;;   ("M-b" backward-word)
  ;;   ("M-f" foward-word)
  ;;   ("C-p" previous-line)
  ;;   ("C-n" next-line)
  ;;   ("M-s o" occur)
  ;;   ("C-SPC" set-mark-command)
  ;;   ("DEL" delete-backward-char)
  ;;   ("C-d" delete-char )
  ;;   ("M-d" kill-word)
  ;;   ("M-DEL" backward-kill-word)
  ;;   ("M-{" backward-paragraph)
  ;;   ("M-}" forward-paragraph)
  ;;   ("M-{" ergoemacs-backward-block)
  ;;   ("M-}" ergoemacs-forward-block)
  ;;   ("C-e" ergoemacs-end-of-line-or-what)
  ;;   ("C-a" ergoemacs-beginning-of-line-or-what)
  ;;   ("C-e" ergoemacs-end-of-line-or-what)
  ;;   ("C-a" move-beginning-of-line)
  ;;   ("C-e" move-end-of-line)
  ;;   ("C-v" scroll-down-command)
  ;;   ("M-v" scroll-up-command)
  ;;   ("<begin>" beginning-of-buffer)
  ;;   ("<C-end>" end-of-buffer)
  ;;   ("C-M-b" ergoemacs-backward-open-bracket)
  ;;   ("C-M-f" ergoemacs-backward-open-bracket)
  ;;   ("M-w" ergoemacs-copy-line-or-region)
  ;;   ("C-y" ergoemacs-paste)
  ;;   ("M-y" ergoemacs-paste-cycle)
  ;;   ("C-_" ergoemacs-undo)
  ;;   ;("C-/" ergoemacs-undo)
  ;;   ("M-%" query-replace)
  ;;   ("C-s" isearch-forward)
  ;;   ("C-M-s" isearch-forward-regexp)
  ;;   ("C-r" isearch-backward)
  ;;   ("C-M-r" isearch-backward-regexp)
  ;;   ("C-x 1" delete-other-windows)
  ;;   ("C-x 0" delete-window)
  ;;   ("C-x 2" split-window-below)
  ;;   ("C-x 3" split-window-right)
  ;;   ("C-x b" switch-to-buffer)
  ;;   ("C-x C-b" ibuffer)
  ;;   ("C-x C-b" execute-extended-command)
  ;;   ("C-k" kill-line)
  ;;   ("M-TAB" ergoemacs-call-keyword-completion)

;; Redimensionando a janela de abertura do Emacs
(setq default-frame-alist
      '((top . 200) (left . 400)
        (width . 80) (height . 46)))

(setq initial-frame-alist '((top . 10) (left . 30)))



(global-set-key  (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "M-o") 'ace-window)

(global-set-key (kbd "M-<tab>") 'transpose-frame)

;; ;; C-z to 'undo, the default is C-/.
;; (global-unset-key "\C-z")
;; (global-set-key "\C-z" 'undo)

;; ;; Enabling control-c and control-v copy and paste

;; (global-unset-key "\C-c")
;; (global-set-key (kbd "C-c") 'undefined)
;; (global-set-key (kbd "C-c") 'kill-ring-save)
;; (global-set-key (kbd "C-v") 'yank)

(global-set-key (kbd "<f12>") 'next-buffer)
(global-set-key (kbd "<f11>") 'previous-buffer)

(cua-mode)
(require 'iso-transl)



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
