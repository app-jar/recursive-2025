% Основной предикат для вычисления минимального остовного дерева
compute_mst(Graph, ResultTree) :-
    collect_nodes(Graph, Nodes),
    Nodes = [StartNode|_],
    build_tree([StartNode], Nodes, Graph, [], TempTree),
    reverse(TempTree, ResultTree).

% Собираем все узлы графа
collect_nodes(Graph, NodeList) :-
    findall(NodeA, member(e(NodeA, _, _), Graph), ListA),
    findall(NodeB, member(e(_, NodeB, _), Graph), ListB),
    append(ListA, ListB, Combined),
    sort(Combined, NodeList).

% Построение дерева - базовый случай
build_tree(Processed, TotalNodes, _, CurrentResult, CurrentResult) :-
    count_elements(Processed, ProcessedCount),
    count_elements(TotalNodes, TotalCount),
    ProcessedCount =:= TotalCount,
    !.

% Построение дерева - рекурсивный случай
build_tree(Processed, TotalNodes, Graph, PartialTree, FinalTree) :-
    locate_best_edge(Processed, TotalNodes, Graph, BestEdge),
    BestEdge = e(_, NextNode, _),
    \+ contains(NextNode, Processed),
    build_tree([NextNode|Processed], TotalNodes, Graph, [BestEdge|PartialTree], FinalTree).

% Находит минимальное ребро между обработанными и необработанными узлами
locate_best_edge(Processed, TotalNodes, Graph, BestEdge) :-
    findall(
        e(Source, Target, Cost),
        (member(Source, Processed),
         member(Target, TotalNodes),
         \+ contains(Target, Processed),
         (member(e(Source, Target, Cost), Graph) ; member(e(Target, Source, Cost), Graph))),
        EdgeList
    ),
    EdgeList \= [],
    select_smallest(EdgeList, BestEdge).

% Выбирает ребро с наименьшим весом
select_smallest([SingleEdge], SingleEdge) :- !.
select_smallest([e(S1, D1, W1)|Rest], MinEdge) :-
    select_smallest(Rest, e(S2, D2, W2)),
    (W1 =< W2 -> MinEdge = e(S1, D1, W1) ; MinEdge = e(S2, D2, W2)).

% Вычисляет общий вес дерева
calculate_tree_weight(Tree, Total) :-
    calculate_tree_weight(Tree, 0, Total).
calculate_tree_weight([], Total, Total).
calculate_tree_weight([e(_,_,Value)|Remaining], Accum, Total) :-
    NewAccum is Accum + Value,
    calculate_tree_weight(Remaining, NewAccum, Total).

% Вспомогательные предикаты
count_elements(List, Count) :-
    length(List, Count).

contains(Element, List) :-
    member(Element, List).
