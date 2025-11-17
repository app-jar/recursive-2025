;; Номер 1, задача 9
;; Сгенерировать список, содержащий значения первых N элементов указанного ряда.

;; series — список элементов,
;; n — количество элементов для выборки из series.
(defun list-from-series (series n)
  (let ((result '()))       ; создаём пустой список для результата
    (loop for x in series
          while (< (length result) n)
          do (push x result))
    (reverse result)))      ; возвращаем в правильном порядке

  
;; Пример использования функции:
(defparameter my-series '(1 2 3 4 5 6 7 8 9)) ; задаём список my-series
(format t "~a~%" (list-from-series my-series 5)) ; выводим первые 5 элементов
