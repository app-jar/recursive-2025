;; ЛИСП Номер 2 Задача 16
;; 16.  Решение системы линейных уравнений.
;; Основная функция решения СЛАУ методом Гаусса
(defun solve-gauss (matrix)
  "Решает систему линейных уравнений методом Гаусса"
  (let* ((n (length matrix))
         (augmented (copy-matrix matrix)))
    
    ;; Прямой ход метода Гаусса
    (dotimes (i n)
      ;; Поиск главного элемента в столбце i
      (let ((max-row i)
            (max-val (abs (nth i (nth i augmented)))))
        (loop for j from (1+ i) below n do
          (when (> (abs (nth i (nth j augmented))) max-val)
            (setq max-row j)
            (setq max-val (abs (nth i (nth j augmented))))))
        
        ;; Перестановка строк
        (when (/= max-row i)
          (rotatef (nth i augmented) (nth max-row augmented)))
        
        ;; Проверка на нулевой главный элемент
        (let ((divisor (nth i (nth i augmented))))
          (if (= divisor 0)
              (error "Система вырождена или не имеет единственного решения")
              
              ;; Нормализация строки i
              (loop for j from i to n do
                (setf (nth j (nth i augmented))
                      (/ (nth j (nth i augmented)) divisor))))))
      
      ;; Обнуление элементов ниже главной диагонали в столбце i
      (loop for j from (1+ i) below n do
        (let ((factor (nth i (nth j augmented))))
          (when (/= factor 0)
            (loop for k from i to n do
              (setf (nth k (nth j augmented))
                    (- (nth k (nth j augmented))
                       (* factor (nth k (nth i augmented))))))))))
    
    ;; Обратный ход
    (let ((solution (make-list n :initial-element 0)))
      (loop for i from (1- n) downto 0 do
        (setf (nth i solution) (nth n (nth i augmented)))
        (loop for j from (1+ i) below n do
          (setf (nth i solution)
                (- (nth i solution)
                   (* (nth j (nth i augmented))
                      (nth j solution))))))
      solution)))

;; Вспомогательные функции

(defun copy-matrix (matrix)
  "Создаёт копию матрицы"
  (mapcar #'copy-list matrix))

(defun make-augmented-matrix (coefficients constants)
  "Объединяет матрицу коэффициентов и вектор правых частей"
  (mapcar #'(lambda (row const) (append row (list const)))
          coefficients constants))

;; Тестирование 
;; (defun test-solve-gauss ()
  ;; Пример: 2x + y = 8
  ;;         x - y = 1
  ;; Решение: x = 3, y = 2
  ;;(let* ((coeff '((2 1) (1 -1)))
  ;;         (const '(8 1))
  ;;         (matrix (make-augmented-matrix coeff const))
  ;;         (result (solve-gauss matrix)))
  ;;    (format t "Решение: x = ~A, y = ~A~%" 
  ;;        (first result) (second result))
  ;;    result))