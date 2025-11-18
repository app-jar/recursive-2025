(defun sublist? (lst1 lst2 &key (test #'equal))
  "Проверяет, является ли LST1 последовательным фрагментом LST2"
  (cond
    ((null lst1) t)                    
    ((null lst2) nil)                  
    ((starts-with? lst2 lst1 :test test) t) 
    (t (sublist? lst1 (cdr lst2) :test test)))) 

(defun starts-with? (long short &key (test #'equal))
  "Проверяет, начинается ли список LONG с последовательности SHORT"
  (cond
    ((null short) t)                
    ((null long) nil)              
    ((not (funcall test (car short) (car long))) nil) 
    (t (starts-with? (cdr long) (cdr short) :test test)))) 

(defun sublist-iterative? (lst1 lst2 &key (test #'equal))
  "Итеративная проверка фрагмента"
  (let ((len1 (length lst1))
        (len2 (length lst2)))
    (cond
      ((zerop len1) t)
      ((> len1 len2) nil)
      (t (loop for i from 0 to (- len2 len1)
               thereis (equal-sublist? lst1 (nthcdr i lst2) :test test))))))

(defun equal-sublist? (lst1 lst2 &key (test #'equal))
  "Проверяет, равны ли первые (length LST1) элементов LST2 элементам LST1"
  (cond
    ((null lst1) t)
    ((null lst2) nil)
    ((not (funcall test (car lst1) (car lst2))) nil)
    (t (equal-sublist? (cdr lst1) (cdr lst2) :test test))))
