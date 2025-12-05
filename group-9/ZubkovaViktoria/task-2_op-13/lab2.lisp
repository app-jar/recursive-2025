;; 13. Нахождение минимального пути на графе.

;; Определение графа: список узлов с их соседями и весами рёбер
(defparameter *graph* '((A (B . 1) (C . 4)) (B (D . 6)) (C (D . 3)) (D)))

;; Структура для приоритетной очереди (priority queue)
;; list - список пар (приоритет . элемент)
(defstruct pqueue list)

;; Функция для вставки элемента в очередь с приоритетом
;; Сортирует список по убыванию приоритета (меньше приоритет - выше)
(defun pq-push (pq item priority)
  (push (cons priority item) (pqueue-list pq))
  (sort (pqueue-list pq) #' < :key #'car))

;; Функция для извлечения элемента с наименьшим приоритетом
(defun pq-pop (pq)
  (let ((top (pop (pqueue-list pq))))
    (values (cdr top) (car top))))

;; Проверка, пуста ли очередь
(defun pq-empty-p (pq) (null (pqueue-list pq)))

;; Функция для получения всех уникальных узлов из графа
(defun get-all-nodes (graph)
  (let ((nodes nil))
    (dolist (entry graph)
      (push (car entry) nodes)
      (dolist (neighbor (cdr entry))
        (push (car neighbor) nodes)))
    (remove-duplicates nodes :test 'equal)))

;; Основная функция алгоритма Дейкстры
;; Находит кратчайший путь от start до end в графе
(defun dijkstra (graph start end)
  ;; Инициализация хэш-таблиц: dist - расстояния, prev - предыдущие узлы, visited - посещённые
  (let ((dist (make-hash-table :test 'equal))
        (prev (make-hash-table :test 'equal))
        (visited (make-hash-table :test 'equal))
        (pq (make-pqueue)))
    ;; Получение всех узлов и инициализация расстояний как бесконечность (то есть most-positive-fixnum)
    (let ((nodes (get-all-nodes graph)))
      (dolist (node nodes)
        (setf (gethash node dist) most-positive-fixnum)
        (setf (gethash node prev) nil)
        (setf (gethash node visited) nil)))
    ;; Установка начального узла с расстоянием 0 и его добавление в очередь
    (setf (gethash start dist) 0)
    (pq-push pq start (gethash start dist))
    ;; Основной цикл: пока очередь не пуста
    (loop while (not (pq-empty-p pq)) do
          ;; Извлечение узла с наименьшим расстоянием
          (multiple-value-bind (current cdist) (pq-pop pq)
            ;; Обновление только если расстояние из очереди актуально (меньше или равно сохранённому)
            (when (<= cdist (gethash current dist))
              ;; Если узел ещё не посещён, отмечаем его и обновляем расстояния до соседей
              (unless (gethash current visited)
                (setf (gethash current visited) t)
                (dolist (neighbor-w graph)
                  (when (equal (car neighbor-w) current)
                    (dolist (neighbor (cdr neighbor-w))
                      (let ((new-dist (+ cdist (cdr neighbor))))
                        ;; Если новое расстояние меньшее, обновляем
                        (when (< new-dist (gethash (car neighbor) dist))
                          (setf (gethash (car neighbor) dist) new-dist)
                          (setf (gethash (car neighbor) prev) current)
                          ;; Добавляем соседа в очередь с новым приоритетом
                          (pq-push pq (car neighbor) new-dist))))))))))
    ;; Построение пути: от конца к началу через prev
    ;; Возвращаем список: (расстояние . path) или nil, если путь не найден
    (let ((path nil) (u end))
      (loop while u do
            (push u path)
            (setf u (gethash u prev)))
      ;; Если путь состоит более чем из одного узла (не только конечного), возвращаем расстояние и путь
      (unless (= (length path) 1) (cons (gethash end dist) path)))))
