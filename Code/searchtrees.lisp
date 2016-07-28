(defun mk-tr (k d lf rt) (list k d lf rt))
(defun key (s) (first s))          ; key at root
(defun dat (s) (second s))         ; data at root
(defun lft (s) (third s))          ; left subtree
(defun rgt (s) (fourth s))         ; right subtree
(defun emptyp (s) (not (consp s))) ; empty tree?
(defun height (s)                  ; tree height
  (if (emptyp s)
      0                                               ; ht0
      (+ 1 (max (height (lft s)) (height (rgt s)))))) ; ht1
(defun size (s)                    ; number of keys
  (if (emptyp s)
      0                                     ; sz0
      (+ 1 (size (lft s)) (size (rgt s))))) ; sz1
(defun n-element-list (n xs)
  (if (zp n)
      (equal xs nil)
      (and (consp xs) (n-element-list (- n 1) (rest xs)))))
(defun treep (s)                  ; search tree?
  (or (emptyp s)
      (and (n-element-list 4 s) (natp (key s))
           (treep (lft s)) (treep (rgt s)))))
(defun subp (r s)                ; r subtree of s?
  (and (treep r) (treep s) (not (emptyp s))
       (or  (equal r (lft s)) (subp r (lft s))
            (equal r (rgt s)) (subp r (rgt s)))))
(defun keyp (k s)                ; key k occurs in s?
  (and (not (emptyp s))
       (or (= k (key s)) (keyp k (lft s)) (keyp k (rgt s)))))

(defthm ht0=empty
  (implies (treep s)
           (iff (emptyp s) (= (height s) 0))))

(defun get (k s)          ; retrieve (k d) from s
  (if  (emptyp s)
       nil                              ; get-no
       (if (< k (key s))
           (get k (lft s))              ; get-L
           (if (> k (key s))
               (get k (rgt s))          ; get-R
               (list k (lft s))))))     ; get-=

(defun i-raw (k d s) ; insert k/d in search tree s
  (if (emptyp s)
      (mk-tr k d nil nil)
      (let* ((z  (key s)) (c (dat s))
             (lf (lft s)) (rt (rgt s)))
        (if (< k z)
            (mk-tr z c (i-raw k d lf) rt)      ; i-raw<
            (if (> k z)
                (mk-tr z c lf (i-raw k d rt))  ; i-raw>
                (mk-tr k d lf rt))))))         ; i-raw=

(defun zig (s) ; rotate clockwise
  (let* ((z  (key s))       (c (dat s))
         (x  (key (lft s))) (a (dat (lft s)))
         (xL (lft (lft s))) (xR (rgt (lft s)))
         (zR (rgt s)))
    (mk-tr x a xL (mk-tr z c xR zR))))
(defun zag (s) ; rotate counter-clockwise
  (let* ((z  (key s))       (c (dat s))
         (zL (lft s))
         (y  (key (rgt s))) (b (dat (rgt s)))
         (yL (lft (rgt s))) (yR (rgt (rgt s))))
    (mk-tr y b (mk-tr z c zL yL) yR)))
(defun rot-R (s)     ; rebalance clockwise if ht +2 left
  (let* ((z  (key s)) (c  (dat s))          ;NOTE: s is not empty
         (zL (lft s)) (zR (rgt s)))
    (if (> (height zL) (+ (height zR) 1))           ; unbalanced?
        (if (< (height (lft zL)) (height (rgt zL))) ; inside lft?
            (zig(mk-tr z c (zag zL) zR))            ; dbl rotate
            (zig s))                                ; sngl rotate
        s)))                                        ; no rotate
(defun rot-L (s)     ; rebalance counter-clockwise if ht +2 right
  (let* ((z  (key s)) (c  (dat s))          ;NOTE: s is not empty
         (zL (lft s)) (zR (rgt s)))
    (if (> (height zR) (+ (height zL) 1))           ; unbalanced?
        (if (< (height (rgt zR)) (height (lft zR))) ; inside rgt?
            (zag(mk-tr z c zL (zig zR)))            ; dbl rotate
            (zag s))                                ; sngl rotate
        s)))                                        ; no rotate
(defun ins (kd s)
  (if (emptyp s)
      (mk-tr (first kd) (second kd) nil nil)      ; one-node tree
      (let* ((k (first kd)) (d (second kd))
             (z  (key s)) (c  (dat s))
             (zL (lft s)) (zR (rgt s)))
        (if (< k z)
            (rot-R (mk-tr z c (ins kd zL) zR))    ; insert left
            (if (> k z)
                (rot-L (mk-tr z c zL (ins kd zR))); insert right
                (mk-tr z d zL zR))))))            ; new root data
(defun build-tree-from-list (kds)
  (if (consp kds)
      (ins (first kds) (build-tree-from-list (rest kds))) ; bld1
      nil))                                               ; bld0
(defun tree-for-timing (n)
  (if (zp n)
      nil
      (ins (list n nil) (tree-for-timing (- n 1)))))
(defun measure-time (n)
  (height (tree-for-timing n)))
(defun height-right (n)
  (let* ((h     (height (tree-for-timing n)))
         (2^h   (expt 2 h))
         (2^h/2 (/ 2^h 2)))
    (and (<  2^h/2 (+ n 1))
         (<= (+ n 1) 2^h))))

