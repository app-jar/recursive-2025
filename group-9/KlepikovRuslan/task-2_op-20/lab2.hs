% 20. Эмуляция сложения в столбик

:- initialization(main).

main :-
    column_addition(999, 1, R1), write(R1), nl,
    column_addition(47, 52, R2), write(R2), nl,
    column_addition(888, 222, R3), write(R3), nl,
    column_addition(555, 445, R4), write(R4), nl.

% Основная функция сложения
column_addition(N1, N2, Result) :-
    number_to_list(N1, L1),
    number_to_list(N2, L2),
    reverse(L1, R1),
    reverse(L2, R2),
    add_lists(R1, R2, 0, RResult),
    reverse(RResult, ResultList),
    list_to_number(ResultList, Result).

% Преобразование числа в список цифр
number_to_list(0, [0]) :- !.
number_to_list(N, List) :-
    number_to_list_helper(N, List).

number_to_list_helper(0, []) :- !.
number_to_list_helper(N, [D|Rest]) :-
    N > 0,
    D is N mod 10,
    Next is N // 10,
    number_to_list_helper(Next, Rest).

% Преобразование списка цифр в число
list_to_number(List, Number) :-
    list_to_number_helper(List, 0, Number).

list_to_number_helper([], Acc, Acc).
list_to_number_helper([D|Rest], Acc, Number) :-
    NewAcc is Acc * 10 + D,
    list_to_number_helper(Rest, NewAcc, Number).

% Сложение двух списков цифр с переносом
add_lists([], [], 0, []) :- !.
add_lists([], [], 1, [1]) :- !.
add_lists([X|Xs], [Y|Ys], Carry, [SumDigit|Result]) :-
    Sum is X + Y + Carry,
    NewCarry is Sum // 10,
    SumDigit is Sum mod 10,
    add_lists(Xs, Ys, NewCarry, Result).
add_lists([X|Xs], [], Carry, [SumDigit|Result]) :-
    Sum is X + Carry,
    NewCarry is Sum // 10,
    SumDigit is Sum mod 10,
    add_lists(Xs, [], NewCarry, Result).
add_lists([], [Y|Ys], Carry, [SumDigit|Result]) :-
    Sum is Y + Carry,
    NewCarry is Sum // 10,
    SumDigit is Sum mod 10,
    add_lists([], Ys, NewCarry, Result).
