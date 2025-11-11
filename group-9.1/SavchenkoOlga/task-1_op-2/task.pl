%2.Получить список простых чисел, не превышающих N

%Предикат решета Эратосфена

%базовый случай, если исходный список пуст
resheto([],[]).

% рекурсивный случай, берем первый элемент из списка как простое число и
% отсеиваем все кратные
resheto([Head|Tail],[Head|Primes]):-
    otsev(Head,Tail,Clear),
    resheto(Clear,Primes).

%Предикат для отсеивания чисел, кратных заданному числу

otsev(_,[],[]).

%если головной элемент делится на число без остатка пропускаем его
otsev(Chislo,[Head|Tail],Clear):-
    Head mod Chislo=:=0,
    otsev(Chislo,Tail,Clear).

% если головной элемент не делится на число без остатка сохраняем его
otsev(Chislo,[Head|Tail],[Head|Clear]):-
    Head mod Chislo=\=0,
    otsev(Chislo,Tail,Clear).

%предикат для получения всех простых чисел до N
allprimes(N,Primes):-
    numlist(2,N,Numbers),
    resheto(Numbers,Primes).
