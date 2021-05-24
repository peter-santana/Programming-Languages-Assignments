% Peter Santana
%CIIC4030

store(best_smoothies, [alan,john,mary],
    [smoothie(berry, [orange, blueberry, strawberry], 2),
    smoothie(tropical, [orange, banana, mango, guava], 3),
    smoothie(blue, [banana, blueberry], 3) ]).

store(all_smoothies, [keith,mary],
    [smoothie(pinacolada, [orange, pineapple, coconut], 2),
    smoothie(green, [orange, banana, kiwi], 5),
    smoothie(purple, [orange, blueberry, strawberry], 2),
    smoothie(smooth, [orange, banana, mango],1) ]).

store(smoothies_galore, [heath,john,michelle],
    [smoothie(combo1, [strawberry, orange, banana], 2),
    smoothie(combo2, [banana, orange], 5),
    smoothie(combo3, [orange, peach, banana], 2),
    smoothie(combo4, [guava, mango, papaya, orange],1),
    smoothie(combo5, [grapefruit, banana, pear],1) ]).

% Test to check if the store has more than 4 smoothies.
more_than_four(X):- 
    store(X, _, Menu), 
    length(Menu, Size), 
    Size >= 4.

% Test to check if the store has a smoothie named as.
exists(X):- 
    store(_, _, Menu),
    is_member(X, Menu).

	is_member(X, [smoothie(X, _, _)|_]).
	is_member(X, [_|Tail]):-
    	is_member(X, Tail).


% Test to check if there is a store named X and the average price of the smoothies.
average(X,A):-
    store(X, _, Menu),
	price_sum(Menu, Sum),
    length(Menu, Count),
    Sum/Count =:= A.

    price_sum([], 0).
	price_sum([smoothie(_, _, Price)|Tail], Total):-
    	price_sum(Tail, N),
    	Total is Price + N.

% Test to check ratio of employee/smoothie
ratio(X,R):- 
    store(X, Employees, Menu),
    length(Employees, N),
    length(Menu, M),
    R =:= N/M.