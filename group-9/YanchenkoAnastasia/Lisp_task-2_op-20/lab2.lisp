;; 20. Эмуляция сложения в столбик

(defun emulate-column-addition (a b)
  "Эмулирует сложение двух чисел в столбик."
  (let ((result '())
        (carry 0))
    ;; Цикл проходит по цифрам a и b до конца обоих чисел и остатка переноса
    (loop while (or (> a 0) (> b 0) (> carry 0)) 
          do (let* ((digit-a (mod a 10))
                    (digit-b (mod b 10))
                    (sum (+ digit-a digit-b carry))
                    (digit (mod sum 10)))
               (push digit result)
               (setf carry (floor sum 10)  
                     a (floor a 10)
                     b (floor b 10))))
    ;; Обработка случая, когда результат пустой (оба числа 0)
    (if (null result)
        0
        (reduce (lambda (x y) (+ (* x 10) y)) result))))

;; Пример использования
(format t "Сумма 123 + 4567 = ~a~%" (emulate-column-addition 123 4567))
