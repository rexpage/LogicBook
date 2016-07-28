(in-package "ACL2")

(include-book "data-structures/utilities" :dir :system)

(defun mr-add-entry (entry list)
  (cond ((not (consp list))
	 (list (list (first entry) 
		     (list (second entry)))))
	((equal (first entry) (first (first list)))
	 (cons (list (first entry)
		     (cons (second entry)
			   (second (first list))))
	       (rest list)))
	((lexorder (first entry) (first (first list)))
	 (cons (list (first entry) 
		     (list (second entry)))
	       list))
	(t
	 (cons (first list)
	       (mr-add-entry entry (rest list))))
	))

(defun mr-combine-values (list)
  (if (consp list)
      (mr-add-entry (first list)
		    (mr-combine-values (rest list)))
      nil))


(defmacro defmapreduce (mapreduce map reduce)
  (let ((call-map    (u::pack-intern mapreduce mapreduce '-call-map))
	(call-reduce (u::pack-intern mapreduce mapreduce '-call-reduce))
	)
    `(progn
       (defun ,call-map (list)
	 (if (consp list)
	     (append (,map (first  (first list))
			   (second (first list)))
		     (,call-map (rest list)))
	     nil))

       (defun ,call-reduce (list)
	 (if (consp list)
	     (append (,reduce (first  (first list))
			      (second (first list)))
		     (,call-reduce (rest list)))
	     nil))

       (defun ,mapreduce (dataset)
	 (,call-reduce
	  (mr-combine-values
	   (,call-map
	    dataset))))
       )))

(defmacro defmapreduceiter (mapreduce map reduce)
  (let ((call-map    (u::pack-intern mapreduce mapreduce '-call-map))
	(call-reduce (u::pack-intern mapreduce mapreduce '-call-reduce))
	)
    `(progn
       (defun ,call-map (list current)
	 (if (consp list)
	     (append (,map (first  (first list)) 
			   (second (first list)) 
			   current)
		     (,call-map (rest list) current))
	     nil))

       (defun ,call-reduce (list current)
	 (if (consp list)
	     (append (,reduce (first  (first list))
			      (second (first list)) 
			      current)
		     (,call-reduce (rest list) current))
	     nil))

       (defun ,mapreduce (iters dataset initial)
	 (if (zp iters)
	     initial
	     (,mapreduce (1- iters)
			 dataset
			 (,call-reduce (mr-combine-values (,call-map dataset initial))
				       initial))))
       )))

