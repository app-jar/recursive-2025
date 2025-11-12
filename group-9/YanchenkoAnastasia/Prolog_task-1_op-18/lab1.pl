%18. Сгенерировать список, I-ый элемент которого содержит сумму первых I элементов
%исходного списка.

%создает список префиксных сумм из исходного списка
prefix_sums(List, Result) :-
    prefix_sums_helper(List, 0, Result).

%базовый случай рекурсии: пустой список дает пустой результат
prefix_sums_helper([], _, []).

%рекурсия: добавляем текущий элемент к накопленной сумме
prefix_sums_helper([X|Xs], SumSoFar, [NewSum|Rs]) :-
    NewSum is SumSoFar + X,
    prefix_sums_helper(Xs, NewSum, Rs).
