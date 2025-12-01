% Эмуляция деления в столбик рекурсивным способом

% long_div(Dividend, Divisor, Quotient, Remainder).

% Главный предикат:
long_div(Dividend, Divisor, Quotient, Remainder) :-
    number_digits(Dividend, Digits),     
    divide_digits(Digits, Divisor, 0, [], QDigits, Remainder),
    digits_number(QDigits, Quotient).    % превращаем цифры частного в число

% Деление по цифрам:
% divide_digits(СписокЦифр, Делитель, ТекущийОстаток, АккумуляторЦифрЧастного, РезультатЧастного, ИтоговыйОстаток)

divide_digits([], _, Remainder, Q, Q, Remainder).  
divide_digits([D|Ds], Divisor, Current, QAcc, Q, Remainder) :-
    New is Current * 10 + D,            % подносим цифру "вниз"
    Digit is New // Divisor,            % цифра частного
    Rem is New mod Divisor,             % новый остаток
    divide_digits(Ds, Divisor, Rem, [Digit|QAcc], Q, Remainder).


number_digits(N, Digits) :-
    number_chars(N, Cs),
    maplist(atom_number, Cs, Digits).

digits_number(Ds, N) :-
    reverse(Ds, R),      % разворачиваем, т.к. накапливали в обратном порядке
    digits_number_(R, 0, N).

digits_number_([], Acc, Acc).
digits_number_([D|Ds], Acc, N) :-
    NewAcc is Acc * 10 + D,
    digits_number_(Ds, NewAcc, N).
