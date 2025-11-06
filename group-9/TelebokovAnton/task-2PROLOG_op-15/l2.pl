%Задача 2 Пролог. 15. Нахождение минимального остовного дерева
%Минимальное остовное дерево (MST) — это подграф графа, который соединяет все вершины при минимальной суммарной длине (весе) рёбер и не содержит циклов.
%Задача находит MST в неориентир. взвеш. граф
%сама идея - На каждом шаге растим дерево, добавляя самое дешёвое ребро, которое соединяет дерево с новой вершиной.
%главный предикат
min_spanning_tree(Graph, MST) :-
    get_vertices(Graph, Vertices),
    Vertices = [FirstVertex|_],
    prim_algorithm([FirstVertex], Vertices, Graph, [], ReversedMST),
    reverse(ReversedMST, MST).

%извлекает все уникальный вершины из графа
get_vertices(Graph, Vertices) :-
    findall(Vertex, member(e(Vertex, _, _), Graph), V1),
    findall(Vertex, member(e(_, Vertex, _), Graph), V2),
    append(V1, V2, All),
    sort(All, Vertices).

%баз. случай - когда все вершины посещены -> mst
prim_algorithm(Visited, AllVertices, _, MST, MST) :-
    length(Visited, VisitedCount),
    length(AllVertices, TotalVertices),
    VisitedCount =:= TotalVertices,
    !.

%рекурс случ - находит мин ребро добавляет новую вершину и продолжает
prim_algorithm(Visited, AllVertices, Graph, CurrentMST, MST) :-
    find_min_edge(Visited, AllVertices, Graph, MinEdge),
    MinEdge = e(_, NewVertex, _),
    \+ member(NewVertex, Visited),
    prim_algorithm([NewVertex|Visited], AllVertices, Graph, [MinEdge|CurrentMST], MST).

%находит минимальное по весу ребро между посещёнными и непосещёнными вершинами.
find_min_edge(Visited, AllVertices, Graph, MinEdge) :-
    findall(
        e(From, To, Weight),
        (member(From, Visited),
         member(To, AllVertices),
         \+ member(To, Visited),
         (member(e(From, To, Weight), Graph) ; member(e(To, From, Weight), Graph))),
        Edges
    ),
    Edges \= [],
    min_weight_edge(Edges, MinEdge).

%находим ребро с мин весом из списка ребёр
min_weight_edge([Edge], Edge) :- !.
min_weight_edge([e(F1,T1,W1)|T], MinEdge) :-
    min_weight_edge(T, e(F2,T2,W2)),
    (W1 =< W2 -> MinEdge = e(F1,T1,W1) ; MinEdge = e(F2,T2,W2)).

%вычисляет общий вес дерева
mst_weight(MST, Weight) :-
    mst_weight(MST, 0, Weight).
mst_weight([], Weight, Weight).
mst_weight([e(_,_,W)|T], Acc, Weight) :-
    NewAcc is Acc + W,
    mst_weight(T, NewAcc, Weight).