(include-book "sort-predicates")

(defun dmx (xys)
  (if (consp (rest xys))      ; 2 or more elements?
      (let* ((x (first xys))
             (y (second xys))
             (xsys (dmx (rest (rest xys))))
             (xs (first xsys))
             (ys (second xsys)))
        (list (cons x xs) (cons y ys)))      ; {dmx2}
      (list xys nil)))  ; 1 element or none  ; {dmx1}
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

(defthm dmx-shortens-list-thm ; lemma to help ACL2 admit def of msort
  (implies (consp (rest xs))
           (mv-let (odds evns)
                   (dmx xs)
              (and (< (len odds) (len xs))
                   (< (len evns) (len xs))))))
(defun msort (xs)
  (declare (xargs
            :measure (len xs)
            :hints (("Goal"
                    :use ((:instance dmx-shortens-list-thm))))))
  (if (consp (rest xs))      ; 2 or more elements?
      (let* ((splt (dmx xs))
             (odds (first splt))
             (evns (second splt)))
        (mrg (msort odds) (msort evns))) ; {msrt2}
      xs))             ; (len xs) <= 1   ; {msrt1}                      

(defthm mrg-order-thm
  (implies (and (up xs) (up ys))
           (up (mrg xs ys))))
(defthmd mrg-val-thm
  (iff (occurs-in e (mrg xs ys))
       (or (occurs-in e xs) (occurs-in e ys))))
(defthm msort-order-thm-base-case
  (up (msort xs)))
(defthm msort-order-thm
  (up (msort xs)))
(defthm msort-len-thm-base-case
  (implies (not (consp (rest xs)))
           (= (len (msort xs)) (len xs))))
(defthm msort-len-thm-inductive-case
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