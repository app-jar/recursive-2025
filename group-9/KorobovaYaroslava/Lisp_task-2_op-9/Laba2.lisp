;; 9. По заданному дереву посчитать количество каждого из заданных элементов.

(defun count-elements-in-tree (tree elements)
  "Подсчитывает количество каждого из заданных элементов в дереве"
  (if (null elements)
      nil
      (let ((element (car elements))
            (rest-elements (cdr elements)))
        (cons (cons element (count-element tree element))
              (count-elements-in-tree tree rest-elements)))))

(defun count-element (tree element)
  "Подсчитывает количество вхождений элемента в дереве"
  (cond
    ((null tree) 0)
    ((atom tree) (if (equal tree element) 1 0))
    (t (+ (count-element (car tree) element)
          (count-element (cdr tree) element)))))

;; Примеры использования

(print (count-elements-in-tree '(a (b a) c (a d)) '(a b c)))
;; Результат: ((A . 3) (B . 1) (C . 1))

(print (count-elements-in-tree '(1 (2 (1 3) 4) 1) '(1 2 3 4 5)))
;; Результат: ((1 . 3) (2 . 1) (3 . 1) (4 . 1) (5 . 0))
