(include-book "sort-predicates")

(defun insert (x xs) ; assume x1 <= x2 <= x3 ...
  (if (and (consp xs) (> x (first xs)))
      (cons (first xs) (insert x (rest xs))) ; {ins2}
      (cons x xs)))                          ; {ins1}
(defun isort (xs)
  (if (consp (rest xs)) ; (len xs) > 1?
      (insert (first xs) (isort (rest xs))) ; {isrt2}
      xs))              ; (len xs) <= 1     ; {isrt1}
(defthm isort-ord-thm
  (up (isort xs)))
(defthm isort-len-thm
  (= (len (isort xs)) (len xs)))
(defthm isort-val-thm
  (iff (occurs-in e xs)
       (occurs-in e (isort xs))))
(defun rep (n x)
   (if (zp n)
       nil
       (cons x (rep (1- n) x))))