% Номер 1, задача 6
% Выполнить попарный переворот соседних элементов списка.

% cлучай пустого списка
pairwise_reverse([], []).
% случай списка из одного элемента
pairwise_reverse([X], [X]).
% случай списка из 2-х и более элементов
pairwise_reverse([X, Y | Tail], [Y, X | ReversedTail]) :-
    pairwise_reverse(Tail, ReversedTail).
