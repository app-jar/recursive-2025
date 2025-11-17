% Лабораторная работа 2, Задача 1
% Студент: Болохонов Ярослав
% Группа: 91
% Условие: Является ли один список перестановкой элементов другого списка,
% учитывая сколько раз встретился каждый из элементов.

% Основной предикат
is_permutation(List1, List2) :-
    sort(List1, Sorted1),
    sort(List2, Sorted2),
    Sorted1 == Sorted2,
    count_elements(List1, Count1),
    count_elements(List2, Count2),
    permutation_count(Count1, Count2).

% Предикат для подсчета частот элементов
count_elements(List, CountList) :-
    msort(List, Sorted),
    count_elements(Sorted, [], CountList).

count_elements([], Acc, Acc).
count_elements([H|T], Acc, Result) :-
    count_occurrences([H|T], H, Count, Rest),
    count_elements(Rest, [(H, Count)|Acc], Result).

% Подсчет количества вхождений элемента
count_occurrences(List, Element, Count, Rest) :-
    count_occurrences(List, Element, 0, Count, Rest).

count_occurrences([], _, Count, Count, []).
count_occurrences([H|T], Element, Acc, Count, Rest) :-
    (   H == Element
    ->  NewAcc is Acc + 1,
        count_occurrences(T, Element, NewAcc, Count, Rest)
    ;   Count = Acc,
        Rest = [H|T]
    ).

% Проверка что списки частот являются перестановками
permutation_count(Count1, Count2) :-
    permutation_count(Count1, Count2, []).

permutation_count([], [], _).
permutation_count([(Elem, Count)|T], CountList2, Visited) :-
    select((Elem, Count), CountList2, Rest),
    \+ member(Elem, Visited),
    permutation_count(T, Rest, [Elem|Visited]).

% Тестирование
start :-
    writeln('Laboratory work: Checking list permutations'),
    writeln('==========================================='),
    test_all.

test_all :-
    writeln('TEST:'),
    writeln('--------------'),
    
    % Положительные тесты
    test_permutation([1,2,3], [3,2,1], true, 'Simple permutation'),
    test_permutation([1,1,2], [2,1,1], true, 'With repeated elements'),
    test_permutation([], [], true, 'Empty lists'),
    test_permutation([a,b,c], [c,a,b], true, 'Character elements'),
    test_permutation([1,1,1], [1,1,1], true, 'All elements same'),
    
    % Отрицательные тесты
    test_permutation([1,2,3], [1,2,4], false, 'Different elements'),
    test_permutation([1,2,2], [1,1,2], false, 'Different frequency'),
    test_permutation([1,2,3], [1,2], false, 'Different length'),
    test_permutation([1,2], [1,2,3], false, 'Different length 2'),
    test_permutation([1,1,2], [1,2,2], false, 'Different frequency distribution').

test_permutation(List1, List2, Expected, Description) :-
    (   is_permutation(List1, List2)
    ->  Result = true
    ;   Result = false
    ),
    (   Result == Expected ->
        format('OK! ~w: ~w and ~w -> ~w~n', [Description, List1, List2, Result])
    ;   format('NO! ~w: ~w and ~w -> ~w (expected: ~w)~n', 
               [Description, List1, List2, Result, Expected])
    ).