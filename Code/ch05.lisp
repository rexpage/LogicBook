(include-book "testing" :dir :teachpacks)
(include-book "doublecheck" :dir :teachpacks)

(defun dgts (n)
  (if (zp n)
      nil                          ; {dgts0}
      (cons (mod n 10)
            (dgts (floor n 10))))) ; {dgts1}

(check-expect (dgts 1215) '(5 1 2 1))
(check-expect (dgts 1964) '(4 6 9 1))
(check-expect (dgts 12345) '(5 4 3 2 1))
(check-expect (dgts 0) '())

(defproperty dgts-last-digit-tst
  (n-1  :value (random-natural))
  (let* ((n (+ n-1 1))) ; avoid n=0
    (= (first (dgts n)) 
       (mod n 10))))

(defproperty dgts-other-digits-tst
  (n-1  :value (random-natural))
  (let* ((n (+ n-1 1)))          ; avoid n=0
    (equal (rest (dgts n))
           (dgts (floor n 10)))))

(defun num10 (xs)
  (if (consp xs)
      (+ (first xs)               ; non-empty numeral
         (* 10 (num10 (rest xs))))
      0))                         ; empty numeral

(check-expect (num10 '(5 1 2 1)) 1215)
(check-expect (num10 '(4 6 9 1)) 1964)
(check-expect (num10 '(5 4 3 2 1)) 12345)
(check-expect (num10 '()) 0)

(defproperty num10-tst
  (n-1  :value (random-natural))
  (let* ((n (+ n-1 1)))  ; avoid n=0
    (= (first (dgts n)) 
       (mod n 10))))

(defun char-to-digit (chr)
  (let* ((dgt9  (char-code #\9))
         (code (char-code chr)))
    (if (> code dgt9)
        (+ 10 (- code (char-code #\A)))
        (- code (char-code #\0)))))
(defun chars-to-digits (chrs)
  (if (consp chrs)
      (cons (char-to-digit (first chrs))
            (chars-to-digits (rest chrs)))
      nil))
(defun digits-to-chars (dgts)
  (if (consp dgts)
      (cons (digit-to-char (first dgts))
            (digits-to-chars (rest dgts)))
      nil))
(defun string-to-numeral (str)
  ;e.g. (string-to-numeral "41C5") = '(5 11 1 4) 
  (let* ((chrs (coerce (string-upcase str) 'list)))
    (chars-to-digits (reverse chrs))))
(defun numeral-to-string (nml)
  ;e,g. (numeral-to-string '(5 11 1 4)) = "41C5" 
  (let* ((dgts (reverse nml)))
    (coerce (digits-to-chars dgts) 'string)))