(in-package "ACL2")
(defun up (xs) ; (up (x1 x2 x3 ...)) = x1 <= x2 <= x3 ...
  (or (not (consp (rest xs)))          ; (len xs) < 2
      (and (<= (first xs) (second xs)) ; x1 <= x2
           (up (rest xs)))))           ; x2 <= x3 <= x4 ...
(defun occurs-in (x xs)
   (and (consp xs)
        (or (equal x (first xs))
            (occurs-in x (rest xs)))))