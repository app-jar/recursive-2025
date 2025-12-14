(defun poly-power (x power acc)
  (if (zerop power) acc
      (poly-power x (1- power) (* x acc))))

(defun poly-value (coeffs x)
  (labels ((calc (coeffs deg)
             (if (null coeffs) 0
                 (+ (* (car coeffs) (poly-power x deg 1))
                    (calc (cdr coeffs) (1- deg))))))
    (calc coeffs (1- (length coeffs)))))

(defun is-root? (coeffs x)
  (= 0 (poly-value coeffs x)))

(format t "=== Тест 1: x² - 3x + 2 при x=1 (КОРЕНЬ) ===~%")
(format t "Значение: ~A~%" (poly-value '(1 -3 2) 1))
(format t "Корень? ~A~%~%" (is-root? '(1 -3 2) 1))

(format t "=== Тест 2: x=2 (КОРЕНЬ) ===~%")
(format t "Значение: ~A~%" (poly-value '(1 -3 2) 2))
(format t "Корень? ~A~%~%" (is-root? '(1 -3 2) 2))

(format t "=== Тест 3: 2x-4 при x=2 (КОРЕНЬ) ===~%")
(format t "Корень? ~A~%~%" (is-root? '(2 -4) 2))

(format t "=== Тест 4: x=0 (НЕ КОРЕНЬ) ===~%")
(format t "Значение: ~A~%" (poly-value '(1 -3 2) 0))
(format t "Корень? ~A~%~%" (is-root? '(1 -3 2) 0))
