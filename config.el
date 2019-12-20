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
   "google"
   `((c-recognize-knr-p . nil)
     (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
     (c-basic-offset . 2)
     (indent-tabs-mode . nil)
     (c-comment-only-line-offset . 0)
     (c-hanging-braces-alist . ((defun-open after)
                                (defun-close before after)
                                (class-open after)
                                (class-close before after)
                                (inexpr-class-open after)
                                (inexpr-class-close before)
                                (namespace-open after)
                                (inline-open after)
                                (inline-close before after)
                                (block-open after)
                                (block-close . c-snug-do-while)
                                (extern-lang-open after)
                                (extern-lang-close after)
                                (statement-case-open after)
                                (substatement-open after)))
     (c-hanging-colons-alist . ((case-label)
                                (label after)
                                (access-label after)
                                (member-init-intro before)
                                (inher-intro)))
     (c-hanging-semi&comma-criteria
      . (c-semi&comma-no-newlines-for-oneline-inliners
         c-semi&comma-inside-parenlist
         c-semi&comma-no-newlines-before-nonblanks))
     (c-indent-comments-syntactically-p . t)
     (comment-column . 40)
     (c-indent-comment-alist . ((other . (space . 2))))
     (c-cleanup-list . (brace-else-brace
                        brace-elseif-brace
                        brace-catch-brace
                        empty-defun-braces
                        defun-close-semi
                        list-close-comma
                        scope-operator))
     (c-offsets-alist . ((arglist-intro google-c-lineup-expression-plus-4)
                         (func-decl-cont . ++)
                         (member-init-intro . ++)
                         (inher-intro . ++)
                         (comment-intro . 0)
                         (arglist-close . c-lineup-arglist)
                         (topmost-intro . 0)
                         (block-open . 0)
                         (inline-open . 0)
                         (substatement-open . 0)
                         (statement-cont
                          .
                          (,(when (fboundp 'c-no-indent-after-java-annotations)
                              'c-no-indent-after-java-annotations)
                           ,(when (fboundp 'c-lineup-assignments)
                              'c-lineup-assignments)
                           ++))
                         (label . /)
                         (case-label . +)
                         (statement-case-open . +)
                         (statement-case-intro . +) ; case w/o {
                         (access-label . /)
                         (innamespace . 0)))))
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
  (c-add-style
   "WebKit"
   '("Google"
     (c-basic-offset . 4)
     (c-offsets-alist . ((innamespace . 0)
                         (access-label . -)
                         (case-label . 0)
                         (member-init-intro . +)
                         (topmost-intro . 0)
                         (arglist-cont-nonempty . +)))))
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
