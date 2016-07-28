(include-book "map-reduce")

(defconst *URLKEYWORDS*
  '((shop  amazon.com)
    (books amazon.com)
    (shop  amazon.com)
    (store amazon.com)
    (news  cnn.com)))

(defun kw-map (key value)
  (list (list value key)))

; Note: (lexorder x y) is the same as "x < y", but it works for all types of data, not just numbers.
; I.e., "lexorder is like <" in the same way that "equal is like =".

(defun kw-insert (item list)
  (cond ((not (consp list))
	 (list (list item 1)))
	((equal item (first (first list)))
	 (cons (list item
		     (+ (second (first list)) 1))
	       (rest list)))
	((lexorder item (first (first list)))
	 (cons (list item 1)
	       list))
	(t
	 (cons (first list)
	       (kw-insert item (rest list))))))

(defun kw-count-values (values)
  (if (consp values)
      (kw-insert (first values)
		 (kw-count-values (rest values)))
      nil))

(defun kw-maxlist (key count list)
  (cond ((not (consp list))
	 key)
	((< count (second (first list)))
	 (kw-maxlist (first  (first list))
		     (second (first list))
		     (rest list)))
	(t
	 (kw-maxlist key count (rest list)))))

(defun kw-reduce (key values)
  (let ((counts (kw-count-values values)))
    (if (consp counts)
	(list (list key (kw-maxlist nil 0 counts)))
	nil)))

(defmapreduce keywords kw-map kw-reduce)

(keywords *URLKEYWORDS*)
