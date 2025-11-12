% Задание 1 номер 15
% Определить наиболее редко встречающееся число в списке.
least_frequent([], _) :- fail.
least_frequent(List, Least) :-
    % Создаем список уникальных элементов
    sort(List, Unique),
    % Для каждого уникального элемента считаем частоту
    findall(Count-Element, 
        (member(Element, Unique), 
         count_occurrences(Element, List, Count)), 
        Pairs),
    % Находим минимальную частоту
    min_member(MinCount-_, Pairs),
    % Находим ВСЕ элементы с минимальной частотой
    findall(X, member(MinCount-X, Pairs), LeastFrequent),
    % Берем первый (или можно вернуть список всех)
    LeastFrequent = [Least|_].

% Предикат для подсчета вхождений элемента в список
count_occurrences(Element, List, Count) :-
    include(=(Element), List, Occurrences),
    length(Occurrences, Count).
