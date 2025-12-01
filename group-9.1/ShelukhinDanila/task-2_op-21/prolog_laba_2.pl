%Номер 2, Задача 21
%Эмуляция умножения в столбик


% Главный предикат для вывода умножения в столбик
show_multiplication(A, B) :-
    % Получаем цифры чисел
    number_chars(A, ADigits),
    number_chars(B, BDigits),
    
    % Выводим заголовок
    format('  ~s~n', [ADigits]),
    format('× ~s~n', [BDigits]),
    format('------~n', []),
    
    % Вычисляем частичные произведения БЕЗ добавления нулей
    calculate_simple_partials(A, B, SimplePartials),
    % Форматируем с правильным сдвигом
    format_partials_with_shift(SimplePartials, FormattedPartials),
    show_all_partials(FormattedPartials),
    
    % Выводим результат
    format('------~n', []),
    Result is A * B,
    format('~d~n', [Result]).

% Вычисление простых частичных произведений (без сдвига)
calculate_simple_partials(A, B, Partials) :-
    number_chars(B, BDigits),
    reverse(BDigits, BReversed),
    calculate_simple_partials_rec(A, BReversed, [], Partials).

calculate_simple_partials_rec(_, [], Acc, Acc).
calculate_simple_partials_rec(A, [BDigit|BRest], Acc, Partials) :-
    char_number(BDigit, BNum),
    Partial is A * BNum,
    calculate_simple_partials_rec(A, BRest, [Partial|Acc], Partials).

% Форматирование частичных произведений со сдвигом
format_partials_with_shift(Partials, FormattedPartials) :-
    format_partials_with_shift_rec(Partials, 0, [], FormattedPartials).

format_partials_with_shift_rec([], _, Acc, Acc).
format_partials_with_shift_rec([Partial|Rest], Shift, Acc, FormattedPartials) :-
    number_chars(Partial, PartialChars),
    % Добавляем пробелы слева для сдвига
    add_spaces_left(PartialChars, Shift, ShiftedChars),
    atomic_list_concat(ShiftedChars, FormattedLine),
    NewShift is Shift + 1,
    format_partials_with_shift_rec(Rest, NewShift, [FormattedLine|Acc], FormattedPartials).

% Добавление пробелов слева для сдвига
add_spaces_left(Chars, 0, Chars).
add_spaces_left(Chars, N, Result) :-
    N > 0,
    Result = [' '|Chars],
    N1 is N - 1,
    add_spaces_left(Result, N1, _).

% Простой вывод частичных произведений
show_all_partials([]).
show_all_partials([Partial|Rest]) :-
    format('~s~n', [Partial]),
    show_all_partials(Rest).

% Преобразование символа в число
char_number(Char, Number) :-
    char_type(Char, digit(Number)).

% Тест
?-show_multiplication(10,12).
