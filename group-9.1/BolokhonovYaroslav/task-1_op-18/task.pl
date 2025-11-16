% Лабораторная работа 1, Задача 18
% Студент: Болохонов Ярослав
% Группа: 9.1
% 
% Условие: Сгенерировать список, I-ый элемент которого содержит сумму 
% первых I элементов исходного списка.

% Основной предикат
% cumulative_sum(+InputList, -OutputList)
cumulative_sum(List, Cumulative) :-
    cumulative_sum(List, 0, Cumulative).

% Вспомогательный предикат с аккумулятором
cumulative_sum([], _, []).
cumulative_sum([H|T], Acc, [Sum|Rest]) :-
    Sum is Acc + H,
    cumulative_sum(T, Sum, Rest).

% ========== ТЕСТИРОВАНИЕ ==========

% Главный предикат для запуска
start :-
    writeln('LAB 1'),
    writeln('============================================='),
    test_examples.

% Тестовые случаи
test_examples :-
    writeln('TEST EXAMPLES:'),
    writeln('-----------------'),
    test([1,2,3,4,5], [1,3,6,10,15]),
    test([0,0,0,5,10], [0,0,0,5,15]),
    test([-1,2,-3,4,-5], [-1,1,-2,2,-3]),
    test([], []),
    test([42], [42]),
    test([1,1,1,1,1], [1,2,3,4,5]).

test(Input, Expected) :-
    cumulative_sum(Input, Result),
    (   Result = Expected ->
        format('OK! Test passed: ~w -> ~w~n', [Input, Result])
    ;   format('NO! Test failed: ~w -> ~w (expected: ~w)~n', 
               [Input, Result, Expected])
    ).