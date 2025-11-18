%15. Определить наиболее редко встречающееся число в списке.
least_frequent(List, Least) :-
    List \= [],
    % Получаем список пар Частота-Элемент
    findall(Count-Element, 
            (member(Element, List), 
             count_occurrences(Element, List, Count)), 
            Pairs),
    % Находим минимальную частоту
    min_member(MinCount-_, Pairs),
    % Находим элемент с этой частотой
    member(MinCount-Least, Pairs).

count_occurrences(Element, List, Count) :-
    include(=(Element), List, Occurrences),
    length(Occurrences, Count).