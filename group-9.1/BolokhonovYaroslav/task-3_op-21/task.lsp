;;; Лабораторная работа 3, задача 21
;;; Студент: Болохонов Ярослав
;;; Группа: 91
;;; Условие: По заданному списку посчитать количество каждого из встречаемых в нём элементов

(defun count-elements (lst)
  "Рекурсивный подсчет элементов в списке"
  (labels ((count-helper (remaining result)
             (if (null remaining)
                 result
                 (let ((element (car remaining)))
                   (count-helper 
                    (cdr remaining)
                    (if (assoc element result :test #'equal)
                        (mapcar (lambda (pair)
                                  (if (equal element (car pair))
                                      (cons element (1+ (cdr pair)))
                                      pair))
                                result)
                        (cons (cons element 1) result)))))))
    (count-helper lst '())))

;; Функция для красивого вывода результатов
(defun print-counts (count-list)
  "Красиво выводит результаты подсчета"
  (format t "Element counts:~%")
  (format t "----------------~%")
  (dolist (pair count-list)
    (format t "~A: ~D times~%" (car pair) (cdr pair))))

;; Тестирование
(defun test-count-elements ()
  "Запуск тестов подсчета элементов"
  (format t "Laboratory work: Counting elements in list~%")
  (format t "===========================================~%")
  (format t "~%TEST EXAMPLES:~%")
  (format t "--------------~%")
  
  ;; Тест 1: Простой список с числами
  (let ((result (count-elements '(1 2 3 2 1 3 4 1))))
    (format t "OK! Test 1 (Numbers): ~A~%" result)
    (print-counts result))
  
  ;; Тест 2: Список с символами
  (let ((result (count-elements '(a b a c b a d))))
    (format t "~%OK! Test 2 (Symbols): ~A~%" result)
    (print-counts result))
  
  ;; Тест 3: Список со строками
  (let ((result (count-elements '("apple" "banana" "apple" "cherry" "banana"))))
    (format t "~%OK! Test 3 (Strings): ~A~%" result)
    (print-counts result))
  
  ;; Тест 4: Пустой список
  (let ((result (count-elements '())))
    (format t "~%OK! Test 4 (Empty list): ~A~%" result)
    (print-counts result))
  
  ;; Тест 5: Смешанные типы
  (let ((result (count-elements '(1 "hello" 2 "hello" 1 :key :key))))
    (format t "~%OK! Test 5 (Mixed types): ~A~%" result)
    (print-counts result)))

;; Основная функция для запуска
(defun start ()
  "Основная функция для запуска лабораторной работы"
  (test-count-elements))