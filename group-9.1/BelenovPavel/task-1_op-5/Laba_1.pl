%Belenov Pavel
%5. Проверить симметричность списка

% Пустой список + нечто = нечто
append([], L, L).
% убираем по одному элементу из начала, пока первый список не станет
% пустым
append([H|T], L, [H|TResult]) :-
    append(T, L, TResult).

% пустой список симметричен
symmetry([]).
% список из одного элемента симметричен
symmetry([_]).
% список симметричен = первый равен последнему и середина симметрична
symmetry([First|Tail]) :-
    append(Middle, [Last], Tail),
    First = Last,
    symmetry(Middle).

