;;; php-snippets.el --- write less PHP

;; Copyright (c) 2014 James W. Dunne

;; Author: James W. Dunne
;; Created: 2014-03-10

;;; Commentary

;; Defines various emacs commands which expand into common PHP constructs
;; such as class, function, for and if. This aids in writing less PHP
;; which saves time.

;;; License

;; Public domain

(defun empty-p (str)
  (string= str ""))

(defun php-block ()
  (insert " {")
  (newline 2)
  (insert "}")
  (backward-char 2))

(defun php-parse-args (arg-str)
  (read (concat "(" arg-str ")")))

(defun php-make-args (arg-list)
  (mapconcat 'prin1-to-string
             arg-list
             ", "))

(defun php-args (args)
  (php-make-args (php-parse-args args)))

(defun php-if (test)
  (interactive "MEnter a boolean: ")
  (insert (concat "if (" test ")"))
  (php-block))

(defun php-for (max &optional var)
  (interactive "MEnter the max value: \nMEnter var name: ")
  (when (empty-p var)
    (setq var "$i"))
  (insert (concat "for (" 
                  var " = 0; "
                  var " < " max "; "
                  var "++)"))
  (php-block))

(defun php-foras (assoc var &optional key)
  (interactive "MEnter name of assoc: \nMEnter varname: \nMEnter key (optional): ")
  (insert "for (")
  (insert (concat assoc " as "))
  (unless (empty-p key)
    (insert (concat key " => ")))    
  (insert (concat var ")"))
  (php-block))

(defun php-fn (name args)
  (interactive "MEnter name of fn: \nMEnter list of args: ")
    (insert (concat "function " name "("
                    (php-args args)
                    ")"))
    (php-block))

(defun php-class (name &optional extends)
  (interactive "MEnter class name: \nMEnter parent: ")
  (insert (concat "class " name))
  (unless (empty-p extends)
    (insert (concat " extends " extends)))
  (php-block))

(defun php-const (&optional args)
  (interactive "MEnter list of args: ")
  (insert "public ")
  (php-fn "__construct" args))

(provide 'php-snippets)
