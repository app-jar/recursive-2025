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

(defun run-tests ()
  (format t "Running tests...~%")

  ;; basic
  (assert-equal '(3 1) (long-division 10 3))
  (assert-equal '(4 0) (long-division 20 5))

  ;; division by zero
  (assert-error (lambda () (long-division 5 0)))

  ;; dividend = 0
  (assert-equal '(0 0) (long-division 0 7))

  ;; divisor = 1 / -1
  (assert-equal '(7 0) (long-division 7 1))
  (assert-equal '(-7 0) (long-division 7 -1))

  ;; dividend = divisor
  (assert-equal '(1 0) (long-division 9 9))
  ;; dividend = -divisor
  (assert-equal '(-1 0) (long-division 9 -9))

  ;; dividend < divisor
  (assert-equal '(0 3) (long-division 3 5))

  ;; big numbers
  (assert-equal (list (floor 1000000 3) (mod 1000000 3))
                (long-division 1000000 3))

  ;; 1001 / 11
  (assert-equal '(91 0) (long-division 1001 11))

  ;; negatives combinations, compare with floor
  (assert-equal (list (floor -17 5) (- -17 (* 5 (floor -17 5))))
                (long-division -17 5))
  (assert-equal (list (floor 17 -5) (- 17 (* -5 (floor 17 -5))))
                (long-division 17 -5))
  (assert-equal (list (floor -17 -5) (- -17 (* -5 (floor -17 -5))))
                (long-division -17 -5))

  ;; compare many cases with floor
  (loop for a in '(1 5 10 99 1234 -1 -5 -777)
        do (loop for b in '(1 2 3 -2 -5 7)
                 unless (zerop b)
                 do (let* ((res (long-division a b))
                           (q (first res))
                           (r (second res)))
                      (assert-equal (floor a b) q)
                      (assert-equal (- a (* b q)) r))))

  ;; consistency dividend = divisor*quotient + remainder
  (loop for a in '(123 5 9999 -100 -1 0)
        do (loop for b in '(1 2 3 -2 -7 11)
                 unless (zerop b)
                 do (let* ((res (long-division a b))
                           (q (first res))
                           (r (second res)))
                      (assert-equal a (+ (* b q) r)))))

  (format t "All tests passed.~%"))

;;; Auto-run for SBCL when file loaded
#+sbcl (run-tests)
