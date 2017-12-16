(include-book "doublecheck" :dir :teachpacks)
(include-book "binary-arith")

(defun add-1 (x)
  (if (and (consp x) (= (first x) 1))
      (cons 0 (add-1 (rest x)))      ; {add11}
      (cons 1 (rest x))))            ; {add10}

(defun add-c (c x)
  (if (= c 1)
      (add-1 x)  ; {addc1}
      x))        ; {addc0}

(defun add (c0 x y)
  (if (not (consp x))
      (add-c c0 y)                                   ; {add0y}
      (if (not (consp y))
          (add-c c0 x)                               ; {addx0}
          (let* ((x0 (first x))
                 (y0 (first y))
                 (a  (full-adder c0 x0 y0))
                 (s0 (first a))
                 (c1 (second a)))
            (cons s0 (add c1 (rest x) (rest y))))))) ; {addxy}

(defun mxy (x y) ; assumption: y is not nil
  (if (consp x)
      (let* ((p  (mxy (rest x) y)))             ; {mul.p}
        (if (= (first x) 1)
            (cons (first y) (add 0 p (rest y))) ; {mul1xy}
            (cons 0 p)))                        ; {mul0xy}
      nil))                                     ; {mul0y}

(defun mul (x y)
  (if (consp y)
      (mxy x y) ; {mulxy}
      nil))     ; {mulx0}

(defun add-tst (m n)
  (= (numb (add 0 (bits m) (bits n)))
     (+ m n)))
(defun mul-tst (m n)
  (= (numb (mul (bits m) (bits n)))
     (* m n)))

(defthm bignum-add-ok
  (= (numb(add c x y))
     (+ (numb (list c)) (numb x) (numb y))))

(defun fin (xs)
  (if (consp (rest xs))
      (fin (rest xs)) ; {fin2}
      (first xs)))    ; {fin1}
(defthm bignum-add-hi-order-bit-thm
  (implies (and (= (fin x) 1) (= (fin y) 1))
           (= (fin (add c0 x y)) 1)))
(defthm bignum-mul-ok
  (= (numb (mul x y)) (* (numb x) (numb y))))

(defproperty add-ok
  (c :value (random-between 0 1)
   x :value (random-list-of (random-between 0 1))
   y :value (random-list-of (random-between 0 1)))
  (= (numb (add c x y))
     (+ (numb (list c)) (numb x) (numb y))))
(defproperty mul-ok
  (x :value (random-list-of (random-between 0 1))
   y :value (random-list-of (random-between 0 1)))
  (= (numb (mul x y)) (* (numb x) (numb y))))