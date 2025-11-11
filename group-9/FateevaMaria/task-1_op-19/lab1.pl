% 19. Сгенерировать список, содержащий первые N чисел Фибоначчи.

% 0 чисел Фибоначчи 
fibonacci_list(0, [0]).

%  1 число Фибоначчи 
fibonacci_list(1, [0, 1]).

% N чисел Фибоначчи
fibonacci_list(N, List) :-
    N > 1,
    N1 is N - 1,                     
    fibonacci_list(N1, PrevList),    
    reverse(PrevList, [B, A | _]),    % берем два последних числа
    Next is A + B,                    % вычисляем следующее число
    append(PrevList, [Next], List).   % добавляем число в конец
