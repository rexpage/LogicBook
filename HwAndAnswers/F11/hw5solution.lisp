;;; Homework 5 solutions
(include-book "doublecheck" :dir :teachpacks)

;; (1) Ex 23

(defproperty floor-is-natural-when-operands-are-natural
  (divisor :value (+ 1 (random-natural))
   dividend :value (random-natural))
  (natp (floor dividend divisor)))

;; (2) Ex 24

(defproperty max-greater-than-or-equal-to-args
  (x :value (random-rational)
   y :value (random-rational))
  (and (>= (max x y) x)
       (>= (max x y) y)))

;; (3) Ex 25

(defproperty distributive-law
  (x :value (random-number)
   y :value (random-number)
   z :value (random-number))
  (= (* x (+ y z))
     (+ (* x y) (* x z))))

;; (4) Ex 26

(defproperty mod-distributes-over-plus
  (x :value (random-natural)
   y :value (random-natural)
   m :value (random-natural))
  (equal (mod (+ x y) m)
         (mod (+ (mod x m) (mod y m)) m)))

(defproperty mod-distributes-over-minus
  (x :value (random-natural)
   y :value (random-natural)
   m :value (random-natural))
  (equal (mod (- x y) m)
         (mod (- (mod x m) (mod y m)) m)))

(defproperty mod-distributes-over-times
  (x :value (random-natural)
   y :value (random-natural)
   m :value (random-natural))
  (equal (mod (* x y) m)
         (mod (* (mod x m) (mod y m)) m)))