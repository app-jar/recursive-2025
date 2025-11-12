;; Номер 1 Задача 19
;; 19. Проверить, может ли один список быть получен из другого путём удаления некоторых элементов.
(defun subsequence-p (subseq seq)
  "Проверяет, можно ли subseq получить из seq удалением элементов."
  (cond
    ((null subseq) t)
    ((null seq) nil)
    ((equal (first subseq) (first seq))
     (subsequence-p (rest subseq) (rest seq)))
    (t
     (subsequence-p subseq (rest seq)))))

(defun check-subsequence (subseq seq)
  "Выводит Yes, если subseq можно получить из seq, иначе No."
  (if (subsequence-p subseq seq)
      (print "Yes")
      (print "No")))

;; Примеры вызова
(check-subsequence '(2 4) '(1 2 3 4 5))   ; Выведет "Yes"
(check-subsequence '(2 5 6) '(1 2 3 4 5)) ; Выведет "No"
