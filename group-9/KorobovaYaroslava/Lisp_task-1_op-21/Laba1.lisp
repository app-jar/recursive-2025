;; 21. По заданному списку посчитать количество каждого из встречаемых в нём элементов.

(defun count-elements (lst)
  "Подсчитывает количество каждого элемента в списке"
  (if (null lst)
      nil
      (let ((current (car lst))
            (rest (cdr lst)))
        (add-count current (count-elements rest)))))

(defun add-count (element counts)
  "Добавляет элемент в счетчик или увеличивает его счетчик"
  (cond
    ((null counts) (list (cons element 1)))
    ((equal element (car (car counts)))
     (cons (cons element (+ 1 (cdr (car counts))))
           (cdr counts)))
    (t (cons (car counts)
             (add-count element (cdr counts))))))

;; Тестирование
(print (count-elements '(a b a c b a d)))
;; Результат: ((D . 1) (C . 1) (B . 2) (A . 3))

(print (count-elements '(1 2 3 2 1)))
;; Результат: ((3 . 1) (2 . 2) (1 . 2))
