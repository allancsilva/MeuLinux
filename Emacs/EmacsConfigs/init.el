;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;; in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)     
(setq inhibit-startup-message t)                  
(column-number-mode)
(global-display-line-numbers-mode t)
(setq kill-do-not-save-duplicates t)
(setq next-line-add-newlines nil)
(setq initial-scratch-message nil)   
(setq auto-save-default t)   

(setq scroll-step 1) 
(setq use-dialog-box nil)
(setq use-package-compute-statistics t)
(setq ring-bell-function 'ignore)
(setq create-lockfiles nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq enable-local-variables :all)

;; (setq mode-line-format nil)
;; (setq-default mode-line-format nil)

(set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)
(setq-default line-spacing 0)
(setq scroll-preserve-screen-position t)
(setq widget-image-enable nil)
(setq visible-bell t)
(setq ring-bell-function 'ignore)
(show-paren-mode t)
(setq evil-want-keybinding nil)
(setq show-paren-style 'expression)

(setq default-frame-alist
      (append (list '(width  . 72) '(height . 40)
                    '(vertical-scroll-bars . nil)
                    '(internal-border-width . 18)
                    '(font . "Fira Code 13")
                    )))
(set-frame-parameter (selected-frame)
                     'internal-border-width 18)
;; Underline line at descent position, not baseline position
(setq x-underline-at-descent-line t)

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

;; Speed up startup
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
(add-hook 'after-init-hook
          `(lambda ()
             (setq gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Measure emacs startup time
(add-to-list 'after-init-hook
             (lambda ()
               (message (concat "emacs ("
                                (number-to-string (emacs-pid))
                                ") started in "
                                (emacs-init-time)))))


;; Repositorios aqui 
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

(require 'package)
(package-initialize)
(setq package-archives '( ("gnu" . "http://elpa.gnu.org/packages/")                 
                          ("elpa" . "http://tromey.com/elpa/")
                          ("melpa" . "http://melpa.org/packages/")
                          ("org" . "https://orgmode.org/elpa/")))

;; Install dependencies
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))
(setq-default use-package-always-ensure t)
  

;; Temas
(use-package chocolate-theme
   :ensure t
   :config
   (load-theme 'chocolate t))

(define-key mode-line-major-mode-keymap [header-line]
  (lookup-key mode-line-major-mode-keymap [mode-line]))

(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))
(setq-default mode-line-format
     '((:eval
       (mode-line-render
       (format-mode-line (list
         (propertize "   ☰" 'face `(:inherit mode-line-buffer-id)
                         'help-echo "Mode(s) menu"
                         'mouse-face 'mode-line-highlight
                         'local-map   mode-line-major-mode-keymap)
         " %b "
         (if (and buffer-file-name (buffer-modified-p))
             (propertize "(modified)" 'face `(:inherit face-faded)))))
       (format-mode-line
        (propertize "%4l:%2c  " 'face `(:inherit face-faded)))))))

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

;; vterm
(use-package vterm
  :config
  (defun turn-off-chrome ()
    (hl-line-mode -1)
    (display-line-numbers-mode -1))
  :hook (vterm-mode . turn-off-chrome))

(use-package vterm-toggle
  :custom
  (vterm-toggle-fullscreen-p nil "Open a vterm in another window.")
  (vterm-toggle-scope 'project)
  :bind (("C-c t" . #'vterm-toggle)
         :map vterm-mode-map
         ("C-\\" . #'popper-cycle)
         ("s-t" . #'vterm) ; Open up new tabs quickly
         ("s-v" . #'vterm-yank)
         ))

;; Let's Be Evil !!
(straight-use-package 'evil)
(evil-mode 1)

;; Vim bindings for plugins: evil-collection
(straight-use-package 'evil-collection)
(evil-collection-init)

;; Comment stuff out: Evil commentary
(straight-use-package 'evil-commentary)
(evil-commentary-mode)

;; Geral
(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

;; (use-package perspective
;;   :demand t
;;   :bind (("C-x C-b" . persp-list-buffers)
;;          ("C-M-k" . persp-switch)
;;          ("C-M-l" . persp-next)
;;          ("C-x k" . persp-kill-buffer*))
;;   :custom
;;   (persp-initial-frame-name "Main")
;;   :config
;;   ;; Running `persp-mode' multiple times resets the perspective list...
;;   (unless (equal persp-mode t)
;;     (persp-mode)))

(use-package page-break-lines
  :ensure t
  :init
  (global-page-break-lines-mode))

(use-package minions
  :ensure t
  :init
  (minions-mode))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
(yas-global-mode t)

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet)
  :config (yas-global-mode 1))

(use-package color-identifiers-mode
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package volatile-highlights
  :diminish ""
  :ensure t
  :config
  (volatile-highlights-mode t))  

(use-package highlight-thing
  :ensure t
  :hook
  (prog-mode . highlight-thing-mode))

(use-package highlight-indent-guides
	:if (display-graphic-p)
  :hook (prog-mode . highlight-indent-guides-mode)
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?‖)
  (setq highlight-indent-guides-responsive 'top))

(use-package smartparens
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode)
	(setq
	   sp-base-key-bindings 'paredit
	   sp-autoskip-closing-pair 'always
	   sp-hybrid-kill-entire-symbol nil
     sp-show-pair-from-inside nil)
  (smartparens-global-mode 1)
  (require 'smartparens-config)
  :diminish smartparens-mode)

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'geiser-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode))

(use-package ws-butler
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

(use-package neotree
  :bind
  ("<f8>" . neotree-toggle)
  :config
  ;; needs package all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme 'arrow)
  (setq neo-smart-open t)
  (setq neo-window-width 25)
  (setq-default neo-show-hidden-files t)
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (display-line-numbers-mode -1)))
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (setq mode-line-format nil)))
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (setq header-line-format nil))))

;; Git 
(straight-use-package 'magit)
(straight-use-package
 '(git-modes
   :type git
   :host github :repo "magit/git-modes"))

(use-package git-gutter
  :straight git-gutter-fringe
  :hook ((text-mode . git-gutter-mode)
         (prog-mode . git-gutter-mode))
  :config
	(global-git-gutter-mode 1)
  (setq git-gutter:update-interval 2))

;; Outros
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

(use-package vertico
  :straight '(vertico :host github
                      :repo "minad/vertico"
                      :branch "main")
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . dw/minibuffer-backward-kill))
  :custom
  (vertico-cycle t)
  :custom-face
  (vertico-current ((t (:background "#3a3f5a"))))
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :straight t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; Linguagens aqui
;; (use-package flycheck
;;   :init
;;   (global-flycheck-mode))

(use-package company
  :ensure t
  :delight
  :bind (("C-c ." . company-complete)
         ("C-c C-." . company-complete)
         ("C-c s s" . company-yasnippet)
         :map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous)
         ("C-d" . company-show-doc-buffer)
         ("M-." . company-show-location))
  :init
  (add-hook 'c-mode-common-hook 'company-mode)
  (add-hook 'sgml-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (add-hook 'text-mode-hook 'company-mode)
  (add-hook 'lisp-mode-hook 'company-mode)
  :config
  (eval-after-load 'c-mode
    '(define-key c-mode-map (kbd "[tab]") 'company-complete))

  (setq company-tooltip-limit 20)
  (setq company-show-numbers t)
  (setq company-dabbrev-downcase nil)
  (setq company-idle-delay 0)
  (setq company-echo-delay 0)

  (setq company-backends '(company-capf
                           company-keywords
                           company-semantic
                           company-files
                           company-etags
                           company-elisp
                           company-clang
                           company-irony-c-headers
                           company-irony
                           company-jedi
                           company-cmake
                           company-ispell
                           company-yasnippet))

	(defun my-company-visible-and-explicit-action-p ()
    (and (company-tooltip-visible-p)
         (company-explicit-action-p)))
  (defun company-ac-setup ()
    "Sets up `company-mode' to behave similarly to `auto-complete-mode'."
    (setq company-require-match nil)
    (setq company-auto-complete #'my-company-visible-and-explicit-action-p)
    (setq company-frontends '(company-echo-metadata-frontend
                              company-pseudo-tooltip-unless-just-one-frontend-with-delay
                              company-preview-frontend))
    (define-key company-active-map [tab]
      'company-select-next-if-tooltip-visible-or-complete-selection)
    (define-key company-active-map (kbd "TAB")
      'company-select-next-if-tooltip-visible-or-complete-selection))

  (company-ac-setup)
  (add-hook 'js2-mode-hook (lambda () (company-mode)))
	
  (global-company-mode))

(use-package company-quickhelp
  :after company
  :config
  (setq company-quickhelp-idle-delay 0.1)
  (company-quickhelp-mode 1))

;; (use-package company-irony
;;   :ensure t
;;   :after (company irony)
;;   :commands (company-irony)
;;   :config
;;   (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands))

;; (use-package company-irony-c-headers
;;   :ensure t
;;   :commands (company-irony-c-headers)
;;   :after company-irony)

(use-package company-jedi
  :ensure t
  :commands (company-jedi)
  :after (company python-mode))

(use-package company-statistics
  :ensure t
  :after company
  :config
  (company-statistics-mode))

(use-package php-mode
  :defer t
  :hook ((php-mode . (lambda () (set (make-local-variable 'company-backends))))))

(use-package phpunit
  :ensure t
  :after php-mode
  :config
  (setq phpunit-configuration-file "phpunit.xml"))

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
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)   
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  (setq-default web-mode-attribute-indent-offset 2)
  (setq web-mode-tag-auto-close-style 1)
  (setq web-mode-auto-close-style 1))

(use-package auto-rename-tag
	:hook (web-mode . auto-rename-tag-mode))

(setq-default js-indent-level 2)
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
              ;; (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
              )))

(use-package prettier-js
  :ensure t
  :defer t
  :hook
  ((js2-mode js-mode css-mode scss-mode graphql-mode web-mode) . prettier-js-mode))

(use-package markdown-mode
   :commands (markdown-mode gfm-mode)
   :mode (("README\\.md\\'" . gfm-mode)
          ("\\.md\\'" . markdown-mode)
          ("\\.markdown\\'" . markdown-mode))
   :init (setq markdown-command "multimarkdown"))

;; (use-package typescript-mode
;;   :mode "\\.ts\\'"
;;   :hook (typescript-mode . lsp-deferred)
;;   :config
;;   (setq typescript-indent-level 2))

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


;; (global-set-key  (kbd "C-<tab>") 'other-window)
;; (global-set-key (kbd "<C-up>") 'shrink-window)
;; (global-set-key (kbd "<C-down>") 'enlarge-window)
;; (global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
;; (global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (global-set-key (kbd "M-o") 'ace-window)

;; (global-set-key (kbd "M-<tab>") 'transpose-frame)

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
 '(custom-safe-themes
	 '("e0628ee6c594bc7a29bedc5c57f0f56f28c5b5deaa1bc60fc8bd4bb4106ebfda" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(vertico-current ((t (:background "#3a3f5a")))))
