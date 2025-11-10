%3. Проверить, является ли один список декартовым произведением двух других.
%cоздание всех пар (X, Y) для фиксированного X
pairs_with(_, [], []).
pairs_with(X, [Y|Ys], [(X,Y)|Rest]) :-
    pairs_with(X, Ys, Rest).

% декартово произведение двух списков
cartesian_product([], _, []).
cartesian_product([X|Xs], Ys, Result) :-
    pairs_with(X, Ys, Pairs),
    cartesian_product(Xs, Ys, Rest),
    append(Pairs, Rest, Result).

% проверка строгого равенства (учитывает порядок)
is_cartesian_product(A, B, C) :-
    cartesian_product(A, B, CP),
    CP == C.

% проверка без учёта порядка (как множества)
is_cartesian_product_unordered(A, B, C) :-
    cartesian_product(A, B, CP),
    permutation(CP, C).
