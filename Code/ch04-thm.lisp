(defthmd len-thm
  (= (len xs)
     (if (consp xs)
         (+ 1 (len (rest xs)))
         0)))

(defthmd len-is-natural-number-thm
  (natp (len xs)))

(defthmd consp<->len>0-thm
  (iff (> (len xs) 0) (consp xs)))

(defthmd append-thm
  (equal (append xs ys)
         (if (consp xs)
             (cons (first xs)
                   (append (rest xs) ys))
             ys)))

(defthmd append-additive-length
  (= (len (append xs ys))
     (+ (len xs) (len ys))))

(include-book "arithmetic/top" :dir :system)
(defthmd append-suffix-thm
  (equal (nthcdr (len xs) (append xs ys))
         ys))

(defthmd nthcdr-lemma
  (equal (nthcdr n nil)
         nil))

(in-theory (enable nthcdr-lemma))
(defthmd nthcdr-thm
  (implies (true-listp xs)
           (equal (nthcdr n xs)
                  (if (and (posp n) (consp xs))
                      (nthcdr (- n 1) (rest xs))
                      xs))))
