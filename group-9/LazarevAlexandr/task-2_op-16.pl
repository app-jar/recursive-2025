% Номер 2. Задача 16
% Решение системы 3x3 

solve3(Matrix, D, Result) :-
    % Распаковываем матрицу и правые части
    Matrix = [[A1,B1,C1],[A2,B2,C2],[A3,B3,C3]],
    D = [D1,D2,D3],
    Row1 = [A1,B1,C1,D1],
    Row2 = [A2,B2,C2,D2],
    Row3 = [A3,B3,C3,D3],

    % --- Прямой ход ---
    pivot(Row1, Row2, Row3, R1,R2,R3),
    forward_elimination(R1,R2,R3,R1f,R2f,R3f),

    % --- Проверка на несовместность / бесконечно много решений ---
    check_consistency(R1f,R2f,R3f,Result0),
    ( Result0 \= unknown -> Result = Result0
    ; back_substitution(R1f,R2f,R3f,Result)
    ).

% --- Пивотинг: перестановка строк, если ведущий элемент ноль ---
pivot(R1,R2,R3,R1o,R2o,R3o) :-
    ( nth0(0,R1,0) ->
        ( nth0(0,R2,V2), V2 \= 0 ->
            swap(R1,R2,R2o,R1o), R3o = R3, R2o = R2o
        ; nth0(0,R3,V3), V3 \= 0 ->
            swap(R1,R3,R3o,R1o), R2o = R2, R3o = R3o
        ; R1o = R1, R2o = R2, R3o = R3  % все нули
        )
    ; R1o = R1, R2o = R2, R3o = R3
    ).

swap([A,B,C,D],[E,F,G,H],[E,F,G,H],[A,B,C,D]).

% --- Прямой ход (обнуление под диагональю) ---
forward_elimination([A1,B1,C1,D1],[A2,B2,C2,D2],[A3,B3,C3,D3],
                    [A1,B1,C1,D1],[A2p,B2p,C2p,D2p],[A3p,B3p,C3p,D3p]) :-

    (A1 =:= 0 -> fail ; true),
    F2 is A2/A1, F3 is A3/A1,
    B2p is B2 - F2*B1, C2p is C2 - F2*C1, D2p is D2 - F2*D1,
    B3p is B3 - F3*B1, C3p is C3 - F3*C1, D3p is D3 - F3*D1,

    (B2p =:= 0 -> 
        (B3p \= 0 -> 
            swap([B2p,C2p,D2p],[B3p,C3p,D3p],[B3p,C3p,D3p],[B2p,C2p,D2p])
        ; true
        )
    ; true
    ),
    F is B3p/B2p,
    C3p is C3p - F*C2p,
    D3p is D3p - F*D2p.

% --- Проверка на несовместность / бесконечные решения ---
check_consistency(R1,R2,R3,Result) :-
    ( zero_row(R1) -> (R1=[_,_,_,D], D \= 0 -> Result = error(inconsistent) ; true) ; true ),
    ( zero_row(R2) -> (R2=[_,_,_,D], D \= 0 -> Result = error(inconsistent) ; true) ; true ),
    ( zero_row(R3) -> (R3=[_,_,_,D], D \= 0 -> Result = error(inconsistent) ; true) ; true ),
    ( rank3(R1,R2,R3) -> Result = unknown ; Result = ok(infinite_solutions) ).

zero_row([A,B,C,_D]) :- A =:= 0, B =:= 0, C =:= 0.

% Для 3x3 считаем ранг = 3, если диагональ не нулевая
rank3([A1,_,_,_],[_,B2,_,_],[_,_,C3,_]) :- A1 =\= 0, B2 =\= 0, C3 =\= 0.

% --- Обратный ход ---
back_substitution([A1,B1,C1,D1],[_,B2,C2,D2],[_,_,C3,D3],[X,Y,Z]) :-
    Z is D3/C3,
    Y is (D2 - C2*Z)/B2,
    X is (D1 - B1*Y - C1*Z)/A1.
