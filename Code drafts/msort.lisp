(include-book "sort-predicates")

(defun dmx (xys)      ; xys = (x1 y1 x2 y2 x3 y3 ...)
  (if (consp xys)
      (mv-let (ys xs) ; ((y1 y2 ...)(x2 x3 ...))
              (dmx (rest xys))
        (mv (cons (first xys) xs) ys)) ; {dmx1}
      (mv nil nil)))                   ; {dmx0}
(defthm dmx-len-thm
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
(defthm mrg-len-thm
  (= (len (mrg xs ys)) (+ (len xs) (len ys))))

(defthm dmx-shortens-list-lemma ; to help ACL2 admit msort
  (implies (consp (rest xs))
           (mv-let (odds evns)
                   (dmx xs)
              (and (< (len odds) (len xs))
                   (< (len evns) (len xs))))))
(defun msort (xs)
  (declare (xargs
            :measure (len xs)
            :hints (("Goal"
                    :use ((:instance dmx-shortens-list-lemma))))))
  (if (consp (rest xs))   ; (len xs) > 1?
      (mv-let (odds evns) ; (len xs) > 1
              (dmx xs)
        (mrg (msort odds) (msort evns)))    ; {msrt2}
      xs))                ; (len xs) <= 1     {msrt1}                       

(defthm mrg-order-thm
  (implies (and (up xs) (up ys))
           (up (mrg xs ys))))
(defthmd mrg-val-thm
  (iff (occurs-in e (mrg xs ys))
       (or (occurs-in e xs) (occurs-in e ys))))
(defthm msort-order-thm
  (up (msort xs)))
(defthm msort-len-lemma-base-case
  (implies (not (consp (rest xs)))
           (= (len (msort xs)) (len xs))))
(defthm msort-len-lemma-inductive-case
  (= (len (msort (cons x xs)))
     (1+ (len (msort xs)))))
(defthm msort-len-thm
  (= (len (msort xs)) (len xs)))
(defthm msort-val-thm
  (iff (occurs-in e xs)
       (occurs-in e (msort xs)))
  :hints (("Goal"
         :use ((:instance dmx-val-thm
                          (xys xs))
               (:instance mrg-val-thm
                          (xs (first(dmx xs))) (ys (second(dmx xs))))))))

(defun rep (n x)
   (if (zp n)
       nil
       (cons x (rep (1- n) x))))