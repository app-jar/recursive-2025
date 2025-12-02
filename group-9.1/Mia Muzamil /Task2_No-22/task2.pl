% Эмуляция деления в столбик рекурсивным способом


long_div(Dividend, Divisor, Quotient, Remainder) :-
    % Обработка знаков
    (Dividend >= 0 -> SignD = 1 ; SignD = -1),
    (Divisor  >= 0 -> SignV = 1 ; SignV = -1),

    % Работаем с абсолютными значениями
    AbsD is abs(Dividend),
    AbsV is abs(Divisor),
    number_digits(AbsD, Digits),
    divide_digits(Digits, AbsV, 0, [], QDigits, RemainderAbs),
    digits_number(QDigits, QAbs),
    QuotSign is SignD * SignV,
    Quotient is QAbs * QuotSign,

    Remainder is RemainderAbs * SignD.

% База рекурсии: цифры закончились
divide_digits([], _, Remainder, Q, Q, Remainder).

% Рекурсивное извлечение цифр
divide_digits([D|Ds], Divisor, Current, QAcc, Q, Remainder) :-
    New is Current * 10 + D,     
    Digit is New // Divisor,    
    Rem is New mod Divisor,      
    divide_digits(Ds, Divisor, Rem, [Digit|QAcc], Q, Remainder).

% Преобразования числа и списка цифр

number_digits(N, Digits) :-
    number_chars(N, Cs),
    maplist(atom_number, Cs, Digits).

digits_number(Ds, N) :-
    reverse(Ds, R),                  
    digits_number_(R, 0, N).

digits_number_([], Acc, Acc).        
digits_number_([D|Ds], Acc, N) :-
    NewAcc is Acc * 10 + D,         
    digits_number_(Ds, NewAcc, N).
