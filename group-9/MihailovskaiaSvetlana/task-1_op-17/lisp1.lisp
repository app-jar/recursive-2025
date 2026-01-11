;; Михайловская Светлана
;; Номер 1, задание 17
;; Является ли один список перестановкой элементов другого списка без учёта того,
;; сколько раз встретился каждый из элементов.

;; Список без повторов
(defun distinct-items (lst)
  (labels ((iter (tail seen)
             (if (endp tail)
                 (nreverse seen)
                 (let ((elem (first tail)))
                   (if (member elem seen :test #'equal)
                       (iter (rest tail) seen)
                       (iter (rest tail) (cons elem seen)))))))
    (iter lst nil)))

;; Равенство множеств
(defun same-set-p (a b)
  (and (every (lambda (x) (member x b :test #'equal)) a)
       (every (lambda (x) (member x a :test #'equal)) b)))

;; Основная функция
(defun contain-same-elements-p (a b)
  (same-set-p (distinct-items a) (distinct-items b)))

;; Примеры
(print (contain-same-elements-p '() '()))
(print (contain-same-elements-p '(1 1 2 3) '(3 2 1 2)))
(print (contain-same-elements-p '(q w e r) '(a s d w e)))

