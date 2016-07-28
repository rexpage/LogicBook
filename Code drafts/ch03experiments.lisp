(defun h (n)
  (if (zp n)
      0
      (+ (/ 1 n) (h (- n 1)))))
;(defun f (n)
;  (if (zp n)
;      0
;      (if (= n 1)
;          1
;          (+ (f (- n 1))
;             (f (- n 2))))))
(defun fac (n)
  (if (= n 0)
      1
      (* n (fac (- n 1)))))
(defun f (n)
  (if (posp (- n 1))
      (+ (f (- n 1)) (f (- n 2)))
      1))

(defun ns (n)
  (if (zp n)
      nil
      (cons n (ns (- n 1)))))
