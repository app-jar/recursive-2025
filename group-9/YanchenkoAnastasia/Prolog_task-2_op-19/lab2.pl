% 19. Получить все возможные разложения заданного числа в виде суммы.
% Перестановка слагаемых нового способа не даёт.

% Разложение числа N на сумму слагаемых без повторов перестановок
decompose(N, AllResults) :-
    findall(Result, decompose_one(N, Result), AllResults).

% Вспомогательный генератор одного разложения
decompose_one(N, Result) :-
    decompose_helper(N, N, [], Result).

% Базовый случай: число разложено
decompose_helper(0, _, Acc, Result) :-
    reverse(Acc, Result).

% Рекурсия: выбираем слагаемое X ≤ min(N, Max)
decompose_helper(N, Max, Acc, Result) :-
    N > 0,
    Min is min(N, Max),             % вычисляем минимум отдельно
    between(1, Min, X),
    NewN is N - X,
    decompose_helper(NewN, X, [X|Acc], Result).  % X — новый максимум

% Вывод всех разложений
print_decompositions(N) :-
    decompose(N, All),
    forall(member(L, All), (write(L), nl)).
