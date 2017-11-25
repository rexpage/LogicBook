(defthm append-associative-thm
   (equal (append xs (append ys zs))
          (append (append xs ys) zs)))
          