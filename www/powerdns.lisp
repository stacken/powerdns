;;;; powerdns.lisp

(in-package #:powerdns)

;;; "powerdns" goes here. Hacks and glory await!


(defparameter *db* "pdns")
(defparameter *user* "pdns")
(defparameter *password* "secret")
(defparameter *host* "localhost")

(defun connect (db username password host)
  (setf postmodern:*database* (postmodern:connect db username password host)))

(defun disconnect ()
  (postmodern:disconnect postmodern:*database*))


(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080))

(defmacro defpage (name uri (&rest parameters) &rest html)
  (with-gensyms (stream)
    `(hunchentoot:define-easy-handler (,name :uri ,uri) ,parameters
       (with-output-to-string (,stream)
	 (generate-html (,stream :indent t)
			,html)))))

(defmacro page-template (&rest html)
  (with-gensyms (stream)
    `(with-output-to-string (,stream)
       (generate-html (,stream :indent t)
		      ("<!DOCTYPE html>"
		       (:html (:head (:title "Powerdns")
				     (:link :rel "stylesheet" :href "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css")
				     (:link :rel "stylesheet" :href "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css")
				     (:script :src "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"))
			      (:body (:div :class "col-md-2" "&nbsp;")
				     (:div :class "col-md-8" ,@html)
				     (:div :class "col-md-2" "&nbsp;"))))))))

(defpage index "/" ()
	 (page-template
	  (:h1 "Hello, world!")
	  (:p "This is a text.")))

(defpage test "/test" (name)
	 (page-template
	  (:html (:body "hej, " name))))


(defpage login "/login" ()
	 (page-template
	  (:div :class "col-md-3" "&nbsp;")
	  (:div :class "col-md-6"
		(:h1 "Please log in")
		(:form :action "/login.do" :method "post"
		       (:div :class "form-group"
			     (:label :for "username" "Username")
			     (:input :type "text" :id "username"
				     :name "username" :class "form-control"))
		       (:div :class "form-group"
			     (:label :for "password" "Password")
			     (:input :type "password" :id "password"
				     :name "password" :class "form-control"))
		       (:div :class "form-group"
			     (:input :type "button" :class "btn btn-default" :value "Log in"))))
	  (:div :class "col-sm-3" "&nbsp;")))
