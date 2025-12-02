prefix_sums(List, N, Result) :-
    take_first_n(List, N, Taken),
    prefix_sums_acc(Taken, 0, Result).

% Берём первые N элементов списка
take_first_n(_, 0, []) :- !.
take_first_n([H|T], N, [H|R]) :-
    N1 is N - 1,
    take_first_n(T, N1, R).

% Аккумулятор для вычисления сумм
prefix_sums_acc([], _, []).
prefix_sums_acc([H|T], Acc, [S|R]) :-
    S is Acc + H,
    prefix_sums_acc(T, S, R).

