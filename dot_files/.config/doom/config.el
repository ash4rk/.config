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

(setq doom-font (font-spec :family "Comic Shanns Mono Nerd Font" :size 28 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Comic Shanns Mono Nerd Font" :size 13))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(customize-set-variable 'doom-themes-treemacs-theme "doom-colors")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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

;; dired
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file
  (kbd "left") 'dired-up-directory
  (kbd "right") 'dired-open-file)

;; treemacs
(defun +private/treemacs-back-and-forth ()
  (interactive)
  (if (treemacs-is-treemacs-window-selected?)
      (aw-flip-window)
    (treemacs-select-window)))

(map! :after treemacs
      :leader
      :n "-" #'+private/treemacs-back-and-forth)

(setq org-support-shift-select 't)

;; to debug CPP code with DAP-MODE
(setq dap-auto-configure-mode t)
(require 'dap-cpptools)
;; Debugging Keybindings
(map! :leader
      "dd" nil)
(map! :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      (:prefix ("dd" . "Debug")
       :desc "dap debug recent"  "r" #'dap-debug-recent
       :desc "dap debug last"    "l" #'dap-debug-last

       ;; eval
       :desc "remove expression"   "d" #'dap-ui-expressions-remove)
      (:prefix ("de" . "Eval")
       :desc "eval"                "e" #'dap-eval
       :desc "eval region"         "r" #'dap-eval-region
       :desc "eval thing at point" "s" #'dap-eval-thing-at-point
       :desc "add expression"      "a" #'dap-ui-expressions-add)

      (:prefix ("db" . "Breakpoint")
       :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
       :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
       :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
       :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message))

;; Move text up, down, left and right
(global-set-key [M-up] 'drag-stuff-up)
(global-set-key [M-down] 'drag-stuff-down)
(global-set-key [M-right] 'drag-stuff-right)
(global-set-key [M-left] 'drag-stuff-left)

(add-hook! 'c++-mode-hook
  (setq c-basic-offset 2         ;; indentation = 2 spaces
        tab-width 2
        indent-tabs-mode nil))   ;; use spaces, not tabs

;; Needed for `:after char-fold' to work
(use-package char-fold
  :custom
  (char-fold-symmetric t)
  (search-default-mode #'char-fold-to-regexp))

(use-package reverse-im
  :ensure t ; install `reverse-im' using package.el
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  ;; cache generated keymaps
  (reverse-im-cache-file (locate-user-emacs-file "reverse-im-cache.el"))
  ;; use lax matching
  (reverse-im-char-fold t)
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  ;; translate these methods
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t)) ; turn the mode on

;; Manual Russian bindings as fallback
(map! :after evil
      :map evil-normal-state-map
      "." #'evil-ex-search-forward     ; Russian "/"
      "," #'evil-ex-search-backward    ; Russian "?"
      ;; Common commands
      "з" #'evil-paste-after           ; Russian "p"
      "З" #'evil-paste-before          ; Russian "P"
      "н" #'evil-yank                  ; Russian "y"
      "в" #'evil-delete                ; Russian "d"
      "с" #'evil-change                ; Russian "c"
      "ш" #'evil-insert                ; Russian "i"
      "а" #'evil-append                ; Russian "a"
      "щ" #'evil-open-below            ; Russian "o"
      "Щ" #'evil-open-above            ; Russian "O"
      "г" #'evil-undo                  ; Russian "u"
      "к" #'evil-replace               ; Russian "r"

      ;; Movement (if needed)
      "р" #'evil-backward-char         ; Russian "h"
      "о" #'evil-next-line             ; Russian "j"
      "л" #'evil-previous-line         ; Russian "k"
      "д" #'evil-forward-char          ; Russian "l"

      ;; Magit
      "," #'magit-dispatch             ; Russian "?" in Magit buffers
      :map magit-status-mode-map
      "," #'magit-dispatch)             ; Russian "?" in Magit status

(map! :leader
      :desc "Switch header/source"
      "c h" #'lsp-clangd-find-other-file)

(setq-default evil-escape-key-sequence "оо")  ; Russian "jj"
(setq-default evil-escape-unordered-key-sequence t)

