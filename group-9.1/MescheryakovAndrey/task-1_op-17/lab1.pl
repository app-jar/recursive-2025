% Номер 1, Задача 17
% Список сумм первых N элементов исходного списка List

sum_series(List, N, Result) :-
    prefix(List, N, Prefix),
    partial_sums(Prefix, Result).

% prefix(+List, +N, -Prefix) — взять первые N элементов списка
prefix(_, 0, []) :- !.
prefix([], _, []) :- !.
prefix([H|T], N, [H|Prefix]) :-
    N1 is N - 1,
    prefix(T, N1, Prefix).

% partial_sums(+List, -Sums) — получить список промежуточных сумм
partial_sums(List, Sums) :-
    partial_sums(List, 0, Sums).

partial_sums([], _, []).
partial_sums([H|T], Acc, [S|Sums]) :-
    S is Acc + H,
    partial_sums(T, S, Sums).

/** <examples>
sum_series([1,2,3,4,5,6], 4, R).
sum_series([10,20,30,40], 3, R).
*/
