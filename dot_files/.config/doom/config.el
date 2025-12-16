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

;; C++ Header/Implementation Navigation Functions
(defun my/get-class-name-from-file ()
  "Extract class name from current file name and convert to PascalCase."
  (let ((filename (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ;; Convert snake_case or kebab-case to PascalCase
    (mapconcat 'capitalize (split-string filename "[_-]") "")))

(defun my/get-function-signature-at-point ()
  "Get the function signature at current point, handling both declarations and definitions."
  (save-excursion
    (beginning-of-line)
    (let* ((start-pos (point))
           (line-content (buffer-substring-no-properties (line-beginning-position) (line-end-position)))
           function-name
           signature
           implementation-body)

      ;; Clean up the line first
      (setq line-content (string-trim line-content))

      ;; Check if this is a function definition (has body) or just declaration
      (if (string-match "{" line-content)
          ;; Function definition - extract implementation
          (progn
            ;; First get the signature part (before the brace)
            (when (string-match "\\(.*?\\){" line-content)
              (setq signature (string-trim (match-string 1 line-content)))
              ;; Extract function name from signature
              (when (string-match "\\(.*?\\)\\b\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\s-*(" signature)
                (setq function-name (match-string 2 signature))))

            ;; Now get the implementation body
            (let ((brace-pos (search-forward "{" (line-end-position) t)))
              (when brace-pos
                (backward-char 1) ; go back to the opening brace
                (let ((body-start (point))
                      (body-end (progn (forward-sexp 1) (point))))
                  ;; Extract the implementation body
                  (setq implementation-body
                        (string-trim (buffer-substring-no-properties (1+ body-start) (1- body-end))))))))

        ;; Function declaration - normal processing
        (setq line-content (replace-regexp-in-string "\\s-*;\\s-*\\(//.*\\)?$" "" line-content))
        (setq line-content (replace-regexp-in-string "\\s-*=\\s-*0\\s-*$" "" line-content))
        (setq line-content (replace-regexp-in-string "^\\s-*\\(?:virtual\\|static\\|inline\\)\\s-+" "" line-content))
        (setq signature line-content)

        ;; Extract function name
        (when (string-match "\\(.*?\\)\\b\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\s-*(" line-content)
          (setq function-name (match-string 2 line-content))))

      (list function-name signature implementation-body))))

(defun my/find-or-create-implementation-file ()
  "Find or create the corresponding .cpp file for current .h file."
  (let* ((current-file (buffer-file-name))
         (base-name (file-name-sans-extension current-file))
         (cpp-file (concat base-name ".cpp")))
    (if (file-exists-p cpp-file)
        (find-file cpp-file)
      ;; Create new cpp file with basic structure
      (find-file cpp-file)
      (insert (format "#include \"%s.h\"\n\n" (file-name-nondirectory base-name)))
      (save-buffer))
    cpp-file))

(defun my/create-implementation-stub ()
  "Create implementation stub for function at point in corresponding .cpp file."
  (interactive)
  (if (not (string-match "\\.h\\(pp\\)?$" (buffer-file-name)))
      (message "This command only works in header files")
    (let ((func-info (my/get-function-signature-at-point)))
      (if (not func-info)
          (message "No function found at current point")
        (let* ((func-name (car func-info))
               (signature (cadr func-info))
               (class-name (my/get-class-name-from-file))
               (current-buffer (current-buffer)))

          ;; Switch to implementation file
          (my/find-or-create-implementation-file)

          ;; Check if function already exists
          (goto-char (point-min))
          (if (search-forward (format "%s::%s" class-name func-name) nil t)
              (message "Implementation for %s already exists" func-name)

            ;; Add implementation at end of file
            (goto-char (point-max))
            (unless (bolp) (insert "\n"))
            (insert "\n")

            ;; Create the implementation stub - simpler approach
            ;; Parse the signature to extract return type and parameters
            (let* ((parts (split-string signature "("))
                   (before-params (string-trim (car parts)))
                   (params (if (cdr parts) (concat "(" (mapconcat 'identity (cdr parts) "(")) "()"))
                   ;; Split return type and function name
                   (before-parts (split-string before-params))
                   (return-type (if (> (length before-parts) 1)
                                    (mapconcat 'identity (butlast before-parts) " ")
                                  "void"))
                   (impl-signature (format "%s %s::%s%s" return-type class-name func-name params)))
              (insert (format "%s {\n    \n}\n" impl-signature))
              ;; Position cursor inside the function body
              (forward-line -2)
              (end-of-line)
              (message "Created implementation stub for %s::%s" class-name func-name))))))))

(defun my/goto-function-implementation ()
  "Go to the implementation of function at point in corresponding .cpp file."
  (interactive)
  (if (not (string-match "\\.h\\(pp\\)?$" (buffer-file-name)))
      (message "This command only works in header files")
    (let ((func-info (my/get-function-signature-at-point)))
      (if (not func-info)
          (message "No function found at current point")
        (let* ((func-name (car func-info))
               (class-name (my/get-class-name-from-file))
               (current-file (buffer-file-name))
               (base-name (file-name-sans-extension current-file))
               (cpp-file (concat base-name ".cpp")))

          (if (not (file-exists-p cpp-file))
              (message "Implementation file %s not found" cpp-file)

            ;; Switch to implementation file and find function
            (find-file cpp-file)
            (goto-char (point-min))
            (if (search-forward (format "%s::%s" class-name func-name) nil t)
                (progn
                  (beginning-of-line)
                  (message "Found implementation of %s::%s" class-name func-name))
              (message "Implementation of %s::%s not found" class-name func-name))))))))

;; Key bindings
(map! :leader
      :desc "Create implementation stub" "c I" #'my/create-implementation-stub
      :desc "Go to implementation" "c g" #'my/goto-function-implementation)

(defun my/debug-function-at-point ()
  "Debug function extraction at current point."
  (interactive)
  (let ((line-content (buffer-substring-no-properties (line-beginning-position) (line-end-position))))
    (message "Line content: '%s'" line-content)
    (message "Has brace: %s" (string-match "{" line-content))
    (let ((result (my/get-function-signature-at-point)))
      (message "Function info: %s" result)
      (message "Function name: %s" (nth 0 result))
      (message "Signature: %s" (nth 1 result))
      (message "Implementation body: %s" (nth 2 result)))))

