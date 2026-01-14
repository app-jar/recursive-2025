; Номер 2 задание 21
; Эмуляция умножения в столбик

(defun string-to-digits (n)
  (map 'list (lambda (c) (- (char-code c) (char-code #\0))) (write-to-string n)))

(defun digits-to-string (digits)
  (coerce (map 'list (lambda (d) (code-char (+ d (char-code #\0)))) digits) 'string))

(defun multiply-column-display (num1 num2)
  "Эмуляция умножения в столбик с правильными частичными произведениями."
  (let* ((digits1 (string-to-digits num1))
         (digits2 (string-to-digits num2))
         (partial-results '())
         (width (max (length digits1) (length digits2))))
    ;; Проходим по множителю справа налево
    (loop for i from (1- (length digits2)) downto 0 do
         (let ((carry 0)
               (partial '()))
           ;; Умножаем на каждый разряд числа слева направо
           (dolist (d1 (reverse digits1))
             (let* ((prod (* d1 (nth i digits2)))
                    (sum (+ prod carry)))
               (push (mod sum 10) partial)
               (setf carry (floor sum 10))))
           (when (> carry 0)
             (push carry partial))
           ;; Добавляем нули справа для сдвига
           (setq partial (append (reverse partial) (make-list (- (1- (length digits2)) i) :initial-element 0)))
           (push partial partial-results)))
    ;; Выводим числа и линия
    (format t "~v@T~a~%" (+ 2 width) num1)
    (format t "~v@T~a~%" (+ 2 width) num2)
    (format t "~v@T~a~%" (+ 2 width) (make-string (max (length (write-to-string num1))
                                                       (length (write-to-string num2))) :initial-element #\-))
    ;; Печатаем частичные произведения
    (dolist (p (reverse partial-results))
      (format t "~v@T~a~%" (+ 2 width) (digits-to-string p)))
    ;; Складываем частичные произведения
    (let* ((max-len (apply #'max (mapcar #'length partial-results)))
           (sum (make-list max-len :initial-element 0)))
      ;; Складываем столбцами справа налево
      (dolist (p partial-results)
        (dotimes (k (length p))
          (incf (nth (- max-len 1 k) sum) (nth (- (length p) 1 k) p))))
      ;; Обрабатываем перенос
      (let ((carry 0))
        (dotimes (i max-len)
          (let ((total (+ (nth (- max-len 1 i) sum) carry)))
            (setf (nth (- max-len 1 i) sum) (mod total 10))
            (setf carry (floor total 10))))
        (loop while (> carry 0) do
             (push (mod carry 10) sum)
             (setf carry (floor carry 10))))
      ;; Линия и итог
      (format t "~v@T~a~%" (+ 2 width) (make-string (length sum) :initial-element #\-))
      (format t "~v@T~a~%" (+ 2 width) (digits-to-string sum)))))

;; Пример
(multiply-column-display 123 45)
