;(defconstant *M* (* 1024 1024))

(defconstant *M* 10)

(defun rand ()
  (/ (random *M*) *M*))

(defun random-jig ()
  (+ -3/2 (* 3 (rand))))

(defun random-offset ()
  (list (random-jig) 
	(random-jig)))

(defun random-center ()
  (let ((r (random 4)))
    (if (eq r 0)
	(list 1 1)
	(if (eq r 1)
	    (list -1 1)
	    (if (eq r 2)
		(list -1 -1)
		(list 1 -1))))))

(defun p-+ (p1 p2)
  (list (+ (first p1)  (first p2))
	(+ (second p1) (second p2))))

(defun random-point ()
  (p-+ (random-center) (random-offset)))

(defun random-list (n)
  (if (= n 0)
      nil
      (cons (random-point)
	    (random-list (- n 1)))))