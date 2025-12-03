;; Номер 1, задача 24. 
;; Реализовать функцию перемножения многочленов, если многочлены задаются в виде списков их коэффициентов.
(defun poly-multiply (p1 p2)
  (let* ((len1 (length p1))
         (len2 (length p2))
         (result (make-list (+ len1 len2 -1) :initial-element 0)))
    (dotimes (i len1)
      (dotimes (j len2)
        (setf (nth (+ i j) result)
              (+ (nth (+ i j) result)
                 (* (nth i p1) (nth j p2))))))
    result))
