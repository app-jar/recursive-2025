;; Номер 1, Задание 14
;; Проверить, является ли заданный граф связным.

(defun graph-connected? (graph)
  ;; Если граф пустой, он считается связным
  (when graph
    (let* ((vertices (mapcar #'first graph))      ; Получаем все вершины графа
           (visited (dfs graph (first vertices) '())))  
      (equal (sort visited #'<) (sort vertices #'<)))))

(defun dfs (graph current visited)
  ;; Если вершина уже посещена, возвращаем текущий список посещенных
  (if (member current visited)
      visited
      (let ((new-visited (cons current visited)))
        ;; Рекурсивно обходим всех соседей текущей вершины
        (dolist (neighbor (rest (assoc current graph)) new-visited)
          (setq new-visited (dfs graph neighbor new-visited))))))

;; Тестирование функции
(graph-connected? '((1 2 3) (2 1 3) (3 1 2)))  ; => True
(graph-connected? '((1 2) (2 1) (3 4) (4 3)))  ; => NIL(false)
