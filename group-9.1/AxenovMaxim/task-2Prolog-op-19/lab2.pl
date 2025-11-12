%19. Получить все возможные разложения заданного числа в виде суммы.

partition(N, Parts) :-
    partition_helper(N, N, [], Parts).

partition_helper(0, _, Acc, Parts) :-
    reverse(Acc, Parts).
partition_helper(Rem, MaxPart, Acc, Parts) :-
    Rem > 0,
    between(1, MaxPart, Part),
    Rem1 is Rem - Part,
    partition_helper(Rem1, Part, [Part | Acc], Parts).

all_partitions(N, List) :-
    findall(Parts, partition(N, Parts), List).

% Выводит все разбиения числа N.
print_all_partitions(N) :-
    all_partitions(N, Partitions),
    forall(member(P, Partitions),
           (write_partition(P), nl)).

% Рекурсивно выводит части разбиения через " + ".
write_partition([]) :- !.
write_partition([H|T]) :-
    write(H),
    (T = [] -> true ; write(' + ')),
    write_partition(T).
