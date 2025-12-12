;;12. Найти корни уравнения P(x)=0, где P(x) – многочлен.

;; Вычисление значения многочлена в точке x
(defun poly-eval-simple (coeffs x)
  (let ((result 0) (power 1))
    (dolist (c coeffs result)
      (setf result (+ result (* c power)))
      (setf power (* power x)))))

;; Вычисление производной многочлена
(defun poly-deriv-simple (coeffs)
  (when (cdr coeffs)
    (let ((deriv '()) (n 1))
      (dolist (c (cdr coeffs) (reverse deriv))
        (push (* c n) deriv)
        (incf n)))))

;; Метод Ньютона для поиска корня
(defun newton-simple (coeffs start &optional (eps 1e-8) (max-iters 1000))
  (let ((deriv (poly-deriv-simple coeffs)))
    (labels ((iter (x n)
               (if (or (< (abs (poly-eval-simple coeffs x)) eps) (>= n max-iters))
                   x
                   (let ((fpx (poly-eval-simple deriv x)))
                     (if (< (abs fpx) eps)
                         nil
                         (iter (- x (/ (poly-eval-simple coeffs x) fpx)) (1+ n)))))))
      (iter start 0))))

;; Поиск всех корней
(defun find-all-roots (coeffs &optional (step 1.0) (eps 1e-8) (unique-eps 1e-4))
  (let ((degree (1- (length coeffs))) (found-roots '()))
    (dotimes (i (* 2 degree))
      (let ((start-val (- (* i step) (* degree step))))
        (let ((root (newton-simple coeffs start-val eps)))
          (when (and root 
                     
                     (notany (lambda (r) (< (abs (- root r)) unique-eps)) 
                             found-roots))
            (push root found-roots)))))
    (sort found-roots #'<)))


;; Тест 1: x^2 - 4 = 0
(format t "Test 1: Searching roots for x^2 - 4 (coefficients: -4 0 1):~%")
(let* ((coeffs '(-4 0 1))
       (roots (find-all-roots coeffs 2.0)))
  (format t "  Roots found: ~a~%" roots)
  (format t "  Verification:~%")
  (dolist (root roots)
    (format t "    f(~a) = ~a~%" root (poly-eval-simple coeffs root))))

;; Тест 2: x^2 + x - 6 = 0 (корни: x=2 и x=-3)
(format t "~%Test 2: Searching roots for x^2 + x - 6 (coefficients: -6 1 1):~%")
(let* ((coeffs '(-6 1 1)) ; -6 + 1*x + 1*x^2
       (roots (find-all-roots coeffs 2.0)))
  (format t "  Expected roots: -3.0, 2.0~%")
  (format t "  Roots found: ~a~%" roots)
  (when roots
    (format t "  Verification:~%")
    (dolist (root roots)
      (format t "    f(~a) = ~a~%" root (poly-eval-simple coeffs root)))))

;; Тест 3: x^3 - 3x^2 + 2x = 0 (корни: x=0, x=1, x=2)
(format t "~%Test 3: Searching roots for x^3 - 3x^2 + 2x (coefficients: 0 2 -3 1):~%")
(let* ((coeffs '(0 2 -3 1)) ; 0 + 2*x - 3*x^2 + 1*x^3
       (roots (find-all-roots coeffs 1.0))) ; меньший шаг для лучшего поиска
  (format t "  Expected roots: 0.0, 1.0, 2.0~%")
  (format t "  Roots found: ~a~%" roots)
  (when roots
    (format t "  Verification:~%")
    (dolist (root roots)
      (format t "    f(~a) = ~a~%" root (poly-eval-simple coeffs root)))))
 
 
 ;; Тест 4: Кратный корень (x-1)^2 = x^2 - 2x + 1
(format t "~%Test 4: Multiple root - (x-1)^2 = x^2 - 2x + 1 (coefficients: 1 -2 1):~%")
(let* ((coeffs '(1 -2 1)) ; 1 - 2*x + 1*x^2
       (roots (find-all-roots coeffs 2.0)))
  (format t "  Expected: x = 1.0 (double root)~%")
  (format t "  Roots found: ~a~%" roots)
  (when roots
    (format t "  Verification :~%")
    (dolist (root roots)
      (format t "    f(~a) = ~a~%" root (poly-eval-simple coeffs root)))))
