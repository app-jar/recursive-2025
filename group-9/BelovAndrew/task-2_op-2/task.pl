% Номер 2, задача 2
% Отсортировать список чисел по возрастанию

% Базовый случай: пустой список отсортирован как пустой.
insert_sort([], []).


insert_sort([H|T], Sorted) :-
    insert_sort(T, SortedTail), 
    insert(H, SortedTail, Sorted). 


% Вставка в пустой список — результат список из одного элемента X.
insert(X, [], [X]).


insert(X, [H|T], [H|R]) :-
    X > H,
    insert(X, T, R).
insert(X, [H|T], [X,H|T]) :-
    X =< H.
