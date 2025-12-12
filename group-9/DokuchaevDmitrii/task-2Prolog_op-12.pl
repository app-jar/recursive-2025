% Основной предикат проверки отсортированности матрицы
matrix_sorted([]).
matrix_sorted([Row|Rows]) :-
    rows_sorted([Row|Rows]),
    columns_sorted([Row|Rows]).

% Проверка что строка отсортирована по неубыванию
row_sorted([]).
row_sorted([_]).
row_sorted([A,B|T]) :-
    A =< B,
    row_sorted([B|T]).

% Проверка что все строки матрицы отсортированы
rows_sorted([]).
rows_sorted([Row|Rows]) :-
    row_sorted(Row),
    rows_sorted(Rows).

% Проверка что все столбцы матрицы отсортированы
columns_sorted(Matrix) :-
    Matrix = [FirstRow|_],
    length(FirstRow, Cols),
    check_columns(Matrix, 0, Cols).

% Рекурсивная проверка столбцов по индексам
check_columns(_, Index, Cols) :-
    Index >= Cols.
    
check_columns(Matrix, Index, Cols) :-
    Index < Cols,
    get_column(Matrix, Index, Column),
    row_sorted(Column),
    Next is Index + 1,
    check_columns(Matrix, Next, Cols).

% Извлечение столбца по индексу
get_column([], _, []).
get_column([Row|Rows], Index, [Elem|Column]) :-
    nth0(Index, Row, Elem),
    get_column(Rows, Index, Column). 
