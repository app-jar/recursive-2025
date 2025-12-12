 % 15. Найти наименее частые элементы в списке
least_frequent(List, Least) :-
    List \= [],
    findall(Count-Element, (my_member(Element, List), count(Element, List, Count)), Pairs),
    min_member(MinCount-_, Pairs),
    findall(X, my_member(MinCount-X, Pairs), Least).

% Самописный member
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

% Подсчет вхождений элемента
count(X, List, Count) :-
    findall(X, my_member(X, List), Occurrences),
    length(Occurrences, Count).
