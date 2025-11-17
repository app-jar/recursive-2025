% 13. Проверить, является ли список повторением одного и того же списка N раз

% Собственная реализация length
my_length([], 0).
my_length([_|Tail], Len) :-
    my_length(Tail, TailLen),
    Len is TailLen + 1.

% Собственная реализация append
my_append([], List, List).
my_append([Head|Tail1], List2, [Head|Tail3]) :-
    my_append(Tail1, List2, Tail3).

% Пустой список - 0 повторений любого шаблона
repeats([], _, 0).

% Обработка пустого базового списка
repeats(List, [], N) :-
    my_length(List, Len),
    (Len = 0 -> N = 0 ; fail).

% Проверка непустого базового списка
repeats(List, Base, N) :-
    Base \= [],
    my_length(Base, Len),
    my_length(List, TotalLen),
    TotalLen mod Len =:= 0,
    N is TotalLen // Len,
    check_repeats(List, Base, N, Len).

% Проверка что список состоит из N копий Base
check_repeats([], _, 0, _).

% Рекурсивная проверка каждой копии Base
check_repeats(List, Base, N, Len) :-
    N > 0,
    get_prefix(List, Len, Prefix, Rest),
    Prefix = Base,
    N1 is N - 1,
    check_repeats(Rest, Base, N1, Len).

% Получить префикс определенной длины
get_prefix(List, 0, [], List).
get_prefix([Head|Tail], Len, [Head|Prefix], Rest) :-
    Len > 0,
    Len1 is Len - 1,
    get_prefix(Tail, Len1, Prefix, Rest).
