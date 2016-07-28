(include-book "Doublecheck" :dir :teachpacks)

(defun reciprocals (n)
  (if (zp n)
      0
      (+ (reciprocals (- n 1)) (/ 1 n))))

(defthm reciprocals-thm
  (implies (natp n)
           (= (reciprocals n)
              (if (= n 0)
                  0
                  (+ (reciprocals (- n 1)) (/ 1 n))))))

(defproperty reciprocals-tests
  (n :value (random-natural))
  (= (reciprocals n)
     (if (= n 0)
         0
         (+ (reciprocals (- n 1)) (/ 1 n)))))
