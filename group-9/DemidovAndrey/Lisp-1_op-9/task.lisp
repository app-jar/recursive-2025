(defun take-first-n-safe (series n)
  "Безопасно возвращает первые N элементов ряда"
  (cond
    ((not (listp series)) (error "Первый аргумент должен быть списком"))
    ((not (integerp n)) (error "Второй аргумент должен быть числом"))
    ((< n 0) (error "N не может быть отрицательным"))
    (t (let ((length (length series)))
         (if (>= n length)
             series
             (subseq series 0 n))))))

(print (take-first-n-safe '(13 123 232 3254) 3))