(in-package "ACL2")
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)
(defun prefix (n xs)
  (if (and (posp n) (consp xs))
      (cons (first xs) (prefix (- n 1) (rest xs)));{pfx1}
      nil))                                       ;{pfx0}
(defun rep (n x)
  (if (zp n)
      nil
      (cons x (rep (- n 1) x))))
(defun pad (n x xs)
  (let* ((padding (- n (len xs))))
    (if (natp padding)
        (append xs (rep padding x)) ; {pad+}
        (prefix n xs))))            ; {pad-}
(defun bitp (x)
  (or (= x 0) (= x 1)))
(defun bit-listp (xs)
  (if (consp xs)
      (and (bitp (first xs))
           (bit-listp (rest xs)))
      (equal xs nil)))
(defun num (xs)
  (if (consp xs)
      (+ (first xs)
         (* 2 (num (rest xs))))
      0))
(defun bits (n)
  (if (zp n)
      nil                         ; bits0
      (cons (mod n 2)             ; bits1
            (bits (floor n 2)))))
(defun twos (w n)
  (if (< n 0)
      (+ n (expt 2 w))     ; {2s-neg}
      (pad w 0 (bits n)))) ; {2s-pos}