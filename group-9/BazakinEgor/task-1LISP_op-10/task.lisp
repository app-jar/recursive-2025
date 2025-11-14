;; ЛИСП Номер 1 Задача 10
;; Сгенерировать список, содержащий суммы первых N элементов указанного ряда.

(defun generate-partial-sums (n sequence-function)
  "Возвращает список частичных сумм длины n, используя sequence-function как генератор элементов.
  n — целое число >= 0. sequence-function принимает индекс i и возвращает число."
  (unless (and (integerp n) (>= n 0))
    (error "N must be a non-negative integer"))
  (unless (functionp sequence-function)
    (error "Second argument must be a function"))
  (let ((result '())
        (acc 0))
    ;; Возвращаем (nreverse result), потому что в теле цикла мы пушим (lifo) частичные суммы, 
    ;; следовательно необходимо развернуть наш список, чтобы они шли в правильном порядке
    (dotimes (i n (nreverse result)) 
      ;; Добавляем к i единицу, т.к. в математических рядах индексация с единицы
      (let ((value (funcall sequence-function (1+ i))))
        (unless (numberp value)
          (error "Generated sequence value is not numeric"))
        (setf acc (+ acc value))
        (push acc result)))))
