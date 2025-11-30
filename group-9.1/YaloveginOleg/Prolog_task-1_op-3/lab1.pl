%3. Проверить, является ли указанное число корнем многочлена.

% Проверка корней многочлена
% Использование: check_root(Число, [Коэффициенты])

check_root(X, Coefficients) :-
    calc_poly(Coefficients, X, Value),
    (Value =:= 0 ->
        write(X), write(' - корень'), nl
    ;
        write(X), write(' - не корень (значение='), write(Value), write(')'), nl
    ).

% Вычисление значения многочлена
calc_poly([], _, 0).
calc_poly([C|Cs], X, Result) :-
    calc_poly(Cs, X, R1),
    length(Cs, Power),
    Result is C * (X ^ Power) + R1.

% Тестовые примеры
test :-
    write('Тест 1: x^2 - 3x + 2 = 0'), nl,
    write('Корни: 1, 2'), nl,
    check_root(1, [1, -3, 2]),
    check_root(2, [1, -3, 2]),
    check_root(3, [1, -3, 2]), nl,

    write('Тест 2: 2x^3 - 3x^2 + x = 0'), nl,
    write('Корни: 0, 1'), nl,
    check_root(0, [2, -3, 1, 0]),
    check_root(1, [2, -3, 1, 0]),
    check_root(2, [2, -3, 1, 0]).

% Запуск тестов
:- initialization(test).