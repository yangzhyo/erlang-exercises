-module(math_functions).
-export([even/1, odd/1, filter/2, filter1/1, filter2/1]).

even(X) ->
	case X rem 2 of
		0 -> true;
		1 -> false
	end.

odd(X) ->
	if
		X rem 2 =:= 0 -> false;
		X rem 2 =:= 1 -> true
	end.

filter(F, [H|T]) ->
	case F(H) of
		true -> [H|filter(F, T)];
		false -> filter(F, T)
	end;
filter(_, []) -> [].

filter1(L) ->
	Odds = [X || X <- L, odd(X) =:= true],
	Evens = [X || X <- L, even(X) =:= true],
	{Odds, Evens}.

filter2(L) ->
	filter2_acc(L, [], []).

filter2_acc([H|T], Odds, Evens) ->
	case odd(H) of
		true -> filter2_acc(T, [H|Odds], Evens);
		false -> filter2_acc(T, Odds, [H|Evens])
	end;
filter2_acc([], Odds, Evens) -> {lists:reverse(Odds), lists:reverse(Evens)}.