% Основной предикат: получить список простых чисел до N
primes_up_to(N, Primes) :-
    generate_numbers(2, N, Numbers),  % Создаем список чисел от 2 до N
    filter_primes(Numbers, Primes).   % Фильтруем, оставляя только простые

% Генерация списка чисел от Start до End
generate_numbers(Start, End, []) :- Start > End, !.
generate_numbers(Start, End, [Start|Rest]) :-
    Start =< End,
    Next is Start + 1,
    generate_numbers(Next, End, Rest).

% Фильтрация простых чисел
filter_primes([], []).
filter_primes([H|T], [H|Result]) :-
    prime(H),
    !,
    filter_primes(T, Result).
filter_primes([_|T], Result) :-
    filter_primes(T, Result).

% Проверка, является ли число простым
prime(2).                        % 2 - простое число
prime(3).                        % 3 - простое число
prime(N) :-
    integer(N), N > 3, 
    N mod 2 =\= 0,               % Простые числа (кроме 2) - нечетные
    \+ has_divisor(N, 3).        % Проверяем делители начиная с 3

% Проверка наличия делителей
has_divisor(N, D) :-
    D * D =< N,                  % Проверяем делители только до sqrt(N)
    (N mod D =:= 0               % Если делится без остатка - составное
    ; 
    D2 is D + 2,                 % Переходим к следующему нечетному делителю
    has_divisor(N, D2)).

% Основная цель для запуска с выводом
main :-
    primes_up_to(100, Primes),
    write('Простые числа до 100: '), write(Primes), nl,
    length(Primes, Count),
    write('Количество: '), write(Count), nl.

:- initialization(main).
