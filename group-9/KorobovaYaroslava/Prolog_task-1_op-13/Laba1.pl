% 13.Проверить, является ли список повторением одного и того же списка N раз

% Пустой список - 0 повторений любого шаблона
repeats([], _, 0).

% Обработка пустого базового списка
repeats(List, Base, N) :-
    Base = [], !,  % Обработка пустого Base
    length(List, N).

% Проверка непустого базового списка
repeats(List, Base, N) :-
    Base \= [],
    length(Base, Len),
    length(List, TotalLen),
    TotalLen mod Len =:= 0,
    N is TotalLen // Len,
    check_repeats(List, Base, N).

% Проверка что список состоит из N копий Base
check_repeats([], _, _).

% Рекурсивная проверка каждой копии Base
check_repeats(List, Base, N) :-
    N > 0,
    append(Base, Rest, List),
    N1 is N - 1,
    check_repeats(Rest, Base, N1).
