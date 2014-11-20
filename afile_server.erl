-module(afile_server).
-export([start/1, loop/1]).

loop(Dir) ->
	receive
		{Client, list_dir} ->
			Client ! {self(), file:list_dir(Dir)};
		{Client, {get_file, File}} ->
			FullName = filename:join(Dir, File),
			Client ! {self(), file:read_file(FullName)};
		{Client, {put_file, File, Content}} ->
			FullName = filename:join(Dir, File),
			Client ! {self(), file:write_file(FullName, Content)}
	end,
	loop(Dir).

start(Dir) -> spawn(afile_server, loop, [Dir]).
