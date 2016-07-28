(include-book "map-reduce")

(defconst *RAWDATA*
  '((-7/10 -1/5) (-1/10 1/10) (-7/10 11/5) (-1 -2/5) (7/10 1) 
    (-5/2 1) (-19/10 -8/5) (8/5 8/5) (-2/5 -7/10) (-11/5 19/10)
    (-11/5 -8/5) (-8/5 -19/10) (-2/5 -1/2) (-1/5 -5/2) (11/5 -2/5)
    (-1 -1) (-13/10 -8/5) (-1/10 1) (13/10 -1/2) (-11/5 -5/2)
    (-19/10 1/10) (-19/10 -1/5) (13/10 1/10) (19/10 -1/2) (1/5 -1)
    (-8/5 19/10) (-1/10 13/10) (-5/2 -2/5) (-5/2 7/10) (8/5 -19/10)
    (-7/10 2/5) (-5/2 1/5) (1/5 1/5) (-2/5 11/5) (-1/10 1)
    (7/10 -11/5) (-7/10 19/10) (-2/5 -11/5) (-1/10 -19/10) (-8/5 1)))

(defun make-pair (list)
  (if (consp list)
      (cons (list (first list) nil)
	    (make-pair (rest list)))
      nil))

(defconst *DATA* (make-pair *RAWDATA*))

(defun point-distance (p1 p2)
  (+ (* (- (first p2) (first p1))
	(- (first p2) (first p1)))
     (* (- (second p2) (second p1))
	(- (second p2) (second p1)))))

(defun find-closest-center-aux (point closest mindist centers)
  (if (consp centers)
      (let ((distance (point-distance point (second (first centers)))))
	(if (< distance mindist)
	    (find-closest-center-aux point
				     (first (first centers))
				     distance
				     (rest centers))
	    (find-closest-center-aux point
				     closest
				     mindist
				     (rest centers))))
      closest)) 

(defun find-closest-center (point centers)
  (find-closest-center-aux point 
			   (first (first centers))
			   (point-distance point (second (first centers)))
			   (rest centers)))

(defun cl-map (point value centers)
  (declare (ignore value))
  (list (list (find-closest-center point centers)
	      point)))

(defun point-plus (p1 p2)
  (list (+ (first p1)  (first p2))
	(+ (second p1) (second p2))))

(defun point-average-aux (values point-sum count)
  (if (consp values)
      (point-average-aux (rest values)
			 (point-plus point-sum (first values))
			 (1+ count))
      (list (/ (first  point-sum) count)
	    (/ (second point-sum) count))))

(defun point-average (values)
  (point-average-aux values (list 0 0) 0))

(defun cl-reduce (key values centers)
  (declare (ignore centers))
  (list (list key (point-average values))))


(defmapreduceiter cluster cl-map cl-reduce)

(defconst *CENTERS* '( (A ( -2 0 )) (B ( -1 0 )) (C ( 0 0 )) (D ( 1 0 )) ))

(cluster 50 *DATA* *CENTERS*)