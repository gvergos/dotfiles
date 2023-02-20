;; MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; ---------------------------------------

;; USE PACKAGE
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; ---------------------------------------

;; EVIL MODE PACKAGE
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (evil-mode))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

;; ---------------------------------------

;; GENERAL KEYBINDIGS PACKAGE
(use-package general
  :config
  (general-evil-setup t))

;; ---------------------------------------

;; MAKES STARTUP FASTER
;; Using garbage magic hack.
 (use-package gcmh
   :config
   (gcmh-mode 1))
;; Setting garbage collection threshold
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))
;; Silence compiler warnings as they can be pretty disruptive
(if (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
(setq load-prefer-newer noninteractive)

;; ---------------------------------------
;; ---------------- UI -------------------
;; ---------------------------------------
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Makes *scratch* empty.
(setq initial-scratch-message "")
(set-fringe-mode 10)

;; ---------------------------------------
;; -------------- THEME ------------------
;; ---------------------------------------
(load-theme 'gruber-darker t)
;; Font size
(set-face-attribute 'default nil :height 140)
;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
;; LineNumbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-width 3)
(global-visual-line-mode t)
;; Disable line numbers for some things
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))


;; ---------------------------------------
;; ------------- KEYMAPS -----------------
;; ---------------------------------------

(nvmap :keymaps 'override :prefix "SPC"
       "m m"   '(counsel-M-x :which-key "M-x")
       "v s"   '(split-window-right :which-key "Vertical Split")
       "h s"   '(split-window-below :which-key "Horizontal Split")
       "f f"   '(counsel-find-file :which-key "Find File")
       "r c"   '(counsel-find-file :which-key "Find File")
       "e e"   '(eshell-here :which-key "Open eshell")
       "c SPC" '(comment-or-uncomment-region :which-key "Comment Line")
)

(use-package evil
  :bind (:map evil-motion-state-map
              ("C-j" . evil-window-down)
              ("C-k" . evil-window-up)
              ("C-l" . evil-window-right)
              ("C-h" . evil-window-left)))

;; ---------------------------------------
;; ------------ IMPORTANT ----------------
;; ---------------------------------------

; Remap Esc to jj
(use-package key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; No blink cursor
(blink-cursor-mode 0)
;; Time Zone
(setenv "TZ" "GMT-3")

;; Save backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;; Parenthesis autocomplete
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;; Better scroll
(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; Icons -> to install run M-x all-the-icons-install-fonts
(use-package all-the-icons
  :if (display-graphic-p))

;; Ivy
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Syntax highlighting for emacs
(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))

;; Panel popup for keybindings
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0))

;; Pretty print in M-x
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(setq ivy-height 20)

;; Counsel M-x
(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         ("C-M-l" . counsel-imenu)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; Helpful package -> better view of documentation on emacs
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . helpful-function)
  ([remap describe-symbol] . helpful-symbol)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))

;; Helpful package -> better view of documentation on emacs
(general-define-key
  "C-6" 'counsel-switch-buffer)


;; ---------------------------------------
;; ----------- FILE MANAGER --------------
;; ---------------------------------------

(use-package all-the-icons-dired)
(use-package dired-open)
(use-package peep-dired)

(nvmap :states '(normal visual) :keymaps 'override :prefix "SPC"
               "d d" '(dired :which-key "Open dired")
               "d j" '(dired-jump :which-key "Dired jump to current")
               "d p" '(peep-dired :which-key "Peep-dired"))

(with-eval-after-load 'dired
  ;;(define-key dired-mode-map (kbd "M-p") 'peep-dired)
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
  (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
  (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))



;; ---------------------------------------
;; ------------- ORG MODE ----------------
;; ---------------------------------------
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-directory "~/Org/"
      org-agenda-files '("~/Org/agenda.org")
      org-default-notes-file (expand-file-name "notes.org" org-directory)
      org-ellipsis " ▼ "
      org-log-done 'time
      org-journal-dir "~/Org/journal/"
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org"
      org-hide-emphasis-markers t)
(setq org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

;; Bullets
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; TODO KEYWORDS
(setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "BLOG(b)"           ; Blog writing assignments
               "MEETEING(m)"       ; Meeting
           "GYM(g)"            ; Things to accomplish at the gym
           "PROJ(p)"           ; A project that contains other tasks
           "VIDEO(v)"          ; Video assignments
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)" )))  ; Task has been cancelled

;; Table of contents in org files
(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

;; PROJECTILE
(use-package projectile
  :config
  (projectile-global-mode 1))

;; ESHELL SYNTAX HIGHLIGHTING
(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

;; Simple autocomplete
(use-package auto-complete)
(use-package ac-slime)

;; ---------------------------------------
;; ------------- LSP MODE ----------------
;; ---------------------------------------
;; VHDL
(use-package lsp-mode)
(setq lsp-keymap-prefix "s-l")
(add-hook 'c-mode-hook #'lsp)
(add-hook 'python-mode-hook #'lsp)

;; PYTHON
(use-package jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; ---------------------------------------
;; ------------- FUNCTIONS ---------------
;; ---------------------------------------
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(defun eshell-close ()
  "Closes the window created by the function 'eshell-here'"
  (interactive)
  (insert "exit")
  (eshell-send-input)
  (delete-window))
