;; Номер 2 Задача 7
;; Определить, является ли бинарное дерево «отсортированным»?

;; Функция проверки, является ли дерево BST
(defun bst-p (tree &optional (min nil) (max nil))
  "Проверяет, является ли дерево бинарным деревом поиска."
  (if (null tree)
      t
      (let ((value (first tree))
            (left (second tree))
            (right (third tree)))
        (and (or (null min) (> value min))
             (or (null max) (< value max))
             (bst-p left min value)
             (bst-p right value max)))))

;; Функция для удобного вывода Yes/No
(defun check-bst (tree)
  "Выводит Yes, если дерево BST, иначе No."
  (if (bst-p tree)
      (print "Yes")
      (print "No")))

;; Глобальные переменные для деревьев без предупреждений
(defparameter tree1 '(5 (3 NIL NIL) (7 NIL NIL)))
(defparameter tree2 '(5 (7 NIL NIL) (3 NIL NIL)))

;; Вызов функции и вывод результатов
(check-bst tree1)  ;; => "Yes"
(check-bst tree2)  ;; => "No"
