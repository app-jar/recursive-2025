#|
Номер 2 задача 7
Определить, является ли бинарное дерево «отсортированным»?
|#
is_sorted_tree(Tree) :-
    is_bst(Tree, -1000000, 1000000).

is_bst(nil, _, _).
is_bst(tree(L, V, R), Min, Max) :-
    V > Min,
    V < Max,
    is_bst(L, Min, V),
    is_bst(R, V, Max).
