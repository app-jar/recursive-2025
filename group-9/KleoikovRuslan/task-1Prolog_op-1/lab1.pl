%1. Получить список всех делителей указанного числа.

%поиск делителей
divisors_eff(N, Divisors) :-
    N > 0,
    Limit is integer(sqrt(N)),
    findall(D, (between(1, Limit, D), is_divisor(N, D)), SmallDivisors),
    findall(Partner, (member(D, SmallDivisors), Partner is N // D, Partner \= D), BigDivisors),
    append(SmallDivisors, BigDivisors, UnsortedDivisors),
    sort(UnsortedDivisors, Divisors).

%вспомогательный предикат
is_divisor(N, D) :-
    0 is N mod D.
