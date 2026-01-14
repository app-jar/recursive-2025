;11. Проверить, является ли матрица нижнетреугольной.

(defun lower-triangular-matrix (matrix)
  (let ((n (length matrix)))
    (dotimes (i n t)
      (dotimes (j (- n i 1))
        (let ((element (nth (+ i j 1) (nth i matrix))))
          (when (/= element 0)
            (format t "Матрица не нижнетреугольная~%")
            (return-from lower-triangular-matrix nil))))))
  (format t "Матрица нижнетреугольная~%")
  t)

; Тест
(lower-triangular-matrix '((1 0 0)
                          (5 6 0)
                          (1 7 9)))
