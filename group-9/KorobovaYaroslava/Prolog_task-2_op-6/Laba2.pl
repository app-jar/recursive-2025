%6. Определить максимальное количество дочерних узлов в дереве.

% Пустое дерево имеет 0 дочерних узлов
max_child_count(nil, 0).

% Дерево node(Value, Children)
max_child_count(node(_, Children), MaxCount) :-
    length(Children, CurrentCount),      % количество непосредственных детей
    children_max(Children, ChildrenMax), % макс. количество в поддеревьях
    max_list([CurrentCount, ChildrenMax], MaxCount).

% Обработка списка детей
children_max([], 0).
children_max([Child|Rest], Max) :-
    max_child_count(Child, ChildMax),
    children_max(Rest, RestMax),
    Max is max(ChildMax, RestMax).

% Вспомогательный предикат max_list
max_list([X], X).
max_list([X,Y|Rest], Max) :-
    CurrentMax is max(X, Y),
    max_list([CurrentMax|Rest], Max).
