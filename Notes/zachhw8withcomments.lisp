(defun natfix (x)
  (if (natp x)
      x
      0))
(defun sum-nats (xs)
  (if (consp xs)
      (+ (natfix (first xs)) (sum-nats (rest xs)))
  0))
(defun max-nats (x y)
  (let* ((a (natfix x)) (b (natfix y)))
    (if (> a b)
        a
        b)))
(defthm sumnats-is-nats
  (natp (sum-nats xs)))
(defthm max-nats-nat
  (natp (max-nats x y)))
(defthm len-cdr
  (implies (consp xs)
           (< (len (rest xs)) (len xs)))) ; was: (< (len xs) (len (rest xs))))

;(defthm rest-reduces-sum-lens ; ACL2 proves this, but it doesn't help
;  (implies (or (consp xs) (consp ys))
;           (<  (+ (len(rest xs)) (len(rest ys))) (+ (len xs) (len ys)))))
; Zach's maxes:
(defun maxes (xs ys)
  (declare (xargs :measure (+ (len xs) (len ys))))
  (if (or (consp xs) (consp ys))
      (cons (max-nats (first xs) (first ys)) (maxes (rest xs) (rest ys)))
      nil))

;(defun maxes (xs ys) ; ACL2 automatically admits this definition of maxes
;  (if (and (consp xs) (consp ys))
;      (cons (max-nats (first xs) (first ys)) (maxes (rest xs) (rest ys)))
;      (if (consp xs)
;          xs
;          ys)))

(include-book "doublecheck" :dir :teachpacks)
(defproperty maxes-exceeds
  (xs :value (random-list-of (random-natural))
   ys :value (random-list-of (random-natural)))
  (not (or (< (sum-nats (maxes xs ys)) (sum-nats xs)) 
           (< (sum-nats (maxes xs ys)) (sum-nats ys)))))
