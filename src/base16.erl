%%%===================================================================
%%% @copyright (C) 2012, Erlang Solutions Ltd.
%%% This file is licensed under BSD 2-Clause License (see LICENSE file)
%%% @doc Encoding and decoding of Base16-encoded binaries
%%% @end
%%%===================================================================

-module(base16).

-export([encode/1, encode_upper/1, decode/1]).

%%--------------------------------------------------------------------
%% Public API
%%--------------------------------------------------------------------

-spec encode(binary()) -> <<_:_*16>>.
encode(Data) ->
    encode(Data, lower).

-spec encode_upper(binary()) -> <<_:_*16>>.
encode_upper(Data) ->
    encode(Data, upper).

-spec decode(<<_:_*16>>) -> binary().
decode(Base16) when size(Base16) rem 2 =:= 0 ->
    << <<(unhex(H) bsl 4 + unhex(L))>> || <<H,L>> <= Base16 >>.

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

encode(Data, Mode) ->
    << <<(hex(N div 16, Mode)), (hex(N rem 16, Mode))>> || <<N>> <= Data >>.

hex(0, _) -> $0;
hex(1, _) -> $1;
hex(2, _) -> $2;
hex(3, _) -> $3;
hex(4, _) -> $4;
hex(5, _) -> $5;
hex(6, _) -> $6;
hex(7, _) -> $7;
hex(8, _) -> $8;
hex(9, _) -> $9;
hex(10, lower) -> $a;
hex(11, lower) -> $b;
hex(12, lower) -> $c;
hex(13, lower) -> $d;
hex(14, lower) -> $e;
hex(15, lower) -> $f;
hex(10, upper) -> $A;
hex(11, upper) -> $B;
hex(12, upper) -> $C;
hex(13, upper) -> $D;
hex(14, upper) -> $E;
hex(15, upper) -> $F.

unhex(D) when $0 =< D andalso D =< $9 ->
    D - $0;
unhex(D) when $a =< D andalso D =< $f ->
    10 + D - $a;
unhex(D) when $A =< D andalso D =< $F ->
    10 + D - $A.
