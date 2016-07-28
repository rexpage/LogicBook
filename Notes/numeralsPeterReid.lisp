(include-book "arithmetic/top" :dir :system)

(defthmd nthcdr-axioms
  (equal (nthcdr n xs)
         (if (zp n)
             xs
             (nthcdr (- n 1) (rest xs)))))



(defthm drop-all0
  (= (+ (len (nthcdr (len xs) xs)))
     0))

(defthm drop-all
  (implies (natp n)
           (= (len (nthcdr (+ (len xs) n) xs))
              0)))


(defun rep (n x)
  (if (zp n)
      nil
      (cons x (rep (- n 1) x))))

(defthm rep-len
  (implies (natp n)
           (= (len (rep n x)) n)))



(defthmd rep-mem
  (implies (and (natp n)
                (member-equal y (rep n x)))
           (member-equal y (list x))))



(defun prefix (n xs)
  (if (and (posp n) (consp xs))                    ;{pfx1}
      (cons (first xs) (prefix (- n 1) (rest xs))) ;{pfx0}
      nil))

(defun pad (n x xs)
  (let* ((padding (- n (len xs))))
    (if (natp padding)
        (append xs (rep padding x)) ; {pad+}
        (prefix n xs))))            ; {pad-}



(defthm additive-law-of-concatenation
  (= (len (append xs ys))
     (+ (len xs) (len ys))))

(defthm app-pfx
  (implies (true-listp xs)
           (equal (prefix (len xs) (append xs ys))
                  xs)))

(defthm app-sfx
  (equal (nthcdr (len xs) (append xs ys))
         ys))

(defthm prefix-len
  (implies (and (natp n)
                (true-listp xs)
                (<= n (len xs)))
           (= (len (prefix n xs)) n)))

(defthm pad-len
  (implies (natp n)
           (= (len (pad n x xs)) n)))

; To make ACL2 admit bits, it needs to prove termination. That 
; means showing how floor behaves.
(include-book "arithmetic/idiv" :dir :system)
(defthm floor-2-decreases
  (implies (not (zp n))
           (< (floor n 2)
              n))
  :hints (("Goal" :use (:instance truncate-lower-bound (x n) (y 2))))
  :rule-classes (:linear :rewrite))

(defthm floor-positive
  (implies (natp n)
           (<= 0 (floor n 2)))
  :rule-classes (:linear :rewrite))

; To get the two rules above to apply, you need to disable floor.
; Otherwise, it gets expanded away and the rewriter doesn't see it.
(in-theory (disable floor))

(defun bits (n)
  (if (zp n)
      nil             ; bits0
    (cons (mod n 2)   ; bits1
          (bits (floor n 2)))))

(defun twos (w n)
  (if (< n 0)
      (pad w 0 (+ n (expt 2 w))) ; {2s-neg}
      (pad w 0 (bits n))))       ; {2s-pos}
