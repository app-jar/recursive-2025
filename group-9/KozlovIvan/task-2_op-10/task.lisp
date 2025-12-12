;; Номер 10 Задача
;; Проверить, является ли матрица верхнетреугольной.

(defun upper-triangular-p (matrix &optional (row 1))
  "Проверяет, является ли матрица верхнетреугольной."
  (cond
    ((null matrix) t)  ; Пустая матрица считается верхнетреугольной
    ((null (first matrix)) t)  ; Пустая строка
    ((< (length matrix) row) t)  ; Проверили все строки
    (t
     (let ((current-row (nth (1- row) matrix)))  ; Получаем текущую строку
       (if (loop for col from 0 below (1- row)  ; Проверяем элементы ниже диагонали
                 always (zerop (nth col current-row)))
           (upper-triangular-p matrix (1+ row))  ; Рекурсивно проверяем следующую строку
           nil)))))  ; Нашли ненулевой элемент ниже диагонали

(defun check-upper-triangular (matrix)
  "Выводит Yes, если матрица верхнетреугольная, иначе No."
  (if (upper-triangular-p matrix)
      (print "Yes")
      (print "No")))

;; Примеры вызова
(print "Пример 1: Верхнетреугольная матрица 3x3")
(check-upper-triangular '((1 2 3) 
                          (0 4 5) 
                          (0 0 6)))   ; Выведет "Yes"

(print "~%Пример 2: Не верхнетреугольная матрица 3x3")
(check-upper-triangular '((1 2 3) 
                          (0 4 5) 
                          (1 0 6)))   ; Выведет "No" (1 в третьей строке, первом столбце)

(print "~%Пример 3: Верхнетреугольная матрица 2x2")
(check-upper-triangular '((7 8) 
                          (0 9)))     ; Выведет "Yes"

(print "~%Пример 4: Верхнетреугольная матрица с нулями")
(check-upper-triangular '((0 1 2) 
                          (0 0 3) 
                          (0 0 0)))   ; Выведет "Yes"

(print "~%Пример 5: Не верхнетреугольная (элемент ниже диагонали)")
(check-upper-triangular '((1 2) 
                          (3 4)))     ; Выведет "No" (3 в (2,1))