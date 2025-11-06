% Номер 1, задача 16
% Сгенерировать список, содержащий значения первых N элементов указанного ряда.
% Генерируем первые N натуральных чисел: 1, 2, 3, ..., N

% Основной предикат: генерирует список первых N натуральных чисел
generate_series(N, List) :-
    N > 0,
    generate_series_helper(1, N, List).

% Вспомогательный предикат для генерации списка
generate_series_helper(Current, N, [Current]) :-
    Current =:= N.

generate_series_helper(Current, N, [Current | Rest]) :-
    Current < N,
    Next is Current + 1,
    generate_series_helper(Next, N, Rest).