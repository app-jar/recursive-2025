;; Номер 1, задание 17
;; Является ли один список перестановкой элементов другого списка без учёта того, сколько раз встретился каждый из элементов.

;; Список без повторов
(defun uniq-list (lst)
  (labels ((u (rest acc)
             (if (endp rest)
                 (nreverse acc)
                 (let ((x (first rest)))
                   (if (member x acc :test #'equal)
                       (u (rest rest) acc)
                       (u (rest rest) (cons x acc)))))))
    (u lst '())))

;; Равенство множеств
(defun set-equal-p (list1 list2)
  (and (= (length list1) (length list2))
       (every (lambda (x) (member x list2 :test #'equal)) list1)))

;; Основная функция
(defun permutation-ignoring-multiplicity-p (list1 list2)
  (set-equal-p (uniq-list list1)
               (uniq-list list2)))

;; Примеры
(format t "~A~%" 
        (permutation-ignoring-multiplicity-p '(1 1 2 3) '(3 2 2 1 2)))

(format t "~A~%"
        (permutation-ignoring-multiplicity-p '(a b c) '(c a d)))

(format t "~A~%"
        (permutation-ignoring-multiplicity-p '(1 2 3 4) '(4 3 2 1)))

(format t "~A~%"
        (permutation-ignoring-multiplicity-p '() '()))
