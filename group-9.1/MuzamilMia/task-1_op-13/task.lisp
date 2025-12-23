;; NO-16. Размещения с повторениями из N по K

(defun placements (n k)
  "Генерирует все размещения с повторениями"
  (when (>= k 0)
    (placements-helper 1 n k '())))

(defun placements-helper (start n k current)
  (cond
    ((= k 0) (list (reverse current)))  
    ((> start n) '())                   
    (t (append
         (placements-helper start n (- k 1) (cons start current))
         (placements-helper (+ start 1) n k current)))))
		 
		 
;; Функция для вывода результатов
(defun print-placements (n k)
  (format t "~%Размещения с повторениями из ~D по ~D:~%~%" n k)
  (let ((all-placements (placements n k)))
    (if all-placements
        (progn
          (loop for placement in all-placements
                for i from 1
                do (format t "~3D: [~{~A~^, ~}]~%" i placement))
          (format t "~%Всего: ~D размещений~%" (length all-placements))
          (format t "По формуле: ~D^~D = ~D~%" n k (expt n k)))
        (format t "Невозможно сгенерировать размещения~%"))))


;; Тест 1: Размещения из 3 по 2
(print-placements 3 2)

