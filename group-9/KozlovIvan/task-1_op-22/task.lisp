;; Номер 2 Задача 22
;; 22. По заданному списку посчитать количество каждого из заданных элементов.

(defun count-elements (elements-to-count target-list)
  "Считает количество каждого элемента из elements-to-count в target-list."
  (cond
    ((null elements-to-count) nil)
    (t
     (cons (list (first elements-to-count)
                 (count (first elements-to-count) target-list))
           (count-elements (rest elements-to-count) target-list)))))

(defun count-and-print (elements-to-count target-list)
  "Выводит количество каждого элемента из elements-to-count в target-list."
  (let ((result (count-elements elements-to-count target-list)))
    (dolist (pair result)
      (format t "~A: ~A~%" (first pair) (second pair)))))

;; Примеры вызова
(print "Пример 1:")
(count-and-print '(a b c) '(a b a c b a d e f))  
;; Выведет:
;; a: 3
;; b: 2
;; c: 1

(print "~%Пример 2:")
(count-and-print '(2 5 7) '(1 2 3 2 4 5 2 6 5))  
;; Выведет:
;; 2: 3
;; 5: 2
;; 7: 0

(print "~%Пример 3:")
(count-and-print '() '(1 2 3))  ; Выведет ничего (пустой список для подсчета)