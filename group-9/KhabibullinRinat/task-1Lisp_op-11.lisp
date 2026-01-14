; Номер 1 задание 11
; Цель: получить список, I-й элемент которого равен сумме первых I элементов исходного списка

(defun prefix-sums (lst &optional (current-sum 0))
  (if (null lst)
      nil
      (let ((new-sum (+ current-sum (car lst))))
        (cons new-sum
              (prefix-sums (cdr lst) new-sum)))))

(format t "~a~%" (prefix-sums '(1 2 3 4 5)))
