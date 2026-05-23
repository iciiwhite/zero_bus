%% © 2026 Icii Digital. This software is provided 'as is', without warranty of any kind, express or implied. In no event shall Icii Digital be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

-module(zero_bus_ipc).
-behaviour(gen_server).

-export([start_link/0, send_message/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(NIF_LIB, "priv/zero_bus_nif").

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

send_message(Dest, Payload) ->
    gen_server:call(?MODULE, {send, Dest, Payload}).

init([]) ->
    ok = erlang:load_nif(filename:join(code:priv_dir(zero_bus), "zero_bus_nif"), 0),
    {ok, #{}}.

handle_call({send, Dest, Payload}, _From, State) ->
    Result = zero_bus_nif:send(Dest, Payload),
    {reply, Result, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.