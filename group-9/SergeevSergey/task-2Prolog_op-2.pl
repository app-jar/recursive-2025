 % 2. Отсортировать список чисел по возрастанию 
sort_list(List, Sorted) :-
    qsort(List, Sorted).

% Быстрая сортировка
qsort([], []).
qsort([Pivot|Tail], Sorted) :-
    split(Pivot, Tail, Less, Greater),
    qsort(Less, SortedLess),
    qsort(Greater, SortedGreater),
    my_append(SortedLess, [Pivot|SortedGreater], Sorted).

% Разделение на элементы <= и > опорного
split(_, [], [], []).
split(Pivot, [H|T], [H|Less], Greater) :- 
    my_less_equal(H, Pivot), 
    split(Pivot, T, Less, Greater).
split(Pivot, [H|T], Less, [H|Greater]) :- 
    my_greater(H, Pivot), 
    split(Pivot, T, Less, Greater).

my_append([], L, L).
my_append([H|T], L, [H|R]) :- my_append(T, L, R).

my_less_equal(X, Y) :- X =< Y.
my_greater(X, Y) :- X > Y.
