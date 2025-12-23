;; NOD EVKLID
(defun gcd-euclid (a b)
  (if (zerop b)
      (abs a)
      (gcd-euclid b (mod a b))))

;; NOK
(defun lcm-simple (a b)
  (if (or (zerop a) (zerop b))
      0
      (/ (abs (* a b)) (gcd-euclid a b))))

;; MANY NUM
(defun lcm-list (numbers)
  (reduce #'lcm-simple numbers :initial-value 1))

;; Пример использования
(print (lcm-simple 12 18))    ; => 36
(print (lcm-list '(4 6 8)))   ; => 24
