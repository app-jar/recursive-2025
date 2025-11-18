% Предикат для проверки, является ли число простым
is_prime(2).
is_prime(3).
is_prime(N) :-
    integer(N),
    N > 3,
    N mod 2 =\= 0,
    \+ has_factor(N, 3).

% Вспомогательный предикат для проверки наличия делителей
has_factor(N, F) :-
    F * F =< N,
    (N mod F =:= 0 -> true;
     F2 is F + 2,
     has_factor(N, F2)).

% Основной предикат: получить список простых чисел до N
primes_up_to(N, Primes) :-
    integer(N),
    N >= 2,
    findall(P, (between(2, N, P), is_prime(P)), Primes).

% Альтернативная рекурсивная реализация
primes_up_to_recursive(N, Primes) :-
    integer(N),
    N >= 2,
    primes_up_to_recursive(2, N, [], Primes).

primes_up_to_recursive(Current, N, Acc, Primes) :-
    Current =< N,
    (is_prime(Current) -> 
        NewAcc = [Current|Acc]
    ; 
        NewAcc = Acc
    ),
    Next is Current + 1,
    primes_up_to_recursive(Next, N, NewAcc, Primes).

primes_up_to_recursive(Current, N, Acc, Primes) :-
    Current > N,
    reverse(Acc, Primes).

% Предикат для проверки простоты числа (более простая версия)
is_prime_simple(2).
is_prime_simple(N) :-
    integer(N),
    N > 2,
    N mod 2 =\= 0,
    \+ divisible(N, 3).

divisible(N, D) :-
    D * D =< N,
    (N mod D =:= 0; 
     D2 is D + 2, 
     divisible(N, D2)).