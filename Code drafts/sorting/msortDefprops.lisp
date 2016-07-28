(include-book "doublecheck" :dir :teachpacks)
(include-book "sort-predicates")

(defun dmx (xys)      ; xys = (x1 y1 x2 y2 x3 y3 ...)
  (if (consp xys)
      (mv-let (ys xs) ; ((y1 y2 ...)(x2 x3 ...))
              (dmx (rest xys))
        (mv (cons (first xys) xs) ys)) ; {dmx1}
      (mv nil nil)))                   ; {dmx0}
(defproperty dmx-len-thm
  (xs :value (random-list-of (random-natural)))
  (mv-let (odds evns)
          (dmx xs)
    (= (+ (len odds) (len evns))
       (len xs))))
(defthmd dmx-val-thm
  (iff (occurs-in e xys)
       (or (occurs-in e (first (dmx xys)))
           (occurs-in e (second (dmx xys))))))

(defun mrg (xs ys)
  (declare (xargs :measure (+ (len xs) (len ys))))
  (if (and (consp xs) (consp ys))
      (let* ((x (first xs)) (y (first ys)))
        (if (<= x y)
            (cons x (mrg (rest xs) ys))   ; {x<=y}
            (cons y (mrg xs (rest ys))))) ; {y<x}
      (if (not (consp ys))
          xs     ; ys is empty            ; {mg0}
          ys)))  ; xs is empty            ; {mg1}
(defproperty mrg-len-thm
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (= (len (mrg xs ys)) (+ (len xs) (len ys))))

(defthm dmx-shortens-list ; lemma to help ACL2 admit def'n of msort
  (implies (consp (rest xs))
           (mv-let (odds evns)
                   (dmx xs)
              (and (< (len odds) (len xs))
                   (< (len evns) (len xs))))))
(defun msort (xs)
  (declare (xargs
            :measure (len xs)
            :hints (("Goal"
                    :use ((:instance dmx-shortens-list))))))
  (if (consp (rest xs))   ; (len xs) > 1?
      (mv-let (odds evns) ; (len xs) > 1
              (dmx xs)
        (mrg (msort odds) (msort evns)))    ; {msrt2}
      xs))                ; (len xs) <= 1     {msrt1}                       

(defproperty mrg-order-thm
  (xs :value (random-increasing-list)
      :where (up xs)
   ys :value (random-increasing-list)
      :where (up ys))
  (implies (and (up xs) (up ys))
           (up (mrg xs ys))))
(defproperty msort-order-thm-base-case
  (zero-or-one :value (random-between 0 1)
   xs :value (random-natural-list-of-length zero-or-one)
      :where (not (consp (rest xs))))
  (up (msort xs)))
(defproperty msort-order-thm
  (xs :value (random-list-of (random-natural)))
  (up (msort xs)))
(defproperty msort-len-thm-base-case
  (zero-or-one :value (random-between 0 1)
   xs :value (random-natural-list-of-length zero-or-one)
      :where (not (consp (rest xs))))
  (= (len (msort xs)) (len xs)))
(defproperty msort-len-thm-inductive-case
  (x  :value (random-natural)
   xs :value (random-list-of (random-natural)))
  (= (len (msort (cons x xs)))
     (1+ (len (msort xs)))))
(defproperty msort-len-thm
  (xs :value (random-list-of (random-natural)))
  (= (len (msort xs)) (len xs)))
;(defproperty mrg-val-thm
;  (xs :value (random-list-of (random-natural))
;   ys :value (random-list-of (random-natural))
;   e  :value (random-natural))
;  (iff (occurs-in e (mrg xs ys))
;       (or (occurs-in e xs) (occurs-in e ys))))
(defthmd mrg-val-thm
  (iff (occurs-in e (mrg xs ys))
       (or (occurs-in e xs) (occurs-in e ys))))
;(defproperty msort-conservation-of-values
;  (xs :value (random-list-of (random-natural))
;   e  :value (random-natural))
;  (iff (occurs-in e xs)
;       (occurs-in e (msort xs))))
(defthm msort-val-thm
  (iff (occurs-in e xs)
       (occurs-in e (msort xs)))
  :hints (("Goal"
         :use ((:instance dmx-val-thm)
               (:instance mrg-val-thm)))))

