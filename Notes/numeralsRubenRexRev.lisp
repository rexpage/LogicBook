
(include-book "arithmetic-3/top" :dir :system)
(include-book "arithmetic-3/floor-mod/floor-mod" :dir :system)

(defun prefix (n xs)
  (if (and (posp n) (consp xs))
      (cons (first xs) (prefix (- n 1) (rest xs)));{pfx1}
      nil))                                       ;{pfx0}

(defun bits (n)
  (if (zp n)
      nil                         ; bits0
      (cons (mod n 2)             ; bits1
            (bits (floor n 2)))))

(defun fin (xs)
  (if (consp (rest xs))
      (fin (rest xs)) ; {fin2}
      (first xs)))    ; {fin1}

(defthm hi-1
  (implies (posp n)
           (= (fin (bits n)) 1)))

(defun num (xs)
  (if (consp xs)
      (+ (first xs)
         (* 2 (num (rest xs))))
      0))

(defthm num-bits ; {bits-ok}
    (implies (natp n)
	     (= (num (bits n))
		n)))

(defun bit-list-p (xs)
  (if (consp xs)
      (and (or (= (car xs) 0)
	       (= (car xs) 1))
	   (bit-list-p (cdr xs)))
      t))

(defthm natp-num
    (implies (bit-list-p xs)
	     (natp (num xs)))
  :rule-classes (:type-prescription :rewrite))

(defthmd num-upper-bound-lemma ; {num-bnd-lemma}
    (implies (and (natp x)
		  (natp y)
		  (< x y))
	     (< (+ 1 (* 2 x))
		(* 2 y))))

(defthm num-upper-bound  ; {num-bnd}
    (implies (bit-list-p xs)
	     (< (num xs)
		(expt 2 (len xs))))
  :hints (("Subgoal *1/2"
	   :use ((:instance num-upper-bound-lemma
			    (x (num (cdr xs)))
			    (y (expt 2 (len (cdr xs)))))))))

(defthm bit-list-p-bits
    (bit-list-p (bits n)))

(defthmd num-lower-bound-lemma ; {num-lower-bnd-lemma}
    (implies (and (natp x)
		  (natp y)
		  (<= y x))
	     (<= (* 2 y)
		 (+ 1 (* 2 x)))))

(defthmd integerp-expt-1 ; {2^w is nat}
    (implies (> w 0)
	     (natp (expt 2 (+ -1 w)))))

(defthm num-lower-bound ; {num-lower-bnd}
    (implies (and (bit-list-p xs)
		  (= (fin xs) 1))
	     (>= (num xs)
                 (expt 2 (- (len xs) 1))))
  :hints (("Subgoal *1/3"
	   :use ((:instance num-lower-bound-lemma
			    (x (num (cdr xs)))
			    (y (expt 2 (+ -1 (len (cdr xs))))))
		 (:instance integerp-expt-1
			    (w (len (cdr xs)))))
	   ))
  )

;; (defthm expt-bits-n-lower-bound
;;     (implies (posp n)
;; 	     (<= (expt 2 (- (len (bits n)) 1)) n))
;;   :hints (("Goal" :do-not-induct t
;; 	   :use ((:instance num-lower-bound
;; 			    (xs (bits n)))))))

(defthmd expt-monotonic ; {2^n monotonic}
    (implies (and (natp x)
		  (natp y)
		  (<= x y))
	     (<= (expt 2 x) (expt 2 y))))

