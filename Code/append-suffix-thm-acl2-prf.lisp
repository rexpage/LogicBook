(include-book "arithmetic-3/top" :dir :system)
(defthmd append-suffix-thm
  (equal (nthcdr (len xs) (append xs ys))
         ys))
