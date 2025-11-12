% 13. Проверить, является ли список повторением одного и того же списка N раз

% Пустой список - 0 повторений любого шаблона
repeats([], _, 0).

% Обработка пустого базового списка
repeats(List, [], N) :-
    length(List, Len),         
    (Len = 0 -> N = 0 ; fail).  

% Проверка непустого базового списка
repeats(List, Base, N) :-
    Base \= [],
    length(Base, Len),     
    length(List, TotalLen),  
    TotalLen mod Len =:= 0,
    N is TotalLen // Len,
    check_repeats(List, Base, N, Len).  

% Проверка что список состоит из N копий Base
check_repeats([], _, 0, _).

% Рекурсивная проверка каждой копии Base
check_repeats(List, Base, N, Len) :-
    N > 0,
    length(Prefix, Len),      
    append(Prefix, Rest, List),
    Prefix = Base,          
    N1 is N - 1,
    check_repeats(Rest, Base, N1, Len).
