;;22. Эмуляция деления в столбик
;; Функция для правильного отображения деления в столбик
(defun display-long-division (dividend divisor)
  "Display long division in correct format, works with negative numbers."
  
  ;; Проверяем деление на ноль
  (when (zerop divisor)
    (error "Division by zero is not possible"))
  
  ;; Вычисляем частное и остаток с правильными знаками
  (let* ((abs-dividend (abs dividend))
         (abs-divisor (abs divisor))
         (abs-quotient (floor abs-dividend abs-divisor))
         (abs-remainder (mod abs-dividend abs-divisor))
         ;; Определяем знаки
         (negative-quotient (not (eq (> dividend 0) (> divisor 0))))
         (quotient (if negative-quotient (- abs-quotient) abs-quotient))
         ;; Остаток должен иметь тот же знак, что и делимое
         (remainder (if (< dividend 0) (- abs-remainder) abs-remainder))
         (dividend-str (format nil "~A" abs-dividend))
         (divisor-str (format nil "~A" abs-divisor))
         (quotient-str (format nil "~A" abs-quotient))
         (sign-line (if negative-quotient "-" ""))
         (lines '())
         (dividend-digits (map 'list #'digit-char-p dividend-str)))
    
    ;; Базовая строка с делимым и делителем 
    (if negative-quotient
        (push (format nil "~A | -~A" dividend-str divisor-str) lines)
        (push (format nil "~A | ~A" dividend-str divisor-str) lines))
    
    (if (zerop abs-remainder)
        ;; Если деление нацело
        (progn
          (push (format nil "~A    ~A~A" 
                        (make-string (length dividend-str) :initial-element #\-)
                        sign-line quotient-str) lines)
          (push (format nil " 0") lines))
        
        ;; Иначе показываем процесс деления
        (let ((current 0)
              (steps '())
              (position 0)
              (result-digits '()))
          
          ;; Вычисляем шаги деления 
          (dolist (digit dividend-digits)
            (setf current (+ (* current 10) digit))
            (incf position)
            
            (if (>= current abs-divisor)
                (let* ((digit-quotient (floor current abs-divisor))
                       (subtract-amount (* digit-quotient abs-divisor))
                       (new-current (- current subtract-amount)))
                  
                  ;; Сохраняем цифру частного
                  (push digit-quotient result-digits)
                  
                  ;; Сохраняем шаг для отображения
                  (push (list :position position
                              :current current
                              :subtract subtract-amount
                              :remainder new-current
                              :new-current (if (< new-current abs-divisor) 
                                               new-current 
                                               (+ (* new-current 10) 
                                                  (or (nth position dividend-digits) 0))))
                        steps)
                  
                  (setf current new-current))
                
                ;; Если число меньше делителя, добавляем 0 в частное
                (when (or (not (null result-digits)) (> position 1))
                  (push 0 result-digits))))
          
          ;; Если остался остаток от последней цифры
          (when (and (> current 0) (null steps))
            (push (list :position position
                        :current current
                        :subtract 0
                        :remainder current
                        :new-current current) steps)
            (push 0 result-digits))
          
          (setf steps (reverse steps))
          (setf result-digits (reverse result-digits))
          
          (when steps
            ;; Отображаем первый шаг
            (let* ((first-step (first steps))
                   (first-current (getf first-step :current))
                   (first-subtract (getf first-step :subtract))
                   (indent (- (length dividend-str) 
                              (length (format nil "~A" first-current)))))
              
              ;; Первое вычитание и частное
              (push (format nil "~A~A   ~A~A" 
                            (make-string indent :initial-element #\space)
                            first-subtract sign-line quotient-str) lines)
              
              ;; Линия под первым вычитанием
              (push (format nil "~A~A" 
                            (make-string indent :initial-element #\space)
                            (make-string (length (format nil "~A" first-subtract)) 
                                         :initial-element #\-)) lines)
              
              ;; Последующие шаги
              (loop for i from 1 below (length steps) do
                (let* ((step (nth i steps))
                       (prev-step (nth (1- i) steps))
                       (step-current (getf step :current))
                       (step-subtract (getf step :subtract))
                       (step-remainder (getf step :remainder))
                       (indent (- (length dividend-str) 
                                  (length (format nil "~A" step-current)))))
                  
                  ;; Если есть что вычитать, показываем текущее число
                  (when (> step-subtract 0)
                    ;; Текущее число (сносим следующую цифру)
                    (push (format nil "~A~A" 
                                  (make-string indent :initial-element #\space)
                                  step-current) lines)
                    
                    ;; Вычитание
                    (push (format nil "~A-~A" 
                                  (make-string indent :initial-element #\space)
                                  step-subtract) lines)
                    
                    ;; Линия
                    (push (format nil "~A~A" 
                                  (make-string indent :initial-element #\space)
                                  (make-string (1+ (length (format nil "~A" step-subtract))) 
                                               :initial-element #\-)) lines)))
                
                ;; Финальный остаток (после последнего шага)
                (let* ((last-step (first (last steps)))
                       (last-remainder (getf last-step :remainder))
                       (last-current (getf last-step :current))
                       (indent (- (length dividend-str) 
                                  (length (format nil "~A" last-current)))))
                  (when (> last-remainder 0)
                    (push (format nil "~A ~A" 
                                  (make-string (1+ indent) :initial-element #\space)
                                  last-remainder) lines))))))))
    
    ;; Вывод всех строк
    (format t "~%")
    (dolist (line (reverse lines))
      (format t "~A~%" line))
    
    ;; Вывод результата с правильными знаками
    (format t "~%Result: ~A~%" quotient)
    (if (not (zerop remainder))
        (format t "Remainder: ~A~%" remainder)
        (format t "No remainder~%"))
    
    (format t "Verification: ~A * ~A + ~A = ~A~%~%" 
            quotient divisor remainder 
            (+ (* quotient divisor) remainder))))
            
            

(format t "=== Example 1 ===")
(display-long-division 1234 56)

(format t "===  Example 2 ===")
(display-long-division -1234 56)


(format t "=== Division with zero remainder ===")
(display-long-division 100 25)
