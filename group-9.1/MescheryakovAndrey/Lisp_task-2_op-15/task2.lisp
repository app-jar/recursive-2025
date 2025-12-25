;; Номер 2, задание 15
;; Нахождение минимального остовного дерева (МОД) в неориентированном графе.

;; Все вершины графа
(defun vertices-from-edges (edges)
  (remove-duplicates
   (mapcan (lambda (e)
             (list (first e) (second e)))
           edges)
   :test #'equal))

;; Поиск компоненты связности для вершины
(defun find-component (vertex components)
  (dolist (component components)
    (when (member vertex component :test #'equal)
      (return component))))

;; Объединение двух компонент
(defun union-components (comp1 comp2 components)
  (cons (union comp1 comp2 :test #'equal)
        (remove comp1 (remove comp2 components :test #'equal) :test #'equal)))

;; Минимальное остовное дерево
(defun minimal-spanning-tree (edges)
  (let* ((sorted-edges (sort (copy-list edges) #'< :key #'third))
         (vertices (vertices-from-edges edges))
         (components (mapcar #'list vertices))
         (mst '()))
    
    (dolist (edge sorted-edges mst)
      (destructuring-bind (u v weight) edge
        (let ((comp-u (find-component u components))
              (comp-v (find-component v components)))
          (when (not (equal comp-u comp-v))
            (setf components (union-components comp-u comp-v components))
            (push edge mst)))))))

;; Суммарный вес остовного дерева
(defun mst-weight (mst)
  (reduce #'+ mst :key #'third))

;; Пример графа
(defparameter *graph*
  '((a b 4)
    (a c 1)
    (b c 3)
    (b d 2)
    (c d 5)
    (c e 6)
    (d e 7)))

;; Примеры
(let ((mst (minimal-spanning-tree *graph*)))
  (format t "МОД: ~A~%" mst)
  (format t "Вес МОД: ~A~%" (mst-weight mst)))
