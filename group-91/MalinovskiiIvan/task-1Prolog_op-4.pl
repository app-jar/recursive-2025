%Номер 1, Задача 4
% Выполнить симметричный переворот списка.
symmetric_reverse(List, ReversedList) :-
    length(List, Len),
    (   Len mod 2 =:= 1  % если нечетная длина
    ->  FirstPartLen is (Len - 1) // 2, 
        split_list(List, FirstPartLen, FirstPart, Rest1),
        split_list(Rest1, 1, [Middle], LastPart), % средний элемент
        append(LastPart, [Middle], Temp), % последние элементы + средний
        append(Temp, FirstPart, ReversedList) % первые элементы
    ;   % если четная длина
        Half is Len // 2,
        split_list(List, Half, FirstHalf, SecondHalf),
        append(SecondHalf, FirstHalf, ReversedList)
    ).
% разделяет список 
split_list(List, 0, [], List) :- !.
split_list([H|T], N, [H|FirstN], Rest) :-
    N > 0,
    N1 is N - 1,
    split_list(T, N1, FirstN, Rest). 
