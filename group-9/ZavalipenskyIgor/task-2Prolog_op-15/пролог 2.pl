
mst(Edges, Nodes, Tree) :-
    sort(Edges, SortedEdges),
    init_sets(Nodes, Sets),
    kruskal(SortedEdges, Sets, [], Tree).

% Инициализация множеств: каждая вершина — своё множество
init_sets([], []).
init_sets([N|Ns], [set(N, [N]) | Rest]) :-
    init_sets(Ns, Rest).

% Поиск множества, которому принадлежит элемент
find_set(X, [set(Leader, Members) | _], Leader) :-
    member(X, Members), !.
find_set(X, [_ | T], Leader) :-
    find_set(X, T, Leader).

% Объединение множеств
union_sets(A, B, Sets, NewSets) :-
    select(set(A, MembersA), Sets, Sets1),
    select(set(B, MembersB), Sets1, Sets2),
    append(MembersA, MembersB, Merged),
    NewSets = [set(A, Merged) | Sets2].

% Основной шаг алгоритма Крускала
kruskal([], _, Tree, Tree).
kruskal([Cost-U-V | Rest], Sets, Acc, Tree) :-
    find_set(U, Sets, SetU),
    find_set(V, Sets, SetV),
    ( SetU \= SetV ->
        union_sets(SetU, SetV, Sets, NewSets),
        kruskal(Rest, NewSets, [Cost-U-V | Acc], Tree)
    ;
        kruskal(Rest, Sets, Acc, Tree)
    ).

% Вывод остовного дерева
print_mst(Tree) :-
    nl, write('Minimal Spanning Tree:'), nl,
    forall(member(C-U-V, Tree),
           (write(U), write(' - '), write(V),
            write(' (cost '), write(C), write(')'), nl)).