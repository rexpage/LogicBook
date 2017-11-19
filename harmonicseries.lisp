(include-book "doublecheck" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)

(defun h (n)
  (if (posp n)
      (+ (h (- n 1)) (/ 1 n))
      0))

(defproperty h-test
  (n :value (random-natural))
  (= (h n)
     (if (= n 0)
         0
         (+ (h (- n 1)) (/ 1 n)))))
