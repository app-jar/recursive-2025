(defun is-factorization? (n lst)
  "Проверяет, является ли список LST разложением числа N на простые множители"
  (and (list-of-primes? lst)
       (= n (product lst))))

(defun product (lst)
  "Вычисляет произведение элементов списка"
  (reduce #'* lst :initial-value 1))

(defun prime? (num)
  "Проверяет, является ли число простым"
  (cond
    ((< num 2) nil)
    ((= num 2) t)
    ((evenp num) nil)
    (t (let ((limit (isqrt num)))
         (loop for divisor from 3 to limit by 2
               never (zerop (mod num divisor)))))))

(defun list-of-primes? (lst)
  "Проверяет, что все элементы списка являются простыми числами"
  (every #'prime? lst))

;; Альтернативная рекурсивная версия list-of-primes?
(defun list-of-primes-recursive? (lst)
  (cond
    ((null lst) t)
    ((not (prime? (car lst))) nil)
    (t (list-of-primes-recursive? (cdr lst)))))
