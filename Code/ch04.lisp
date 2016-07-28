(include-book "doublecheck" :dir :teachpacks)
;
;(defproperty len-test
;  (xs :value (random-list-of (random-natural)))
;  (= (len xs)
;     (if (consp xs)
;         (+ 1 (len (rest xs)))
;         0)))
;
;(defproperty append-test
;  (xs :value (random-list-of (random-natural))
;   ys :value (random-list-of (random-natural)))
;  (equal (append xs ys)
;         (if (consp xs)
;             (cons (first xs)
;                   (append (rest xs) ys))
;             ys)))

(defproperty additive-law-of-concatenation-tst
    (xs :value (random-list-of (random-natural))
     ys :value (random-list-of (random-natural)))
  (= (len (append xs ys))
     (+ (len xs) (len ys))))

(include-book "arithmetic/top" :dir :system)
(defthmd append-suffix-thm
  (equal (nthcdr (len xs) (append xs ys))
         ys))

(defun prefix (n xs)
  (if (and (posp n)
           (consp xs))
      (cons (first xs)                 ; {pfx1}
            (prefix (- n 1) (rest xs)))
      nil))                            ; {pfx0}

(defthmd prefix-thm
  (equal (prefix n xs)
         (if (and (posp n)
                  (consp xs))
             (cons (first xs)                 ; {pfx1}
                   (prefix (- n 1) (rest xs)))
             nil)))                           ; {pfx0}

