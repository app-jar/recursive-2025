;; Номер 1, задача 4
;; Вывести список всех делителей указанного числа.

;; Основная функция: находит все делители числа n
(defun divisors (n)
  "Возвращает список всех делителей числа n"
  (if (<= n 0)
      (error "Число должно быть положительным")
      (divisors-helper n 1 '())))

;; Вспомогательная функция для рекурсивного поиска делителей
(defun divisors-helper (n current result)
  "Рекурсивно находит все делители числа n, начиная с current"
  (cond
    ((> current n) result)  ; базовый случай: прошли все числа
    ((zerop (mod n current))  ; если current делит n без остатка
     (divisors-helper n (+ current 1) (append result (list current))))
    (t  ; иначе переходим к следующему числу
     (divisors-helper n (+ current 1) result))))

;; Примеры использования:
;; (divisors 12) => (1 2 3 4 6 12)
;; (divisors 17) => (1 17)
;; (divisors 100) => (1 2 4 5 10 20 25 50 100)

