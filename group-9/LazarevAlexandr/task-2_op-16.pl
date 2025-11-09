% Номер 2. Задача 16
% Решение 3x3 системы вручную
solve3([ [A1,B1,C1],
         [A2,B2,C2],
         [A3,B3,C3] ],
       [D1,D2,D3],
       [X,Y,Z]) :-

    % Прямой ход (обнуляем элементы первого столбца в строках 2 и 3)
    F2 is A2/A1, F3 is A3/A1,
    B2p is B2 - F2*B1, C2p is C2 - F2*C1, D2p is D2 - F2*D1,
    B3p is B3 - F3*B1, C3p is C3 - F3*C1, D3p is D3 - F3*D1,

    % Обнуляем элемент второго столбца в строке 3
    F is B3p/B2p,
    C3pp is C3p - F*C2p, D3pp is D3p - F*D2p,

    % Обратный ход
    Z is D3pp/C3pp,
    Y is (D2p - C2p*Z)/B2p,
    X is (D1 - B1*Y - C1*Z)/A1.
