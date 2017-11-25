(include-book "arithmetic-3/top" :dir :system)
(defthm drop-all-len-thm
   (= (len (nthcdr (len xs) xs))
      0))
(defthm drop-all-thm
   (implies (true-listp xs)
            (equal (nthcdr (len xs) xs)
                   nil)))
