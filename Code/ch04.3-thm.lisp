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

(defthmd append-prefix-thm
  (implies (true-listp xs)
           (equal (prefix (len xs) (append xs ys))
                  xs)))

(defthmd append-associative-thm
  (implies (and (true-listp xs)
                (true-listp ys))
           (equal (append xs (append ys zs))  ; {app-assoc}
                  (append (append xs ys) zs))))
