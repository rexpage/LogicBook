
(include-book "arithmetic-3/top" :dir :system)

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
(defun padOLD (n x xs)
 (if (zp n)
     nil
     (if (consp xs)
         (cons (first xs)
               (padOLD (- n 1) x (rest xs)))
         (cons x (padOLD (- n 1) x nil)))))

(defthmd pad-lenOLD
  (implies (natp n)
           (= (len (padOLD n x xs))
              n)))

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
  (if (and (posp n) (consp xs))
      (cons (first xs) (prefix (- n 1) (rest xs)));{pfx1}
      nil))                                       ;{pfx0}
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

(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun bits (n)
  (if (zp n)
      nil                         ; bits0
      (cons (mod n 2)             ; bits1
            (bits (floor n 2)))))
(defun twos (w n)
  (if (< n 0)
      (+ n (expt 2 w))     ; {2s-neg}
      (pad w 0 (bits n)))) ; {2s-pos}

(defun fin (xs)
  (if (consp (rest xs))
      (fin (rest xs)) ; {fin2}
      (first xs)))    ; {fin1}

(defthm hi-1
  (implies (posp n)
           (= (fin (bits n)) 1)))

(defun num (xs)
  (if (consp xs)
      (+ (first xs)
         (* 2 (num (rest xs))))
      0))

;(defthm leading-0
;  (implies (natp n)
;           (= (num (append (bits n) (list 0)))
;              (num (bits n)))))

(defthm leading-0s
  (implies (and (natp n) (natp z))
           (= (num (bits n))
              (num (append (bits n) (rep z 0))))))

