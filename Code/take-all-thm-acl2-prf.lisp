(include-book "arithmetic-3/top" :dir :system)

(defun prefix (n xs)
   (if (and (posp n) (consp xs))
       (cons (first xs) (prefix (- n 1) (rest xs))) ; {pfx1}
       nil))                                         ; {pfx0}

(defthm take-all-thm
   (implies (true-listp xs)
            (equal (prefix (len xs) xs)
                   xs)))
