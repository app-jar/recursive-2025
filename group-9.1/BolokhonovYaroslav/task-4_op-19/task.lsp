;;; Лабораторная работа 4, задача 19
;;; Студент: Болохонов Ярослав
;;; Группа: 91
;;; Условие: Получить все возможные разложения заданного числа в виде суммы.
;;; Перестановка слагаемых нового способа не даёт.

(defun partitions (n)
  "Получить все возможные разбиения числа на слагаемые"
  (partitions-helper n n '() '()))

(defun partitions-helper (n max-term current result)
  "Вспомогательная функция для генерации разбиений"
  (cond
    ((= n 0) (cons (reverse current) result))
    ((< n 0) result)
    (t (let ((new-result result))
         (loop for i from (min max-term n) downto 1 do
           (setf new-result 
                 (partitions-helper (- n i) i (cons i current) new-result)))
         new-result))))

;; Функция для красивого вывода результатов
(defun print-partitions (partitions-list)
  "Красиво выводит разбиения числа"
  (format t "All partitions:~%")
  (format t "===============~%")
  (let ((count 0))
    (dolist (partition partitions-list)
      (incf count)
      (format t "~2D: ~A~%" count partition)))
  (format t "~%Total: ~D partitions~%" (length partitions-list)))

;; Тестирование
(defun test-partitions ()
  "Запуск тестов генерации разбиений"
  (format t "Laboratory work: Number partitions~%")
  (format t "==================================~%")
  (format t "~%TEST EXAMPLES:~%")
  (format t "--------------~%")
  
  ;; Тест 1: Число 4
  (let ((result (partitions 4)))
    (format t "Test 1 (Number 4):~%")
    (print-partitions result))
  
  ;; Тест 2: Число 5
  (let ((result (partitions 5)))
    (format t "~%Test 2 (Number 5):~%")
    (print-partitions result))
  
  ;; Тест 3: Число 6
  (let ((result (partitions 6)))
    (format t "~%Test 3 (Number 6):~%")
    (print-partitions result))
  
  ;; Тест 4: Число 1
  (let ((result (partitions 1)))
    (format t "~%Test 4 (Number 1):~%")
    (print-partitions result))
  
  ;; Тест 5: Число 0
  (let ((result (partitions 0)))
    (format t "~%Test 5 (Number 0):~%")
    (print-partitions result)))

;; Основная функция для запуска
(defun start ()
  "Основная функция для запуска лабораторной работы"
  (test-partitions))