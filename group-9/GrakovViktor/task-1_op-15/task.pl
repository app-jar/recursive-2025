% Номер 1, задача 15
% Определить наиболее редко встречающееся число в списке. 
least_frequent([], _) :- fail.
least_frequent([H|T], Least) :-
    count_occurrences(H, [H|T], FirstCount),
    least_frequent_helper(T, [H|T], H, FirstCount, Least).

least_frequent_helper([], _, Least, _, Least).
least_frequent_helper([H|T], FullList, CurrentLeast, MinCount, Least) :-
    count_occurrences(H, FullList, Count),
    (Count < MinCount -> 
        least_frequent_helper(T, FullList, H, Count, Least)
    ; 
        least_frequent_helper(T, FullList, CurrentLeast, MinCount, Least)
    ).
