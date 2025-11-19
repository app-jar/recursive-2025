%15. Определить наиболее редко встречающееся число в списке.
least_frequent(List, Least) :-
    List \= [],
    findall(Count-Element, count_element(Element, List, Count), Pairs),
    min_member(MinCount-_, Pairs),
    my_member(MinCount-Least, Pairs).

% Самописная функция member
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

% Подсчет количества вхождений элемента
count_element(Element, List, Count) :-
    my_member(Element, List),
    count_occurrences(Element, List, 0, Count).

count_occurrences(_, [], Count, Count).
count_occurrences(Element, [Element|T], Acc, Count) :-
    NewAcc is Acc + 1,
    count_occurrences(Element, T, NewAcc, Count).
count_occurrences(Element, [H|T], Acc, Count) :-
    H \= Element,
    count_occurrences(Element, T, Acc, Count).