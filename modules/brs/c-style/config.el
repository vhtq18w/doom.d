;;; brs/c-style/config.el -*- lexical-binding: t; -*-

(when (featurep! :lang cc)
  (require 'google-c-style)
  (c-add-style "google" google-c-style)

  (c-add-style "llvm" '("gnu" (c-basic-offset . 2)
                        (fill-column . 80)
                        (c++-indent-level . 2)
                        (indent-tabs-mode . nil)
                        (c-comment-only-line-offset . 0)
                        (c-offsets-alist
                         (arglist-intro . ++)
                         (innamespace . 0)
                         (member-init-intro . ++)
                         (statement-cont . +))))

  (c-add-style "webkit" '("google" (c-basic-offset . 4)
                          (c-offsets-alist
                           (innamespace . 0)
                           (access-label . -)
                           (case-label . 0)
                           (member-init-intro . +)
                           (topmost-intro . 0)
                           (arglist-cont-nonempty . +))))

  (after! cc-mode
    (setq-default c-basic-offset 2
                  tab-width 2
                  c-default-style "llvm")))

;;; brs/c-style/config.el ends here
