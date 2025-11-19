;; Новосельская Ирина 1 лаба 15 номер
;; 15. Сгенерировать все сочетания с повторениями из N по К.
;; Основная функция: генерирует все сочетания с повторениями из n по k
;; n — количество элементов, k — длина каждой комбинации
(defun combinations-wr (n k)
  (labels ((rec (start len)
             
             (if (= len 0)
                 '(())
                 (mapcan (lambda (i)
                           (mapcar (lambda (rest)
                                     (cons i rest))
                                   (rec i (- len 1))))
                         (loop for i from start below n collect i)))))
    (rec 0 k)))
    
(print (combinations-wr 4 3))
