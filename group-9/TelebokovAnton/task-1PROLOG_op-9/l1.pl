%Задача 1 Пролог. 9. Получить список, содержащий все элементы исходного списка, но по одному.

unique_elements([], []).

unique_elements([H|T], Result) :-
    member(H, T),
    unique_elements(T, Result).

unique_elements([H|T], [H|Result]) :-
    \+ member(H, T),
    unique_elements(T, Result).
