(defun mux (xs ys)
  (if (not (consp xs))
      ys                                             ; mux0
      (if (not (consp ys))
          xs                                         ; mux10
          (cons (first xs)
                (cons (first ys)
                      (mux (rest xs) (rest ys))))))) ; mux11
;(defun mux (xs ys) ; this is clever, but needs a hint and dmx-inverts-mux fails
;   (declare (xargs :measure (+ (len xs) (len ys))))  
;   (if (consp xs)
;       (cons (first xs) (mux ys (rest xs)))
;       ys))
(defun dmx (xys)
  (if (not (consp xys))
      (list xys xys)                                 ; dmx0
      (let* ((x (first xys))
             (ysxs (dmx (rest xys)))
             (ys (first ysxs))
             (xs (second ysxs)))
        (list (cons x xs) ys))))                     ; dmx1

(defun in? (x xs)
   (if (consp xs)
       (or (equal x (first xs))
           (in? x (rest xs)))
       nil))
(defthmd dmx-preserves-length-thm
  (= (len xys)
     (+ (len (first (dmx xys)))
        (len (second (dmx xys))))))
(defthm mux-preserves-length-thm
  (= (len (mux xs ys))
     (+ (len xs) (len ys))))
(defthmd dmx-conservation-of-elements-thm
  (iff (member-equal e xys)
       (or (member-equal e (first (dmx xys)))
           (member-equal e (second (dmx xys))))))
(defthm mux-conservation-of-elements-thm
             (iff (member-equal e (mux xs ys))
                  (or (member-equal e xs)
                      (member-equal e ys))))
(defthm mux-inverts-dmx-thm
  (equal (mux (first  (dmx xys))
              (second (dmx xys)))
         xys))
(defthm dmx-inverts-mux-thm
  (implies (and (true-listp xs) (true-listp ys)
                (= (len xs) (len ys)))
           (equal (dmx (mux xs ys))
                  (list xs ys))))
(defun mrg (xs ys)
  (if (and (consp xs) (consp ys))
      (let* ((x (first xs)) (y (first ys)))
        (if (<= x y)
            (cons x (mrg (rest xs) ys))   ; {x<=y}
            (cons y (mrg xs (rest ys))))) ; {y<x}
      (if (not (consp ys))
          xs         ; note: ys is empty    ; {mg0}
          ys)))      ; note: xs is empty    ; {mg1}