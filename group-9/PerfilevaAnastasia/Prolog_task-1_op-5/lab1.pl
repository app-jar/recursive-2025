%5. Проверить симметричность списка.
symmetrical([]).
symmetrical([_]).
symmetrical([H|T]) :-
    append(Middle, [H], T),
    symmetrical(Middle).
