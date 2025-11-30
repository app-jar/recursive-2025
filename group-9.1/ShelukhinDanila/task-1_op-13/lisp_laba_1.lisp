;Номер 1, Задание 13
;Сгенерировать все сочетания без повторений из N по К.


;; Основная функция - генерирует все сочетания без повторений из N по K
(defun combinations (n k)
  (when (and (>= n k) (>= k 0))
    (combinations-helper 1 n k '())))

;; Вспомогательная рекурсивная функция
(defun combinations-helper (start n k current)
  (cond
    ((= k 0) (list (reverse current)))
    ((> start n) '())
    (t (append
         (combinations-helper (+ start 1) n (- k 1) (cons start current))
         (combinations-helper (+ start 1) n k current)))))

;; Функция для вывода сочетаний
(defun print-combinations (n k)
  (format t "Сочетания из ~D по ~D:~%" n k)
  (let ((combs (combinations n k)))
    (if combs
        (dolist (comb combs)
          (format t "~{ ~A~}~%" comb))
        (format t "Невозможно сгенерировать сочетания~%"))))

;; Тест
(print-combinations 4 2)
