;; Номер 2, задача 16
;; Решение системы линейных уравнений.
;; Реализован метод Гаусса для решения системы n уравнений с n неизвестными

;; Основная функция: решает систему линейных уравнений
;; matrix - расширенная матрица (коэффициенты + свободные члены)
;; Возвращает список значений неизвестных
(defun solve-linear-system (matrix)
  "Решает систему линейных уравнений методом Гаусса"
  (let ((augmented (copy-matrix matrix)))
    (forward-elimination augmented)
    (back-substitution augmented)))

;; Прямой ход метода Гаусса (приведение к треугольному виду)
(defun forward-elimination (matrix)
  "Приводит матрицу к треугольному виду"
  (let ((n (length matrix)))
    (loop for i from 0 below (- n 1) do
      (let ((pivot-row (find-pivot-row matrix i)))
        (when pivot-row
          (swap-rows matrix i pivot-row)
          (loop for j from (+ i 1) below n do
            (let ((factor (/ (aref (nth j matrix) i)
                            (aref (nth i matrix) i))))
              (eliminate-row matrix j i factor))))))))

;; Обратный ход метода Гаусса (нахождение решений)
(defun back-substitution (matrix)
  "Находит решения системы методом обратной подстановки"
  (let* ((n (length matrix))
         (solutions (make-array n :initial-element 0.0)))
    (loop for i from (- n 1) downto 0 do
      (let ((sum 0.0)
            (row (nth i matrix)))
        (loop for j from (+ i 1) below n do
          (incf sum (* (aref row j) (aref solutions j))))
        (setf (aref solutions i)
              (/ (- (aref row n) sum)
                 (aref row i)))))
    (coerce solutions 'list)))

;; Вспомогательные функции

;; Поиск строки с максимальным элементом в столбце (для уменьшения ошибок)
(defun find-pivot-row (matrix col)
  "Находит строку с максимальным элементом в столбце col, начиная с строки col"
  (let ((n (length matrix))
        (max-val 0.0)
        (max-row col))
    (loop for i from col below n do
      (let ((val (abs (aref (nth i matrix) col))))
        (when (> val max-val)
          (setf max-val val)
          (setf max-row i))))
    (if (> max-val 0.0) max-row nil)))

;; Обмен двух строк матрицы
(defun swap-rows (matrix i j)
  "Меняет местами строки i и j в матрице"
  (let ((temp (nth i matrix)))
    (setf (nth i matrix) (nth j matrix))
    (setf (nth j matrix) temp)))

;; Исключение переменной из строки
(defun eliminate-row (matrix row col factor)
  "Вычитает из строки row строку col, умноженную на factor"
  (let ((n (length (nth row matrix))))
    (loop for k from col below n do
      (decf (aref (nth row matrix) k)
            (* factor (aref (nth col matrix) k))))))

;; Копирование матрицы
(defun copy-matrix (matrix)
  "Создает копию матрицы"
  (mapcar (lambda (row)
            (let ((new-row (make-array (length row))))
              (loop for i from 0 below (length row) do
                (setf (aref new-row i) (aref row i)))
              new-row))
          matrix))

;; Удобная функция для создания расширенной матрицы из списков
(defun make-matrix (rows)
  "Создает матрицу из списка списков"
  (mapcar (lambda (row) (coerce row 'vector)) rows))

;; Примеры использования:
;; Система уравнений:
;;  2x + y = 5
;;  x - y = 1
;; Решение: x = 2, y = 1
;;
;; (setq m (make-matrix '((2 1 5) (1 -1 1))))
;; (solve-linear-system m) => (2.0 1.0)
;;
;; Система уравнений:
;;  x + 2y = 7
;;  3x - y = 1
;; Решение: x = 9/7, y = 20/7
;;
;; (setq m (make-matrix '((1 2 7) (3 -1 1))))
;; (solve-linear-system m) => (1.2857143 2.857143)

