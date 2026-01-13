% Проверка является ли один список перестановкой другого
is_permutation(List1, List2) :-
    msort(List1, Sorted1),    % Сортируем первый список
    msort(List2, Sorted2),    % Сортируем второй список
    Sorted1 == Sorted2.       % Сравниваем отсортированные версии

main :-
    write('Результат: '),
    (is_permutation([1,2,2,3], [2,3,2,1]) 
     -> write('true'), nl 
     ;  write('false'), nl).

:- initialization(main).
