-module(geometry).
-export([area/1]).

area({circle, R}) -> 2 * 3.14 * R * R;
area({triangle_right, X, Y}) -> X * Y.