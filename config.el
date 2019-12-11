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

;; (when (display-graphic-p)
;;   (add-hook! 'doom-init-ui-hook
;;     (defun brs/vterm-startup ()
;;       (vterm)
;;       (doom/reload-theme))))

;; C/C++
;; Add a cc-mode style for editing LLVM C and C++ code
(when (featurep! :lang cc)
  (c-add-style
   "llvm"
   '("gnu"
     (c-basic-offset . 2)
     (fill-column . 80)
     (c++-indent-level . 2)
     (indent-tabs-mode . nil)
     (c-comment-only-line-offset . 0)
     (c-offsets-alist
      (arglist-intro . ++)
      (innamespace . 0)
      (member-init-intro . ++)
      (statement-cont . +))))
  (after! cc-mode
    (setq-default c-basic-offset 2
                  tab-width 2
                  c-default-style "llvm")))

;; Company
(after! company
  (setq company-idle-delay 0
        company-minimum-prefix-length 2))

;; Jupyter
;;(when (featurep! :tools ein)
;;  (setq +ein-notebook-dir (concat (getenv "HOME") "/Studio/Projects/Note-Collection")))

;; LaTeX
(when (featurep! :lang latex)
  (setq +latex-viewers '(evince)))

;; LSP
(when (featurep! :tools lsp)
  (setq lsp-ui-sideline-enable nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-enable-symbol-highlighting nil))

;; Org
(when (featurep! :lang org)
  (after! org
    (add-to-list 'org-capture-templates
                 '("w"
                   "Work todo"
                   entry
                   (file+headline org-todo-file-path "Work")
                   ))
    (when (featurep! +hugo)
      (add-to-list 'org-capture-templates
                   '("h"
                     "Hugo post"
                     entry
                     (file+headline org-todo-file-path "BLOG")
                     (function brs-org-hugo-new-subsubtree-post-capture-template)
                     )))
    (setq org-latex-listings t)
    (setq org-latex-pdf-process
          '("xelatex -interaction nonstopmode %f" "xelatex -interaction nonstopmode %f"))))

;; Python
(if (and IS-LINUX (featurep! :lang python +lsp))
    (setq lsp-python-ms-executable
          (concat (getenv "MICROSOFT_PYTHON_LANGUAGE_SERVER_HOME_DIR") "/output\
/bin/Release/Microsoft.Python.LanguageServer")))

;; IRC
;; sync username and password is unsafe, ignore this file.
(when (featurep! :app irc)
  (load! "+irc-info"))

;; @see https://github.com/magit/magit/issues/2492
(setq-default with-editor-emacsclient-executable "emacsclient")
