

;; Структура для ребра
(defstruct edge
  from
  to
  weight)

;; Вспомогательная функция XOR (правильное имя!)
(defun xor (a b)
  (or (and a (not b))
      (and (not a) b)))

;; Алгоритм Прима
(defun prim-mst (edges start)
  (let ((visited (make-hash-table))
        (mst '())
        (vertices (remove-duplicates 
                   (append (mapcar #'edge-from edges)
                           (mapcar #'edge-to edges)))))
    
    (setf (gethash start visited) t)
    
    (loop while (< (hash-table-count visited) (length vertices)) do
      (let ((min-edge nil)
            (min-weight most-positive-fixnum))
        
        (dolist (e edges)
          (let ((from-visited (gethash (edge-from e) visited))
                (to-visited (gethash (edge-to e) visited)))
            
            (when (xor from-visited to-visited)
              (when (< (edge-weight e) min-weight)
                (setf min-weight (edge-weight e)
                      min-edge e)))))
        
        (when min-edge
          (push min-edge mst)
          (setf (gethash (edge-from min-edge) visited) t
                (gethash (edge-to min-edge) visited) t))))
    
    (reverse mst)))

;; Тестовый граф
(defparameter *test-graph*
  (list
   (make-edge :from 'A :to 'B :weight 4)
   (make-edge :from 'A :to 'C :weight 2)
   (make-edge :from 'B :to 'C :weight 1)
   (make-edge :from 'B :to 'D :weight 5)
   (make-edge :from 'C :to 'D :weight 8)))

;; Вывод результата
(defun print-mst (mst)
  (format t "~%Минимальное остовное дерево:~%")
  (let ((total 0))
    (dolist (e mst)
      (format t "  ~A --(~A)--> ~A~%" 
              (edge-from e) (edge-weight e) (edge-to e))
      (incf total (edge-weight e)))
    (format t "~%Общий вес: ~A~%" total)))

;; Тест
(defun test ()
  (format t "=== Алгоритм Прима (минимальное остовное дерево) ===~%~%")
  
  (format t "Тестовый граф:~%")
  (dolist (e *test-graph*)
    (format t "  ~A-~A (вес: ~A)~%" (edge-from e) (edge-to e) (edge-weight e)))
  
  (format t "~%Результат (начинаем с вершины A):")
  (print-mst (prim-mst *test-graph* 'A))
  
  (format t "~%=== Готово ==="))

;; Запуск
(test)
