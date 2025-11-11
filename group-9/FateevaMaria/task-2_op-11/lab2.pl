%11. Проверить, является ли матрица нижнетреугольной.


lower_triangular([]).  % пустая матрица - нижнетреугольная

lower_triangular([FirstRow|RestRows]) :-
    check_rows([FirstRow|RestRows], 1).

% проверка строк
check_rows([], _).  % все строки проверены

check_rows([Row|RestRows], RowNum) :-
    check_zeros_above_diagonal(Row, RowNum, 1),
    NextRowNum is RowNum + 1,
    check_rows(RestRows, NextRowNum).

% Проверка на 0
check_zeros_above_diagonal([], _, _).

check_zeros_above_diagonal([Element|Rest], RowNum, ColNum) :-
    (ColNum > RowNum -> 
        Element =:= 0      % выше диагонали должен быть 0
    ; 
        true               % иначе - любое значение
    ),
    NextColNum is ColNum + 1,
    check_zeros_above_diagonal(Rest, RowNum, NextColNum).
