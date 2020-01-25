;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name " Burgess Chang"
      user-mail-address "brs@sdf.org")

;; @fix: Warning (with-editor): Cannot determine a suitable Emacsclient

;; Determining an Emacsclient executable suitable for the
;; current Emacs instance failed.  For more information
;; please see https://github.com/magit/magit/wiki/Emacsclient.
(setq-default with-editor-emacsclient-executable "emacsclient")

;; URL proxy config
(setq url-gateway-method 'socks
      socks-server '("Default server" "127.0.0.1" 1080 5))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-solarized-light)

;; Clean title format
(setq frame-title-format "")

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")
(defvar org-todo-file-path (concat org-directory "TODOs.org"))

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(add-hook 'org-mode-hook #'+word-wrap-mode)
(remove-hook 'text-mode-hook #'auto-fill-mode)
;;(+global-word-wrap-mode +1)

(when (featurep! :completion company)
  (after! company
    (setq company-idle-delay 0
          company-minimum-prefix-length 2)))

(when (featurep! :ui deft)
  (after! deft
    (setq deft-directory "~/org/notes"
          deft-extensions '("org" "md")
          deft-recursive t
          deft-use-filename-as-title t)))

(when (featurep! :ui doom-dashboard)
  (setq fancy-splash-image "~/.config/doom/gnu.png"))

(when (featurep! :lang markdown)
  (after! markdown-mode
    (add-hook! 'markdown-mode-hook #'+word-wrap-mode)))

(when (featurep! :ui modeline)
  (after! doom-modeline
    (setq doom-modeline-icon (display-graphic-p)
          doom-modeline-major-mode-icon t
          doom-modeline-major-mode-color-icon t
          doom-modeline-buffer-state-icon t
          doom-modeline-buffer-modification-icon t
          doom-modeline-minor-modes nil
          doom-modeline-lsp t
          doom-modeline-env-version t)))

(when (featurep! :lang org)
  (when (featurep! +journal)
    (setq org-journal-dir "~/org/journal/")))

(when (featurep! :lang rust)
  (when (featurep! +lsp)
    (setq lsp-rust-server 'rust-analyzer)))

(when (featurep! :term vterm)
  (after! vterm
    (setq vterm-shell "/bin/zsh")))
