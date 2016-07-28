(include-book "doublecheck" :dir :teachpacks)

(defun dmx (xys)      ; xys = (x1 y1 x2 y2 x3 y3 ...)
  (if (consp xys)
      (mv-let (ys xs) ; ((y1 y2 ...)(x2 x3 ...))
              (dmx (rest xys))
        (mv (cons (first xys) xs) ys)) ; {dmx1}
      (mv nil nil)))                   ; {dmx0}

(defproperty dmx-shortens-list
  (xs :value (random-list-of (random-natural))
      :where (consp (rest xs)))
  (mv-let (odds evns)
          (dmx xs)
    (and (< (len odds) (len xs))
         (< (len evns) (len xs)))))
(defproperty dmx-preserves-len
  (xs :value (random-list-of (random-natural)))
  (mv-let (odds evns)
          (dmx xs)
    (= (+ (len odds) (len evns))
       (len xs))))

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

(defproperty merge-preserves-len
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (= (len (mrg xs ys)) (+ (len xs) (len ys))))

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

(defun insert (x xs) ; assume x1 <= x2 <= x3 ...
  (if (and (consp xs) (> x (first xs)))
      (cons (first xs) (insert x (rest xs))) ; {ins2}
      (cons x xs)))                          ; {ins1}
(defun isort (xs)
  (if (consp (rest xs)) ; (len xs) > 1?
      (insert (first xs) (isort (rest xs))) ; {isrt2}
      xs))              ; (len xs) <= 1     ; {isrt1}

(defun up (xs) ; (up (x1 x2 x3 ...)) = x1 <= x2 <= x3 ...
  (or (not (consp (rest xs)))          ; (len xs) < 2
      (and (<= (first xs) (second xs)) ; x1 <= x2
           (up (rest xs)))))           ; x2 <= x3 <= x4 ...

(defproperty isort-sorts
  (xs :value (random-list-of (random-natural)))
  (up (isort xs)))
(defproperty isort-preserves-len
  (xs :value (random-list-of (random-natural)))
  (= (len (isort xs)) (len xs)))
(defproperty isort-conservation-of-values
  (xs :value (random-list-of (random-natural))
   e  :value (random-natural))
  (iff (member-equal e xs) (member-equal e (isort xs))))

(defun partial-sums (s xs)
  (if (consp xs)
      (let* ((s+x (+ s (first xs))))
        (cons s+x (partial-sums s+x (rest xs))))
      xs))
(defrandom random-increasing ()
  (partial-sums 0 (random-list-of (random-natural))))
(defproperty mrg-preserves-order
  (xs :value (random-increasing)
      :where (up xs)
   ys :value (random-increasing)
      :where (up ys))
  (implies (and (up xs) (up ys))
           (up (mrg xs ys))))
(defproperty msort-sorts-base-case
  (xs :value (random-list-of (random-natural)
              :size (random-between 0 1))
      :where (not (consp (rest xs))))
  (up (msort xs)))
(defproperty msort-sorts
  (xs :value (random-list-of (random-natural)))
  (up (msort xs)))
(defproperty msort-preserves-len-base-case
  (xs :value (random-list-of (random-natural)
              :size (random-between 0 1))
      :where (not (consp (rest xs))))
  (= (len (msort xs)) (len xs)))
(defproperty msort-preserves-len-inductive-case
  (x  :value (random-natural)
   xs :value (random-list-of (random-natural)))
  (= (len (msort (cons x xs)))
     (1+ (len (msort xs)))))
(defproperty msort-preserves-len
  (xs :value (random-list-of (random-natural)))
  (= (len (msort xs)) (len xs)))
;(defproperty mrg-conservation-of-values
;  (xs :value (random-list-of (random-natural))
;   ys :value (random-list-of (random-natural))
;   e  :value (random-natural))
;  (iff (member-equal e (mrg xs ys))
;       (or (member-equal e xs) (member-equal e xs))))
(defproperty msort-conservation-of-values
  (xs :value (random-list-of (random-natural))
   e  :value (random-natural))
  (iff (member-equal e xs)
       (member-equal e (msort xs))))

(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(defun log2 (n)
  (if (posp (- n 2))
      (1+ (log2 (floor n 2)))
      0))

(defun S (n)
  (if (posp (- n 1))
      (+ (S (floor (+ n 1) n))      ; {S2}
         (S (floor n 2))
         (* 23 n)
         51)
      3))                           ; {S1}

(defun S-diff (n)
  (- (* 40 n (log2 n))
     (S n)))
(defproperty random-cases-merge-is-nlogn
  (n :value (random-natural))
  (> (S-diff (+ n 6)) 0))
(defun n-to-0 (n) ; (n n-1 n-2 ... 1)
  (if (zp n)
      (list 0)
      (cons n (n-to-0 (1- n)))))
(defun list-diffs (ns)
  (if (consp ns)
      (cons (S-diff (+ (car ns) 6))
            (list-diffs (cdr ns)))
      nil))
(defun list-base-cases ()
  (list-diffs (n-to-0 44)))
(defun all-positive? (xs)
  (or (not (consp xs))
      (and (> (car xs) 0) (all-positive? (cdr xs)))))
(defun all-base-cases ()
  (all-positive? (list-base-cases)))