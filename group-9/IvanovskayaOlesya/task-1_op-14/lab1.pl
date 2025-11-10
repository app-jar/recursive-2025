% Номер 1, задча 14. 
% Определить наиболее часто встречающееся число в списке.

% подсчет вхождений элемента в список
count_occurrences([], _, 0).
count_occurrences([H|T], Element, Count) :-
    count_occurrences(T, Element, Count1),
    (H =:= Element -> Count is Count1 + 1; Count = Count1).

% основной предикат
most_frequent(List, Result) :-
    find_most_freq(List, [], 0, Result), !.

find_most_freq([], CurrentNumbers, _, CurrentNumbers). 

find_most_freq([H|T], CurrentNumbers, CurrentMax, Result) :-
    count_occurrences([H|T], H, Count), !,
    (Count > CurrentMax ->
        !, find_most_freq(T, [H], Count, Result); 
        Count =:= CurrentMax ->
        \+ member(H, CurrentNumbers), !, find_most_freq(T, [H|CurrentNumbers], CurrentMax, Result);
        find_most_freq(T, CurrentNumbers, CurrentMax, Result)
    ).

% тестики
main :-
    most_frequent([1,2,7, 7, 7, 7, 7], R),
    write('results for [1,2,7,7,7,7,7]: '), writeln(R),

    most_frequent([1,2,7], R2),
    write('results for [1,2,7]: '), writeln(R2),
    
    most_frequent([1,2,2, 2,7,7,7], R3),
    write('results for [1,2,2,2,7,7,7]: '), writeln(R3).
