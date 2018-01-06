(in-package "ACL2")
(include-book "testing" :dir :teachpacks)
(include-book "doublecheck" :dir :teachpacks)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun dgts (n)
  (if (zp n)
      nil                                     ; {dgts0}
      (cons (mod n 10) (dgts (floor n 10))))) ; {dgts1}

(check-expect (dgts 1215) (list 5 1 2 1))
(check-expect (dgts 1964) (list 4 6 9 1))
(check-expect (dgts 12345) (list 5 4 3 2 1))
(check-expect (dgts 0) nil)

(defproperty dgts-last-digit-tst
  (n-1 :value (random-natural))
  (let* ((n (+ n-1 1))) ; avoid n=0
    (= (first (dgts n))
       (mod n 10))))
(defproperty dgts-other-digits-tst
  (n-1 :value (random-natural))
  (let* ((n (+ n-1 1))) ; avoid n=0
    (equal (rest (dgts n))
           (dgts (floor n 10)))))

(defun nmb10 (xs)
  (if (consp xs)
      (+ (first xs) (* 10 (nmb10 (rest xs)))) ; {n10.1}
      0))                                     ; {n10.0}
