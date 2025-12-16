;; Belenov Pavel 91 group
;; Симмуляция сложения столбиком

;; Число -> список (младшие разряды в начале)
(defun number->digits (n)
  (if (< n 10)
      (list n)
      (cons (mod n 10)
            (number->digits (floor n 10)))))

;; Список -> число
(defun digits->number (digits)
  (if (null digits)
      0
      (+ (car digits)
         (* 10 (digits->number (cdr digits))))))

;; сложение двух списков цифр
(defun add-column (a b &optional (carry 0))
  (cond
    ((and (null a) (null b)) 
     (if (> carry 0) (list carry) nil))
    (t
     (let* ((digit-a (if a (car a) 0))
            (digit-b (if b (car b) 0))
            (sum (+ digit-a digit-b carry))
            (new-digit (mod sum 10))
            (new-carry (floor (/ sum 10))))
       (cons new-digit 
             (add-column (cdr a) (cdr b) new-carry))))))

;; сложение столбиком двух чисел
(defun column-add (num1 num2)
  (digits->number
    (add-column 
      (number->digits num1)
      (number->digits num2))))

;(print (number->digits 567)) ; тест конвертации в список
;(print (digits->number '(7 6 5))) ; тест конвертации в число
;(print (digits->number ((add-column '(7 6 5)) '(4 3)))) ; 567 + 34 = 601
(print (column-add 567 34))
