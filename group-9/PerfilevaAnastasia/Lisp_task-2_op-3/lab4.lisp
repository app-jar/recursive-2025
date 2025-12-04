;3. Проверить, является ли один список декартовым произведением двух других.
(defun my-append (a b)
  "Рекурсивная версия append."
  (if (null a)
      b
      (cons (car a)
            (my-append (cdr a) b))))

(defun pairs-with (x b)
  "Создаёт список пар (x y) для всех y из b."
  (if (null b)
      nil
      (cons (list x (car b))
            (pairs-with x (cdr b)))))

(defun cartesian (a b)
  "Рекурсивная генерация декартова произведения списков a и b."
  (if (null a)
      nil
      (my-append
        (pairs-with (car a) b)
        (cartesian (cdr a) b))))

(defun cartesian-product-p (a b c)
  "Проверяет, является ли c декартовым произведением a и b."
  (equal c (cartesian a b)))

(format t "~a~%"
        (cartesian-product-p
          '(1 2)
          '(3 4)
          '((1 3) (1 4) (2 3) (2 4))))
