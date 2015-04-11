(in-package #:powerdns)

(defclass record ()
  ((id :col-type integer
       :initarg :id
       :reader record-id)
   (domain-id :col-type integer
	      :initarg :domain-id
	      :initform :null
	      :reader record-domain-id)
   (name :col-type string
	 :initarg :name
	 :initform :null
	 :accessor record-name)
   (type :col-type string
	 :initarg :type
	 :initform :null
	 :accessor record-type)
   (content :col-type string
	    :initarg :content
	    :initform :null
	    :accessor record-content)
   (ttl :col-type integer
	:initarg :ttl
	:initform :null
	:accessor record-ttl)
   (prio :col-type integer
	 :initarg :prio
	 :initform :null
	 :accessor record-prio)
   (change-date :col-type integer
		:initarg :change_date
		:initform :null
		:accessor record-change-date)
   (disabled :col-type bool
	     :initarg :disabled
	     :initform :null
	     :accessor record-disabled)
   (ordername :col-type string
	      :initarg :ordername
	      :initform :null
	      :accessor record-ordername)
   (auth :col-type bool
	 :initarg :auth
	 :initform t
	 :accessor record-auth))
  (:metaclass postmodern:dao-class)
  (:keys id)
  (:table-name "records"))

(defmethod print-object ((r record) str)
  (format str "('RECORD :id ~a :domain_id ~a :name ~a :type ~a :content ~a :ttl ~a :prio ~a :change-date ~a :disabled ~a :ordername ~a :auth ~a)"
	  (record-id r)
	  (record-domain-id r)
	  (record-name r)
	  (record-type r)
	  (record-content r)
	  (record-ttl r)
	  (record-prio r)
	  (record-change-date r)
	  (record-disabled r)
	  (record-ordername r)
	  (record-auth r)))

(defun new-record (&optional (domain_id :null) (name "") (type "") (content "") (ttl :null)
		     (prio :null) (change_date :null) (disabled nil) (ordername "") (auth t))
  (postmodern:make-dao 'record
		       :domain_id domain_id
		       :name name
		       :type type
		       :content content
		       :ttl ttl
		       :prio prio
		       :change_date change_date
		       :disabled disabled
		       :ordername ordername
		       :auth auth))
