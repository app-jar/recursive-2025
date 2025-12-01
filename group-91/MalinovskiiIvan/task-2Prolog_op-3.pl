%Номер 2, Задача 3
% Проверить, является ли один список декартовым произведением двух других.
is_Dekart_product(List1, List2, List3) :-
    find_all_pairs(List1, List2, DekartProduct),  % Строим декартово произведение
    sort(List3, SortedList3),                        % Сортируем для сравнения
    sort(DekartProduct, SortedDekart),
    SortedList3 == SortedDekart.                  % Сравниваем множества

% Генерация всех пар декартова произведения
find_all_pairs(List1, List2, AllPairs) :-
    findall((X, Y), (member(X, List1), member(Y, List2)), AllPairs). 
