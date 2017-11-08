(in-package "ACL2")
(include-book "testing" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun bits (n)
  (if (zp n)
      nil                                   ; {bits0}
      (cons (mod n 2) (bits (floor n 2))))) ; {bits1}
(defun numb (xs)
  (if (consp xs)
      (if (= (first xs) 1)
          (+ 1 (* 2 (numb (rest xs)))) ; {2numb+1}
          (* 2 (numb (rest xs))))      ; {2numb}
      0))                              ; {numb0}
(defun prefix (n xs)
   (if (and (posp n) (consp xs))
       (cons (first xs) (prefix (- n 1) (rest xs))) ; {pfx1}
       nil))                                        ; {pfx0}
(defun rep (n x)
  (if (posp n)
      (cons x (rep (- n 1) x))   ; {rep1}
      nil))                      ; {rep0}
(defun pad (n x xs)
  (let* ((padding (- n (len xs))))
    (if (natp padding)
        (append xs (rep padding x)) ; {pad+}
        (prefix n xs))))            ; {pad-}
(defun twos (w n)             ; w = word size
  (if (< n 0)                 ; -2^(w-1) <= n < 2^(w-1)
      (bits (+ (expt 2 w) n)) ; {2s-}
      (pad w 0 (bits n))))    ; {2s+}

(defthm nmb1
   (implies (consp xs)
            (= (+ (numb (list (first xs)))
                  (* 2 (numb (rest xs))))
               (numb xs))))

(defun and-gate (x y) (if (and (= x 1) (= y 1)) 1 0))
(defun or-gate (x y) (if (or (= x 1) (= y 1)) 1 0)) 
(defun xor-gate (x y) (if (and (= x 1) (= y 1)) 0 (or-gate x y)))
(defun half-adder (x y) (list (xor-gate x y) (and-gate x y)))
(defun full-adder (c-in x y)
  (let* ((h1 (half-adder x y))
         (s1 (first h1)) (c1 (second h1))
         (h2 (half-adder s1 c-in))
         (s  (first h2)) (c2 (second h2))
         (c  (or-gate c1 c2)))
    (list s c)))

(check-expect (full-adder 0 0 0) (list 0 0))
(check-expect (full-adder 0 0 1) (list 1 0))
(check-expect (full-adder 0 1 0) (list 1 0))
(check-expect (full-adder 0 1 1) (list 0 1))
(check-expect (full-adder 1 0 0) (list 1 0))
(check-expect (full-adder 1 0 1) (list 0 1))
(check-expect (full-adder 1 1 0) (list 0 1))
(check-expect (full-adder 1 1 1) (list 1 1))

(defthm full-adder-ok
  (= (numb (full-adder c-in x y))
     (+ (numb (list c-in)) (numb (list x)) (numb (list y)))))

(defun adder2 (c0 x y)
  (let* ((x0 (first x)) (x1 (second x))
         (y0 (first y)) (y1 (second y))
         (f0 (full-adder c0 x0 y0))
         (s0 (first f0)) (c1 (second f0))
         (f1 (full-adder c1 x1 y1))
         (s1 (first f1)) (c2 (second f1)))
    (list (list s0 s1) c2)))
(defthm adder2-ok
  (let* ((a (adder2 c0 (list x0 x1) (list y0 y1)))
         (s (first a)) (c (second a)))
    (= (numb (append s (list c)))
       (+ (numb(list c0)) 
          (numb (list x0 x1)) 
          (numb (list y0 y1))))))

(defun adder (c0 x y)
  (if (consp x)
      (let* ((x0 (first x)) (xs (rest x)) 
             (y0 (first y)) (ys (rest y))
             (a0 (full-adder c0 x0 y0)) 
             (s0 (first a0)) (c1 (second a0)) ; {add.bit0}
             (a  (adder c1 xs ys)) 
             (ss (first a)) (c (second a)))
        (list (cons s0 ss) c))                ; {add1}
      (list nil c0)))                         ; {add0}
(defthm adder-ok
  (implies (= (len x) (len y))
           (let* ((a (adder c0 x y))
                  (s (first a)) (c (second a)))
             (= (numb (append s (list c)))
                (+ (numb (list c0)) (numb x) (numb y))))))
