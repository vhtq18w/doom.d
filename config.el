;;; .doom.d/config.el -*- lexical-binding: t; -*-

(after! doom-modeline
  (setq doom-modeline-bar-width 3
        doom-modeline-buffer-modification-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-enable-word-count t

        doom-modeline-env-version t

        ;; Or for individual languages
        doom-modeline-env-enable-python t
        doom-modeline-env-enable-ruby t
        doom-modeline-env-enable-perl t
        doom-modeline-env-enable-go t
        doom-modeline-env-enable-elixir t
        doom-modeline-env-enable-rust t
        doom-modeline-env-python-executable "python" ; or `python-shell-interpreter'
        doom-modeline-env-ruby-executable "ruby"
        doom-modeline-env-perl-executable "perl"
        doom-modeline-env-go-executable "go"
        doom-modeline-env-elixir-executable "iex"
        doom-modeline-env-rust-executable "rustc"

        ;; What to dispaly as the version while a new one is being loaded
        doom-modeline-env-load-string "..."

        doom-modeline-buffer-encoding t
        doom-modeline-github t
        doom-modeline-github-interval (* 30 60)
        doom-modeline-height 1
        doom-modeline-lsp t
        doom-modeline-mu4e nil
        doom-modeline-persp-name t
        doom-modeline-persp-name-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-minor-modes nil
        doom-modeline-buffer-file-name-style 'relative-from-project)
  
  (set-face-attribute 'mode-line nil :height 100)
  (set-face-attribute 'mode-line-inactive nil :height 100))

(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 3))

;; Python
(if (and IS-LINUX (featurep! :lang python +lsp))
    (setq lsp-python-ms-executable (concat (getenv "HOME") "/Build\
/python-language-server/output/bin/Release/linux-x64/publish/\
Microsoft.Python.LanguageServer")))
