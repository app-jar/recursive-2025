% Проверка, является ли список фрагментом другого списка

sublist(Sub, List) :-
    prefix(Sub, List).
sublist(Sub, [_|Tail]) :-
    sublist(Sub, Tail).

prefix([], _).
prefix([H1|T1], [H2|T2]) :-
    H1 = H2,
    prefix(T1, T2).
