#|
Номер 1 задача 3 
Проверить, является ли указанное число корнем многочлена.
|#
poly_value([], _, 0).
poly_value([A|T], X, V) :-
    poly_value(T, X, V1),
    V is A + X * V1.

is_root(Coeffs, X) :-
    poly_value(Coeffs, X, V),
    V =:= 0.
