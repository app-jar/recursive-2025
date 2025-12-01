% Новосельская Ирина лаба 1 задача 15
% Найти число из списка с наименьшей частотой появления

% минимальное из 2 чисел
min(X, Y, X) :- X =< Y, !.
min(_, Y, Y).

% минимальное из списка чисел
min_from_list([Count], Count) :- !.
min_from_list([CountX|Rest], Min) :-
    min_from_list(Rest, MinRest),
    min(CountX, MinRest, Min).

% поиск всех чисел с заданной частотой
find_all_with_frequency([], [], _, []).
find_all_with_frequency([Num|Nums], [Count|Counts], TargetCount, [Num|Rest]) :-
    Count = TargetCount,
    find_all_with_frequency(Nums, Counts, TargetCount, Rest).
find_all_with_frequency([_|Nums], [_|Counts], TargetCount, Result) :-
    find_all_with_frequency(Nums, Counts, TargetCount, Result).

% конвертация списка чисел в список уникальных чисел и список их частот
convert_to_frequency([], [], []).
convert_to_frequency([H|T], Nums, Counts) :-
    convert_to_frequency(T, TempNums, TempCounts),
    update_freq(H, TempNums, TempCounts, Nums, Counts).

% обновление частот
update_freq(X, [], [], [X], [1]).
update_freq(X, [X|Nums], [Count|Counts], [X|Nums], [NewCount|Counts]) :-
    NewCount is Count + 1.
update_freq(X, [Y|Nums], [Count|Counts], [Y|NewNums], [Count|NewCounts]) :-
    X \= Y,
    update_freq(X, Nums, Counts, NewNums, NewCounts).

%поиск числа с минимальной частотой
find_min_freq(List, Rarest):-
    convert_to_frequency(List, Numbers, Freq),
    min_from_list(Freq, MinFreq),
    find_all_with_frequency(Numbers, Freq, MinFreq, Rarest).
