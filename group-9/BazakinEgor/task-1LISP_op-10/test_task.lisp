(defun assert-equal (a b)
  "Вспомогательная функция, которая предполагает что два значения равны"
  (unless (equal a b)
    (error "Assertion failed: ~A is not equal to ~A" a b)))

(defun assert-error (fn)
  "Вспомогательная функция, которая предполагает что функция должна выкинуть ошибку"
  (handler-case
      (progn (funcall fn)
             (error "Expected error, but none was signaled"))
    (error () t)))

(defun test-generate-partial-sums ()
  ;; Проверяем базовый пример
  (assert-equal (generate-partial-sums 5 (lambda (i) 1)) (list 1 2 3 4 5))
  ;; Проверяем для ряда обратных квадратов
  (assert-equal (generate-partial-sums 0 (lambda (i) (/ 1.0 (* i i)))) '())
  (assert-equal (generate-partial-sums 1 (lambda (i) (/ 1.0 (* i i)))) (list 1.0))
  (assert-equal (generate-partial-sums 3 (lambda (i) (/ 1.0 (* i i)))) (list 1.0 1.25 1.3611112))

  ;; Проверяем для некорректных аргументов
  (assert-error (lambda () (generate-partial-sums -1 (lambda (i) i))))
  (assert-error (lambda () (generate-partial-sums 5 :not-a-fn)))
  (assert-error (lambda () (generate-partial-sums 3 (lambda (i) (if (= i 2) 'x i)))))
  (assert-error (lambda () (generate-partial-sums 'abc (lambda (i) i))))
  (assert-error (lambda () (generate-partial-sums 10 (lambda (i) (list i)))))

  ;; Проверяем корректно ли работает для длинных списков
  (let ((big-n 100000))
    (let ((res (generate-partial-sums big-n (lambda (i) (/ 1.0 (+ i 1))))))
      (assert-equal (length res) big-n)))

  'OK)
