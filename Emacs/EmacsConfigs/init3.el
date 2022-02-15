;; ;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;; ;; in Emacs and init.el will be generated automatically!

;; Configuraçoes gerais
(menu-bar-mode -1) 
(column-number-mode)
(global-display-line-numbers-mode t)
(setq kill-do-not-save-duplicates t)
(setq next-line-add-newlines nil)
(setq initial-scratch-message nil)      
(setq show-paren-style 'expression)     
(setq scroll-step 1) 
(setq use-dialog-box nil)
(setq use-package-compute-statistics t)
(setq ring-bell-function 'ignore)
(setq create-lockfiles nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default tab-width 2)
(setq mode-line-format nil)
(setq-default mode-line-format nil)
(setq evil-want-keybinding nil)

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

; ;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))

;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

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

;; Theme 
(straight-use-package '(nano-theme :type git :host github
                                   :repo "rougier/nano-theme"))
(require 'nano-theme)
(nano-mode) (nano-light)

(use-package nano-modeline
  :straight (nano-modeline :type git
                           :host github
                           :repo "rougier/nano-modeline")
  :demand t
  :config
  (nano-modeline))

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package neotree
  :bind
  ("<f8>" . neotree-toggle)
  :config
  ;; needs package all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-theme 'arrow)
  (setq neo-smart-open t)
  (setq neo-window-width 20)
  
  (setq-default neo-show-hidden-files t)

  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (display-line-numbers-mode -1)))

  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (setq mode-line-format nil)))

  (add-hook 'neo-after-create-hook
            (lambda (&rest _) (setq header-line-format nil)))
  
  (add-hook 'neo-after-create-hook
            (lambda (&rest _) ((setq set-face-background 'dark))))

  )


;; Let's Be Evil !!
(straight-use-package 'evil)
(evil-mode 1)

;; Vim bindings for plugins: evil-collection
(straight-use-package 'evil-collection)
(evil-collection-init)

;; Comment stuff out: Evil commentary
(straight-use-package 'evil-commentary)
(evil-commentary-mode)

(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)

;; Completions:
(straight-use-package 'vertico)
(vertico-mode)

(straight-use-package 'selectrum)
(selectrum-mode +1)
;; to make sorting and filtering more intelligent
(straight-use-package 'selectrum-prescient)
(selectrum-prescient-mode +1)
(prescient-persist-mode +1)

(straight-use-package 'ivy)
(ivy-mode 1)

(setq ivy-use-selectable-prompt t)

;; Copy and paste: xclip
(straight-use-package 'xclip)
(xclip-mode 1)


;; Git 
(straight-use-package 'magit)
(straight-use-package
 '(git-modes
   :type git
   :host github :repo "magit/git-modes"))



;; Linguagens aqui 
;; Syntax highlighted HTML exports for code blocks: htmlize
;; (straight-use-package 'htmlize)

;; (which-key-setup-side-window-right)

;; (straight-use-package 'emacs-everywhere)

;; ;; ;; ;; sudo apt install elpa-counsel
;; ;; ;; ;; sudo apt install elpa-ivy-hydra

;; (use-package ivy-hydra
;;   :defer t
;;   :after hydra)

;; (use-package ivy-posframe
;;   :disabled
;;   :custom
;;   (ivy-posframe-width      115)
;;   (ivy-posframe-min-width  115)
;;   (ivy-posframe-height     10)
;;   (ivy-posframe-min-height 10)
;;   :config
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
;;   (setq ivy-posframe-parameters '((parent-frame . nil)
;;                                   (left-fringe . 8)
;;                                   (right-fringe . 8)))
;;   (ivy-posframe-mode 1))

;; (use-package counsel
;;   :demand t
;;   :bind (("M-x" . counsel-M-x)
;;          ("C-x b" . counsel-ibuffer)
;;          ("C-x C-f" . counsel-find-file)
;;          ;; ("C-M-j" . counsel-switch-buffer)
;;          ("C-M-l" . counsel-imenu)
;;          :map minibuffer-local-map
;;          ("C-r" . 'counsel-minibuffer-history))
;;   :custom
;;   (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
;;   :config
;;   (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; (use-package wgrep)

;; (use-package prescient
;;   :after counsel
;;   :config
;;   (prescient-persist-mode 1))

;; (use-package ivy-prescient
;;   :after prescient
;;   :config
;;   (ivy-prescient-mode 1))

;; (use-package marginalia
;;   :after vertico
;;   :straight t
;;   :custom
;;   (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
;;   :init
;;   (marginalia-mode))

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
  ;;   ("<begin>" beginning-of-buffer)(straight-use-package 'selectrum)
;; (selectrum-mode +1)
;; ;; to make sorting and filtering more intelligent
;; (straight-use-package 'selectrum-prescient)
;; (selectrum-prescient-mode +1)
;; (prescient-persist-mode +1)

;; (straight-use-package 'ivy)
;; (ivy-mode 1)

;; (setq ivy-use-selectable-prompt t)

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

;; (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; (global-set-key (kbd "M-o") 'ace-window)

;; (global-set-key (kbd "M-<tab>") 'transpose-frame)

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



