(include-book "arithmetic-3/top" :dir :system)
(defun fib(n) ; n-th Fibonacci number
  (if (posp (- n 1))                      ; n > 1
      (+ (fib(- n 1)) (fib(- n 2)))       ; {fib2}
      n))                                 ; {fib1}
(defun gib (n b a)  ; b = (fib(n-1)), a=(fib(n-2))
   (if (posp (- n 1))                     ; n > 1
       (gib (- n 1) (+ b a) b)            ; {gib2}
       (if (= n 1)
           b                              ; {gib1}               
           a)))                           ; {gib0}
(defun fib-fast (n)         ; (fib-fast n)=(fib n)
   (gib n 1 0))             ; (fib 1)=1, (fib 0)=0
(defthm gib-base-equation            ; a la {fib1}
    (= (gib 1 b a) b))
(defthm gib-inductive-equation       ; a la {fib2}
    (implies (posp (- n 1))              ; n > 1
             (= (gib n b a)              ; n-th
                (+ (gib (- n 1) b a)     ; (n-1)th
                   (gib (- n 2) b a))))) ; (n-2)th
(defthm fib=fib-fast ; (fib-fast n) = (fib n)
    (implies (natp n)
             (= (fib n) (fib-fast n))))
