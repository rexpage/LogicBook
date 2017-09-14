(defthm additive-law-of-concatenation-thm
   (= (len (append xs ys))
      (+ (len xs) (len ys))))
