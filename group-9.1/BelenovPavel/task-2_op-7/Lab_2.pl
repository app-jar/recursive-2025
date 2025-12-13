% Беленов Павел 91 группа
% 7. Определить, является ли бинарное дерево «отсортированным»?

% несортированное 1,2,3,4,5,6,7
% сортированное   4,2,6,1,5,3,7

% разбиение списка на корень, левую и правую ветвь
split_list([], [], []).
split_list([X], [X], []).
split_list([X,Y|T], [X|Left], [Y|Right]) :-
    split_list(T, Left, Right).

% преобразование списка в дерево
list_to_tree([], empty).
list_to_tree([H|T], tree(H, Left, Right)) :-
    split_list(T, LeftList, RightList),
    list_to_tree(LeftList, Left),
    list_to_tree(RightList, Right).

min(X, Y, X) :- X =< Y, !.
min(_, Y, Y).

max(X, Y, X):- X >= Y, !.
max(_, Y, Y).

% проверка, что все элементы дерева из левой ветви меньше,
% чем текущее корневое значение
left_tree_max(empty, -inf).
left_tree_max(tree(Value, Left, Right), Max):-
    left_tree_max(Right, RightMax),
    left_tree_max(Left, LeftMax),
    max(Value, RightMax, TempMax),
    max(LeftMax, TempMax, Max).

% проверка, что все элементы дерева из правой ветви больше,
% чем текущее корневое значение
right_tree_min(empty, inf).
right_tree_min(tree(Value, Left, Right), Min):-
    right_tree_min(Left, LeftMin),
    right_tree_min(Right, RightMin),
    min(Value, LeftMin, TempMin),
    min(TempMin, RightMin, Min).

% дерево отсортировано, если все элементы слева меньше, а справа больше
is_sort(empty).
is_sort(tree(Value, Left, Right)):-
    is_sort(Left),
    is_sort(Right),
    left_tree_max(Left, MaxLeft),
    right_tree_min(Right, MinRight),
    MaxLeft =< Value,
    MinRight >= Value.

% обёртка: преобразование списка в дерево, проверка дерева на
% упорядоченность
check_sort(List):-
    list_to_tree(List, Tree),
    is_sort(Tree).
