;;;; powerdns.asd

(asdf:defsystem #:powerdns
  :description "Describe powerdns here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:postmodern
               #:hunchentoot
               #:cl-ppcre)
  :serial t
  :components ((:file "package")
               (:file "powerdns")
	       (:file "DomainModel")
	       (:file "RecordModel")
	       (:file "html-gen")))
