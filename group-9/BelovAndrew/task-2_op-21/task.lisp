;;Номер 2, задача 21
;;Эмуляция умножения в столбик

;;Выполняет умножение чисел A и B, эмулируя процесс умножения в столбик.
(defun multiply-in-column (a b)
  (let* ((sign-a (signum a))                 ; Определение знаков чисел
         (sign-b (signum b))
         (result-sign (* sign-a sign-b))
         (abs-a (abs a))                     ; Абсолютне значения чисел
         (abs-b (abs b))
         (b-str (princ-to-string abs-b))    ; Строковое представление множителя
         (result 0))
    (loop for i from 0 below (length b-str)
          for digit-char = (aref b-str (- (length b-str) 1 i))
          for digit-b = (parse-integer (string digit-char))
          do (let ((partial (* abs-a digit-b))   ; Частичное произведение: A * цифра множителя
                   (shift (expt 10 i)))          ; Смещение по разрядам (10^i)
               (setf result (+ result (* partial shift)))))  ;; Добавление с учётом смещения к итоговому результату
    (* result result-sign)))

;;ПРИМЕРЫ:
(format t "Произведение равно: ~a~%" (multiply-in-column 12 -45)) ;;-540
(format t "Произведение равно: ~a~%" (multiply-in-column 12 45)) ;;540
(format t "Произведение равно: ~a~%" (multiply-in-column -12 -45)) ;;540
(format t "Произведение равно: ~a~%" (multiply-in-column 12 0)) ;;0
