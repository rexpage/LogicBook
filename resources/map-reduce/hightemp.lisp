(include-book "map-reduce")


(defconst *TEMPERATURES*
  '((norman (ok 100))
    (norman (ok 98))
    (norman (ok 104))
    (norman (ok 102))
    (laramie (wy 29))
    (laramie (wy 20))    
    (casper  (wy -20))
    (jelm    (wy 21))))

(defun temp-map (key value)
  (declare (ignore key))
  (list (list (first value)
	      (second value))))

(defun maxlist (list)
  (if (consp list)
      (if (consp (rest list))
	  (if (< (first list)
		 (maxlist (rest list)))
	      (maxlist (rest list))
	      (first list))
	  (first list))
      nil))

(defun temp-reduce (key values)
  (list (list key
	      (maxlist values))))

(defmapreduce hightemps temp-map temp-reduce)

(hightemps *TEMPERATURES*)