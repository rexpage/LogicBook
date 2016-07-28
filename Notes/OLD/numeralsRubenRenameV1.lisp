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

(defthm num-bits
    (implies (natp x)
	     (= (num (bits x))
		x)))

(defun bit-listp (xs) ; true iff xs=list of 0s/1s
  (if (consp xs)
      (and (or (= (car xs) 0)
	       (= (car xs) 1))
	   (bit-listp (cdr xs)))
      t))

(defthm num-delivers-nat
    (implies (bit-listp xs)
	     (natp (num xs)))
  :rule-classes (:type-prescription :rewrite))

(defthmd x<y->2x+1<2y
    (implies (and (natp x)
		  (natp y)
		  (< x y))
	     (< (+ 1 (* 2 x))
		(* 2 y))))

(defthm num_xs<2^len_xs
    (implies (bit-listp xs)
	     (< (num xs)
		(expt 2 (len xs))))
  :hints (("Subgoal *1/2"
	   :use ((:instance x<y->2x+1<2y
			    (x (num (cdr xs)))
			    (y (expt 2 (len (cdr xs)))))))))

(defthm bits-delivers-bit-list
    (bit-listp (bits n)))

(defthmd x>=y->2x+1>=y
    (implies (and (natp x)
		  (natp y)
		  (<= y x))
	     (<= (* 2 y)
		 (+ 1 (* 2 x)))))

(defthmd 2^w>0
    (implies (posp w)
	     (posp (expt 2 (- w 1)))))

(defthm log2_num_xs>=len_xs-1
    (implies (and (bit-listp xs)
		  (= (fin xs) 1))
	     (<= (expt 2 (- (len xs) 1))
		 (num xs)))
  :hints (("Subgoal *1/3"
	   :use ((:instance x>=y->2x+1>=y
			    (x (num (cdr xs)))
			    (y (expt 2 (+ -1 (len (cdr xs))))))
		 (:instance 2^w>0
			    (w (len (cdr xs))))))))

(defthmd 2^n-monotonic
    (implies (and (natp x)
		  (natp y)
		  (<= x y))
	     (<= (expt 2 x) (expt 2 y))))


(defthmd len-bits-part1-lemma
    (implies (and (natp x)
		  (posp w)
		  (natp n)
		  (< n (expt 2 x))
		  (< x w))
	     (< n (expt 2 (+ -1 w))))
  :hints (("Goal"
	   :use ((:instance 2^n-monotonic
			    (x x)
			    (y (+ -1 w))))
	   :in-theory '(posp natp))))

(defthmd len-bits-part1
    (implies (and (natp w)
		  (natp n)
		  (< (len (bits n)) w))
	     (< n (expt 2 (1- w))))
  :hints (("Goal"
	   :use ((:instance num_xs<2^len_xs
			    (xs (bits n)))	
		 (:instance len-bits-part1-lemma
			    (x (len (bits n)))
			    (w w)
			    (n n))))))

(defthmd len-bits-part2-lemma
    (implies (and (posp x)
		  (natp w)
		  (natp n)
		  (<= (expt 2 (+ -1 x)) n)
		  (< w x))
	     (<= (expt 2 w) n))
  :hints (("Goal"
	   :use ((:instance 2^n-monotonic
			    (x w)
			    (y (+ -1 x))))
	   :in-theory '(posp natp))))

(defthmd len-bits-part2
    (implies (and (natp w)
		  (posp n)
		  (< w (len (bits n))))
	     (<= (expt 2 w) n))
  :hints (("Goal" :do-not-induct t
	   :use ((:instance log2_num_xs>=len_xs-1
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

(defthm pfx-mod-lemma
    (implies (and (natp w)
		  (<= w (len xs))
		  (true-listp xs))
	     (equal (+ (num (prefix w xs))
		       (* (expt 2 w)
			  (num (nthcdr w xs))))
		    (num xs))))  

(defthm pfx-mod-lemma-2
    (implies (and (natp w)
		  (natp n)
		  (<= w (len (bits n)))
		  (true-listp (bits n)))
	     (equal (+ (num (prefix w (bits n)))
		       (* (expt 2 w)
			  (num (nthcdr w (bits n)))))
		    (num (bits n)))))  

(defthmd mod-simplification
 (implies (and (natp a)
	       (natp b)
	       (natp w))
	  (equal (mod (+ a (* w b)) w)
		 (mod a w))))

(defthm prefix-preserves-bit-listp
    (implies (bit-listp xs)
	     (bit-listp (prefix w xs)))
  :rule-classes (:type-prescription
		 :rewrite))

(defthm nthcdr-preserves-bit-listp
    (implies (bit-listp xs)
	     (bit-listp (nthcdr w xs)))
  :rule-classes (:type-prescription
		 :rewrite))

(defthm pfx-mod-lemma-3
    (implies (and (natp w)
		  (natp n)
		  (<= w (len (bits n))))
	     (equal (mod (num (prefix w (bits n))) (expt 2 w))
		    (mod n (expt 2 w))))
  :hints (("Goal"
	   :use ((:instance pfx-mod-lemma-2)
		 (:instance mod-simplification
			    (a (num (prefix w (bits n))))
			    (b (num (nthcdr w (bits n))))
			    (w (expt 2 w))))
	   :in-theory (disable pfx-mod-lemma pfx-mod-lemma-2))))

(defthm prefix-vacuous
    (implies (and (true-listp xs)
		  (natp w)
		  (< (len xs) w))
	     (equal (prefix w xs) xs)))

(defthm pfx-mod-lemma-4
    (implies (and (natp w)
		  (natp n)
		  (<= (len (bits n)) w))
	     (= (mod n (expt 2 w)) n))	
  :hints (("Goal" 
	   :use ((:instance num_xs<2^len_xs (xs (bits n))))
	   :in-theory (disable num_xs<2^len_xs))))


(defthm len-prefix
    (implies (natp w) 
	     (<= (len (prefix w xs)) w)))

(defthm num-prefix
    (implies (and (natp w)
		  (bit-listp xs))
	     (< (num (prefix w xs))
		(expt 2 w)))
  :hints (("Goal"
	   :do-not-induct t
	   :use ((:instance num_xs<2^len_xs
			    (xs (prefix w xs)))
		 (:instance 2^n-monotonic
			    (x (len (prefix w xs)))
			    (y w))
		 )
	   :in-theory (disable num_xs<2^len_xs 
			       EXPT-IS-WEAKLY-INCREASING-FOR-BASE->-1
			       SIMPLIFY-PRODUCTS-GATHER-EXPONENTS-<))))
		  
(defthm pfx-mod-lemma-5
    (implies (and (natp w)
		  (bit-listp xs))
	     (<= (len (bits (num (prefix w xs))))
		 w))
  :hints (("Goal"
	   :use ((:instance num-prefix)
		 (:instance len-bits-part2 
			    (w w)
			    (n (num (prefix w xs)))))
	   :in-theory (disable num-prefix))))


(defthm pfx-mod-lemma-6
    (implies (and (natp w)
		  (natp n)
		  (<= w (len (bits n))))
	     (equal (mod (num (prefix w (bits n))) (expt 2 w))
		    (num (prefix w (bits n)))))
  :hints (("Goal"
	   :use ((:instance pfx-mod-lemma-4
			    (w w)
			    (n (num (prefix w (bits n)))))
		 )
	   :in-theory (disable pfx-mod-lemma-4)
	   )))

(defthm pfx-mod-lemma-7
    (implies (and (natp w)
		  (natp n)
		  (<= w (len (bits n))))
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
	   :cases ((<= w (len (bits n)))))))
