;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font-increment 1)
(setq me/doom-font-size 16)
(setq me/doom-variable-font-size 16)
(setq me/doom-font-family "Iosevka Nerd Font")
(setq doom-font (font-spec :family me/doom-font-family :size me/doom-font-size))

(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font-14"))
(set-face-attribute 'default t :font "Iosevka Nerd Font-14")
(set-frame-font "Iosevka Nerd Font-14" nil t)

(when (display-graphic-p)
  (require 'all-the-icons))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/documents/org/")
(setq evil-move-cursor-back nil)
;;(after! comment-dwim-2
;;  (map! "M-;" #'comment-dwim-2))

(after! git-timemachine
  :command (git-timemachine))

(after! git-messenger
  (setq git-messenger:show-detail t))

(map! :ne "C-c sw" #'ispell-word)
(map! :ne "C-c sb" #'ispell-buffer)
(map! :ne "C-c dr" #'delete-region)
(map! :ne "C-c mg" #'git-messenger:popup-message)
(map! :ne "C-c mt" #'git-timemachine)
(map! :ne "C-c vt" #'vterm)
(map! :ne "C-x j" #'evil-window-mru)

(map! :leader
      (:prefix-map ("a" . "my-key")
       :desc "Move end of file" "e" #'move-end-of-line
       :desc "Git timemachine" "gt" #'git-timemachine
       :desc "Git messenger" "gm" #'git-messenger:popup-message
       :desc "Turn on evil" "v" #'turn-on-evil-mode
       :desc "Trun off evil" "z" #'turn-off-evil-mode
       :desc "Spell check word" "w" #'ispell-word
       :desc "Spell check buffer" "b" #'ispell-buffer
       :desc "Open treemacs in directory" "o" #'treemacs-select-directory
       :desc "Save buffer" "s" #'save-buffer))

(after! ccls
  (setq ccls-executable "/bin/ccls")
  (setq ccls-sem-highlight-method 'overlay)
  (setq ccls-call-hierarchy t)
  (ccls-use-default-rainbow-sem-highlight))

(defalias 'evil-insert-state 'evil-emacs-state)
(define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
(setq evil-emacs-state-cursor '(bar . 1))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
