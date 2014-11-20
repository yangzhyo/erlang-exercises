-module(john).
-export([mytuple_to_list/1, my_time_func/1, my_date_string/0]).

mytuple_to_list(T) when tuple_size(T) =:= 0 -> [];
mytuple_to_list(T) -> [element(1, T)|mytuple_to_list(erlang:delete_element(1, T))].

my_time_func(F) ->
	{_, _, MS1} = now(),
	F(),
	{_, _, MS2} = now(),
	MS2 - MS1.

my_date_string() ->
	NOW = {_, _, MS} = now(),
	{{YEAR, MONTH, DAY}, {HOUR, MIN, SEC}} = calendar:now_to_local_time(NOW),
	MONTH_STR = element(MONTH, {"Jan","Feb","Mar","Apr","May","Jun","Jul",
			  "Aug","Sep","Oct","Nov","Dec"}),
	io:format("~2w ~s ~4w ~2..0w:~2..0w:~2..0w:~6..0w~n", [DAY,MONTH_STR,YEAR,HOUR,MIN,SEC,MS]).