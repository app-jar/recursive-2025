% Номер 1, задача 16
% Сгенерировать список, содержащий значения первых N элементов указанного ряда.

% Основной предикат: генерирует список первых N элементов ряда
% N - количество элементов
% SeriesPred - предикат для генерации элементов (SeriesPred(Index, Value))
% List - результирующий список
generate_series(N, SeriesPred, List) :-
    N > 0,
    generate_series_helper(1, N, SeriesPred, List).

% Вспомогательный предикат для генерации списка
generate_series_helper(Current, N, SeriesPred, [Value]) :-
    Current =:= N,
    call(SeriesPred, Current, Value).

generate_series_helper(Current, N, SeriesPred, [Value | Rest]) :-
    Current < N,
    call(SeriesPred, Current, Value),
    Next is Current + 1,
    generate_series_helper(Next, N, SeriesPred, Rest).


% Натуральные числа: 1, 2, 3, ...
natural_number(I, I).

% Квадраты: 1, 4, 9, 16, ...
square(I, Value) :-
    Value is I * I.

% Арифметическая прогрессия: a, a+d, a+2d, ...
arithmetic_progression(Start, Step, I, Value) :-
    Value is Start + (I - 1) * Step.

% Примеры использования:
% generate_series(5, natural_number, L).  % L = [1, 2, 3, 4, 5]
% generate_series(5, square, L).          % L = [1, 4, 9, 16, 25]
% generate_series(5, arithmetic_progression(2, 3), L).  % L = [2, 5, 8, 11, 14]