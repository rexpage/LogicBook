(defun mux (xs ys)
  (if (not (consp xs))
      ys                                             ; mux0
      (if (not (consp ys))
          xs                                         ; mux10
          (cons (first xs)
                (cons (first ys)
                      (mux (rest xs) (rest ys))))))) ; mux11
;(defun mux (xs ys) ; this is clever, but needs a hint
;                   ; and dmx-inverts-mux fails
;   (declare (xargs :measure (+ (len xs) (len ys))))  
;   (if (consp xs)
;       (cons (first xs) (mux ys (rest xs)))
;       ys))
;(defun dmx (xys) ; too clever by half
;  (if (consp xys)
;      (let* ((x (first xys))
;             (ysxs (dmx (rest xys)))
;             (ys (first ysxs))
;             (xs (second ysxs)))
;        (list (cons x xs) ys))                      ; dmx1
;      (list xys xys)))                              ; dmx0

(defun dmx (xys)
  (if (consp (rest xys))      ; 2 or more elements?
      (let* ((x (first xys))
             (y (second xys))
             (xsys (dmx (rest (rest xys))))
             (xs (first xsys))
             (ys (second xsys)))
        (list (cons x xs) (cons y ys)))      ; dmx2
      (list xys nil)))  ; 1 element or none    dmx1

(defthmd dmx-preserves-length-thm
  (= (len xys)
     (+ (len (first (dmx xys)))
        (len (second (dmx xys))))))
(defthm mux-preserves-length-thm
  (= (len (mux xs ys))
     (+ (len xs) (len ys))))

(defun occurs-in (x xs)
   (and (consp xs)
        (or (equal x (first xs))
            (occurs-in x (rest xs)))))
(defthmd dmx-conservation-of-elements-thm
  (iff (occurs-in e xys)
       (or (occurs-in e (first (dmx xys)))
           (occurs-in e (second (dmx xys))))))
(defthm mux-conservation-of-elements-thm
             (iff (occurs-in e (mux xs ys))
                  (or (occurs-in e xs)
                      (occurs-in e ys))))
(defthm mux-inverts-dmx-thm
  (implies (true-listp xys)
           (equal (mux (first  (dmx xys))
                       (second (dmx xys)))
                  xys)))
(defthm dmx-inverts-mux-thm
  (implies (and (true-listp xs) (true-listp ys)
                (= (len xs) (len ys)))
           (equal (dmx (mux xs ys))
                  (list xs ys))))

(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)    
(defthm dmx-len-first
   (= (len (first (dmx xs)))
      (ceiling (len xs) 2)))
(defthm dmx-len-second
   (= (len (second (dmx xs)))
      (floor (len xs) 2)))
