;; Михайловская Светлана
;; номер 2, задача 5
;;Определить высоту дерева.


;; maximum
(defun my-max (a b)
  (if (> a b) a b))

;; вспомогательная рекурсивная функция
(defun max-height-of-children (children)
  (if (null children)
      0
      (my-max (tree-height (car children))
              (max-height-of-children (cdr children)))))

;; основная задача
(defun tree-height (tree)
  (cond
    ((null tree) 0)                    ; пустое дерево
    ((atom tree) 1)                    ; лист
    (t (1+ (max-height-of-children (cdr tree))))))

;; примеры

(print (tree-height nil))
(print (tree-height '(a (b) (c (d)))))
