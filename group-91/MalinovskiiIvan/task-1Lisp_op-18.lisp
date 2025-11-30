 ;; ЛИСП Номер 1 Задача 18
;; 18. Проверить является ли один список фрагментом другого списка.
(defun is-sublist (sub lst)
  "Проверяет, является ли список sub фрагментом (подсписком) списка lst"
  (cond
    ((null sub) t)  
    ((null lst) nil) 
    ((starts-with sub lst) t) 
    (t (is-sublist sub (cdr lst))))) 

(defun starts-with (sub lst)
  ;;Проверяет, начинается ли список lst с подсписка sub 
  (cond
    ((null sub) t)  
    ((null lst) nil) 
    ((equal (car sub) (car lst)) 
     (starts-with (cdr sub) (cdr lst))) 
    (t nil))) 

;; Тестирование
(print "Тест 1: (1 2 3) является подсписком (a 1 2 3 b)")
(print (is-sublist '(1 2 3) '(a 1 2 3 b))) 

(print "Тест 2: (1 2) является подсписком (1 2 3 4)")
(print (is-sublist '(1 2) '(1 2 3 4)))  

(print "Тест 3: (1 3) является подсписком (1 2 3 4)")
(print (is-sublist '(1 3) '(1 2 3 4))) 

