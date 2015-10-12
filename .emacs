(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "outline" :family "Consolas"))))
 '(mode-line ((t (:background "purple4" :foreground "white"))))
 '(mode-line-highlight ((((class color) (min-colors 88)) nil)))
 '(mode-line-inactive ((default (:inherit mode-line)) (((class color) (min-colors 88) (background light)) (:background "grey90" :foreground "grey20" :weight light)))))


;;
;; ^^ Everything before is automatic / default
;; vv Everything after is my personalisations
;;
(define-minor-mode sensitive-mode
  "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
      (progn
	;; disable backups
	(set (make-local-variable 'backup-inhibited) t)	
	;; disable auto-save
	(if auto-save-default
	    (auto-save-mode -1)))
    ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
    ;resort to default auto save setting
    (if auto-save-default
	(auto-save-mode 1))))


(setq auto-mode-alist
 (append '(("\\.gpg$" . sensitive-mode))
               auto-mode-alist))

(add-to-list 'load-path "C:/Program Files/emacs-23.2/lisp/color-theme-6.6.0/")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-sitaramv-nt)))

;;;; twittering replaced by twit.el below
;;(add-to-list 'load-path "C:/Program Files/emacs-23.2/lisp/twittering-mode-2.0.0")
;;(require 'twittering-mode)
;;(setq twittering-use-master-password t)

(autoload 'twitel-get-friends-timeline "twitel" nil t)
(autoload 'twitel-status-edit "twitel" nil t)
(global-set-key "\C-xt" 'twitel-get-friends-timeline)
(add-hook 'twitel-status-edit-mode-hook 'longlines-mode)

(set-frame-height (selected-frame) 40)
(set-frame-width (selected-frame) 120)

(global-visual-line-mode 1)    ;; Always want 'proper' line wrapping
(global-linum-mode 1)          ;; I like to see the line numbers in the gutter
(column-number-mode t)         ;; Show column numbers in the toolbar
;;(scroll-bar-mode -1)           ;; Turn scrollbars off - still trialling this -> I prefer to have scrollbars.

(setq backup-inhibited t)      ;; No backup files
(setq make-bakcup-files nil)   ;; Not sure what the difference between this and the above is!
(setq auto-save-default nil)   ;; Stop creating those #backup# files

;; The following three lines would allow emacs to create versioned history files in ~/.emacss_backups/
;;(setq make-backup-files t)     ;; Enable backup files.
;;(setq version-control t)       ;; Enable versioning with default values (keep five last versions, I think!)
;;(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/")))) ;; Save all backup file in this directory.

;;(global-hl-line-mode 1)        ;; Highlight the current line

;; Seems like I need to use spaces rather than tabs :(
(setq-default indent-tabs-mode nil)
(setq-default c-basic-indent 2)
(setq-default tab-width 8)
;(setq indent-tabs-mode nil)


(load "journal")

;; TODO

(setq-default indent-tabs-mode t)            ;; Set tabs rather than spaces when <tab> is pressed.

