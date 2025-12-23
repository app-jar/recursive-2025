% Номер 1, задача 6
% Выполнить попарный переворот соседних элементов списка.

% empty list
pairwise_reverse([], []).
% one element
pairwise_reverse([X], [X]).
% two_or_more elements
pairwise_reverse([X, Y | Tail], [Y, X | ReversedTail]) :-
    pairwise_reverse(Tail, ReversedTail).

