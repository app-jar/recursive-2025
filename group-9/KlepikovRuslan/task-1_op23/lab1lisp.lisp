;;23. Реализовать функцию сложения многочленов, если многочлены задаются в виде списков их коэффициентов.

(defun add-polynomials (poly1 poly2)
  "Сложение двух многочленов, заданных списками коэффициентов"
  (let* ((len1 (length poly1))
         (len2 (length poly2))
         (max-len (max len1 len2))
         (result (make-list max-len :initial-element 0)))
    
    (dotimes (i max-len)
      (let ((coeff1 (if (< i len1) (nth i poly1) 0))
            (coeff2 (if (< i len2) (nth i poly2) 0)))
        (setf (nth i result) (+ coeff1 coeff2))))
    
    ;; Удаляем нулевые старшие коэффициенты (кроме константы)
    (remove-trailing-zeros result)))

(defun remove-trailing-zeros (poly)
  "Удаляет нулевые старшие коэффициенты многочлена"
  (if (null poly)
      '(0)
      (let ((reversed (reverse poly)))
        (loop while (and (cdr reversed) (zerop (car reversed)))
              do (setq reversed (cdr reversed)))
        (reverse (if (null reversed) '(0) reversed)))))

(defun print-polynomial (poly)
  "Вывод многочлена"
  (let ((terms '())
        (first-term t))
    (loop for i from 0
          for coeff in poly
          when (not (zerop coeff))
          do (cond
              ((zerop i) (push (format nil "~a" coeff) terms))
              ((= i 1) (push (format nil "~a*x" coeff) terms))
              (t (push (format nil "~a*x^~a" coeff i) terms))))
    
    (if terms
        (format t "~{~a~^ + ~}~%" (reverse terms))
        (format t "0~%"))))

;; Тестовые примеры
(let ((p1 '(1 2 3))   ; 1 + 2x + 3x²
      (p2 '(2 1)))    ; 2 + x
  
  (format t "Первый многочлен: ")
  (print-polynomial p1)
  
  (format t "Второй многочлен: ")
  (print-polynomial p2)
  
  (format t "Результат сложения: ")
  (print-polynomial (add-polynomials p1 p2)))

(let ((p1 '(1 1))     ; x + 1
      (p2 '(1 -1)))   ; x - 1
  
  (format t "Первый многочлен: ")
  (print-polynomial p1)
  
  (format t "Второй многочлен: ")
  (print-polynomial p2)
  
  (format t "Результат сложения: ")
  (print-polynomial (add-polynomials p1 p2)))

(let ((p1 '(1 3 2))   ; 2x² + 3x + 1
      (p2 '(2 1)))    ; x + 2
  
  (format t "Первый многочлен: ")
  (print-polynomial p1)
  
  (format t "Второй многочлен: ")
  (print-polynomial p2)
  
  (format t "Результат сложения: ")
  (print-polynomial (add-polynomials p1 p2)))
