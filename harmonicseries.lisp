(include-book "doublecheck" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)

(defun reciprocals (n)
  (if (posp n)
      (+ (reciprocals (- n 1)) (/ 1 n))
      0))

(defproperty reciprocals-test
  (n :value (random-natural))
  (= (reciprocals n)
     (if (= n 0)
         0
         (+ (reciprocals (- n 1)) (/ 1 n)))))
