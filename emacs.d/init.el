(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/") t)

(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

(require 'use-package)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  :ensure t)

(server-start)

;; Package: diminish
(use-package diminish
  :config
  (progn
    (diminish 'abbrev-mode))
  :ensure t)

(use-package doom-themes
  :config
  (progn
    (setq doom-themes-enable-bold t)
    (setq doom-themes-enable-italic t)
    (load-theme 'doom-nord t)
    (doom-themes-visual-bell-config)
    (doom-themes-neotree-config)
    (doom-themes-treemacs-config)
    (doom-themes-org-config))
  :ensure t)

;; Package doom-modeline
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (progn
    (setq doom-modeline-height 25)
    (setq doom-modeline-bar-width 3)
    (setq doom-modeline-icon (display-graphic-p))
    (setq doom-modeline-major-mode-icon t)
    (setq doom-modeline-buffer-state-icon t)
    (setq doom-modeline-lsp t)
    (setq doom-modeline-irc t)
    (setq doom-modeline-irc-stylize 'identity)
    (setq doom-modeline-env-version t))
  :ensure t)

;; Package: all-the-icons
;; Run: all-the-icons-install-fonts
(use-package all-the-icons
  :if
  (display-graphic-p)
  :ensure t)

;; Package: all-the-icons-ivy
(use-package all-the-icons-ivy
  :init
  (add-hook 'after-init-hook 'all-the-icons-ivy-setup)
  :ensure t)

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))
(set-face-attribute 'default t :font "Iosevka Nerd Font-14")
(set-frame-font "Iosevka Nerd Font-14" nil t)

;; Transparent background when opened in the terminal
(defun on-frame-open (&optional frame)
  "If the FRAME created in terminal don't load background color."
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))

;; Package: vterm
(use-package vterm
 :config
 (progn
   (setq vterm-always-compile-module t)
   (global-set-key (kbd "C-c v t") 'vterm)
   (setq vterm-max-scrollback 100000))
 :ensure t)

(add-hook 'after-make-frame-functions 'on-frame-open)
;; (add-hook 'emacs-startup-hook 'vterm)
;; (setq initial-buffer-choice 'eshell)

;; hide menu-bar, scroll-bar and tool-bar
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; disable global tabs-mode
(setq-default indent-tabs-mode nil)

;; show column number
(column-number-mode t)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

(setq ispell-program-name "/bin/aspell")

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
	  (lambda ()
	    (interactive)
	    (setq show-trailing-whitespace 1)))

;; automatically indent when press RET
(global-set-key (kbd "RET") 'newline-and-indent)

;; delete selected region
(delete-selection-mode 1)
(global-set-key (kbd "C-c d r") 'delete-region)

(global-set-key (kbd "C-x n") 'next-multiframe-window)
(global-set-key (kbd "C-x p") 'previous-multiframe-window)
(global-set-key (kbd "C-x q") 'quit-window)

;; show the function you are in
(which-function-mode t)

;; create alias for yes or no ?s
(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq inhibit-startup-message t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Package: ispell
(use-package ispell
  :bind
  (("C-c s w" . ispell-word)
   ("C-c s b" . ispell-buffer))
  :defer t)

;; Package: flyspell
(use-package flyspell
  :init
  (add-hook 'prog-mode-hook #'flyspell-prog-mode)
  :ensure t)

;; show the cursor when moving after big movements in the window
(use-package beacon
  :init
  (beacon-mode 1)
  :ensure t)

;; Package: mic-paren
(use-package mic-paren
  :config
  (progn
    (paren-activate)
    (setq paren-match-face 'highlight)
    (setq paren-sexp-mode t)
    (setq paren-dont-touch-blink t))
  :ensure t)

;; Package: smartparens
(use-package smartparens
  :init (smartparens-global-mode 1)
  :config
  (progn
    (require 'smartparens-config)
    (setq sp-base-key-bindings 'paredit)
    (setq sp-autoskip-closing-pair 'always)
    (setq sp-hybrid-kill-entire-symbol nil)
    (sp-use-paredit-bindings))
  :diminish smartparens-mode
  :ensure t)

;; Package: clean-aindent-mode
(use-package clean-aindent-mode
  :init
  (add-hook 'prog-mode-hook 'clean-aindent-mode)
  :ensure t)

;; Package: ws-butler
(use-package ws-butler
  :init
  (add-hook 'prog-mode-hook 'ws-butler-mode)
  :config
  (progn
    (add-hook 'c-mode-common-hook 'ws-butler-mode)
    (add-hook 'text-mode 'ws-butler-mode)
    (add-hook 'fundamental-mode 'ws-butler-mode))
  :diminish ws-butler-mode
  :ensure t)

;; Package: dtrt-indent
(use-package dtrt-indent
  :init
  (dtrt-indent-mode 1)
  :config
  (setq dtrt-indent-verbosity 0)
  :ensure t)

;; Package: yasnippet
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (progn
    (yas-reload-all)
    (use-package yasnippet-snippets
      :ensure t)
    (yas-minor-mode 1)
    (add-hook 'prog-mode-hook 'yas-minor-mode)
    (add-hook 'text-mode-hook 'yas-minor-mode))
  :diminish yas-minor-mode
  :ensure t)

;; Package: anzu
(use-package anzu
  :init
  (anzu-mode +1)
  :bind
  (("M-%" . 'anzu-query-replace)
   ("C-M-%" . 'anzu-query-replace-regexp))
  :diminish anzu-mode
  :ensure t)

;; Package: volatile-highlights
(use-package volatile-highlights
  :init
  (volatile-highlights-mode t)
  :diminish volatile-highlights-mode
  :ensure t)

;; Package: rainbow-delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :ensure t)

;; Package: rainbow-identifiers
(use-package rainbow-identifiers
  :config
  (add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
  :ensure t)

;; Package: duplicate-thing
(use-package duplicate-thing
  :bind
  ("M-c" . 'duplicate-thing)
  :ensure t)

;; Package: comment-dwim-2
(use-package comment-dwim-2
  :bind
  ("M-;" . 'comment-dwim-2)
  :ensure t)

;; Package: pulse
(use-package pulse
  :commands pulse-momentary-highlight-one-line
  :config
  (progn
    (setq pulse-iterations 8
          pulse-delay .05)
    (set-face-background 'pulse-highlight-start-face
			 (face-foreground 'font-lock-keyword-face))))

;; Package: magit
(use-package magit
  :config (add-hook 'after-save-hook 'magit-after-save-refresh-status t)
  :bind
  (("C-x m" . magit-status)
   ("C-c m b" . magit-blame-addition)
   ("C-c m l" . magit-log-buffer-file))
  :commands magit-status
  :ensure t)

;; Package: git-messenger
(use-package git-messenger
  :config
  (setq git-messenger:show-detail t)
  :bind
  ("C-c m g" . git-messenger:popup-message)
  :ensure t)

;; Package: git-timemachine
(use-package git-timemachine
  :commands
  (git-timemachine)
  :bind
  ("C-c m t" . git-timemachine)
  :defer t
  :ensure t)

;; Package: avy
(use-package avy
  :bind
  ("C-c a v" . avy-goto-word-1)
  :ensure t)

;; Package: vimish-fold
(use-package vimish-fold
  :init
  (vimish-fold-global-mode 1)
  :bind
  (("C-c f f" . vimish-fold)
   ("C-c f d" . vimish-fold-delete)
   ("C-c f u" . vimish-fold-toggle))
  :ensure t)

;; Package: multiple-cursor
(use-package multiple-cursors
  :bind
  (("C-c m c" . mc/edit-lines)
   ("C-c m >" . mc/mark-next-like-this)
   ("C-c m <" . mc/mark-previous-like-this)
   ("C-c m |" . mc/mark-all-like-this))
  :ensure t)

;; Package: counsel - ivy + swiper
(use-package counsel
  :init
  (ivy-mode 1)
  :bind
  (("C-s" . 'swiper)
   ("M-x" . 'counsel-M-x)
   ("C-x C-f" . 'counsel-find-file)
   ("C-c C-r" . 'ivy-resume)
   ("C-c g" . 'counsel-git)
   ("C-c j" . 'counsel-git-grep)
   ("C-c k" . 'counsel-ag))
  :diminish ivy-mode
  :ensure t)

;; Package: undo-tree
(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  :bind
  (("C-c u u" . undo-tree-undo)
   ("C-c u r" . undo-tree-redo)
   ("C-c u b" . undo-tree-switch-branch)
   ("C-c u v" . undo-tree-visualize))
  :diminish undo-tree-mode
  :ensure t)

;; Package: company
(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (use-package company-c-headers
      :init
      (add-to-list 'company-backends 'company-c-headers)
      :ensure t)
    (setq company-tooltip-align-annotations t))
  :diminish global-company-mode
  :ensure t)

;; Package: format-all
(use-package format-all
  :config
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
  :ensure t)

;; Package: clang-format
(use-package clang-format
  :config
  (setq clang-format-style "file")
   :bind
  (("C-c f r" . clang-format-region)
   ("C-c f b" . clang-format-buffer))
  :ensure t)

;; Package: auto-complete
(use-package auto-complete
  :config
  (progn
    (use-package auto-complete-config)
    (use-package fuzzy
      :ensure t)
    (ac-config-default)
    (ac-fuzzy-complete))
  :init
  (auto-complete-mode 1)
  :diminish auto-complete-mode
  :ensure t)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (progn
    (setq lsp-headerline-breadcrumb-enable nil)
    (setq lsp-file-watch-threshold 100000)
    (setq lsp-enable-file-watchers nil)
    (use-package lsp-ui
      :commands
      (lsp-ui-mode)
      ;; :config (progn
      ;; (setq lsp-ui-peek-enable t)
      ;; (setq lsp-ui-peek-show-directory t))
      :ensure t)
    (use-package lsp-ivy
      :ensure t)
    (use-package company-lsp
      :commands company-lsp
      :ensure t))
  :commands lsp
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  :bind
  ("C-c l" . lsp-command-map)
  :ensure t)

;; Package: ccls
(use-package ccls
  :config
  (progn
    (setq ccls-executable "/bin/ccls")
    (setq ccls-sem-highlight-method 'overlay)
    (setq ccls-call-hierarchy t)
    (ccls-use-default-rainbow-sem-highlight))
  :hook
  ((c-mode c++-mode c-or-c++-mode) . (lambda () (require 'ccls) (lsp)))
  :ensure t)

;; Package: flycheck
(use-package flycheck
  :init
  (global-flycheck-mode)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :diminish flycheck-mode
  :ensure t)

(use-package smart-tabs-mode
  :config
  (smart-tabs-insinuate 'c 'c++)
  :ensure t)

(use-package cc-mode
  :config
  (progn
    ;; (setq mode-name "/")
    ;; (setq c-default-style "linux")
    ;; (setq-default c-basic-offset 8 indent-tabs-mode t tab-width 8)
    (add-hook 'c-mode-common-hook 'hs-minor-mode)
    (add-hook 'c++-mode-hook 'flycheck-mode)
    (add-hook 'c-mode-hook 'flycheck-mode))
  :hook
  ((c-mode) . (lambda ()
                (setq indent-tabs-mode t)
                (setq-default c-basic-offset 8))))

;; Package: rustic-mode
(use-package rustic
  :config
  (progn
    (setq rustic-format-on-save t)
    (setq rustic-lsp-server 'rls)
    (setq lsp-rust-analyzer-server-command '("~/.cargo/bin/rust-analyzer"))
    (push 'rustic-clippy flycheck-checkers))
  :ensure t)

;; Package: go-mode
(use-package go-mode
  :config
  (progn
    (use-package flycheck-golangci-lint
      :ensure t
      :hook
      (go-mode . flycheck-golangci-lint-setup))
    (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))
  :ensure t)

;; Package: web-mode
(use-package web-mode
  :config
  (progn
    (setq web-mode-enable-current-column-highlight t)
    (setq web-mode-enable-current-element-highlight t)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
    (add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode)))
  :ensure t)

;; Package yaml-mode
(use-package yaml-mode
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode)))
  :ensure t)

;; Package: anaconda-mode
(use-package anaconda-mode
  :config
  (progn
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
  :diminish anaconda-mode
  :ensure t)

;; Package: rst-mode
(use-package rst
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.txt\\'" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rst\\'" . rst-mode))
    (add-to-list 'auto-mode-alist '("\\.rest\\'" . rst-mode)))
  :ensure t)

;; Package: meson-mode
(use-package meson-mode
  :config
  (add-hook 'meson-mode-hook 'company-mode)
  :ensure t)

;; Package: dts-mode
(use-package dts-mode
  :ensure t)

;; Package: haskell-mode
(use-package haskell-mode
 :config
 (progn
   (use-package lsp-haskell
     :config (progn
	       (add-hook 'haskell-mode-hook #'lsp)
	       (add-hook 'haskell-literate-mode-hook #'lsp))
     :ensure t)
   (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
   ;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
   )
 :ensure t)

;; Package: racket-mode
(use-package racket-mode
  :config
  (progn
    (require 'racket-xp)
    (add-hook 'racket-mode-hook #'racket-xp-mode)
    (add-hook 'racket-mode-hook #'racket-unicode-input-method-enable)
    (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))
  :ensure t)

;; Package: geiser
(use-package geiser
  :config
  (progn
    (setq geiser-active-implementations '(guile chez racket))
    (add-hook 'scheme-mode-hook 'geiser-mode)
    (autoload 'enable-paredit-mode "paredit"
      "Turn on pseudo-structural editing of Lisp code."
      t))
  :ensure t)

;; Package: nix-mode
(use-package nix-mode
  :mode "\\.nix\\'"
  :ensure t)

;; Package: json-mode
(use-package  json-mode
  :config
  (add-hook 'json-mode-hook
	    (lambda ()
              (make-local-variable 'js-indent-level)
              (setq js-indent-level 2)))
  :ensure t)

;; Package: elixir-mode
(use-package elixir-mode
  :config
  (progn
    (use-package mix
      :config
      (add-hook 'elixir-mode-hook 'mix-minor-mode)
      :ensure t)
    (add-hook 'elixr-mode-hook #'lsp)
    (add-to-list 'exec-path "~/.local/elixir")
    (add-hook 'elixir-mode-hook
	      (lambda () (add-hook 'before-save-hook 'elixir-format nil t))))
  :ensure t)

;; Package: erlang
(use-package erlang
  :config
  (add-hook 'erlang-mode-hook #'lsp)
  :ensure t)

;; Package: jinja2-mode
(use-package jinja2-mode
  :ensure t)

;; Package: toml-mode
(use-package toml-mode
  :ensure t)

;; Package: kotlin-mode
(use-package kotlin-mode
  :hook
  (kotlin-mode . lsp)
  :ensure t)
