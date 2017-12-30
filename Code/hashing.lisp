(defun hash-op (hash-base chars)
   (if (consp chars)
       (+ (char-code (first chars))
          (* hash-base (hash-op hash-base (rest chars))))
       0))
(defun hash-key (hash-base wrd)
   (hash-op hash-base (coerce wrd 'list)))
(defun hash-idx (hash-base num-bkts wrd)
   (mod (hash-key hash-base wrd) num-bkts))
(defun rep (n x)
  (if (posp n)
  (cons x (rep (- n 1) x)) ; {rep1}
  nil))                    ; {rep0}
(defun bump-bkt (idx bkts)
   (if (posp idx)
       (cons (first bkts)
             (bump-bkt (- idx 1) (rest bkts)))
       (cons (+ 1 (first bkts)) (rest bkts))))
(defun fill-bkt-counts (hash-base num-bkts bkts wrds)
   (if (consp wrds)
       (let* ((idx (hash-idx hash-base num-bkts (first wrds)))
              (newbs (bump-bkt idx bkts)))
          (fill-bkt-counts hash-base num-bkts newbs (rest wrds)))
       bkts))
(defun hash-bucket-sizes (hash-base num-bkts wrds)
   (fill-bkt-counts hash-base num-bkts (rep num-bkts 0) wrds))
(defconst *example-tbl-25-most-common-English-words*
   (hash-bucket-sizes 31 10
             (list "the" "be" "to" "of" "and"
                   "a" "in" "that" "have" "I"
                   "it" "for" "not" "with" "he"
                   "as" "you" "do" "at" "this"
                   "but" "his" "by" "from" "they")))
