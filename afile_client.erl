-module(afile_client).
-export([ls/1, get_file/2, put_file/3]).

ls(Dir) ->
	FileServer = afile_server:start(Dir),
	FileServer ! {self(), list_dir},
	receive
		{Server, DirContent} ->
			DirContent
	end.

get_file(Dir, File) ->
	FileServer = afile_server:start(Dir),
	FileServer ! {self(), {get_file, File}},
	receive
		{Server, FileContent} ->
			FileContent
	end.

put_file(Dir, File, Content) ->
	FileServer = afile_server:start(Dir),
	FileServer ! {self(), {put_file, File, Content}},
	receive
		{Server, Result} ->
			Result
	end.