% Номер 2, задача 13
% Нахождение минимального пути на графе.
% Граф представлен как список рёбер: edge(From, To, Weight)

% Пример графа (можно изменить под свои нужды)
edge(a, b, 4).
edge(a, c, 2).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 8).
edge(c, e, 10).
edge(d, e, 2).

% Основной предикат: находит минимальный путь от Start до End
min_path(Start, End, Path, Cost) :-
    findall([Cost, Path], path(Start, End, Path, Cost), Paths),
    Paths \= [],
    min_member([MinCost, MinPath], Paths),
    Path = MinPath,
    Cost = MinCost.

% Поиск пути от Start до End с вычислением стоимости
path(Start, End, [Start, End], Cost) :-
    edge(Start, End, Cost).

path(Start, End, [Start | RestPath], TotalCost) :-
    edge(Start, Next, Cost),
    path(Next, End, RestPath, RestCost),
    \+ member(Start, RestPath),  % избегаем циклов
    TotalCost is Cost + RestCost.