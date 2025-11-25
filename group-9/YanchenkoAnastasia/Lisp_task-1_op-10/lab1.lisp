;; 10. Сгенерировать список, содержащий суммы первых N элементов указанного ряда.

(defun generate-random-series ()
  "Генерирует ряд длиной от 5 до 15 случайных чисел."
  (let ((len (+ 5 (random 11))))    ;; длина ряда случайно 5-15
    (loop repeat len collect (random 100)))) ;; случайные числа 0-99

(defun prefix-sums (lst n)
  "Возвращает список сумм первых N элементов."
  (when (<= n (length lst))  ;; проверяем, что n не превышает длину списка
    (loop for x in lst
          for i from 1 to n
          sum x into total
          collect total)))

(defun main ()
  "Основная функция."
  (let* ((series (generate-random-series))
         (n 3))                      ;; N = 3
    (format t "Сгенерированный ряд: ~a~%" series)
    (format t "Длина ряда: ~a~%" (length series))
    (format t "Суммы первых ~a элементов: ~a~%"
            n (prefix-sums series n))))

;; Пример запуска:
(main)
