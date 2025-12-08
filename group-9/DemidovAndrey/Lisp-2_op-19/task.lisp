(defun partitions (n)
  "Возвращает все разбиения числа N на положительные целые слагаемые"
  (partitions-helper n n))

(defun partitions-helper (n max-part)
  "Вспомогательная функция с ограничением на максимальное слагаемое"
  (cond
    ((zerop n) '(()))                    ; Базовый случай: разбиение 0 - пустой список
    ((< n 0) nil)                        ; Отрицательное число - нет разбиений
    (t (loop for i from (min n max-part) downto 1    ; От максимального до 1
             append (mapcar (lambda (p) (cons i p))  ; Добавляем i к каждому разбиению
                           (partitions-helper (- n i) i))))))

;; Примеры использования:
(print (partitions 4))
;; Вывод: ((4) (3 1) (2 2) (2 1 1) (1 1 1 1))