;15. Сгенерировать все сочетания с повторениями из N по К.
(defun combinations-with-repetition (n k &optional (start 1))
  " start — минимальное значение следующего элемента (для обеспечения неубывания)"
  (cond
    ((= k 0) (list nil))
    (t
     (loop for x from start to n append
          (mapcar (lambda (tail) (cons x tail))
                  (combinations-with-repetition n (1- k) x))))))
                  
;(format t "~a~%" (combinations-with-repetition 3 2))
