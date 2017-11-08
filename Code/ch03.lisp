(include-book "doublecheck" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)

(defun reciprocals (n)
  (if (zp n)
      0
      (+ (reciprocals (- n 1)) (/ 1 n))))

(defproperty reciprocals-test
  (n :value (random-natural))
  (= (reciprocals n)
     (if (= n 0)
         0
         (+ (reciprocals (- n 1)) (/ 1 n)))))

(check-expect (mod 12 2) 0)
(check-expect (mod 27 2) 1)

(check-expect (mod 14 3) 2)
(check-expect (mod  7 3) 1)
(check-expect (mod 18 3) 0)

(defproperty mod-test
  (divisor-1         :value (random-natural)
   dividend-divisor  :value (random-natural))
  (let* ((divisor  (+ divisor-1 1))
         (dividend (+ dividend-divisor divisor)))
    (= (mod dividend divisor)
       (mod (- dividend divisor) divisor))))

(defproperty mod-upper-limit-test
  (divisor-1         :value (random-natural)
   dividend-divisor  :value (random-natural))
  (let* ((divisor  (+ divisor-1 1))
         (dividend (+ dividend-divisor divisor)))
    (< (mod dividend divisor) divisor)))

(defproperty mod-range-test
  (divisor-1         :value (random-natural)
   dividend-divisor  :value (random-natural))
  (let* ((divisor  (+ divisor-1 1))
         (dividend (+ dividend-divisor divisor)))
    (and (natp (mod dividend divisor))
         (< (mod dividend divisor) divisor))))

(defproperty quotient-upper-limit-test
  (divisor-1         :value (random-natural)
   dividend-divisor  :value (random-natural))
  (let* ((divisor  (+ divisor-1 1))
         (dividend (+ dividend-divisor divisor)))
    (= (+ (* divisor (floor dividend divisor))
          (mod dividend divisor))
       dividend)))

(defproperty division-test
  (divisor-1         :value (random-natural)
   dividend-divisor  :value (random-natural))
  (let* ((divisor  (+ divisor-1 1))
         (dividend (+ dividend-divisor divisor)))
    (= (+ (* divisor (floor dividend divisor))
          (mod dividend divisor))
       dividend)))