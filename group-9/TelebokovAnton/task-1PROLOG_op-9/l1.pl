%Задача 1 Пролог. 9. Получить список, содержащий все элементы исходного списка, но по одному.

unique_elements([], []).

unique_elements([H|T], Result) :-
    my_member(H, T),
    unique_elements(T, Result).

unique_elements([H|T], [H|Result]) :-
    \+ my_member(H, T),
    unique_elements(T, Result).

%Дописал свой member
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).
