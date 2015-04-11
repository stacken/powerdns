(in-package #:powerdns)

(defclass domain ()
  ((id :col-type integer
       :initarg :id
       :reader domain-id
       :documentation "This field is used to easily manage the
domains with this number as an unique handle.")
   (name :col-type string
	 :initarg :name
	 :initform (error "name must be provided")
	 :reader domain-name
	 :documentation "This field is the actual domainname.
This is the field that powerDNS matches to when it gets a request.
The domainname should be in the format of: domainname.TLD")
   (master :col-type bool
	   :initarg :master
	   :accessor domain-master
	   :initform :null
	   :documentation "This describes the master nameserver
from which this domain should be slaved. Takes IPs, not hostnames!")
   (last-check :col-type integer
	       :initarg :last-check
	       :reader domain-last-check
	       :initform :null
	       :documentation "Last time this domain was checked for freshness.")
   (type :initarg :type
	 :initform "NATIVE"
	 :col-type string
	 :accessor domain-type
	 :documentation "Posible values are:  NATIVE,  MASTER,  SLAVE,
SUPERSLAVE. Use NATIVE if there are no slaves nor masters.")
   (notified-serial :col-type integer
		    :initarg :notified-serial
		    :reader domain-notified-serial
		    :initform :null
		    :documentation "The last notified serial of a master domain.
This is updated from the SOA record of the domain.")
   (account :col-type string
	    :initarg :account
	    :reader domain-account
	    :initform :null
	    :documentation "Determine if a certain host is a supermaster
for a certain domain name."))
  (:metaclass postmodern:dao-class)
  (:keys id)
  (:table-name "domains"))

(defmethod print-object ((d domain) str)
  (format str "('DOMAIN :id ~a :name ~a :master ~a :last-check ~a :type ~a :notified-serial ~a :account ~a)"
	  (domain-id d)
	  (domain-name d)
	  (domain-master d)
	  (domain-last-check d)
	  (domain-type d)
	  (domain-notified-serial d)
	  (domain-account d)))

(defun new-domain (name type &optional (master ) (last-check 0) (notified-serial 0) (account nil))
  (postmodern:make-dao 'domain
		       :name name
		       :type type
		       :master master
		       :last-check last-check
		       :notified-serial notified-serial
		       :account account))
