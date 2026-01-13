% Основной предикат: получить список простых чисел до N
primes_up_to(N, Primes) :-
    numlist(2, N, Numbers),
    include(prime, Numbers, Primes).

% Проверка, является ли число простым
prime(2).
prime(3).
prime(N) :-
    integer(N), N > 3,
    N mod 2 =\= 0,
    not(has_divisor(N, 3)).

% Проверка наличия делителей
has_divisor(N, D) :-
    D * D =< N,
    (N mod D =:= 0
    ;
    D2 is D + 2,
    has_divisor(N, D2)).

% Основной код с выводом
main :-
    primes_up_to(100, Primes),
    write('Простые числа до 100:'), nl,
    write(Primes), nl,
    length(Primes, Count),
    write('Количество простых чисел: '), write(Count), nl.

% Запуск программы
:- initialization(main).
