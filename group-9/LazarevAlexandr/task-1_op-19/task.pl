% Номер 1 задача 19
partial_sums(List, Sums) :-
    partial_sums(List, 0, Sums).

partial_sums([], _, []).

partial_sums([H|T], Acc, [NewSum|Sums]) :-
    NewSum is Acc + H,
    partial_sums(T, NewSum, Sums).