(defthmd len-bits-part1-lemma ; {2^n monotonic corollary}
    (implies (and (natp x)
		  (posp w)
		  (natp n)
		  (< n (expt 2 x))
		  (< x w))
	     (< n (expt 2 (+ -1 w))))
  :hints (("Goal"
	   :use ((:instance expt-monotonic
			    (x x)
			    (y (+ -1 w))))
	   :in-theory '(posp natp))))

(defthmd len-bits-part1 ; {converse-log-bits<=}
    (implies (and (natp w)
		  (natp n)
		  (< (len (bits n)) w))
	     (< n (expt 2 (1- w))))
  :hints (("Goal"
	   :use ((:instance num-upper-bound
			    (xs (bits n)))	
		 (:instance len-bits-part1-lemma
			    (x (len (bits n)))
			    (w w)
			    (n n))))))
	   

(defthmd len-bits-part2-lemma ; {n-min-lemma}
    (implies (and (posp x)
		  (natp w)
		  (natp n)
		  (>= n (expt 2 (+ -1 x)))
		  (> x w))
	     (>= n (expt 2 w)))
  :hints (("Goal"
	   :use ((:instance expt-monotonic
			    (x w)
			    (y (+ -1 x))))
	   :in-theory '(posp natp))))

(defthmd len-bits-part2 ; {n-min}
    (implies (and (natp w)
		  (posp n)
		  (> (len (bits n)) w))
	     (>= n (expt 2 w)))
  :hints (("Goal" :do-not-induct t
	   :use ((:instance num-lower-bound
			    (xs (bits n)))
		 (:instance len-bits-part2-lemma
			    (x (len (bits n)))
			    (w w)
			    (n n))))))

(defthm len-bits
  (implies (and (natp w)
		(natp n)
                (<= (expt 2 (- w 1)) n)
		(< n (expt 2 w)))
           (= (len (bits n)) w))
  :hints (("Goal"
	   :use ((:instance len-bits-part1)
		 (:instance len-bits-part2)))))


(defthm div-mod
  (implies (and (posp a) (posp b) (natp n))
           (= (mod (* a n) (* a b))
              (* a (mod n b)))))

#|
(defthm num-app
    (= (num (append xs ys))
       (+ (num xs)
	  (* (expt 2 (len xs))
	     (num ys)))))

(defthm append-prefix-nthcdr
    (implies (and (natp w) 
		  (<= w (len xs))
		  (true-listp xs)) 
	     (equal (append (prefix w xs) (nthcdr w xs)) xs)))
|#

(defthm pfx-mod-lemma ; {split-bits-lemma}
    (implies (and (natp w)
		  (>= (len xs) w)
		  (true-listp xs))
	     (equal (+ (num (prefix w xs))
		       (* (expt 2 w)
			  (num (nthcdr w xs))))
		    (num xs))))  

(defthm pfx-mod-lemma-2 ; {split-bits}
  (implies (and (natp w) (natp n) (true-listp (bits n))
                (>= (len (bits n)) w))
           (let* ((lo (prefix w (bits n)))
                  (hi (nthcdr w (bits n))))
             (= (+ (num lo) (* (expt 2 w) (num hi)))
		(num (bits n))))))

(defthmd mod-simplification ; {remainder}
 (implies (and (natp a)
	       (natp b)
	       (natp w))
	  (equal (mod (+ a (* w b)) w)
		 (mod a w))))

(defthm prefix-preserves-bit-listp ; {pfx-preserves-bit-listp}
    (implies (bit-list-p xs)
	     (bit-list-p (prefix w xs)))
  :rule-classes (:type-prescription
		 :rewrite))

(defthm nthcdr-preserves-bit-listp ; {sfx-preserves-bit-listp}
    (implies (bit-list-p xs)
	     (bit-list-p (nthcdr w xs)))
  :rule-classes (:type-prescription
		 :rewrite))

(defthm pfx-mod-lemma-3 ; {pfx-mod-long-lemma-lemma}
    (implies (and (natp w)
		  (natp n)
		  (<= w (len (bits n))))
	     (= (mod (num (prefix w (bits n))) (expt 2 w))
		(mod n (expt 2 w))))
  :hints (("Goal"
	   :use ((:instance pfx-mod-lemma-2)
		 (:instance mod-simplification
			    (a (num (prefix w (bits n))))
			    (b (num (nthcdr w (bits n))))
			    (w (expt 2 w))))
	   :in-theory (disable pfx-mod-lemma pfx-mod-lemma-2))))

(defthm prefix-vacuous ; {pfx-vacuous}
    (implies (and (true-listp xs)
		  (natp w)
		  (< (len xs) w))
	     (equal (prefix w xs) xs)))

(defthm pfx-mod-lemma-4 ; {pfx-mod-short}
    (implies (and (natp w)
		  (natp n)
		  (<= (len (bits n)) w))
	     (= (mod n (expt 2 w)) n))	
  :hints (("Goal" 
	   :use ((:instance num-upper-bound (xs (bits n))))
	   :in-theory (disable num-upper-bound))))


(defthm len-prefix
    (implies (natp w) 
	     (<= (len (prefix w xs)) w)))

(defthm num-prefix ; {num-pfx-bnd}
    (implies (and (natp w)
		  (bit-list-p xs))
	     (< (num (prefix w xs))
		(expt 2 w)))
  :hints (("Goal"
	   :do-not-induct t
	   :use ((:instance num-upper-bound
			    (xs (prefix w xs)))
		 (:instance expt-monotonic
			    (x (len (prefix w xs)))
			    (y w))
		 )
	   :in-theory (disable num-upper-bound 
			       EXPT-IS-WEAKLY-INCREASING-FOR-BASE->-1
			       SIMPLIFY-PRODUCTS-GATHER-EXPONENTS-<)
	   )))
		  
(defthm pfx-mod-lemma-5 ; {pfx-constrains-len-bits}
    (implies (and (natp w)
		  (bit-list-p xs))
	     (<= (len (bits (num (prefix w xs))))
		 w))
  :hints (("Goal"
	   :use ((:instance num-prefix)
		 (:instance len-bits-part2 
			    (w w)
			    (n (num (prefix w xs)))))
	   :in-theory (disable num-prefix)
	   )))


(defthm pfx-mod-lemma-6 ; {pfx-mod-long-lemma}
    (implies (and (natp w)
		  (natp n)
		  (>= (len (bits n)) w))
	     (equal (mod (num (prefix w (bits n))) (expt 2 w))
		    (num (prefix w (bits n)))))
  :hints (("Goal"
	   :use ((:instance pfx-mod-lemma-4
			    (w w)
			    (n (num (prefix w (bits n)))))
		 )
	   :in-theory (disable pfx-mod-lemma-4)
	   )))

(defthm pfx-mod-lemma-7 ; {pfx-mod-long}
    (implies (and (natp w)
		  (natp n)
		  (>= (len (bits n)) w))
	     (equal (num (prefix w (bits n)))
		    (mod n (expt 2 w))))
  :hints (("Goal"
	   :do-not-induct t
	   :use ((:instance pfx-mod-lemma-3)
		 (:instance pfx-mod-lemma-4
			    (w w)
			    (n (num (prefix w (bits n))))))
	   :in-theory (disable pfx-mod-lemma-4))))


(defthm pfx-mod
  (implies (and (natp w) (natp n))
           (= (num (prefix w (bits n)))
              (mod n (expt 2 w))))
  :hints (("Goal"
	   :do-not-induct t
	   :cases ((<= w (len (bits n))))))
  )
