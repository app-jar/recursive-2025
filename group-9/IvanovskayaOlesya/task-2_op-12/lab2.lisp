;; Номер 2, задача 12
;; Проверить, является ли матрица отсортированной (строки и столбцы отсортированы). 

(defun is-sorted-matrix (matrix)  
  (unless matrix (return-from is-sorted-matrix t))  ;; пустая матрийа отсортирована  
  (let* ((rows (length matrix))
         (cols (length (first matrix)))
         (row-sorted t)
         (col-sorted t))
    
    ;; строки
    (loop for i from 0 below rows
          for row = (nth i matrix)
          do (loop for j from 0 below (1- cols)
                   do (when (> (nth j row) (nth (1+ j) row))
                        (setf row-sorted nil)
                        (return)))
          while row-sorted)    
    (unless row-sorted (return-from is-sorted-matrix nil))
    
    ;; столбцы
    (loop for j from 0 below cols
          do (loop for i from 0 below (1- rows)
                   do (when (> (nth j (nth i matrix)) 
                               (nth j (nth (1+ i) matrix)))
                        (setf col-sorted nil)
                        (return)))
          while col-sorted)    
    (and row-sorted col-sorted)))

(defun test-sorted-matrix ()
  (let ((sorted-matrix '((1 2 3)
                         (4 5 6)
                         (7 8 9))))
    (format t "Матрица 1 (отсортирована): ~a~%" (is-sorted-matrix sorted-matrix)))

  (let ((unsorted-rows '((1 3 2)
                         (4 5 6)
                         (7 8 9))))
    (format t "Матрица 2 (строки не отсортированы): ~a~%" (is-sorted-matrix unsorted-rows)))
  
  (let ((unsorted-cols '((1 2 3)
                         (4 5 6)
                         (7 8 0))))
    (format t "Матрица 3 (столбцы не отсортированы): ~a~%" (is-sorted-matrix unsorted-cols)))
  
  (let ((another-sorted '((0 0 0)
                          (0 0 0)
                          (0 0 0))))
    (format t "Матрица 4 (отсортирована): ~a~%" (is-sorted-matrix another-sorted))))
(test-sorted-matrix)
