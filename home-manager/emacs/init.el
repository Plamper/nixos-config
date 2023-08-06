(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(setq lsp-log-io t)
(setq inhibit-startup-message t)

(scroll-bar-mode 1)        ; Enable Scrollbar
(set-window-scroll-bars (minibuffer-window) nil nil) ;; Disable Scrollbar in Minibuffer
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips

(menu-bar-mode -1)            ; Disable the menu bar
(global-visual-line-mode t)

;;Configure font and ligatures
(set-face-attribute 'default nil :font "CaskaydiaCove Nerd Font" :height 128)

(use-package ligature
  :ensure t
  ;; :load-path "~/.emacs.d/ligatures/"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia and Fira Code ligatures in programming modes
  (ligature-set-ligatures 'prog-mode
                        '(;; == === ==== => =| =>>=>=|=>==>> ==< =/=//=// =~
                          ;; =:= =!=
                          ("=" (rx (+ (or ">" "<" "|" "/" "~" ":" "!" "="))))
                          ;; ;; ;;;
                          (";" (rx (+ ";")))
                          ;; && &&&
                          ("&" (rx (+ "&")))
                          ;; !! !!! !. !: !!. != !== !~
                          ("!" (rx (+ (or "=" "!" "\." ":" "~"))))
                          ;; ?? ??? ?:  ?=  ?.
                          ("?" (rx (or ":" "=" "\." (+ "?"))))
                          ;; %% %%%
                          ("%" (rx (+ "%")))
                          ;; |> ||> |||> ||||> |] |} || ||| |-> ||-||
                          ;; |->>-||-<<-| |- |== ||=||
                          ;; |==>>==<<==<=>==//==/=!==:===>
                          ("|" (rx (+ (or ">" "<" "|" "/" ":" "!" "}" "\]"
                                          "-" "=" ))))
                          ;; \\ \\\ \/
                          ("\\" (rx (or "/" (+ "\\"))))
                          ;; ++ +++ ++++ +>
                          ("+" (rx (or ">" (+ "+"))))
                          ;; :: ::: :::: :> :< := :// ::=
                          (":" (rx (or ">" "<" "=" "//" ":=" (+ ":"))))
                          ;; // /// //// /\ /* /> /===:===!=//===>>==>==/
                          ("/" (rx (+ (or ">"  "<" "|" "/" "\\" "\*" ":" "!"
                                          "="))))
                          ;; .. ... .... .= .- .? ..= ..<
                          ("\." (rx (or "=" "-" "\?" "\.=" "\.<" (+ "\."))))
                          ;; -- --- ---- -~ -> ->> -| -|->-->>->--<<-|
                          ("-" (rx (+ (or ">" "<" "|" "~" "-"))))
                          ;; *> */ *)  ** *** ****
                          ("*" (rx (or ">" "/" ")" (+ "*"))))
                          ;; www wwww
                          ("w" (rx (+ "w")))
                          ;; <> <!-- <|> <: <~ <~> <~~ <+ <* <$ </  <+> <*>
                          ;; <$> </> <|  <||  <||| <|||| <- <-| <-<<-|-> <->>
                          ;; <<-> <= <=> <<==<<==>=|=>==/==//=!==:=>
                          ;; << <<< <<<<
                          ("<" (rx (+ (or "\+" "\*" "\$" "<" ">" ":" "~"  "!"
                                          "-"  "/" "|" "="))))
                          ;; >: >- >>- >--|-> >>-|-> >= >== >>== >=|=:=>>
                          ;; >> >>> >>>>
                          (">" (rx (+ (or ">" "<" "|" "/" ":" "=" "-"))))
                          ;; #: #= #! #( #? #[ #{ #_ #_( ## ### #####
                          ("#" (rx (or ":" "=" "!" "(" "\?" "\[" "{" "_(" "_"
                                       (+ "#"))))
                          ;; ~~ ~~~ ~=  ~-  ~@ ~> ~~>
                          ("~" (rx (or ">" "=" "-" "@" "~>" (+ "~"))))
                          ;; __ ___ ____ _|_ __|____|_
                          ("_" (rx (+ (or "_" "|"))))
                          ;; Fira code: 0xFF 0x12
                          ("0" (rx (and "x" (+ (in "A-F" "a-f" "0-9")))))
                          ;; Fira code:
                          "Fl"  "Tl"  "fi"  "fj"  "fl"  "ft"
                          ;; The few not covered by the regexps.
                          "{|"  "[|"  "]#"  "(*"  "}#"  "$>"  "^="))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))

