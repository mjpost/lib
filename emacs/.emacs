;; Emacs has package management!
;; 
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; iswitchb-mode
;; (setq iswitchb-buffer-ignore '("^ " "*Buffer"))
(iswitchb-mode 1)

;; custom paths
(add-to-list 'load-path (expand-file-name "~/lib/emacs/") t)

; contains custom functions post-fill-asterisk (C-c f), insert-datetime-string (C-c d), etc
(load "post-custom")

(require 'smart-compile)

;; KEYBINDINGS
;;(global-set-key "\C-cc" '(lambda () (interactive) (shell-command-on-region (region-beginning) (region-end) "pbcopy")))
(global-set-key "\C-cc" 'post-pbcopy)
(global-set-key "\M-c" 'post-pbcopy)
(global-set-key "\M-C" 'capitalize-word)
(global-set-key "\C-cf" 'post-fill-asterisk)
(global-set-key "\C-cd" 'post-insert-datetime-string)
(global-set-key "\C-c#" 'comment-or-uncomment-region)
(global-set-key "\C-c>" 'toggle-truncate-lines)

(global-set-key "\C-co" 'occur)
(global-set-key "\C-cr" 'revert-buffer)
(global-set-key "\C-cg" 'goto-line)
(global-set-key "\C-cx" 'smart-compile)
(global-set-key "\C-ci" 'indent-region)
(global-set-key "\C-ct" 'set-input-method)
(global-set-key "\C-cm" 'rename-file-and-buffer)
(global-set-key "\C-cp" 'picture-mode)

;; quickly go between windows
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-O" (lambda () (interactive (other-window -1))))

; enables mouse scrolling
(global-set-key [mouse-4] 'mouse-scroll-down)
(global-set-key [mouse-5] 'mouse-scroll-up)

;; a quick way to repeat the last macro
(global-set-key [f5] 'call-last-kbd-macro)

(global-set-key "\M-\C-g" 'org-plot/gnuplot)
(global-set-key "\C-cs" 'flyspell-buffer)
(global-set-key "\C-xvp" 'vc-pull)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(column-number-mode t)
 '(compilation-scroll-output 'first-error)
 '(custom-enabled-themes '(manoj-dark))
 '(frame-background-mode 'dark)
 '(indent-tabs-mode nil)
 '(package-selected-packages '(markdown-mode+ jedi markdown-mode))
 '(require-final-newline t)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(tab-width 2)
 '(which-function-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (setq initial-frame-alist '((width . 125) (height . 75)))

;; This enables an org-table submode in Markdown files
(add-hook 'markdown-mode-hook 'turn-on-orgtbl)
(add-hook 'latex-mode-hook 'turn-on-orgtbl)
