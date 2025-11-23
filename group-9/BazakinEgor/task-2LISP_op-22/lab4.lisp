;; ;; ЛИСП Номер 2 Задача 22
;; ;; Эмуляция деления в столбик

(defun long-division (dividend divisor)
  "Возвращает (частное остаток). ЕВКЛИДОВО ДЕЛЕНИЕ (остаток всегда больше нуля)
  Частное равно (floor делимое делитель), остаток = делимое - делитель*частное."
  (when (zerop divisor)
    (error "Division by zero"))

  (when (zerop dividend)
    (return-from long-division (list 0 0)))

  (let* ((abs-divisor (abs divisor))
         (abs-dividend (abs dividend))
         ; Преобразуем делимое в список его цифр
         (digits
          (let ((s (write-to-string abs-dividend)))
            (map 'list (lambda (c) (- (char-code c) (char-code #\0))) s)))
         (current 0)
         (quotient-digits '())  ; Будем собирать цифры частного
         (last-index (1- (length digits)))
         (idx 0))
    ;; проходим по всем цифрам делимого, учитывая текущую позицию idx
    (dolist (d digits)
      (setf current (+ (* current 10) d))
      (cond
        ;; current меньше чем делитель -> записываем (current 0)
        ((< current abs-divisor)
         (push 0 quotient-digits))
         
        ;; current >= divisor
        (t
         (let ((partial-quotient (floor current abs-divisor)))
           (push partial-quotient quotient-digits) 
           (if (< idx last-index)
               ;; НЕ последняя цифра: записываем (current partial-quotient) и затем вычитаем
               (progn
                 (setf current (- current (* partial-quotient abs-divisor))))
               ;; последняя цифра: вычитаем и записываем финальный остаток (remainder 0)
               (progn
                 (setf current (- current (* partial-quotient abs-divisor)))
            )))))

      (incf idx))

    (setf quotient-digits (nreverse quotient-digits))

    ;; Собираем цифры частного в число
    (let ((positive-quotient 
          (if quotient-digits
              (parse-integer (format nil "~{~d~}" quotient-digits))
              0))
        (positive-remainder current))
    
    ;; ЕВКЛИДОВО ДЕЛЕНИЕ: всегда 0 <= remainder < |divisor|
    (cond
      ;; Отрицательное делимое, положительный делитель
      ((and (minusp dividend) (plusp divisor))
        (if (zerop positive-remainder)
            (list (- positive-quotient) 0)
            (list (- (1+ positive-quotient)) (- divisor positive-remainder))))
      
      ;; Положительное делимое, отрицательный делитель  
      ((and (plusp dividend) (minusp divisor))
        (if (zerop positive-remainder)
            (list (- positive-quotient) 0)
            (list (- (1+ positive-quotient)) (+ divisor positive-remainder))))
      
      ;; Оба отрицательные - используем truncate семантику
      ((and (minusp dividend) (minusp divisor))
        (list positive-quotient (- positive-remainder)))
      
      ;; Оба положительные
      (t
        (list positive-quotient positive-remainder))))))
