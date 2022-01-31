;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;;       in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais

(menu-bar-mode -1)                      ; Disable the menu bar

(setq kill-do-not-save-duplicates t)
(setq mode-require-final-newline t)
(setq next-line-add-newlines nil)
(setq save-abbrevs 'silently)
(setq sentence-end-double-space nil)

(setq initial-scratch-message nil)      ; No *scratch* buffer message
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

; ;; Make frame transparency overridable
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

; ;; Descomentar na primeira vez, e quando quiser atualizar
;   ;; Initialize use-package on non-Linux platforms
; (unless (package-installed-p 'use-package)
;   (package-install 'use-package))
; (unless package-archive-contents
;   (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)



;; Instalar o Quelpa se precisar!!
; (if (require 'quelpa nil t)
;     (quelpa-self-upgrade)
;   (with-temp-buffer
;     (url-insert-file-contents
;      "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
;     (eval-buffer)))
; (quelpa
;  '(quelpa-use-package
;    :fetcher git
;    :url "https://github.com/quelpa/quelpa-use-package.git"
;    :stable nil))
; (require 'quelpa-use-package)

; ;; ----------------------------------------------------------------------------
; ;; Geometria, mexer na posiçao do Buffer
; ;; ----------------------------------------------------------------------------
; ;; Fringe on left and right: 8 pixels
; (fringe-mode '(8 . 8))

; ;; Internal border: 32 pixels
; (modify-frame-parameters (selected-frame)
;                          '((internal-border-width . 20)))

; ;; Redimensionando a janela de abertura do Emacs
; (setq default-frame-alist
;       '((top . 400) (left . 200)
;        (width . 65) (height . 36)))
; (setq initial-frame-alist '((top . 41) (left . 12) (right . 60)))


; (setq-default frame-title-format "%b")
; (setq         frame-title-format "%b")

; ----------------------------------------------------------------------------
; Headerline
; ----------------------------------------------------------------------------
(defun mode-line-fill (face reserve)
  "Return empty space using FACE and leaving RESERVE space on the right."
  (unless reserve
    (setq reserve 20))
  (when (and window-system (eq 'right (get-scroll-bar-mode)))
    (setq reserve (- reserve 3)))
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin) ,reserve)))
              'face face))

(setq-default header-line-format (list
   "  "
   'mode-line-buffer-identification
   "   "

   'mode-line-modified
   "   "
   `(vc-mode vc-mode)

   ;; File read-only
   '(:eval (if buffer-read-only
               (list (mode-line-fill 'nil 15)
                     (propertize " [read-only] " 'face 'header-line-grey))))

   ;; File modified
   '(:eval (if (buffer-modified-p)
               (list (mode-line-fill 'nil 10)
                     (propertize " [modified] " 'face 'header-line-red))
             (list (mode-line-fill 'nil 10)
                   (propertize "%4l:%3c " 'face 'header-line))))
   ))
(setq-default mode-line-format "")


; ; ;; ----------------------------------------------------------------------------
; ; ;; Font
; ; ;; ----------------------------------------------------------------------------
; ; (set-frame-font "Source Code Pro Light 14")
; ; (add-to-list 'default-frame-alist
; ;              '(font . "Source Code Pro Light 14"))


;; Change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))


; ;; Pacotes começam aqui !!

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


;; Modos de textos, teclados do Emacs

;; Cua eh o modo normal, por exemplo Ctrl + C normal, tudo normal
; (cua-mode)
; (require 'iso-transl)


; ;; Quebrado, que triste
; ;; Let's Be Evil !!!
; ;; Teclas do Vim aqui

(use-package evil
  :ensure t
  :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)

(use-package evil-collection
  :after evil
  :ensure t
  :config
    (evil-collection-init))

(use-package evil-indent-textobject
  :ensure t)

(use-package powerline-evil
  :ensure t
  :config
  (powerline-evil-vim-color-theme))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

;; gc operator, like vim-commentary
(use-package evil-commentary
  :ensure t
  :bind (:map evil-normal-state-map
              ("gc" . evil-commentary)))

;; visual hints while editing
(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-use-diff-faces)
  (evil-goggles-mode))

;;;;;;;;;;;;;
;; 
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
  (setq neo-theme 'arrow)
  (setq neo-smart-open t)
  (setq neo-window-width 25)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Tabnine, cuidado muito hack aqui !!! kkkkkk

(use-package company
  :config
    (global-company-mode)
  :custom
  ;https://github.com/company-mode/company-mode/issues/14#issuecomment-290261406
  ; Do not downcase the returned candidates automatically
  (company-dabbrev-downcase nil) 
  ; Trigger completion immediately.
  (company-idle-delay 0) 
  (company-minimum-prefix-length 1)
  (company-tooltip-align-annotations t)
  (company-dabbrev-other-buffers t) ; search buffers with the same major mode
  (company-selection-wrap-around t)
  ; Number the candidates (use M-1, M-2 etc to select completions).
  (company-show-numbers t)
    :bind (:map company-active-map
                ("C-n" . company-select-next)
                ("C-p" . company-select-previous)
                ("C-s" . company-filter-candidates)
                ("<tab>" . company-complete-selection))
    :bind (:map company-search-map
                ("C-n" . company-select-next)
                ("C-p" . company-select-previous)))

; npm install --global vscode-html-languageserver-bin
; npm install -g vscode-html-languageserver-bin
;https://github.com/TommyX12/company-tabnine
;Run M-x company-tabnine-install-binary to install the TabNine binary for your system.
(use-package company-tabnine)
;https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html
;; Customize company backends.
(setq company-backends
      '(
        (company-tabnine :separate company-dabbrev company-keywords company-files company-ispell company-capf)
        ))

;; Add yasnippet support for all company backends.
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

;; Add `company-elisp' backend for elisp.
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (require 'company-elisp)
              (push 'company-elisp company-backends)))

;; Remove duplicate candidate.
(add-to-list 'company-transformers #'delete-dups)



;; Git
(use-package magit
    :bind ("C-x g" . magit-status))


(use-package git-gutter
  :ensure t
  :if (not window-system)
  :config
  (global-git-gutter-mode 1))



; Outros
(use-package hydra
  :defer 1)

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

;; sudo apt install elpa-counsel
;; sudo apt install elpa-ivy-hydra

(use-package ivy-hydra
  :defer t
  :after hydra)

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

(use-package wgrep)



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


; ;; Tema do Emacs
; ;; Pra usa-lo primeiro e preciso desabilitar o nano-emacs la em cima
; ;; Comente as linhas do nano-emacs e descomente essas aqui

(use-package chocolate-theme
  :ensure t
  :config
  (load-theme 'chocolate t))

; ; ;; Temas do Emacs : O kaolin oferece muitos temas
; ; (use-package kaolin-themes
; ;   :config
; ;   (load-theme 'kaolin-bubblegum t)
; ;   (kaolin-treemacs-theme))

; ;; ;; ;; Temas kaolin
; ;; ;; kaolin-dark - a dark jade variant inspired by Sierra.vim
; ;; ;; kaolin-light - light variant of the original kaolin-dark.
; ;; ;; kaolin-aurora - Kaolin meets polar lights.
; ;; ;; kaolin-bubblegum - Kaolin colorful theme with dark blue background.
; ;; ;; kaolin-eclipse - a dark purple variant
; ;; ;; kaolin-galaxy - bright theme based on one of the Sebastian Andaur arts.
; ;; ;; kaolin-ocean - a dark blue variant.
; ;; ;; kaolin-temple - dark background with syntax highlighting focus on blue, green and pink shades
; ;; ;; kaolin-valley-dark - colorful Kaolin theme with brown background.
; ;; ;; kaolin-valley-light - light variant of kaolin-valley theme.



(use-package spaceline
  :ensure t
  :init (setq powerline-height 24
              spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
              powerline-default-separator 'arrow)
  :config
  (spaceline-spacemacs-theme))


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


(global-set-key  (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "M-o") 'ace-window)

(global-set-key (kbd "M-<tab>") 'transpose-frame)

;; C-z to 'undo, the default is C-/.
(global-unset-key "\C-z")
(global-set-key "\C-z" 'undo)

;; ;; Enabling control-c and control-v copy and paste

;; (global-unset-key "\C-c")
;; (global-set-key (kbd "C-c") 'undefined)
;; (global-set-key (kbd "C-c") 'kill-ring-save)
;; (global-set-key (kbd "C-v") 'yank)

(global-set-key (kbd "<f12>") 'next-buffer)
(global-set-key (kbd "<f11>") 'previous-buffer)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(smartparens which-key use-package no-littering neotree flycheck auto-package-update auto-complete all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
