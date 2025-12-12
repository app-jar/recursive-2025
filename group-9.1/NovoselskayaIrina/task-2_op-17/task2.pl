% 17. Реализовать вычисление метрики Левенштейна.
% Новосельская Ирина 2 лаба, номер 17
% S1 и S2 — списки символов, Distance — расстояние Левенштейна

levenshtein([], [], 0).
levenshtein([], S, D) :- length(S, D).
levenshtein(S, [], D) :- length(S, D).

levenshtein([H|T1], [H|T2], D) :-
    levenshtein(T1, T2, D).

levenshtein([_|T1], [_|T2], D) :-
    levenshtein(T1, [_|T2], D1),
    levenshtein([_|T1], T2, D2),
    levenshtein(T1, T2, D3),
    min_list([D1, D2, D3], M),
    D is M + 1


