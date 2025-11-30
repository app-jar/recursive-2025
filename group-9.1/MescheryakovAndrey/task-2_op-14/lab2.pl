% --- Проверка связности графа ---

% Пример графа (неориентированный)
edge(a, b).
edge(b, c).
edge(c, d).
edge(d, a).
edge(b, d).

% Граф неориентированный: путь возможен в обе стороны
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% reachable(+Start, +Visited, -Reachable)
% Находит все вершины, достижимые из Start
reachable(Start, Visited, Reachable) :-
    connected(Start, Next),
    \+ member(Next, Visited),
    reachable(Next, [Next|Visited], Reachable).

reachable(_, Visited, Visited).

% graph_connected/0 — проверка связности графа
graph_connected :-
    findall(V, (edge(V, _); edge(_, V)), Vertices0),
    sort(Vertices0, Vertices),          % список всех вершин без повторов
    Vertices = [Start|_],               % возьмём первую как начальную
    reachable(Start, [Start], Reachable),
    sort(Reachable, ReachableSorted),
    ReachableSorted = Vertices,
    write('Граф связный'), !.

graph_connected :-
    write('Граф не связный').

/** <examples>
?- graph_connected.
*/
