% Номер 2, задача 22
% Эмуляция деления в столбик
long_divide(Dividend, Divisor, Quotient, Remainder) :-
    Divisor \= 0,
    long_divide_helper(Dividend, Divisor, 0, Quotient, Remainder).

long_divide_helper(Dividend, Divisor, Acc, Quotient, Remainder) :-
    (Dividend >= Divisor ->
        NewDividend is Dividend - Divisor,
        NewAcc is Acc + 1,
        long_divide_helper(NewDividend, Divisor, NewAcc, Quotient, Remainder)
    ;
        Quotient = Acc,
        Remainder = Dividend
    ).
