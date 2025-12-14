(defun partitions (n)
  "Все разбиения числа n на слагаемые."
  (labels ((part-help (n min-sum acc)
             (cond ((zerop n) (list (reverse acc)))
                   (t (loop for i from min-sum to n
                            append (part-help (- n i) i (cons i acc)))))))
    (part-help n 1 '())))

(format t "Разбиения числа 4:~%")
(format t "~A~%~%" (partitions 4))

(format t "Разбиения числа 5:~%")
(format t "~A~%~%" (partitions 5))