(use-package adwaita-dark-theme
  ;; :load-path  "~/.emacs.d/adwaita-dark-theme/"
  :ensure t)
(load-theme 'adwaita-dark t)


;; Setup Toolbox Tramp
;;(use-package toolbox-tramp
;;  :load-path  "~/.emacs.d/toolbox-tramp/")  


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq-default display-line-numbers-width-start t
              display-line-numbers-width 1
              display-line-numbers-grow-only t)

;; enable smooth scrolling
(pixel-scroll-precision-mode 1)
(setq pixel-scroll-precision-large-scroll-height 15.0)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
		shell-mode-hook
                eshell-mode-hook
		vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package all-the-icons
  :if (display-graphic-p)
  :ensure t)

(use-package ivy
  :ensure t
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
)

(ivy-mode)

;; (use-package general
;;   :config
;;   (general-create-definer plamper/leader-keys
;;     :prefix "C-c"
;;     :global-prefix "C-c")

;;   (plamper/leader-keys
;;     "t"  '(:ignore t :which-key "toggles")
;;     "c"  '(cua-copy-region :which-key "Copy Region")
;;     "x"  '(cua-cut-region :which-key "Cut Region")
;;     "v"  '(cua-paste :which-key "Paste Clipboard")
;;     "tt" '(counsel-load-theme :which-key "choose theme"))) 

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-switch-buffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))


(use-package vterm
  :ensure t)  


;; Install Hydra and and set zoom keybindings
;; (use-package hydra)

;; (defhydra hydra-text-scale (:timeout 4)
;;   "scale text"
;;   ("j" text-scale-increase "in")
;;   ("k" text-scale-decrease "out")
;;   ("f" nil "finished" :exit t))

;; (defhydra hydra-window-size (:timeout 4)
;;   "resize window"
;;   ("<up>" shrink-window  "decrease height")
;;   ("<down>" enlarge-window "increase height")
;;   ("<left>" shrink-window-horizontally "decrease width")
;;   ("<right>" enlarge-window-horizontally  "increase width")
;;   ("f" nil "finished" :exit t)) 

;; (plamper/leader-keys
;;   "ts" '(hydra-text-scale/body :which-key "scale text")
;;   "tw" '(hydra-window-size/body :which-key "scale window")
;;   "tv" '(vterm-other-window :which "vterm in new window"))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; For Emacs client
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))))

(use-package neotree
  :config
  (eval-after-load 'neotree #'adwaita-dark-theme-neotree-configuration-enable))

;; Fringe Config
(set-fringe-mode 6)
(adwaita-dark-theme-arrow-fringe-bmp-enable)

(use-package diff-hl
  :config
  (eval-after-load 'diff-hl #'adwaita-dark-theme-diff-hl-fringe-bmp-enable)
  (global-diff-hl-mode))

;; Code completion config
(use-package company
  :config
  (add-hook 'prog-mode-hook #'company-mode))
(eval-after-load 'flymake #'adwaita-dark-theme-flymake-fringe-bmp-enable)

(use-package yasnippet-snippets
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))



(defun open-project-dir ()
    (interactive)
    (counsel-find-file)
    (neotree-show)
    (eglot))

(use-package flymake-popon
  :init
  (use-package posframe)
  (use-package popon))

;; nix mode copied straight from the wiki
(use-package nix-mode
  :ensure t
  :mode ("\\.nix\\'" "\\.nix.in\\'"))
(use-package nix-drv-mode
  :ensure nix-mode
  :mode "\\.drv\\'")
(use-package nix-shell
  :ensure nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))
(use-package nix-repl
  :ensure nix-mode
  :commands (nix-repl))
