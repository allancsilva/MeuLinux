;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;; in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais
(menu-bar-mode -1)                      ; Disable the menu bar
(scroll-bar-mode -1)                    ; Disable visible scrollbar
(tool-bar-mode -1)                      ; Disable the toolbar
(tooltip-mode -1)                       ; Disable tooltips
(set-fringe-mode 10)                    ; Give some breathing room
; (column-number-mode)
(global-display-line-numbers-mode t)
; (display-time-mode 1)
(setq kill-do-not-save-duplicates t)
; (setq mode-require-final-newline t)
; (setq next-line-add-newlines nil)
; (setq save-abbrevs 'silently)
; (setq sentence-end-double-space nil)
(setq initial-scratch-message nil)      ; No *scratch* buffer message
; (setq help-window-select t)
(setq show-paren-style 'expression)     ; highlight text between parens
; (setq column-number-mode t)
; (show-paren-mode 1)
; (delete-selection-mode 1)
(defalias 'yes-or-no-p 'y-or-n-p)
; (setq-default cursor-type 'bar)
(setq-default tab-width 2)
;; UTF-8
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)
;;; Ignore case for completion
; (setq completion-ignore-case t)
; (setq read-buffer-completion-ignore-case t)
; (setq read-file-name-completion-ignore-case t)
; ;; Improve scrolling.
; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
; ; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
; (setq scroll-step 1) ;; keyboard scroll one line at a time
; ; (setq use-dialog-box nil)
; (setq use-package-compute-statistics t)
(setq inhibit-startup-message t)
; (setq ring-bell-function 'ignore)
(setq create-lockfiles nil)
; (setq python-indent-guess-indent-offset t)
; (setq python-indent-guess-indent-offset-verbose nil)
; ;; The default is 800 kilobytes.  Measured in bytes.
; (setq gc-cons-threshold (* 50 1000 1000))
; ;; remover a mensagem de erro
; ;; ad-handle-definition: ‘hippie-expand’ got redefined
; (setq ad-redefinition-action 'accept)


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
(setq use-package-always-ensure t)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; Change the user-emacs-directory to keep unwanted things out of ~/.emacs.d
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory))


;; Theme 
(straight-use-package
 '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))

(require 'nano-theme-dark)

(require 'nano-faces)
(nano-faces)

(require 'nano-theme)
(nano-theme)

;; Nano header & mode lines
(require 'nano-modeline)

; ;; Nano default settings (optional)
; (require 'nano-defaults)

;; Nano session saving (optional)
(require 'nano-session)

;; Help (optional)
(add-to-list 'command-switch-alist '("-no-help" . (lambda (args))))
(unless (member "-no-help" command-line-args)
  (require 'nano-help))

;; Welcome message
(let ((inhibit-message t))
  (message "Welcome to GNU Emacs / N Λ N O edition")
  (message (format "Initialization time: %s" (emacs-init-time))))

(require 'nano-splash)
(require 'nano-bindings)


;; Let's Be Evil !!
(use-package evil
  :ensure t
  :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
  :config
    (evil-mode 1)
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (setq evil-collection-want-unimpaired-p nil)
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

(use-package evil-goggles
  :ensure t
  :config
  (evil-goggles-use-diff-faces)
  (evil-goggles-mode))

(use-package origami
  :hook (yaml-mode . origami-mode))

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
  (push '(completion-at-point . ivy--regex-fu2zy) ivy-re-builders-alist) ;; This doesn't seem to work...
  (push '(swiper . ivy--regex-ignore-order) ivy-re-builders-alist)
  (push '(counsel-M-x . ivy--regex-ignore-order) ivy-re-builders-alist)

)

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

; (require 'swiper)
; (require 'ivy)
; (ivy-mode 1)
; (global-set-key "\C-s" 'swiper)

(use-package wgrep)

(use-package prescient
  :after counsel
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :after prescient
  :config
  (ivy-prescient-mode 1))

(use-package marginalia
  :after vertico
  :straight t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ace-window
  :ensure t)

(use-package page-break-lines
  :ensure t
  :init
  (global-page-break-lines-mode))

(use-package editorconfig
	:ensure t
  :config
  (editorconfig-mode 1))

(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet)
  :config (yas-global-mode 1))

(use-package highlight-thing
  :ensure t
  :hook
  (prog-mode . highlight-thing-mode))


(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?‖)
  (setq highlight-indent-guides-responsive 'top)
  )

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
;;;;;;;;;;;;;;;;;;;;;;;;;


; (use-package cmake-ide
;   :init (use-package rtags)
;   :config (cmake-ide-setup))


(use-package js2-mode
  :ensure t
  :mode (("\\.js\\'" . js2-mode)
         ;; ("components?\\/.*\\.jsx?\\'" . js2-jsx-mode)
         )
  :interpreter ("node" . js2-jsx-mode)
  :init
  (add-hook 'js2-mode-hook
            (lambda ()
              (setq js2-basic-offset 2)
              (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
              )))

; (use-package js2-refactor
;   :ensure t
;   :defer t)


(use-package prettier-js
  :ensure t
  :defer t
  :hook
  ((js2-mode js-mode css-mode scss-mode graphql-mode web-mode) . prettier-js-mode))


; (setq-default js-indent-level 2)
; ; (use-package js2-mode
; ;     :mode "\\.js\\'"
; ;     :config
; ;     (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")))

; (use-package apheleia
; 	:diminish "🅰"
; 	:config
;   (apheleia-global-mode +1))

; (use-package markdown-mode
;    :commands (markdown-mode gfm-mode)
;    :mode (("README\\.md\\'" . gfm-mode)
;           ("\\.md\\'" . markdown-mode)
;           ("\\.markdown\\'" . markdown-mode))
;    :init (setq markdown-command "multimarkdown"))

; (use-package go-mode
;     :config
;     (add-hook 'before-save-hook 'gofmt-before-save))

; (use-package typescript-mode
;   :mode "\\.ts\\'"
;   :hook (typescript-mode . lsp-deferred)
;   :config
;   (setq typescript-indent-level 2))

; (use-package rust-mode)

; ;; 1. Start the server with `httpd-start'
; ;; 2. Use `impatient-mode' on any buffer
(use-package know-your-http-well
  :defer t)

(use-package impatient-mode
  :straight t)

(use-package skewer-mode
  :straight t)

; ;; Python aqui !!!

; ;; Tabnine instalar server Jedi e o Anakin
; ;; instalando as depencias de forma correta
; ;; pip freeze > requirements.txt
; ;; pip install -r requirements.txt


; (use-package python-mode
; 	:diminish "🅟"
; 	:ensure t
; 	:custom
; 	(python-shell-interpreter "python3")
;   :config
;   (setq auto-mode-alist
;         (cons '("\\.py$" . python-mode)
;          auto-mode-alist))
;   (setq interpreter-mode-alist
;         (cons '("python" . python-mode)
;          interpreter-mode-alist))
;   (autoload 'python-mode "python-mode" "Python editing mode." t))

; ;; python3 -m pip install --user flake8

; (use-package python-docstring
;   :diminish "🅳"
;   :config
;   (python-docstring-install))

; ;; pip install elpy flake8 epc isort
; ;; pip install black
; (use-package blacken
;     :diminish "🅱"
;     :config
;     (add-hook 'python-mode-hook 'blacken-mode))


; ;; Tabnine, cuidado muito hack aqui !!! kkkkkk
; (use-package company
; 	:diminish "🅐"
;   :config
;     (global-company-mode)
;   :custom
;   ;https://github.com/company-mode/company-mode/issues/14#issuecomment-290261406
;   ; Do not downcase the returned candidates automatically
;   (company-dabbrev-downcase nil)
;   ; Trigger completion immediately.
;   (company-idle-delay 0)
;   (company-minimum-prefix-length 1)
;   (company-tooltip-align-annotations t)
;   (company-dabbrev-other-buffers t) ; search buffers with the same major mode
;   (company-selection-wrap-around t)
;   ; Number the candidates (use M-1, M-2 etc to select completions).
;   (company-show-numbers t)
;     :bind (:map company-active-map
;                 ("C-n" . company-select-next)
;                 ("C-p" . company-select-previous)
;                 ("C-s" . company-filter-candidates)
;                 ("<tab>" . company-complete-selection))
;     :bind (:map company-search-map
;                 ("C-n" . company-select-next)
;                 ("C-p" . company-select-previous)))

; ; npm install --global vscode-html-languageserver-bin
; ; npm install -g vscode-html-languageserver-bin
; ;https://github.com/TommyX12/company-tabnine
; ;Run M-x company-tabnine-install-binary to install the TabNine binary for your system.
; (use-package company-tabnine)
; ;https://manateelazycat.github.io/emacs/2021/06/30/company-multiple-backends.html
; ;; Customize company backends.
; (setq company-backends
;       '(
;         (company-tabnine :separate company-dabbrev company-keywords company-files company-ispell company-capf)
;         ))

; ;; Add yasnippet support for all company backends.
; (defvar company-mode/enable-yas t
;   "Enable yasnippet for all backends.")

; (defun company-mode/backend-with-yas (backend)
;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
;       backend
;     (append (if (consp backend) backend (list backend))
;             '(:with company-yasnippet))))

; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

; ;; Add `company-elisp' backend for elisp.
; (add-hook 'emacs-lisp-mode-hook
;           #'(lambda ()
;               (require 'company-elisp)
;               (push 'company-elisp company-backends)))

; ;; Remove duplicate candidate.
; (add-to-list 'company-transformers #'delete-dups)


; (use-package company-web
;     :straight t)

; (use-package company-quickhelp
;     :straight t
;     :config
;     (company-quickhelp-mode))

; ;; PHP linguagem Aqui
; ;; Company language package for PHP
; ;; instalar o PHP-mode
; ;; sudo apt -y install php-elisp phpunit
; (use-package company-php
;   :defer
;   :after company)

; (use-package php-mode
;   :defer t
;   :hook ((php-mode . (lambda () (set (make-local-variable 'company-backends))))))

; (use-package phpunit
;   :ensure t
;   :after php-mode
;   :config
;   (setq phpunit-configuration-file "phpunit.xml"))

(use-package web-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
  :config
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2)
  (setq web-mode-tag-auto-close-style 1)
  (setq web-mode-auto-close-style 1)
  )


(use-package auto-rename-tag
	:diminish "🅣"
	:hook (web-mode . auto-rename-tag-mode))


;; Git
(use-package magit
  :bind ("C-x g" . magit-status))

(use-package git-commit
  :custom
  (git-commit-fill-column 78)
  (git-commit-style-convention-checks '(non-empty-second-line overlong-summary-line)))

(use-package magit-filenotify)
(use-package magit-find-file)

(use-package git-gutter
  :straight git-gutter-fringe
  :diminish
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode))
  :config
	(global-git-gutter-mode 1)
  (setq git-gutter:update-interval 2)
    (require 'git-gutter-fringe)
    (set-face-foreground 'git-gutter-fr:added "LightGreen")
    (fringe-helper-define 'git-gutter-fr:added nil
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX")

    (set-face-foreground 'git-gutter-fr:modified "LightGoldenrod")
    (fringe-helper-define 'git-gutter-fr:modified nil
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX")

    (set-face-foreground 'git-gutter-fr:deleted "LightCoral")
    (fringe-helper-define 'git-gutter-fr:deleted nil
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      ".........."
      ".........."
      "XXXXXXXXXX"
      "XXXXXXXXXX"
      "XXXXXXXXXX")

  ;; These characters are used in terminal mode
  (setq git-gutter:modified-sign "≡")
  (setq git-gutter:added-sign "≡")
  (setq git-gutter:deleted-sign "≡")
  (set-face-foreground 'git-gutter:added "LightGreen")
  (set-face-foreground 'git-gutter:modified "LightGoldenrod")
  (set-face-foreground 'git-gutter:deleted "LightCoral")
	(global-git-gutter-mode 1))

(use-package git-link
  :commands git-link
  :config
  (setq git-link-open-in-browser t)
  (dw/leader-key-def
    "gL"  'git-link))


; Outros



; (use-package vertico
;   :straight '(vertico :host github
;                       :repo "minad/vertico"
;                       :branch "main")
;   :bind (:map vertico-map
;          ("C-j" . vertico-next)
;          ("C-k" . vertico-previous)
;          ("C-f" . vertico-exit)
;          :map minibuffer-local-map
;          ("M-h" . dw/minibuffer-backward-kill))
;   :custom
;   (vertico-cycle t)
;   :custom-face
;   (vertico-current ((t (:background "#3a3f5a"))))
;   :init
;   (vertico-mode))





; ;; Tema do Emacs
; ;; Pra usa-lo primeiro e preciso desabilitar o nano-emacs la em cima
; ;; Comente as linhas do nano-emacs e descomente essas aqui

; (use-package chocolate-theme
;   :ensure t
;   :config
;   (load-theme 'chocolate t))
; (use-package flatland-theme
;   :ensure t
;   :config (load-theme 'flatland t))
; (use-package afternoon-theme
;   :ensure t
;   :config (load-theme 'afternoon t))
; (use-package badger-theme
;   :ensure t
;   :config (load-theme 'badger t))
; (use-package dracula-theme
;   :ensure t
;   :config (load-theme 'dracula t))
; (use-package gruvbox-theme
;   :ensure t
;   :config (load-theme 'gruvbox t))
; (use-package nord-theme
;   :ensure t
;   :config (load-theme 'nord t))
; (use-package night-owl-theme
;   :ensure t
;   :config (load-theme 'night-owl t))
; (use-package gruber-darker-theme
;   :ensure t
;   :config (load-theme 'gruber-darker t))


; (use-package spaceline
;   :if window-system
;   :ensure t
;   :defer t
;   :init
;   (setq-default powerline-image-apple-rgb nil)
; 	(setq powerline-height 24
;         spaceline-highlight-face-func 'spaceline-highlight-face-evil-state
;         powerline-default-separator 'wave)
; 	(setq-default spaceline-window-numbers-unicode t)
;   (setq-default spaceline-minor-modes-separator " ")
;   (require 'spaceline-config)
;   :config
;   (spaceline-spacemacs-theme)
;   (spaceline-toggle-buffer-size-off)
;   (spaceline-toggle-hud-off))
;; types are: 'slant, 'arrow, 'cup, 'wave, 'none



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
  ;;   ("C-x b" switch-to-buffer)trans
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



